$root = (Get-Location).Path
$vercelJsonText = [System.IO.File]::ReadAllText((Join-Path $root "vercel.json"))
$vercelJson = $vercelJsonText | ConvertFrom-Json

$vercelRedirects = @{}
foreach ($r in $vercelJson.redirects) {
    $src = $r.source.TrimEnd('/')
    $vercelRedirects[$src] = $r
}

$inventory = Import-Csv "$root/tools/site_inventory_81.csv"
$stubs = $inventory | Where-Object { $_.Type -eq "Redirect Stub" }

$stubReport = @()

foreach ($s in $stubs) {
    $localFile = Join-Path $root $s.RelPath
    $content = [System.IO.File]::ReadAllText($localFile)
    
    $metaRefreshTarget = ""
    if ($content -match 'content=["'']\d+;\s*url=(.*?)["'']') {
        $metaRefreshTarget = $matches[1]
    }

    $jsRedirect = ($content -match 'window\.location' -or $content -match 'location\.href')

    $checkSource = $s.URL.TrimEnd('/')
    $hasVercel = $vercelRedirects.ContainsKey($checkSource)
    $vercelDest = ""
    if ($hasVercel) {
        $vercelDest = $vercelRedirects[$checkSource].destination
    }

    $methods = @()
    if ($hasVercel) { $methods += "Vercel 301 Permanent" }
    if ($metaRefreshTarget) { $methods += "Meta Refresh (0s)" }
    if ($jsRedirect) { $methods += "JavaScript" }

    $target = if ($vercelDest) { $vercelDest } else { $metaRefreshTarget }
    $methodStr = $methods -join " + "

    $stubReport += [PSCustomObject]@{
        URL = $s.URL
        Method = $methodStr
        Target = $target
        CurrentTitle = $s.Title
        Words = $s.WordCount
    }
}

Write-Host "Total Stubs Inspected: $($stubReport.Count)"
$stubReport | Export-Csv -Path "$root/tools/stubs_detailed_report.csv" -NoTypeInformation -Encoding UTF8

$mdLines = @(
    "# The 42 Redirect Stubs Analysis",
    "",
    "| # | Stub URL | Redirection Mechanism | Target Destination | Current Words | Proposed Action |",
    "| :--- | :--- | :--- | :--- | :--- | :--- |"
)

$i = 1
foreach ($sr in ($stubReport | Sort-Object URL)) {
    $proposed = ""
    $u = $sr.URL
    if ($u -eq "/blog") {
        $proposed = "Keep as 301 redirect to /articles/"
    }
    elseif ($u.EndsWith("-stone-art-mural") -or $u -eq "/stone-art-murals/floral-stone-art" -or $u.EndsWith("-stone-panels") -or $u.EndsWith("-mdf-panels") -or $u -eq "/mdf-hdmr-work/mdf-hdmr-wall-panels") {
        $proposed = "**Convert to Standalone Page** (Exact Category Name H1)"
    }
    else {
        $proposed = "Keep as 301 redirect to canonical subcategory page"
    }

    $line = "| {0} | `{1}` | {2} | `{3}` | {4} | {5} |" -f $i, $sr.URL, $sr.Method, $sr.Target, $sr.Words, $proposed
    $mdLines += $line
    $i++
}

$reportPath = Join-Path $root "tools\stubs_detailed_report.md"
$mdLines | Out-File -FilePath $reportPath -Encoding UTF8
Write-Host "Report saved to tools/stubs_detailed_report.csv and tools/stubs_detailed_report.md"
