# Update stone-art-murals/index.html and murals-wall-art/index.html
$muralPages = @("stone-art-murals/index.html", "murals-wall-art/index.html")

foreach ($page in $muralPages) {
    if (-not (Test-Path $page)) { continue }
    $html = Get-Content $page -Raw

    # Card 6: Laxmi Ji
    $html = $html -replace '(<div id="laxmi-ji-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/laxmi-ji-mural.jpg$2Goddess Laxmi seated on blooming lotus hand-carved in pristine white marble mural - Shree Ram & Company Vieta Stone$3'

    # Card 9: Swaminarayan Ji
    $html = $html -replace '(<div id="swaminarayan-ji-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/swaminarayan-ji-mural.jpg$2Bhagwan Swaminarayan sacred hand-carved stone mural in Pink Sandstone Bansi Paharpur - Shree Ram & Company Vieta Stone$3'

    # Card 10: Shreenath Ji
    $html = $html -replace '(<div id="shreenath-ji-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/shreenath-ji-mural.jpg$2Shreenath Ji Pushtimarg swaroop hand-carved in golden Jaisalmer sandstone with white marble inlay - Shree Ram & Company Vieta Stone$3'

    # Card 11: Village Stone Art
    $html = $html -replace '(<div id="village-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/village-stone-art.jpg$2Traditional Indian rural village life hand-carved in Red Sandstone Karauli mural - Shree Ram & Company Vieta Stone$3'

    # Card 1: Radhe Krishna
    $html = $html -replace '(<div id="radhe-krishna-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/radhe-krishna-mural.jpg$2Radhe Krishna hand-carved mural in Indian White Marble with Bansi Paharpur pink sandstone border - Shree Ram & Company Vieta Stone$3'

    # Card 2: Buddha
    $html = $html -replace '(<div id="buddha-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/statue.jpg$2Lord Buddha in deep meditation hand-carved in Gwalior Mint Sandstone relief mural - Shree Ram & Company Vieta Stone$3'

    # Card 3: Hanuman Ji
    $html = $html -replace '(<div id="hanuman-ji-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/hanuman-ji-mural.jpg$2Lord Hanuman in devotional flying posture hand-carved in Red Sandstone Karauli relief mural - Shree Ram & Company Vieta Stone$3'

    # Card 4: Durga Mata Ji
    $html = $html -replace '(<div id="durga-mata-ji-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/durga-mata-mural.jpg$2Goddess Durga on lion Sherawali hand-carved in Indian White Marble and Pink Sandstone arch mural - Shree Ram & Company Vieta Stone$3'

    # Card 5: Ganesh Ji
    $html = $html -replace '(<div id="ganesh-ji-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/ganesh-ji-mural.jpg$2Lord Ganesha in blessing posture hand-carved in golden Jaisalmer and Teak Sandstone relief mural - Shree Ram & Company Vieta Stone$3'

    # Card 7: Ram Darbar
    $html = $html -replace '(<div id="ram-darbar-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/ram-darbar-mural.jpg$2Sacred Ram Darbar hand-carved in Pink Sandstone Bansi Paharpur with White Marble highlights mural - Shree Ram & Company Vieta Stone$3'

    # Card 8: Shiv Ji
    $html = $html -replace '(<div id="shiv-ji-stone-art-mural"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/shiv-ji-mural.jpg$2Lord Shiva on Mount Kailash with Trishul hand-carved in textured Moka Grey and Kandla Grey Sandstone mural - Shree Ram & Company Vieta Stone$3'

    # Card 12: Floral Stone Art
    $html = $html -replace '(<div id="floral-stone-art"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/floral-stone-art.jpg$2Mughal blooming lotus and floral botanical pattern hand-carved in Gwalior Mint Sandstone - Shree Ram & Company Vieta Stone$3'

    [System.IO.File]::WriteAllText((Resolve-Path $page), $html, [System.Text.Encoding]::UTF8)
    Write-Host "Updated $page"
}

# Update stone-wall-panels/index.html
if (Test-Path "stone-wall-panels/index.html") {
    $page = "stone-wall-panels/index.html"
    $html = Get-Content $page -Raw

    $html = $html -replace '(<div id="fluted-stone-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/fluted-stone-panels.jpg$2Fluted natural stone panels in Kandla Grey and Gwalior Mint Sandstone with vertical CNC grooves - Shree Ram & Company Vieta Stone$3'
    $html = $html -replace '(<div id="textured-stone-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/textured-stone-panels.jpg$2Split-face textured natural stone wall panels in Moka Grey and Karauli Red Sandstone - Shree Ram & Company Vieta Stone$3'
    $html = $html -replace '(<div id="wave-stone-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/wave-stone-panels.jpg$23D undulating flowing wave relief panels in natural Vietnam White Marble and Gwalior Mint Sandstone - Shree Ram & Company Vieta Stone$3'
    $html = $html -replace '(<div id="geometrical-stone-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/geometrical-stone-panels.jpg$2Geometric interlocking faceted 3D relief wall panels in Teak and Jaisalmer Sandstone - Shree Ram & Company Vieta Stone$3'

    [System.IO.File]::WriteAllText((Resolve-Path $page), $html, [System.Text.Encoding]::UTF8)
    Write-Host "Updated $page"
}

# Update mdf-hdmr-work/index.html
if (Test-Path "mdf-hdmr-work/index.html") {
    $page = "mdf-hdmr-work/index.html"
    $html = Get-Content $page -Raw

    $html = $html -replace '(<div id="mdf-hdmr-wall-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/mdf-hdmr-wall-panels.jpg$2CNC-routed High-Density Moisture-Resistant HDMR architectural panels with matte ivory PU finish - Shree Ram & Company Vieta Stone$3'
    $html = $html -replace '(<div id="fluted-mdf-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/fluted-mdf-panels.jpg$2Precision fluted HDMR wall panels in warm teak wood veneer finish - Shree Ram & Company Vieta Stone$3'
    $html = $html -replace '(<div id="textured-mdf-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/textured-mdf-panels.jpg$2Textured HDMR architectural panels with embossed satin champagne finish - Shree Ram & Company Vieta Stone$3'
    $html = $html -replace '(<div id="wave-mdf-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/wave-mdf-panels.jpg$2Continuous flowing 3D wave HDMR wall panels in seamless matte champagne PU finish - Shree Ram & Company Vieta Stone$3'
    $html = $html -replace '(<div id="geometrical-mdf-panels"[^>]*>[\s\S]*?<div class="gallery-slide[^"]*data-index="0">\s*<img\s+src=")[^"]+("\s*alt=")[^"]+(")', '$1/assets/images/geometrical-mdf-panels.jpg$2Precision CNC-cut 3D geometric chevron HDMR panels in matte warm grey finish - Shree Ram & Company Vieta Stone$3'

    [System.IO.File]::WriteAllText((Resolve-Path $page), $html, [System.Text.Encoding]::UTF8)
    Write-Host "Updated $page"
}
