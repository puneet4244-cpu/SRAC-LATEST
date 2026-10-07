$root = (Get-Location).Path
$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\\.git\\'
}

$fullPages = @()
$redirectPages = @()

foreach ($file in $htmlFiles) {
    $rel = $file.FullName.Substring($root.Length).TrimStart('\').Replace('\', '/')
    $content = [System.IO.File]::ReadAllText($file.FullName)
    if ($content -match 'http-equiv=["'']refresh["'']') {
        $redirectPages += $rel
    } else {
        $fullPages += $rel
    }
}

Write-Host "Total Full Content Pages: $($fullPages.Count)"
Write-Host "Total Redirect Stubs: $($redirectPages.Count)"

Write-Host "`n--- FULL PAGES ($($fullPages.Count)) ---"
$fullPages | Sort-Object | ForEach-Object { Write-Host " - $_" }

Write-Host "`n--- REDIRECT STUBS ($($redirectPages.Count)) ---"
$redirectPages | Sort-Object | ForEach-Object { Write-Host " - $_" }
