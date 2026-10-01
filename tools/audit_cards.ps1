# Full inventory audit of all product cards and images across the website
$pages = @(
    'index.html',
    'stone-carving/index.html',
    'stone-art-murals/index.html',
    'murals-wall-art/index.html',
    'stone-wall-panels/index.html',
    'mdf-hdmr-work/index.html',
    'elevation-facade/index.html',
    'customised-name-plate/index.html',
    'wall-cladding/index.html',
    'garden-article/index.html',
    'marble-temple/index.html',
    'stone-temple/index.html',
    'temple/index.html',
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
    'wpc-jali/index.html'
)

$inventory = @()

foreach ($p in $pages) {
    if (-not (Test-Path $p)) { continue }
    $content = Get-Content $p -Raw
    
    # In index.html, check the collection section
    if ($p -eq 'index.html') {
        # Find collection section
        if ($content -match '<section[^>]*id="collection"[^>]*>([\s\S]*?)</section>') {
            $colHtml = $matches[1]
            $cardMatches = [regex]::Matches($colHtml, '<div[^>]*class="[^"]*group[^"]*"[^>]*>([\s\S]*?)</div>\s*</div>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
            # Or match each card by looking for image and title
            $aMatches = [regex]::Matches($colHtml, '<a\s+href="([^"]+)"[^>]*class="[^"]*group[^"]*"[^>]*>([\s\S]*?)</a>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
            foreach ($am in $aMatches) {
                $href = $am.Groups[1].Value
                $inner = $am.Groups[2].Value
                $title = ""
                if ($inner -match '<h3[^>]*>([^<]+)</h3>') { $title = $matches[1].Trim() }
                $imgs = [regex]::Matches($inner, '<img\s+[^>]*src="([^"]+)"[^>]*alt="([^"]*)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
                $imgList = @()
                foreach ($im in $imgs) { $imgList += @{ src = $im.Groups[1].Value; alt = $im.Groups[2].Value } }
                $inventory += [PSCustomObject]@{
                    Page = $p
                    Section = "Collection Grid"
                    ProductName = $title
                    Href = $href
                    ImageCount = $imgList.Count
                    Images = ($imgList | ForEach-Object { "$($_.src)|$($_.alt)" }) -join ";"
                }
            }
        }
    } else {
        # In category pages, find product cards
        # Look for the product cards in Swiper or grid
        # In master_page_builder.ps1, let's see how each product card is rendered
        $prodMatches = [regex]::Matches($content, '<!-- Product Card:\s*([^-]+)-->|id="product-([^"]+)"|<div[^>]*class="[^"]*product-card[^"]*"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        
        # Let's inspect Swiper instances or product blocks
        # MasterPageBuilder generates <div class="swiper productSwiper..." or similar
        # Let's find every swiper or card block
        $swipers = [regex]::Matches($content, '(<div[^>]*class="[^"]*swiper[^"]*productSwiper[^"]*"[^>]*>[\s\S]*?<!-- Product Info / Details -->[\s\S]*?</div>\s*</div>\s*</div>)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        
        # Or look for each h3/h2 inside collection
        $cardSections = [regex]::Matches($content, 'id="([^"]+)"[^>]*class="[^"]*(?:bg-white|border)[^"]*"([\s\S]*?)(?=(?:id="[a-z0-9-]+"|$))', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    }
}

Write-Host "Index inventory count: $($inventory.Count)"
$inventory | Format-Table -AutoSize
