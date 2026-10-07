$files = @(
  'index.html',
  'stone-jali/index.html',
  'cnc-jali-work/index.html',
  'stone-wall-panels/fluted-stone-panels/index.html',
  'stone-art-murals/radhe-krishna-stone-art-mural/index.html',
  'stone-carving/staircase-wall/index.html'
)
$keywords = @('ISPM', 'MPa', 'silane', 'fluoropolymer', 'dampen', 'dampening', 'significantly', 'for decades', '2 to 3 weeks', '2-3 weeks', '3x4', '8x12', '15-75', '25-50', '12-25', 'INR', 'Rs.', 'atelier', 'decades', 'Vastu')

foreach ($f in $files) {
    Write-Host "=== CHECKING $f ==="
    $content = Get-Content $f -Raw
    foreach ($k in $keywords) {
        if ($content -match [regex]::Escape($k)) {
            Write-Host "  Found: $k"
        }
    }
}
