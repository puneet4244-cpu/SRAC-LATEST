$root = (Get-Location).Path
$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\\.git\\'
}

# Read sitemap.xml
$sitemapPath = Join-Path $root "sitemap.xml"
$sitemapUrls = @{}
if (Test-Path $sitemapPath) {
    $sitemapContent = [System.IO.File]::ReadAllText($sitemapPath)
    $locMatches = [regex]::Matches($sitemapContent, '<loc>(.*?)</loc>')
    foreach ($m in $locMatches) {
        $u = $m.Groups[1].Value.Trim().TrimEnd('/')
        $sitemapUrls[$u] = $true
        # Also store relative
        $rel = $u.Replace("https://shreeramandcompany.com", "").TrimEnd('/')
        if ($rel -eq "") { $rel = "/" }
        $sitemapUrls[$rel] = $true
    }
}

$inventory = @()

foreach ($file in $htmlFiles) {
    $rel = $file.FullName.Substring($root.Length).TrimStart('\').Replace('\', '/')
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # URL determination
    $url = "/" + $rel
    if ($url.EndsWith("index.html")) {
        $url = $url.Substring(0, $url.Length - 10)
    }

    # Type: Full Page vs Redirect Stub
    $isStub = ($content -match 'http-equiv=["'']refresh["'']')
    $pageType = if ($isStub) { "Redirect Stub" } else { "Full Page" }

    # Title
    $title = ""
    if ($content -match '<title>(.*?)</title>') {
        $title = $matches[1].Trim()
    }

    # Canonical
    $canonical = ""
    if ($content -match '<link\s+rel=["'']canonical["'']\s+href=["''](.*?)["'']') {
        $canonical = $matches[1].Trim()
    }

    # H1
    $h1List = @()
    $h1Matches = [regex]::Matches($content, '<h1[^>]*>(.*?)</h1>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($m in $h1Matches) {
        $cleanH1 = [regex]::Replace($m.Groups[1].Value, '<[^>]+>', '').Trim()
        $cleanH1 = [regex]::Replace($cleanH1, '\s+', ' ')
        if ($cleanH1) { $h1List += $cleanH1 }
    }
    $h1 = if ($h1List.Count -gt 0) { $h1List -join " | " } else { "(None)" }

    # Word Count
    $textOnly = [regex]::Replace($content, '<script[^>]*>.*?</script>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    $textOnly = [regex]::Replace($textOnly, '<style[^>]*>.*?</style>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    $textOnly = [regex]::Replace($textOnly, '<[^>]+>', ' ')
    $words = ($textOnly -split '\s+' | Where-Object { $_ -ne '' }).Count

    # In Sitemap Check
    $cleanCheckUrl = $url.TrimEnd('/')
    if ($cleanCheckUrl -eq "") { $cleanCheckUrl = "/" }
    $fullCheckUrl = "https://shreeramandcompany.com" + $cleanCheckUrl
    $inSitemap = if ($sitemapUrls.ContainsKey($cleanCheckUrl) -or $sitemapUrls.ContainsKey($fullCheckUrl)) { "Yes" } else { "No" }

    $inventory += [PSCustomObject]@{
        RelPath = $rel
        URL = $url
        Type = $pageType
        Title = $title
        H1 = $h1
        WordCount = $words
        Canonical = $canonical
        InSitemap = $inSitemap
    }
}

Write-Host "Total inventory records: $($inventory.Count)"
Write-Host "Full Pages: $(($inventory | Where-Object { $_.Type -eq 'Full Page' }).Count)"
Write-Host "Redirect Stubs: $(($inventory | Where-Object { $_.Type -eq 'Redirect Stub' }).Count)"
Write-Host "In Sitemap: $(($inventory | Where-Object { $_.InSitemap -eq 'Yes' }).Count)"
Write-Host "Not in Sitemap: $(($inventory | Where-Object { $_.InSitemap -eq 'No' }).Count)"

# Export to CSV and Markdown table
$inventory | Export-Csv -Path "$root/tools/site_inventory_81.csv" -NoTypeInformation -Encoding UTF8

$mdLines = @(
    "# Full Site Inventory (81 HTML Files)",
    "",
    "| # | URL | Type | Current Title | H1 | Words | Canonical | In Sitemap |",
    "| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |"
)

$idx = 1
foreach ($item in ($inventory | Sort-Object URL)) {
    $safeTitle = $item.Title.Replace("|", "-")
    $safeH1 = $item.H1.Replace("|", "-")
    $safeCanon = $item.Canonical.Replace("https://shreeramandcompany.com", "")
    $mdLines += "| $idx | `$($item.URL)` | $($item.Type) | $safeTitle | $safeH1 | $($item.WordCount) | `$safeCanon` | $($item.InSitemap) |"
    $idx++
}

$mdLines | Out-File -FilePath "$root/tools/site_inventory_81.md" -Encoding UTF8
Write-Host "Inventory saved to tools/site_inventory_81.csv and tools/site_inventory_81.md"
