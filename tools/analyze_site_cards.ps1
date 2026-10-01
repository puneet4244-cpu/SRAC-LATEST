# Script to analyze all pages, categories, and product cards
$pages = Get-ChildItem -Path . -Recurse -Filter "*.html" | Where-Object { 
    $_.FullName -notmatch '\\\.git\\' -and 
    $_.FullName -notmatch '\\privacy-policy\\' -and 
    $_.FullName -notmatch '\\terms-of-service\\' -and
    $_.FullName -notmatch '\\contact\\' -and
    $_.FullName -notmatch '\\get-a-quote\\' -and
    $_.FullName -notmatch '\\about-us\\' -and
    $_.FullName -notmatch '\\articles\\' -and
    $_.FullName -notmatch '\\blog\\'
}

Write-Host "Analyzing $($pages.Count) catalog and category pages..."

foreach ($page in $pages) {
    $rel = $page.FullName.Substring((Get-Location).Path.Length + 1)
    $content = Get-Content -Path $page.FullName -Raw
    
    # Find title
    $title = ""
    if ($content -match '<title>([^<]+)</title>') { $title = $matches[1] }
    
    # Find all product cards or images
    $imgs = [regex]::Matches($content, '<img\s+[^>]*src=["'']([^"'']+)["''][^>]*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    $productImgs = @()
    foreach ($m in $imgs) {
        $src = $m.Groups[1].Value
        # Filter out logos, icons, google
        if ($src -notmatch 'logo' -and $src -notmatch 'icon' -and $src -notmatch 'google') {
            $productImgs += $src
        }
    }
    
    Write-Host "`nPAGE: $rel | Title: $title"
    Write-Host "  Product image count: $($productImgs.Count)"
    $productImgs | Group-Object | ForEach-Object {
        Write-Host "    $($_.Name) (x$($_.Count))"
    }
}
