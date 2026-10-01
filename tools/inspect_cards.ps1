# Inspect cards in index.html and category pages
$content = Get-Content 'index.html' -Raw

Write-Host "=== INDEX.HTML CARDS ==="
$matches = [regex]::Matches($content, '<article[^>]*>([\s\S]*?)</article>|<div class="[^"]*group[^"]*"[^>]*>([\s\S]*?)</div>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

Write-Host "Found $($matches.Count) candidate cards/groups"

# Also look for sections in index.html
$sections = [regex]::Matches($content, '<section[^>]*id="([^"]+)"[^>]*>([\s\S]*?)</section>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
foreach ($sec in $sections) {
    $secId = $sec.Groups[1].Value
    $secBody = $sec.Groups[2].Value
    $secImgs = [regex]::Matches($secBody, '<img\s+[^>]*src="([^"]+)"[^>]*alt="([^"]*)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    Write-Host "`nSection ID: $secId (Images: $($secImgs.Count))"
    foreach ($img in $secImgs) {
        Write-Host "   img src: $($img.Groups[1].Value) | alt: $($img.Groups[2].Value)"
    }
}
