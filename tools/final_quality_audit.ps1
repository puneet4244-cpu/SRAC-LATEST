Add-Type -AssemblyName System.Drawing

$report = @()

$products = @(
    # Category 1: WALL SURFACES
    # 1.1 Stone Carving
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Carving"
        Product = "Double Height Wall"
        Images = 6
        Material = "Gwalior Mint Sandstone & Teak Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No (Authentic client project photos installed)"
        PrimaryFile = "assets/images/double-height-wall-01.jpg"
        Alt = "Concentric radial sunburst mandala medallion stone carving panels with multi-layered fluted textures in double-height entrance lobby - Shree Ram and Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Carving"
        Product = "Staircase Wall"
        Images = 5
        Material = "Gwalior Mint Sandstone & Kandla Grey Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No (Authentic client project photos installed)"
        PrimaryFile = "assets/images/staircase-mandala-radial-carving.jpg"
        Alt = "Staircase wall clad with hand-carved Gwalior Mint and Kandla Grey Sandstone panels in continuous flowing radial motif - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Carving"
        Product = "Sofa Wall"
        Images = 5
        Material = "Teak Sandstone & Gwalior Mint Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/sofa-wall.jpg"
        Alt = "Living room sofa feature wall hand-carved in natural Teak Sandstone with Gwalior Mint Sandstone framing - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Carving"
        Product = "Statement Wall"
        Images = 5
        Material = "Pink Sandstone Bansi Paharpur & Indian White Marble"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/statement-wall.jpg"
        Alt = "Foyer signature statement wall in sacred Pink Sandstone Bansi Paharpur with Indian White Marble inlay - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Carving"
        Product = "Living Room Wall"
        Images = 5
        Material = "Jaisalmer Sandstone & Teak Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/living-room-wall.jpg"
        Alt = "Luxury living room accent wall hand-carved in royal golden Jaisalmer Sandstone with Teak Sandstone accents - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Carving"
        Product = "Featured Wall"
        Images = 5
        Material = "Moka Grey & Gwalior Mint Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/featured-wall.jpg"
        Alt = "Interior featured accent wall in Moka Grey natural stone with Gwalior Mint Sandstone 3D relief lattice - Shree Ram & Company Vieta Stone"
    },

    # 1.2 Stone Art & Murals
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Radhe Krishna Stone Art & Mural"
        Images = 5
        Material = "Indian White Marble & Pink Sandstone Bansi Paharpur"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/radhe-krishna-mural.jpg"
        Alt = "Radha Krishna under kadamba tree hand-carved in Indian White Marble with Bansi Paharpur Pink Sandstone border - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Buddha Stone Art & Mural"
        Images = 5
        Material = "Gwalior Mint Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/statue.jpg"
        Alt = "Lord Buddha in deep meditation hand-carved in Gwalior Mint Sandstone with lotus relief border - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Hanuman Ji Stone Art & Mural"
        Images = 5
        Material = "Red Sandstone Karauli"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/hanuman-ji-mural.jpg"
        Alt = "Lord Hanuman in devotional flying posture carrying Dronagiri hand-carved in Red Sandstone Karauli - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Durga Mata Ji Stone Art & Mural"
        Images = 5
        Material = "Indian White Marble & Pink Sandstone Bansi Paharpur"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/durga-mata-mural.jpg"
        Alt = "Goddess Durga seated on lion Sherawali hand-carved in Indian White Marble with Pink Sandstone Bansi Paharpur arch - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Ganesh Ji Stone Art & Mural"
        Images = 5
        Material = "Jaisalmer Sandstone & Teak Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/ganesh-ji-mural.jpg"
        Alt = "Lord Ganesha in blessing posture hand-carved in golden Jaisalmer Sandstone with Teak Sandstone frame - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Laxmi Ji Stone Art & Mural"
        Images = 5
        Material = "Vietnam White Marble"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client workshop photo of Laxmi Ji marble carving)"
        PrimaryFile = "assets/images/laxmi-ji-mural.jpg"
        Alt = "Goddess Laxmi seated on blooming lotus with royal elephants Gaja Laxmi hand-carved in crystalline Vietnam White Marble - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Ram Darbar Stone Art & Mural"
        Images = 5
        Material = "Pink Sandstone Bansi Paharpur & Indian White Marble"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/ram-darbar-mural.jpg"
        Alt = "Sacred Ram Darbar hand-carved in Pink Sandstone Bansi Paharpur with Indian White Marble highlights - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Shiv Ji Stone Art & Mural"
        Images = 5
        Material = "Moka Grey & Kandla Grey Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/shiv-ji-mural.jpg"
        Alt = "Lord Shiva in deep meditation on Mount Kailash with Trishul hand-carved in textured Moka Grey and Kandla Grey stone - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Swaminarayan Ji Stone Art & Mural"
        Images = 5
        Material = "Pink Sandstone Bansi Paharpur & Indian White Marble"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client workshop photo of Swaminarayan Ji carving)"
        PrimaryFile = "assets/images/swaminarayan-ji-mural.jpg"
        Alt = "Bhagwan Swaminarayan sacred hand-carved stone mural in Pink Sandstone Bansi Paharpur with pure white marble highlights - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Shreenath Ji Stone Art & Mural"
        Images = 5
        Material = "Jaisalmer Sandstone & Indian White Marble"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client workshop photo of Shreenath Ji carving)"
        PrimaryFile = "assets/images/shreenath-ji-mural.jpg"
        Alt = "Shreenath Ji Pushtimarg swaroop hand-carved in golden Jaisalmer Sandstone with Indian White Marble inlay - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Village Stone Art & Mural"
        Images = 5
        Material = "Red Sandstone Karauli & Teak Sandstone"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client workshop photo of rural village carving)"
        PrimaryFile = "assets/images/village-stone-art.jpg"
        Alt = "Traditional rural Indian village scene with bullock cart and huts hand-carved in Red Sandstone Karauli and Teak Sandstone - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Art & Murals"
        Product = "Floral Stone Art"
        Images = 5
        Material = "Gwalior Mint Sandstone & Indian White Marble"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/floral-stone-art.jpg"
        Alt = "Mughal-inspired blooming lotus and botanical vine pattern hand-carved in Gwalior Mint Sandstone with white marble accents - Shree Ram & Company Vieta Stone"
    },

    # 1.3 Stone Wall Panels
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Wall Panels"
        Product = "Fluted Stone Panels"
        Images = 5
        Material = "Kandla Grey Sandstone & Gwalior Mint Sandstone"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client site photo of fluted stone wall)"
        PrimaryFile = "assets/images/fluted-stone-panels.jpg"
        Alt = "Vertical fluted natural stone panels in Kandla Grey and Gwalior Mint Sandstone with CNC grooves - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Wall Panels"
        Product = "Textured Stone Panels"
        Images = 5
        Material = "Moka Grey & Red Sandstone Karauli"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client site photo of split-face stone wall)"
        PrimaryFile = "assets/images/textured-stone-panels.jpg"
        Alt = "Split-face textured natural stone wall panels in Moka Grey and Karauli Red Sandstone - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Wall Panels"
        Product = "Wave Stone Panels"
        Images = 5
        Material = "Vietnam White Marble & Gwalior Mint Sandstone"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client site photo of 3D wave stone wall)"
        PrimaryFile = "assets/images/wave-stone-panels.jpg"
        Alt = "Seamless 3D undulating flowing wave relief panels in natural Vietnam White Marble and Gwalior Mint Sandstone - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "Stone Wall Panels"
        Product = "Geometrical Stone Panels"
        Images = 5
        Material = "Teak Sandstone & Jaisalmer Sandstone"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with client site photo of geometric stone wall)"
        PrimaryFile = "assets/images/geometrical-stone-panels.jpg"
        Alt = "Precision CNC-cut interlocking triangular and hexagonal 3D relief panels in Teak and Jaisalmer Sandstone - Shree Ram & Company Vieta Stone"
    },

    # 1.4 MDF HDMR Work
    @{
        Category = "Wall Surfaces"
        SubCategory = "MDF HDMR Work"
        Product = "MDF HDMR Wall Panels"
        Images = 5
        Material = "High-Density Moisture-Resistant (HDMR) Board"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with factory photo of CNC routed HDMR panels)"
        PrimaryFile = "assets/images/mdf-hdmr-wall-panels.jpg"
        Alt = "CNC-routed High-Density Moisture-Resistant HDMR architectural panels with matte ivory PU finish - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "MDF HDMR Work"
        Product = "Fluted MDF Panels"
        Images = 5
        Material = "HDMR Board with Teak Veneer / Matte PU"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with factory photo of fluted HDMR panels)"
        PrimaryFile = "assets/images/fluted-mdf-panels.jpg"
        Alt = "Precision-cut fluted HDMR board panels with vertical acoustic ridges in warm teak wood veneer finish - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "MDF HDMR Work"
        Product = "Textured MDF Panels"
        Images = 5
        Material = "HDMR Board with Satin / Metallic Finish"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with factory photo of textured HDMR panels)"
        PrimaryFile = "assets/images/textured-mdf-panels.jpg"
        Alt = "Textured HDMR architectural panels with repeating embossed organic relief in satin champagne beige - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "MDF HDMR Work"
        Product = "Wave MDF Panels"
        Images = 5
        Material = "High-Density HDMR Board"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with factory photo of wave HDMR panels)"
        PrimaryFile = "assets/images/wave-mdf-panels.jpg"
        Alt = "Continuous 3D flowing wave HDMR wall panels in seamless matte champagne PU finish - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Wall Surfaces"
        SubCategory = "MDF HDMR Work"
        Product = "Geometrical MDF Panels"
        Images = 5
        Material = "HDMR Board with PU Finish"
        Source = "AI placeholder (Photorealistic architectural rendering)"
        NeedsRealPhoto = "Yes (Replace with factory photo of geometric HDMR panels)"
        PrimaryFile = "assets/images/geometrical-mdf-panels.jpg"
        Alt = "Precision CNC-cut repeating 3D chevron and diamond geometric HDMR panels in matte warm grey - Shree Ram & Company Vieta Stone"
    },

    # Category 2: EXTERIOR ELEVATION
    @{
        Category = "Exterior Elevation"
        SubCategory = "Elevation Facade"
        Product = "Elevation Facade"
        Images = 5
        Material = "Gwalior Mint Sandstone, Karauli Red & Bansi Paharpur Pink Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/elevation-facade.jpg"
        Alt = "Modern luxury bungalow exterior facade clad in Gwalior Mint, Karauli Red, and Bansi Paharpur Pink Sandstone - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Exterior Elevation"
        SubCategory = "Customised Name Plates"
        Product = "Customised Name Plates"
        Images = 5
        Material = "Jaisalmer Sandstone & Indian White Marble"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic carved stone plaque installed)"
        PrimaryFile = "assets/images/customised-name-plate.jpg"
        Alt = "Bespoke hand-carved villa entrance name plate in golden Jaisalmer Sandstone with polished white marble lettering - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Exterior Elevation"
        SubCategory = "Wall Cladding"
        Product = "Wall Cladding"
        Images = 5
        Material = "Kandla Grey Sandstone, Moka Grey & Red Sandstone Karauli"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic split-face stone cladding installed)"
        PrimaryFile = "assets/images/wall-cladding.jpg"
        Alt = "Exterior boundary wall and villa facade clad in split-face Kandla Grey, Moka Grey, and Red Sandstone - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Exterior Elevation"
        SubCategory = "Garden Articles"
        Product = "Garden Articles"
        Images = 5
        Material = "Pink Sandstone Bansi Paharpur & Gwalior Mint Sandstone"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic carved stone urn planter installed)"
        PrimaryFile = "assets/images/garden-article.jpg"
        Alt = "Hand-carved natural Pink Sandstone Bansi Paharpur garden planter urn in landscaped luxury villa grounds - Shree Ram & Company Vieta Stone"
    },

    # Category 3: TEMPLES & STATUES
    @{
        Category = "Temples & Statues"
        SubCategory = "Marble Temples"
        Product = "Marble Temples"
        Images = 5
        Material = "Indian White Marble (Makrana Grade)"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/marble-temple.jpg"
        Alt = "Opulent hand-carved Indian White Marble home mandir with sculpted pillars, shikhara dome, and jaali lattice - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Temples & Statues"
        SubCategory = "Stone Temple"
        Product = "Stone Temple"
        Images = 5
        Material = "Pink Sandstone Bansi Paharpur & Gwalior Mint Sandstone"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic nagara shikhara sandstone temple installed)"
        PrimaryFile = "assets/images/stone-temple.jpg"
        Alt = "Majestic outdoor nagara shikhara temple structure hand-carved in sacred Pink Sandstone Bansi Paharpur - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Temples & Statues"
        SubCategory = "Pooja Rooms"
        Product = "Pooja Rooms"
        Images = 5
        Material = "Indian White Marble & Vietnam White Marble"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic white marble sanctum installed)"
        PrimaryFile = "assets/images/pooja-room.jpg"
        Alt = "Complete luxury home pooja room interior crafted in pure white marble with carved altar and backlit jaali - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Temples & Statues"
        SubCategory = "Marble Inlay"
        Product = "Marble Inlay"
        Images = 5
        Material = "Indian White Marble with Pietra Dura Semi-Precious Stone Inlay"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/marble-inlay.jpg"
        Alt = "Exquisite Pietra Dura semi-precious stone floral vine inlay on pristine Indian White Marble - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Temples & Statues"
        SubCategory = "Statues"
        Product = "Statues"
        Images = 5
        Material = "Vietnam White Marble & Indian White Marble"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic hand-sculpted white marble deity idol installed)"
        PrimaryFile = "assets/images/marble-statue.jpg"
        Alt = "Divine deity idol hand-sculpted from single-block crystalline white marble on carved lotus pedestal - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Temples & Statues"
        SubCategory = "Gazebos"
        Product = "Gazebos"
        Images = 5
        Material = "Pink Sandstone Bansi Paharpur & Red Sandstone Karauli"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic royal Bada Bagh sandstone chhatri installed)"
        PrimaryFile = "assets/images/gazebo.jpg"
        Alt = "Royal Rajasthani garden gazebo chhatri hand-carved in Pink Sandstone Bansi Paharpur with domed roof and carved pillars - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Temples & Statues"
        SubCategory = "Arches & Mehrabs"
        Product = "Arches & Mehrabs"
        Images = 5
        Material = "Gwalior Mint Sandstone & Pink Sandstone Bansi Paharpur"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/arch-mehrab.jpg"
        Alt = "Decorative architectural entrance arch mehrab hand-carved in Gwalior Mint and Pink Sandstone with floral cusped curve - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Temples & Statues"
        SubCategory = "Pillars"
        Product = "Pillars"
        Images = 5
        Material = "Gwalior Mint Sandstone, Pink Sandstone & Teak Sandstone"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic hand-carved stone temple pillars installed)"
        PrimaryFile = "assets/images/pillar.jpg"
        Alt = "Monumental hand-carved architectural stone pillars with fluted shafts and ornate lotus capitals - Shree Ram & Company Vieta Stone"
    },

    # Category 4: HOME INTERIOR & DECOR
    @{
        Category = "Home Interior & Decor"
        SubCategory = "Handicrafts"
        Product = "Handicrafts"
        Images = 5
        Material = "Indian White Marble, Jaisalmer Sandstone & Teak Sandstone"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic Jaipur carved marble artisan handicraft installed)"
        PrimaryFile = "assets/images/handicrafts.jpg"
        Alt = "Luxury tabletop hand-carved Indian White Marble jaali elephant and stone decor - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Home Interior & Decor"
        SubCategory = "Marble Table Tops"
        Product = "Marble Table Tops"
        Images = 5
        Material = "Indian White Marble with Pietra Dura Inlay"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic Agra Pietra Dura marble dining table installed)"
        PrimaryFile = "assets/images/marble-table-tops.jpg"
        Alt = "Luxury dining table top crafted from solid Indian White Marble with Pietra Dura floral vine inlay border - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "Home Interior & Decor"
        SubCategory = "Water Fountains"
        Product = "Water Fountains"
        Images = 5
        Material = "Pink Sandstone Bansi Paharpur & Kandla Grey Sandstone"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/water-fountain.jpg"
        Alt = "Multi-tiered natural stone water fountain hand-carved in Pink Sandstone Bansi Paharpur with cascading water pool - Shree Ram & Company Vieta Stone"
    },

    # Category 5: CNC JALI WORK
    @{
        Category = "CNC Jali Work"
        SubCategory = "Stone Jali"
        Product = "Stone Jali"
        Images = 5
        Material = "Gwalior Mint Sandstone, Pink Sandstone & Indian White Marble"
        Source = "Client Project Photo"
        NeedsRealPhoto = "No"
        PrimaryFile = "assets/images/stone-jali.jpg"
        Alt = "Architectural perforated stone jali screen panel carved from solid Gwalior Mint Sandstone with geometric lattice - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "CNC Jali Work"
        SubCategory = "MDF / HDMR Jali"
        Product = "MDF / HDMR Jali"
        Images = 5
        Material = "High-Density HDMR Board (Matte PU Painted)"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic CNC-cut interior room divider screen installed)"
        PrimaryFile = "assets/images/mdf-jali.jpg"
        Alt = "Modern interior room divider jali screen precision CNC-cut from HDMR board with smooth matte cream painted finish - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "CNC Jali Work"
        SubCategory = "Partition Jali"
        Product = "Partition Jali"
        Images = 5
        Material = "Teak Sandstone & Kandla Grey Sandstone"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic architectural stone partition screen installed)"
        PrimaryFile = "assets/images/partition-jali.jpg"
        Alt = "Full-height architectural partition jali screen dividing luxury dining and living spaces with geometric fretwork - Shree Ram & Company Vieta Stone"
    },
    @{
        Category = "CNC Jali Work"
        SubCategory = "PVC / WPC Jali"
        Product = "PVC / WPC Jali"
        Images = 5
        Material = "Weatherproof WPC / PVC Polymer"
        Source = "Licensed Architectural Photography"
        NeedsRealPhoto = "Optional (Authentic exterior weatherproof facade screen installed)"
        PrimaryFile = "assets/images/wpc-jali.jpg"
        Alt = "Contemporary exterior CNC-cut WPC jali screen panel with modern geometric motif for balcony facade privacy - Shree Ram & Company Vieta Stone"
    }
)

Write-Host "Verifying each product primary image file..."
$verifiedRows = @()

foreach ($p in $products) {
    $exists = Test-Path $p.PrimaryFile
    $unwatermarkedExists = Test-Path ("assets/originals-unwatermarked/" + [System.IO.Path]::GetFileName($p.PrimaryFile))
    $w = -1
    $h = -1
    if ($exists) {
        $img = [System.Drawing.Image]::FromFile($p.PrimaryFile)
        $w = $img.Width
        $h = $img.Height
        $img.Dispose()
    }
    $verifiedRows += [PSCustomObject]@{
        Category = $p.Category
        Product = $p.Product
        Images = $p.Images
        Material = $p.Material
        Source = $p.Source
        Dimensions = "$w x $h"
        UnwatermarkedBackup = if ($unwatermarkedExists) { "Yes" } else { "No" }
        NeedsRealPhoto = $p.NeedsRealPhoto
    }
}

$verifiedRows | Format-Table -AutoSize

# Export Report to CSV and Markdown
$verifiedRows | Export-Csv -Path "tools/product_image_audit_report.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Report exported to tools/product_image_audit_report.csv"
