# Phase 0: Discovery Script for shreeramandcompany.com

$root = (Get-Location).Path
$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\\.git\\'
}

Write-Host "Total HTML files found: $($htmlFiles.Count)"

$pagesData = @()
$vijetaStoneMatches = @()
$namesLock = @()

foreach ($file in $htmlFiles) {
    $relPath = $file.FullName.Substring($root.Length).TrimStart('\').Replace('\', '/')
    $content = [System.IO.File]::ReadAllText($file.FullName)

    # 1. Check for vijetastone.com
    if ($content -match 'vijetastone\.com') {
        $vijetaStoneMatches += $relPath
    }

    # 2. Extract Title
    $title = ""
    if ($content -match '<title>(.*?)</title>') {
        $title = $matches[1].Trim()
    }

    # 3. Extract Meta Description
    $metaDesc = ""
    if ($content -match '<meta\s+name=["'']description["'']\s+content=["''](.*?)["'']' -or $content -match '<meta\s+content=["''](.*?)["'']\s+name=["'']description["'']') {
        $metaDesc = $matches[1].Trim()
    }

    # 4. Extract H1
    $h1List = @()
    $h1Matches = [regex]::Matches($content, '<h1[^>]*>(.*?)</h1>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($m in $h1Matches) {
        $cleanH1 = [regex]::Replace($m.Groups[1].Value, '<[^>]+>', '').Trim()
        $cleanH1 = [regex]::Replace($cleanH1, '\s+', ' ')
        if ($cleanH1) { $h1List += $cleanH1 }
    }

    # 5. Word count (excluding scripts and tags)
    $textOnly = [regex]::Replace($content, '<script[^>]*>.*?</script>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    $textOnly = [regex]::Replace($textOnly, '<style[^>]*>.*?</style>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    $textOnly = [regex]::Replace($textOnly, '<[^>]+>', ' ')
    $words = ($textOnly -split '\s+' | Where-Object { $_ -ne '' }).Count

    # 6. Image count
    $imgCount = ([regex]::Matches($content, '<img\b')).Count

    # Determine URL
    $url = "/" + $relPath
    if ($url.EndsWith("index.html")) {
        $url = $url.Substring(0, $url.Length - 10)
    }

    $pagesData += [PSCustomObject]@{
        RelPath = $relPath
        URL = $url
        Title = $title
        TitleLength = $title.Length
        MetaDesc = $metaDesc
        MetaLength = $metaDesc.Length
        H1Count = $h1List.Count
        H1 = ($h1List -join ' | ')
        WordCount = $words
        ImgCount = $imgCount
    }
}

Write-Host "`n--- DISCOVERY SUMMARY ---"
Write-Host "Total Pages: $($pagesData.Count)"
Write-Host "Pages with vijetastone.com references: $($vijetaStoneMatches.Count)"
if ($vijetaStoneMatches.Count -gt 0) {
    Write-Host "Files containing vijetastone.com:"
    $vijetaStoneMatches | ForEach-Object { Write-Host " - $_" }
}

# Export page inventory to CSV for reference
$pagesData | Export-Csv -Path "$root/tools/phase0_page_inventory.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Inventory exported to tools/phase0_page_inventory.csv"
