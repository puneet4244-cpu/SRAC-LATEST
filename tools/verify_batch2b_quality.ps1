$files = @(
    "stone-art-murals/index.html",
    "stone-art-murals/buddha-stone-art-mural/index.html",
    "stone-art-murals/durga-mata-ji-stone-art-mural/index.html",
    "stone-art-murals/ganesh-ji-stone-art-mural/index.html",
    "stone-art-murals/hanuman-ji-stone-art-mural/index.html",
    "stone-art-murals/laxmi-ji-stone-art-mural/index.html",
    "stone-art-murals/ram-darbar-stone-art-mural/index.html",
    "stone-art-murals/shiv-ji-stone-art-mural/index.html",
    "stone-art-murals/shreenath-ji-stone-art-mural/index.html",
    "stone-art-murals/swaminarayan-ji-stone-art-mural/index.html",
    "stone-art-murals/floral-stone-art/index.html",
    "stone-art-murals/village-stone-art-mural/index.html"
)

$issues = 0
foreach ($f in $files) {
    if (-not (Test-Path $f)) {
        Write-Host "FILE MISSING: $f"
        $issues++
        continue
    }
    $text = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
    
    # Check banned terms (atelier, generational, silane, siloxane)
    if ($text -match '(?i)\b(atelier|generational|silane|siloxane)\b') {
        Write-Host "BANNED TERM HIT in $f : $($matches[1])"
        $issues++
    }
    # Check currency symbols / abbreviations
    if ($text -match '(?i)(?<![a-z])(Rs\.?|INR|\u20B9)\s*\d+') {
        Write-Host "PRICE HIT in $f : $($matches[0])"
        $issues++
    }
    # Check placeholders
    if ($text -match '(?i)\b(TODO|lorem)\b|\[\s*\]|Redirecting\.\.\.') {
        Write-Host "PLACEHOLDER HIT in $f : $($matches[0])"
        $issues++
    }
    # Check product schema
    if ($text -match '"@type":\s*"Product"') {
        Write-Host "PRODUCT SCHEMA HIT in $f"
        $issues++
    }
    # Check noindex on expanded subpages
    if ($f -ne "stone-art-murals/index.html" -and $text -match 'noindex') {
        Write-Host "NOINDEX STILL PRESENT in $f"
        $issues++
    }
}

if ($issues -eq 0) {
    Write-Host "SUCCESS: All 12 Batch 2b files passed clean (0 banned terms, 0 prices, 0 placeholders, 0 Product schemas, 0 noindex stubs)!"
} else {
    Write-Host "FAILED with $issues issues."
}
