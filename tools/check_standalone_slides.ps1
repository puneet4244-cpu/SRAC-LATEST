$dirs = @(
    "customised-name-plate",
    "wall-cladding",
    "garden-article",
    "stone-temple",
    "pooja-room",
    "statue",
    "gazebo",
    "pillar",
    "handicrafts",
    "marble-table-tops",
    "mdf-jali",
    "partition-jali",
    "wpc-jali"
)

foreach ($d in $dirs) {
    $p = "$d/index.html"
    if (Test-Path $p) {
        $content = Get-Content $p -Raw
        $m = [regex]::Match($content, 'class="gallery-slide[^"]*data-index="0">\s*<img\s+src="([^"]+)"([^>]*)>')
        if ($m.Success) {
            Write-Host "$d => Slide 0: $($m.Groups[1].Value)"
        } else {
            Write-Host "$d => No slide 0 match"
        }
    }
}
