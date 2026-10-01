# Deeply inspect all category pages to understand their product card structure
$catPages = @(
    'stone-carving/index.html',
    'stone-art-murals/index.html',
    'stone-wall-panels/index.html',
    'mdf-hdmr-work/index.html',
    'elevation-facade/index.html',
    'customised-name-plate/index.html',
    'wall-cladding/index.html',
    'garden-article/index.html',
    'marble-temple/index.html',
    'stone-temple/index.html',
    'pooja-room/index.html',
    'marble-inlay/index.html',
    'statue/index.html',
    'gazebo/index.html',
    'arch-mehrab/index.html',
    'pillar/index.html',
    'handicrafts/index.html',
    'marble-table-tops/index.html',
    'water-fountain/index.html',
    'stone-jali/index.html',
    'mdf-jali/index.html',
    'partition-jali/index.html',
    'wpc-jali/index.html',
    'murals-wall-art/index.html'
)

foreach ($cp in $catPages) {
    if (Test-Path $cp) {
        $raw = Get-Content $cp -Raw
        Write-Host "=========================================="
        Write-Host "PAGE: $cp"
        
        # Check for card divs or product sections
        # Often cards have h3 or h4 with product name
        $matches = [regex]::Matches($raw, '<(h[2345])[^>]*class="[^"]*(?:title|heading|font-serif)[^"]*"[^>]*>([\s\S]*?)</\1>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($matches.Count -eq 0) {
            $matches = [regex]::Matches($raw, '<(h[234])[^>]*>([\s\S]*?)</\1>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        }
        
        Write-Host "Headings found: $($matches.Count)"
        foreach ($m in $matches) {
            $txt = ($m.Groups[2].Value -replace '<[^>]+>', '').Trim()
            if ($txt.Length -gt 0 -and $txt.Length -lt 80) {
                Write-Host "  -> $txt"
            }
        }
    }
}
