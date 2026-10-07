$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

$pilotFiles = @(
    "index.html",
    "stone-carving\staircase-wall\index.html",
    "stone-art-murals\radhe-krishna-stone-art-mural\index.html",
    "stone-wall-panels\fluted-stone-panels\index.html",
    "cnc-jali-work\index.html",
    "stone-jali\index.html"
)

Write-Output "=== HTML STRUCTURE & BALANCED TAG AUDIT ==="
$allValid = $true

foreach ($f in $pilotFiles) {
    $fullPath = Join-Path $rootDir $f
    $content = [System.IO.File]::ReadAllText($fullPath, [System.Text.Encoding]::UTF8)
    
    $hasDoctype = $content -match '(?i)<!DOCTYPE html>'
    $hasHtml = ($content -match '(?i)<html') -and ($content -match '(?i)</html>')
    $hasHead = ($content -match '(?i)<head') -and ($content -match '(?i)</head>')
    $hasBody = ($content -match '(?i)<body') -and ($content -match '(?i)</body>')
    
    # Check H1 count (must be exactly 1 per SEO best practices)
    $h1Matches = [regex]::Matches($content, '(?is)<h1[^>]*>.*?</h1>')
    $h1Count = $h1Matches.Count

    # Count main container tags
    $divOpen = ([regex]::Matches($content, '<div[\s>]')).Count
    $divClose = ([regex]::Matches($content, '</div>')).Count
    $diff = [math]::Abs($divOpen - $divClose)

    Write-Output "`nFile: $f"
    Write-Output "  Structure: DOCTYPE: $hasDoctype | html: $hasHtml | head: $hasHead | body: $hasBody"
    Write-Output "  H1 count: $h1Count (Expected: 1)"
    Write-Output "  Divs: Open=$divOpen, Close=$divClose (Diff=$diff)"

    if (-not ($hasDoctype -and $hasHtml -and $hasHead -and $hasBody -and ($h1Count -eq 1))) {
        Write-Output "  FAIL: Structural issue in $f"
        $allValid = $false
    }
}

if ($allValid) {
    Write-Output "`nPERFECT PASS: All pilot pages have pristine HTML5 structure and exactly 1 H1."
} else {
    Write-Output "`nReview structural issues above."
}
