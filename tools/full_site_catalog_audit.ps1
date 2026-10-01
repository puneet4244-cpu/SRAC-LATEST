# Complete Catalog Audit Script
$catFiles = @(
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

$auditResults = @()

foreach ($cf in $catFiles) {
    if (-not (Test-Path $cf)) { continue }
    $html = Get-Content $cf -Raw
    
    if ($cf -eq 'index.html') {
        # Check index collection section cards
        if ($html -match '<section[^>]*id="collection"[^>]*>([\s\S]*?)</section>') {
            $col = $matches[1]
            # Match each category card
            $cardMatches = [regex]::Matches($col, '<a\s+href="([^"]+)"[^>]*class="[^"]*group[^"]*"[^>]*>([\s\S]*?)</a>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
            foreach ($cm in $cardMatches) {
                $href = $cm.Groups[1].Value
                $cardHtml = $cm.Groups[2].Value
                $name = ""
                if ($cardHtml -match '<h3[^>]*>([^<]+)</h3>') { $name = $matches[1].Trim() }
                $imgs = [regex]::Matches($cardHtml, '<img\s+[^>]*src="([^"]+)"[^>]*alt="([^"]*)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
                $srcs = @()
                $alts = @()
                foreach ($im in $imgs) {
                    $srcs += $im.Groups[1].Value
                    $alts += $im.Groups[2].Value
                }
                $auditResults += [PSCustomObject]@{
                    Page = $cf
                    Type = "Collection Card"
                    ProductName = $name
                    CardId = ""
                    ImageCount = $srcs.Count
                    Srcs = $srcs -join "; "
                    Alts = $alts -join "; "
                }
            }
        }
    } else {
        # Match each product card on category pages:
        # Pattern in master_page_builder.ps1:
        # <div id="cardSlug" ... class="...product-card... or group ...">
        #   <div class="product-gallery ... data-product="pName" ...>
        #     <div class="gallery-track ...>
        #       <div class="gallery-slide ...><img src="..." alt="..." ...></div>
        
        $cardMatches = [regex]::Matches($html, '<div\s+id="([^"]+)"[^>]*onclick="handleCardClick\(''([^'']+)''[\s\S]*?<!-- In-Card Slider Gallery -->([\s\S]*?)<!-- Product Information', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($cardMatches.Count -gt 0) {
            foreach ($cm in $cardMatches) {
                $cardId = $cm.Groups[1].Value
                $prodName = $cm.Groups[2].Value
                $galleryHtml = $cm.Groups[3].Value
                
                $imgs = [regex]::Matches($galleryHtml, '<img\s+[^>]*src="([^"]+)"[^>]*alt="([^"]*)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
                $srcs = @()
                $alts = @()
                foreach ($im in $imgs) {
                    $srcs += $im.Groups[1].Value
                    $alts += $im.Groups[2].Value
                }
                $auditResults += [PSCustomObject]@{
                    Page = $cf
                    Type = "Product Card (Slider)"
                    ProductName = $prodName
                    CardId = $cardId
                    ImageCount = $srcs.Count
                    Srcs = $srcs -join "; "
                    Alts = $alts -join "; "
                }
            }
        } else {
            # Maybe standard cards
            Write-Host "Warning: No product cards matched in $cf"
        }
    }
}

Write-Host "Total audited cards across all pages: $($auditResults.Count)"
$auditResults | Export-Csv -Path "tools/initial_card_audit.csv" -NoTypeInformation
$auditResults | Select-Object Page, ProductName, ImageCount | Format-Table -AutoSize
