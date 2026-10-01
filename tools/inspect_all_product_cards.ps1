# Inspect all product cards across all pages
$htmlFiles = Get-ChildItem -Path . -Recurse -Filter "*.html" | Where-Object { 
    $_.FullName -notmatch '\\\.git\\' -and 
    $_.FullName -notmatch '\\privacy-policy\\' -and 
    $_.FullName -notmatch '\\terms-of-service\\' -and
    $_.FullName -notmatch '\\contact\\' -and
    $_.FullName -notmatch '\\get-a-quote\\' -and
    $_.FullName -notmatch '\\about-us\\' -and
    $_.FullName -notmatch '\\articles\\' -and
    $_.FullName -notmatch '\\blog\\'
}

foreach ($f in $htmlFiles) {
    $content = Get-Content $f.FullName -Raw
    $rel = $f.FullName.Substring((Get-Location).Path.Length + 1)
    
    # Check if this page has redirect
    if ($content -match 'http-equiv="refresh"') { continue }
    
    Write-Host "`n========================================================"
    Write-Host "FILE: $rel"
    
    # Find all card containers or article tags or sections
    # In this site, product cards are often <div class="...product-card..." or <article or inside a grid
    # Let's find images inside cards
    $cardMatches = [regex]::Matches($content, '(<(?:div|article)[^>]*class="[^"]*(?:card|group|product|swiper-slide)[^"]*"[^>]*>[\s\S]*?</(?:div|article)>)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    # Or let's search for every <img ...> on the page and its nearest heading
    $imgMatches = [regex]::Matches($content, '<img\s+[^>]*src="([^"]+)"[^>]*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    Write-Host "Total images in file: $($imgMatches.Count)"
    foreach ($im in $imgMatches) {
        $tag = $im.Value
        $src = $im.Groups[1].Value
        if ($src -match 'logo' -or $src -match 'icon' -or $src -match 'google') { continue }
        
        # Find alt
        $alt = ""
        if ($tag -match 'alt="([^"]*)"') { $alt = $matches[1] }
        
        # Find nearest heading before this img
        $before = $content.Substring(0, $im.Index)
        $nearestHeading = ""
        $headMatches = [regex]::Matches($before, '<(h[2345])[^>]*>([\s\S]*?)</\1>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($headMatches.Count -gt 0) {
            $lastH = $headMatches[$headMatches.Count - 1]
            $nearestHeading = ($lastH.Groups[2].Value -replace '<[^>]+>', '').Trim()
        }
        
        Write-Host "  -> IMG: $src | ALT: '$alt' | NEAR HEADING: '$nearestHeading'"
    }
}
