$categories = @(
    'temple',
    'pooja-room',
    'statue',
    'stone-carving',
    'stone-jali',
    'mdf-jali',
    'wpc-jali',
    'mdf-hdmr-work',
    'elevation-facade',
    'wall-cladding',
    'stone-wall-panels',
    'murals-wall-art',
    'marble-inlay',
    'marble-table-tops',
    'handicrafts',
    'customised-name-plate',
    'water-fountain',
    'gazebo',
    'pillar',
    'arch-mehrab',
    'garden-article',
    'hero',
    'about'
)

foreach ($cat in $categories) {
    $targetDir = Join-Path $PSScriptRoot "images\$cat"
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }
}

Write-Host "All 23 image category folders are successfully created inside 'images/' folder!"
