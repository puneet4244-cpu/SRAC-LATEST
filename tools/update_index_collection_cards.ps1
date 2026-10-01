$html = Get-Content "index.html" -Raw

# Arch Mehrab
$html = $html -replace '(<a href="/arch-mehrab/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/arch-mehrab.jpg$2Arches and Mehrabs - Hand-carved decorative sandstone archway in Gwalior Mint and Pink Sandstone - Shree Ram & Company Vieta Stone$3'

# Pillar
$html = $html -replace '(<a href="/pillar/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/pillar.jpg$2Pillars - Monumental fluted architectural stone columns with carved lotus capitals - Shree Ram & Company Vieta Stone$3'

# Handicrafts
$html = $html -replace '(<a href="/handicrafts/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/handicrafts.jpg$2Handicrafts - Hand-carved Indian white marble and sandstone artisan decor - Shree Ram & Company Vieta Stone$3'

# Pooja Room
$html = $html -replace '(<a href="/pooja-room/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/pooja-room.jpg$2Pooja Rooms - Complete luxury white marble mandir sanctum interior - Shree Ram & Company Vieta Stone$3'

# Stone Temple
$html = $html -replace '(<a href="/stone-temple/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/stone-temple.jpg$2Stone Temple - Sacred Pink Sandstone Bansi Paharpur outdoor mandir shikhara - Shree Ram & Company Vieta Stone$3'

# MDF Jali
$html = $html -replace '(<a href="/mdf-jali/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/mdf-jali.jpg$2MDF HDMR Jali - Precision CNC-cut decorative interior room divider screen - Shree Ram & Company Vieta Stone$3'

# Partition Jali
$html = $html -replace '(<a href="/partition-jali/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/partition-jali.jpg$2Partition Jali - Hand-carved architectural stone room partition screen - Shree Ram & Company Vieta Stone$3'

# WPC Jali
$html = $html -replace '(<a href="/wpc-jali/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/wpc-jali.jpg$2PVC WPC Jali - Weatherproof exterior CNC-cut balcony privacy screen - Shree Ram & Company Vieta Stone$3'

# Stone Carving
$html = $html -replace '(<a href="/stone-carving/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/statement-wall.jpg$2Stone Carving - Handcrafted architectural natural sandstone relief wall - Shree Ram & Company Vieta Stone$3'

# Murals & Wall Art
$html = $html -replace '(<a href="/murals-wall-art/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/radhe-krishna-mural.jpg$2Murals & Wall Art - Radha Krishna hand-carved white marble and pink sandstone mural - Shree Ram & Company Vieta Stone$3'

# Stone Wall Panels
$html = $html -replace '(<a href="/stone-wall-panels/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/stone-wall-panels.jpg$2Stone Wall Panels - Fluted and textured natural sandstone feature wall panels - Shree Ram & Company Vieta Stone$3'

# MDF HDMR Work
$html = $html -replace '(<a href="/mdf-hdmr-work/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/mdf-work.jpg$2MDF HDMR Work - Precision CNC-routed architectural moisture resistant panels - Shree Ram & Company Vieta Stone$3'

# Elevation Facade
$html = $html -replace '(<a href="/elevation-facade/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/elevation-facade.jpg$2Elevation Facade - Gwalior Mint and Karauli Red Sandstone luxury bungalow facade - Shree Ram & Company Vieta Stone$3'

# Garden Article
$html = $html -replace '(<a href="/garden-article/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/garden-article.jpg$2Garden Articles - Hand-carved sandstone planter urn and garden decor - Shree Ram & Company Vieta Stone$3'

# Customised Name Plate
$html = $html -replace '(<a href="/customised-name-plate/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/customised-name-plate.jpg$2Customised Name Plates - Hand-carved Jaisalmer sandstone and marble villa entrance plaque - Shree Ram & Company Vieta Stone$3'

# Wall Cladding
$html = $html -replace '(<a href="/wall-cladding/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/wall-cladding.jpg$2Wall Cladding - Split-face textured natural sandstone exterior wall cladding - Shree Ram & Company Vieta Stone$3'

# Marble Temples
$html = $html -replace '(<a href="/marble-temple/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/marble-temple.jpg$2Marble Temples - Hand-carved Makrana pure white marble home mandir - Shree Ram & Company Vieta Stone$3'

# Marble Inlay
$html = $html -replace '(<a href="/marble-inlay/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/marble-inlay.jpg$2Marble Inlay - Exquisite Pietra Dura semi-precious stone floral inlay on white marble - Shree Ram & Company Vieta Stone$3'

# Statues
$html = $html -replace '(<a href="/statue/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/marble-statue.jpg$2Statues - Single-block hand-sculpted crystalline white marble deity idol - Shree Ram & Company Vieta Stone$3'

# Gazebos
$html = $html -replace '(<a href="/gazebo/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/gazebo.jpg$2Gazebos - Hand-carved Rajasthani royal pink sandstone garden chhatri - Shree Ram & Company Vieta Stone$3'

# Marble Table Tops
$html = $html -replace '(<a href="/marble-table-tops/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/marble-table-tops.jpg$2Marble Table Tops - Solid Indian white marble table top with Pietra Dura floral vine border - Shree Ram & Company Vieta Stone$3'

# Water Fountains
$html = $html -replace '(<a href="/water-fountain/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/water-fountain.jpg$2Water Fountains - Multi-tiered hand-carved pink sandstone courtyard water fountain - Shree Ram & Company Vieta Stone$3'

# Stone Jali
$html = $html -replace '(<a href="/stone-jali/"[\s\S]*?<img src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/stone-jali.jpg$2Stone Jali - Hand-carved natural Gwalior mint sandstone geometric lattice screen - Shree Ram & Company Vieta Stone$3'

[System.IO.File]::WriteAllText((Resolve-Path "index.html"), $html, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html collection cards"
