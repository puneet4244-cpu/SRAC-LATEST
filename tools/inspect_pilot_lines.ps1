$files = @(
  'index.html',
  'stone-jali/index.html',
  'cnc-jali-work/index.html',
  'stone-wall-panels/fluted-stone-panels/index.html',
  'stone-art-murals/radhe-krishna-stone-art-mural/index.html',
  'stone-carving/staircase-wall/index.html'
)
$keywords = @('\bISPM\b', '\bMPa\b', 'silane', 'fluoropolymer', 'dampen', 'dampening', 'significantly', 'for decades', '2 to 3 weeks', '2-3 weeks', '3x4', '8x12', '15-75', '25-50', '12-25', '\bRs\b', '\u20B9', '\batelier\b', '\bdecades\b', '\bVastu\b')

foreach ($f in $files) {
    Write-Host "`n======================================================="
    Write-Host "FILE: $f"
    Write-Host "======================================================="
    $lines = Get-Content $f
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        foreach ($k in $keywords) {
            if ($line -match $k) {
                Write-Host "Line $($i+1) [$k]: $($line.Trim())"
            }
        }
    }
}
