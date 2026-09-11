# Execution script to generate all 5 categories, subcategories, parent hubs, and product leaf pages
$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

. "$baseDir\master_page_builder.ps1"

# =========================================================================
# 1. WALL SURFACES: DIRECT SUBCATEGORY PRODUCT PAGES (No Detail Pages)
# =========================================================================

# 1.1 Stone Carving Subcategory Page (6 Products Directly on Page)
$stoneCarvingProducts = @(
    @{ 
        Name = "Double Height Wall"; 
        Desc = "Monumental stone carved elevations designed for 18-30 ft tall luxury villa lobbies, duplex halls, and living spaces."; 
        Material = "Gwalior Mint Sandstone & Teak Sandstone"; 
        Size = "Customized up to 25 ft height"; 
        Images = @(
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/double-height-lotus-backlit.jpg",
            "/assets/images/staircase-mandala-radial-carving.jpg",
            "/assets/images/staircase-maple-leaf-relief.jpg",
            "/assets/images/staircase-ginkgo-backlit-panel.jpg"
        )
    },
    @{ 
        Name = "Staircase Wall"; 
        Desc = "Artistic hand-carved stone wall cladding that ascends gracefully along duplex and grand staircase atriums."; 
        Material = "Gwalior Mint Sandstone & Kandla Grey Sandstone"; 
        Size = "Customized to staircase rise & run"; 
        Images = @(
            "/assets/images/staircase-mandala-radial-carving.jpg",
            "/assets/images/staircase-maple-leaf-relief.jpg",
            "/assets/images/staircase-ginkgo-backlit-panel.jpg",
            "/assets/images/double-height-lotus-backlit.jpg",
            "/assets/images/double-height-medallion-facade.jpg"
        )
    },
    @{ 
        Name = "Sofa Wall"; 
        Desc = "Bespoke textured and carved stone backdrops behind master living room sofa seating with ambient perimeter lighting."; 
        Material = "Teak Sandstone & Gwalior Mint Sandstone"; 
        Size = "Custom Wall Dimensions (e.g. 12x10 ft)"; 
        Images = @(
            "/assets/images/sofa-wall.jpg",
            "/assets/images/staircase-ginkgo-backlit-panel.jpg",
            "/assets/images/double-height-lotus-backlit.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Statement Wall"; 
        Desc = "High-impact signature stone focal points with 3D relief detailing and royal geometry for grand entrance foyers."; 
        Material = "Pink Sandstone Bansi Paharpur & Indian White Marble"; 
        Size = "Customized As Per Site Specs"; 
        Images = @(
            "/assets/images/statement-wall.jpg",
            "/assets/images/double-height-lotus-backlit.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/staircase-mandala-radial-carving.jpg",
            "/assets/images/stone-carving.jpg"
        )
    },
    @{ 
        Name = "Living Room Wall"; 
        Desc = "Warm, elegant natural sandstone surfaces with subtle geometric and floral relief carving for modern living halls."; 
        Material = "Jaisalmer Sandstone & Teak Sandstone"; 
        Size = "Modular interlocking blocks"; 
        Images = @(
            "/assets/images/living-room-wall.jpg",
            "/assets/images/staircase-maple-leaf-relief.jpg",
            "/assets/images/staircase-mandala-radial-carving.jpg",
            "/assets/images/staircase-ginkgo-backlit-panel.jpg",
            "/assets/images/stone-wall-panel.jpg"
        )
    },
    @{ 
        Name = "Featured Wall"; 
        Desc = "Custom sculpted architectural highlight walls tailored for master bedroom, luxury suites, and boardroom backdrops."; 
        Material = "Moka Grey & Gwalior Mint Sandstone"; 
        Size = "Bespoke Full Wall Dimensions"; 
        Images = @(
            "/assets/images/featured-wall.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/staircase-mandala-radial-carving.jpg",
            "/assets/images/double-height-lotus-backlit.jpg",
            "/assets/images/stone-carving.jpg"
        )
    }
)

Generate-ProductLeafPage `
    -pagePath "$baseDir\stone-carving\index.html" `
    -title "Stone Carving Wall Surfaces" `
    -metaDesc "Discover luxury handcrafted stone carving collections by Shree Ram & Company Jaipur: Double Height Wall, Staircase Wall, Sofa Wall, Statement Wall, Living Room Wall, Featured Wall." `
    -categoryName "Stone Carving" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/double-height-medallion-facade.jpg" `
    -introOverview "Bespoke architectural hand-carved natural stone walls for luxury residences, duplex atriums, and grand living spaces. Handcrafted in solid sandstone and Makrana marble." `
    -products $stoneCarvingProducts

# Generate redirect stubs for child folders so no separate product detail pages exist
foreach ($p in $stoneCarvingProducts) {
    $slug = ($p.Name.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
    Generate-RedirectStub `
        -pagePath "$baseDir\stone-carving\$slug\index.html" `
        -targetUrl "/stone-carving/#$slug" `
        -title $p.Name
}

# 1.2 Stone Art & Murals Subcategory Page (12 Products Directly on Page)
$stoneArtProducts = @(
    @{ Name = "Radhe Krishna Stone Art & Mural"; Desc = "Divine Radha Krishna Vrindavan leela murals carved in Indian White Marble & Pink Sandstone Bansi Paharpur."; Material = "Indian White Marble & Pink Sandstone Bansi Paharpur"; Size = "5x3 ft / 8x5 ft / Custom"; Images = @("/assets/images/radhe-krishna-mural.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg", "/assets/images/statue.jpg") },
    @{ Name = "Buddha Stone Art & Mural"; Desc = "Serene meditative Buddha wall reliefs bringing peace and zen tranquility in fine Gwalior Mint Sandstone."; Material = "Gwalior Mint Sandstone"; Size = "6x4 ft / Custom Height"; Images = @("/assets/images/statue.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-wall-panel.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Hanuman Ji Stone Art & Mural"; Desc = "Majestic and powerful Lord Hanuman 3D relief murals sculpted in authentic Red Sandstone Karauli."; Material = "Red Sandstone Karauli"; Size = "Custom Full Wall Dimensions"; Images = @("/assets/images/hanuman-ji-mural.jpg", "/assets/images/stone-carving.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/statue.jpg") },
    @{ Name = "Durga Mata Ji Stone Art & Mural"; Desc = "Auspicious and grand Maa Durga Sherawali stone wall art with intricate ornamentation in Indian White Marble."; Material = "Indian White Marble & Pink Sandstone Bansi Paharpur"; Size = "Custom Temple & Foyer Scale"; Images = @("/assets/images/durga-mata-mural.jpg", "/assets/images/mural-art.jpg", "/assets/images/statue.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/marble-temple.jpg") },
    @{ Name = "Ganesh Ji Stone Art & Mural"; Desc = "Vighnaharta Lord Ganesha auspicious entrance murals in solid Jaisalmer Sandstone and Teak Sandstone."; Material = "Jaisalmer Sandstone & Teak Sandstone"; Size = "4x3 ft / 6x4 ft / Custom"; Images = @("/assets/images/ganesh-ji-mural.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/mural-art.jpg", "/assets/images/stone-carving.jpg", "/assets/images/statue.jpg") },
    @{ Name = "Laxmi Ji Stone Art & Mural"; Desc = "Maa Lakshmi prosperity murals with lotus detailing for wealth and positive Vastu energy in Vietnam White Marble."; Material = "Vietnam White Marble"; Size = "Custom Entrance Dimensions"; Images = @("/assets/images/mural-art.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/statue.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Ram Darbar Stone Art & Mural"; Desc = "Sacred Ram Darbar wall relief carvings in Pink Sandstone Bansi Paharpur & Indian White Marble."; Material = "Pink Sandstone Bansi Paharpur & Indian White Marble"; Size = "Full Pooja Room & Hall Scale"; Images = @("/assets/images/ram-darbar-mural.jpg", "/assets/images/marble-temple.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Shiv Ji Stone Art & Mural"; Desc = "Cosmic Lord Shiva Adiyogi and Kailash meditation murals hand-chiselled in Moka Grey & Kandla Grey Sandstone."; Material = "Moka Grey & Kandla Grey Sandstone"; Size = "Bespoke Monumental Dimensions"; Images = @("/assets/images/shiv-ji-mural.jpg", "/assets/images/statue.jpg", "/assets/images/mural-art.jpg", "/assets/images/stone-carving.jpg", "/assets/images/jaipur-artisan.jpg") },
    @{ Name = "Swaminarayan Ji Stone Art & Mural"; Desc = "Akshardham-inspired Bhagwan Swaminarayan devotional architectural stone art in Pink Sandstone Bansi Paharpur."; Material = "Pink Sandstone Bansi Paharpur & Indian White Marble"; Size = "Custom Site Blueprints"; Images = @("/assets/images/marble-temple.jpg", "/assets/images/stone-carving.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/pillar.jpg") },
    @{ Name = "Shreenath Ji Stone Art & Mural"; Desc = "Iconic Shreenath Ji Pushtimarg temple style relief art in royal Jaisalmer Sandstone with Indian White Marble."; Material = "Jaisalmer Sandstone & Indian White Marble"; Size = "5x4 ft / 8x6 ft / Custom"; Images = @("/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/stone-carving.jpg", "/assets/images/statue.jpg") },
    @{ Name = "Village Stone Art & Mural"; Desc = "Nostalgic traditional Indian village life, folk dancers, and rural cultural narratives in Red Sandstone Karauli."; Material = "Red Sandstone Karauli & Teak Sandstone"; Size = "Custom Panoramic Wall Scale"; Images = @("/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg", "/assets/images/mural-art.jpg", "/assets/images/staircase-maple-leaf-relief.jpg", "/assets/images/stone-wall-panel.jpg") },
    @{ Name = "Floral Stone Art"; Desc = "Timeless blooming lotus, vines, and botanic stone sculptures in Gwalior Mint Sandstone with Indian White Marble."; Material = "Gwalior Mint Sandstone & Indian White Marble"; Size = "Modular & Bespoke Panels"; Images = @("/assets/images/floral-stone-art.jpg", "/assets/images/marble-inlay.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/stone-carving.jpg", "/assets/images/jaipur-artisan.jpg") }
)

Generate-ProductLeafPage `
    -pagePath "$baseDir\stone-art-murals\index.html" `
    -title "Stone Art & Murals" `
    -metaDesc "Explore handcrafted divine spiritual stone murals and artistic wall reliefs by master stone sculptors of Shree Ram & Company Jaipur." `
    -categoryName "Stone Art & Murals" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/mural-art.jpg" `
    -introOverview "Divine spiritual stone murals, deity reliefs, and artistic wall sculptures handcrafted by Jaipur's master artisans in Makrana marble and natural sandstone." `
    -products $stoneArtProducts

Generate-ProductLeafPage `
    -pagePath "$baseDir\murals-wall-art\index.html" `
    -title "Stone Art & Murals" `
    -metaDesc "Explore handcrafted divine spiritual stone murals and artistic wall reliefs by master stone sculptors of Shree Ram & Company Jaipur." `
    -categoryName "Stone Art & Murals" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/mural-art.jpg" `
    -introOverview "Divine spiritual stone murals, deity reliefs, and artistic wall sculptures handcrafted by Jaipur's master artisans in Makrana marble and natural sandstone." `
    -products $stoneArtProducts

foreach ($p in $stoneArtProducts) {
    $slug = ($p.Name.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
    Generate-RedirectStub `
        -pagePath "$baseDir\stone-art-murals\$slug\index.html" `
        -targetUrl "/stone-art-murals/#$slug" `
        -title $p.Name
}
foreach ($short in @("radhe-krishna", "buddha", "hanuman-ji", "durga-mata-ji", "ganesh-ji", "laxmi-ji", "ram-darbar", "shiv-ji", "swaminarayan-ji", "shreenath-ji", "village-stone-art", "floral-stone-art")) {
    Generate-RedirectStub `
        -pagePath "$baseDir\stone-art-murals\$short\index.html" `
        -targetUrl "/stone-art-murals/#$short" `
        -title $short
}

# 1.3 Stone Wall Panels Subcategory Page (4 Products Directly on Page)
$stoneWallPanelProducts = @(
    @{ Name = "Fluted Stone Panels"; Desc = "Vertical linear fluted stone cladding creating modern texture, rhythm, and acoustic warmth."; Material = "Kandla Grey Sandstone & Gwalior Mint Sandstone"; Size = "4x2 ft interlocking panels"; Images = @("/assets/images/stone-wall-panel.jpg", "/assets/images/double-height-medallion-facade.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg", "/assets/images/stone-jali.jpg") },
    @{ Name = "Textured Stone Panels"; Desc = "Natural split-face, bush-hammered, and chiseled stone wall cladding panels."; Material = "Moka Grey & Red Sandstone Karauli"; Size = "6x3 ft & Custom Large Format"; Images = @("/assets/images/jaipur-artisan.jpg", "/assets/images/stone-wall-panel.jpg", "/assets/images/staircase-maple-leaf-relief.jpg", "/assets/images/stone-carving.jpg", "/assets/images/double-height-medallion-facade.jpg") },
    @{ Name = "Wave Stone Panels"; Desc = "Flowing curvilinear 3D wave patterns carved seamlessly across continuous wall expanses."; Material = "Vietnam White Marble & Gwalior Mint Sandstone"; Size = "Custom Wall Configuration"; Images = @("/assets/images/stone-wall-panel.jpg", "/assets/images/staircase-ginkgo-backlit-panel.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Geometrical Stone Panels"; Desc = "Crisp diamond, chevron, hexagonal, and parametric 3D geometric stone tile panels."; Material = "Teak Sandstone & Jaisalmer Sandstone"; Size = "Modular 2x2 ft & 4x2 ft Tiles"; Images = @("/assets/images/stone-jali.jpg", "/assets/images/stone-wall-panel.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/double-height-medallion-facade.jpg", "/assets/images/stone-carving.jpg") }
)

Generate-ProductLeafPage `
    -pagePath "$baseDir\stone-wall-panels\index.html" `
    -title "Stone Wall Panels" `
    -metaDesc "Luxury 3D CNC and hand-textured stone wall panels including fluted, wave, textured, and geometrical designs by Shree Ram & Company." `
    -categoryName "Stone Wall Panels" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/stone-wall-panel.jpg" `
    -introOverview "Architectural natural stone wall cladding, precision CNC fluted panels, and hand-chiseled textures crafted for contemporary interior feature walls and exterior elevations." `
    -products $stoneWallPanelProducts

foreach ($p in $stoneWallPanelProducts) {
    $slug = ($p.Name.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
    Generate-RedirectStub `
        -pagePath "$baseDir\stone-wall-panels\$slug\index.html" `
        -targetUrl "/stone-wall-panels/#$slug" `
        -title $p.Name
}
foreach ($short in @("fluted", "textured", "wave", "geometrical")) {
    Generate-RedirectStub `
        -pagePath "$baseDir\stone-wall-panels\$short\index.html" `
        -targetUrl "/stone-wall-panels/#$short" `
        -title $short
}

# 1.4 MDF HDMR Work Subcategory Page (5 Products Directly on Page)
$mdfProducts = @(
    @{ Name = "MDF HDMR Wall Panels"; Desc = "High-density moisture-resistant architectural wall paneling with premium polyurethane finishes."; Material = "Greenpanel / Action TESA HDMR"; Size = "8x4 ft Standard Sheets / Custom"; Images = @("/assets/images/mdf-work.jpg", "/assets/images/mdf-jali.jpg", "/assets/images/stone-wall-panel.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Fluted MDF Panels"; Desc = "Contemporary fluted and reed MDF profile paneling for luxury living and bedroom interiors."; Material = "Interior Grade HDMR + PU Finish"; Size = "Custom Cut Sizing"; Images = @("/assets/images/mdf-jali.jpg", "/assets/images/mdf-work.jpg", "/assets/images/stone-wall-panel.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-jali.jpg") },
    @{ Name = "Textured MDF Panels"; Desc = "High-precision CNC engraved 3D textures in high-density water-resistant board."; Material = "HDMR Board + Metallic Finish"; Size = "Full Height Wall Panels"; Images = @("/assets/images/mdf-work.jpg", "/assets/images/mdf-jali.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-wall-panel.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Wave MDF Panels"; Desc = "Continuous undulating 3D wave contours for modern feature walls and ceiling accents."; Material = "Teak/Walnut Veneer on HDMR"; Size = "Custom Wall Configuration"; Images = @("/assets/images/mdf-work.jpg", "/assets/images/mdf-jali.jpg", "/assets/images/stone-wall-panel.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/double-height-lotus-backlit.jpg") },
    @{ Name = "Geometrical MDF Panels"; Desc = "Sleek geometric interlocking panels suitable for metallic, lacquer, and veneer finishes."; Material = "Water-Resistant HDMR"; Size = "Modular 8x4 ft Panels"; Images = @("/assets/images/mdf-jali.jpg", "/assets/images/mdf-work.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-jali.jpg", "/assets/images/stone-wall-panel.jpg") }
)

Generate-ProductLeafPage `
    -pagePath "$baseDir\mdf-hdmr-work\index.html" `
    -title "MDF HDMR Work" `
    -metaDesc "Architectural high-density moisture-resistant (HDMR) and MDF wall panels, fluted profiles, and 3D geometric textures by Shree Ram & Company." `
    -categoryName "MDF HDMR Work" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/mdf-work.jpg" `
    -introOverview "Premium CNC routed moisture-resistant HDMR wall paneling, acoustic fluted claddings, and 3D geometric textures finished in PU lacquer and natural wood veneers." `
    -products $mdfProducts

foreach ($p in $mdfProducts) {
    $slug = ($p.Name.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
    Generate-RedirectStub `
        -pagePath "$baseDir\mdf-hdmr-work\$slug\index.html" `
        -targetUrl "/mdf-hdmr-work/#$slug" `
        -title $p.Name
}
foreach ($short in @("wall-panels", "fluted", "textured", "wave", "geometrical")) {
    Generate-RedirectStub `
        -pagePath "$baseDir\mdf-hdmr-work\$short\index.html" `
        -targetUrl "/mdf-hdmr-work/#$short" `
        -title $short
}


# =========================================================================
# 2. EXTERIOR ELEVATION (Direct Product Leaf Pages with 4-5 Images)
# =========================================================================

# 2.1 Elevation Facade
$elevationProds = @(
    @{ 
        Name = "Palatial Sandstone Elevation Facade"; 
        Desc = "Grand exterior bungalow elevation featuring intricately carved cornice cornices, jharokha balconies, and classical pillars."; 
        Material = "Gwalior Mint Sandstone & Pink Sandstone Bansi Paharpur"; 
        Size = "Custom Villa Architectural Blueprints"; 
        Images = @(
            "/assets/images/elevation-facade.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/wall-cladding.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/arch-mehrab.jpg"
        )
    },
    @{ 
        Name = "Modern Minimalist Stone Facade"; 
        Desc = "Sleek geometric interlocking stone facades with integrated concealed illumination channels for contemporary residences."; 
        Material = "Gwalior Mint Sandstone & Kandla Grey Sandstone"; 
        Size = "Full Height Exterior Cladding"; 
        Images = @(
            "/assets/images/wall-cladding.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Heritage Haveli Front Elevation"; 
        Desc = "Timeless Rajasthani heritage facade with traditional chhatris, arches, and hand-chiseled jali screen panels."; 
        Material = "Jaisalmer Sandstone & Red Sandstone Karauli"; 
        Size = "Bespoke Multi-Storey Sizing"; 
        Images = @(
            "/assets/images/elevation-facade.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/temple.jpg",
            "/assets/images/wall-cladding.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\elevation-facade\index.html" `
    -title "Elevation Facade" `
    -metaDesc "Luxury exterior stone elevation facades designed and sculpted in natural stone by Shree Ram & Company Jaipur." `
    -categoryName "Elevation Facade" `
    -parentCategoryName "Exterior Elevation" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/elevation-facade.jpg" `
    -introOverview "Monumental exterior stone elevations blending Rajasthani heritage craftsmanship with modern structural engineering." `
    -products $elevationProds

# 2.2 Customised Name Plates
$namePlateProds = @(
    @{ 
        Name = "Backlit Engraved Stone Villa Name Plate"; 
        Desc = "Luxury deep-engraved natural stone name plaque with warm LED silhouette backlighting and solid brass accents."; 
        Material = "Indian White Marble & Moka Grey"; 
        Size = "24x12 in, 36x18 in, 48x24 in"; 
        Images = @(
            "/assets/images/customised-name-plate.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/marble-inlay.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Heritage Jharokha Carved House Nameplate"; 
        Desc = "Traditional arch-framed stone nameplate with delicate floral borders and gold leaf enamel lettering."; 
        Material = "Gwalior Mint Sandstone & Jaisalmer Sandstone"; 
        Size = "30x18 in & Custom"; 
        Images = @(
            "/assets/images/customised-name-plate.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/stone-jali.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/elevation-facade.jpg"
        )
    },
    @{ 
        Name = "Contemporary Floating 3D Letter Stone Plaque"; 
        Desc = "Sleek textured split-face stone slab mounted with 3D raised metal or acrylic house typography."; 
        Material = "Teak Sandstone & Indian White Marble"; 
        Size = "Custom Architectural Sizing"; 
        Images = @(
            "/assets/images/customised-name-plate.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\customised-name-plate\index.html" `
    -title "Customised Name Plates" `
    -metaDesc "Luxury handcrafted stone name plates for villas, bungalows, and estates by Shree Ram & Company Jaipur." `
    -categoryName "Customised Name Plates" `
    -parentCategoryName "Exterior Elevation" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/customised-name-plate.jpg" `
    -introOverview "Prestigious personalized house and estate nameplates hand-chiselled and laser-engraved in solid stone." `
    -products $namePlateProds

# 2.3 Wall Cladding
$claddingProds = @(
    @{ 
        Name = "Natural Split-Face Sandstone Cladding"; 
        Desc = "Rugged textured stone strip cladding offering thermal insulation and striking organic shadow lines."; 
        Material = "Gwalior Mint Sandstone & Kandla Grey Sandstone"; 
        Size = "Variable strip length x 2-4 in width"; 
        Images = @(
            "/assets/images/wall-cladding.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/double-height-medallion-facade.jpg"
        )
    },
    @{ 
        Name = "Dry Stone Mechanical Cladding Panels"; 
        Desc = "Large format honed natural stone slabs pre-grooved for SS bracket dry hanging on exterior facades."; 
        Material = "Gwalior Mint Sandstone & Moka Grey"; 
        Size = "4x2 ft, 3x2 ft Modular Slabs"; 
        Images = @(
            "/assets/images/wall-cladding.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Curved Architectural Fluted Cladding"; 
        Desc = "Continuous vertically fluted stone masonry for compound walls, driveway gates, and villa podiums."; 
        Material = "Pink Sandstone Bansi Paharpur & Teak Sandstone"; 
        Size = "Custom Radii & Heights"; 
        Images = @(
            "/assets/images/wall-cladding.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\wall-cladding\index.html" `
    -title "Wall Cladding" `
    -metaDesc "Exterior natural stone wall cladding, dry stone hanging systems, and textured facade tiles by Shree Ram & Company." `
    -categoryName "Wall Cladding" `
    -parentCategoryName "Exterior Elevation" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/wall-cladding.jpg" `
    -introOverview "Weatherproof, enduring natural stone cladding engineered for luxury villas, boundary walls, and high-rise elevations." `
    -products $claddingProds

# 2.4 Garden Articles
$gardenProds = @(
    @{ 
        Name = "Artisan Carved Stone Garden Benches"; 
        Desc = "Classical curved and straight garden benches hand-sculpted with ornamental lion-paw pedestals."; 
        Material = "Pink Sandstone Bansi Paharpur & Teak Sandstone"; 
        Size = "5 ft to 7 ft Length"; 
        Images = @(
            "/assets/images/garden-article.jpg",
            "/assets/images/water-fountain.jpg",
            "/assets/images/gazebo.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Ornamental Stone Planters & Urns"; 
        Desc = "Monumental hand-carved Roman and Mughal garden urns featuring deep relief acanthus and floral patterns."; 
        Material = "Jaisalmer Sandstone & Gwalior Mint Sandstone"; 
        Size = "24 in to 48 in Height"; 
        Images = @(
            "/assets/images/garden-article.jpg",
            "/assets/images/water-fountain.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/gazebo.jpg"
        )
    },
    @{ 
        Name = "Architectural Garden Lanterns (Kasuga/Pagoda)"; 
        Desc = "Oriental and Indian traditional carved stone lanterns creating magical ambient courtyard night lighting."; 
        Material = "Kandla Grey Sandstone & Red Sandstone Karauli"; 
        Size = "3 ft to 6 ft Height"; 
        Images = @(
            "/assets/images/garden-article.jpg",
            "/assets/images/water-fountain.jpg",
            "/assets/images/gazebo.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\garden-article\index.html" `
    -title "Garden Articles" `
    -metaDesc "Handcrafted natural stone garden benches, planters, lanterns, and outdoor articles by Shree Ram & Company." `
    -categoryName "Garden Articles" `
    -parentCategoryName "Exterior Elevation" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/garden-article.jpg" `
    -introOverview "Transform luxury landscapes, farmhouses, and courtyards with solid hand-carved natural stone garden accents." `
    -products $gardenProds

# =========================================================================
# 3. TEMPLES & STATUES
# =========================================================================

# 3.1 Marble Temples
$marbleTempleProds = @(
    @{ 
        Name = "Grand Makrana Marble Mandir"; 
        Desc = "Exquisitely hand-carved pure white Makrana marble temple with detailed Shikhar and pillars."; 
        Material = "Indian White Marble"; 
        Size = "6 ft to 25 ft Height"; 
        Images = @(
            "/assets/images/marble-temple.jpg",
            "/assets/images/temple.jpg",
            "/assets/images/pooja-room.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Bespoke Home Pooja Mandir in Marble"; 
        Desc = "Indoor luxury prayer sanctum with integrated drawers, slide-out trays, and LED backlight slots."; 
        Material = "Indian White Marble & Vietnam White Marble"; 
        Size = "4x2.5 ft, 5x3 ft, 6x4 ft"; 
        Images = @(
            "/assets/images/temple.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/pooja-room.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Ornate Carved Marble Jharokha Mandir"; 
        Desc = "Palatial wall-mounted and floor-resting temple with Rajasthani jharokha arches and peacock reliefs."; 
        Material = "Indian White Marble"; 
        Size = "Custom Dimensions"; 
        Images = @(
            "/assets/images/marble-temple.jpg",
            "/assets/images/pooja-room.jpg",
            "/assets/images/temple.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\marble-temple\index.html" `
    -title "Marble Temples & Mandirs" `
    -metaDesc "Handcrafted pure Makrana marble temples and home mandirs carved according to ancient Vastu Shastra." `
    -categoryName "Marble Temples" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/marble-temple.jpg" `
    -introOverview "Sacred home mandirs and grand community temples carved out of pure white Makrana marble by master Jaipur artisans." `
    -products $marbleTempleProds

# 3.2 Stone Temple
$stoneTempleProds = @(
    @{ 
        Name = "Pink Sandstone Bansi Paharpur Mandir"; 
        Desc = "Authentic Nagara-style outdoor and courtyard temple hand-chiselled from durable pink sandstone."; 
        Material = "Pink Sandstone Bansi Paharpur & Red Sandstone Karauli"; 
        Size = "8 ft to 30 ft Grand Temples"; 
        Images = @(
            "/assets/images/temple.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Heritage Teak Sandstone Mandir"; 
        Desc = "Rich natural wood-grain pattern stone carved with multi-tier Shikhars and deity panels."; 
        Material = "Teak Sandstone"; 
        Size = "Custom Sizing"; 
        Images = @(
            "/assets/images/marble-temple.jpg",
            "/assets/images/temple.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Community & Trust Stone Temple Project"; 
        Desc = "Turnkey temple construction and carving services for grand public and private trust shrines."; 
        Material = "Pink Sandstone Bansi Paharpur & Gwalior Mint Sandstone"; 
        Size = "Monumental Scales"; 
        Images = @(
            "/assets/images/temple.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\stone-temple\index.html" `
    -title "Natural Stone Temples" `
    -metaDesc "Monumental outdoor and residential natural sandstone temples crafted according to sacred temple architecture." `
    -categoryName "Stone Temple" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/temple.jpg" `
    -introOverview "Traditional Indian temple architecture hand-carved in durable weather-resistant natural sandstones." `
    -products $stoneTempleProds

# Generate /temple/ legacy page
Generate-ProductLeafPage `
    -pagePath "$baseDir\temple\index.html" `
    -title "Temples & Mandirs" `
    -metaDesc "Handcrafted natural stone and marble temples by Shree Ram & Company Jaipur." `
    -categoryName "Temples & Mandirs" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/temple.jpg" `
    -introOverview "Authentic hand-carved marble and sandstone temples designed for luxury homes and community sanctums." `
    -products $stoneTempleProds

# 3.3 Pooja Rooms
$poojaRoomProds = @(
    @{ 
        Name = "Complete Marble Pooja Room Sanctum"; 
        Desc = "Full floor-to-ceiling carved marble pooja room with inlay flooring, carved side pillars, and backlit ceiling domes."; 
        Material = "Indian White Marble & Vietnam White Marble"; 
        Size = "Custom Room Sizing (8x6 ft, 10x8 ft, 12x10 ft)"; 
        Images = @(
            "/assets/images/pooja-room.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/marble-inlay.jpg",
            "/assets/images/temple.jpg",
            "/assets/images/stone-jali.jpg"
        )
    },
    @{ 
        Name = "Sandstone & Wood Sanctum Enclosure"; 
        Desc = "Contemporary spiritual sanctum blending warm sandstone wall reliefs with precision laser-cut jali partition screens."; 
        Material = "Pink Sandstone Bansi Paharpur & Teak Sandstone"; 
        Size = "Tailored to site floor plan"; 
        Images = @(
            "/assets/images/temple.jpg",
            "/assets/images/pooja-room.jpg",
            "/assets/images/stone-jali.jpg",
            "/assets/images/mdf-jali.jpg",
            "/assets/images/marble-temple.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\pooja-room\index.html" `
    -title "Pooja Rooms" `
    -metaDesc "Turnkey bespoke marble and sandstone pooja room design, carving, and installation by Shree Ram & Company." `
    -categoryName "Pooja Rooms" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/pooja-room.jpg" `
    -introOverview "Sacred sanctuaries designed according to Vastu Shastra principles, tailored to elevate daily spiritual contemplation." `
    -products $poojaRoomProds

# 3.4 Marble Inlay
$inlayProds = @(
    @{ 
        Name = "Royal Pietra Dura Floral Inlay Floor Medallion"; 
        Desc = "Intricate floral arabesque flooring medallions crafted by embedding semi-precious lapis, malachite, and jasper in white marble."; 
        Material = "Indian White Marble & Semi-Precious Inlay"; 
        Size = "3 ft to 12 ft Diameter"; 
        Images = @(
            "/assets/images/marble-inlay.jpg",
            "/assets/images/marble-table-tops.jpg",
            "/assets/images/handicrafts.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Bespoke Marble Inlay Border & Treads"; 
        Desc = "Geometric and vine pattern inlay runners for grand staircases, foyer boundaries, and dining room peripheries."; 
        Material = "Indian White Marble & Vietnam White Marble"; 
        Size = "Custom Linear Dimensions"; 
        Images = @(
            "/assets/images/marble-inlay.jpg",
            "/assets/images/marble-table-tops.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/handicrafts.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\marble-inlay\index.html" `
    -title "Marble Inlay Art" `
    -metaDesc "Pietra Dura Italian and Mughal marble inlay flooring, borders, and medallion art by Shree Ram & Company." `
    -categoryName "Marble Inlay" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/marble-inlay.jpg" `
    -introOverview "Centuries-old Pietra Dura stone intarsia handcrafted with museum-grade precision by Jaipur master artisans." `
    -products $inlayProds

# 3.5 Statues
$statueProds = @(
    @{ 
        Name = "Divine Lord Ganesha Idol in Pure White Marble"; 
        Desc = "Life-size and tabletop deity sculpture hand-sculpted in flawless Makrana marble with natural gold leaf painting."; 
        Material = "Vietnam White Marble & Indian White Marble"; 
        Size = "2 ft to 6 ft Height"; 
        Images = @(
            "/assets/images/statue.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/mural-art.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Meditating Buddha Sculpture in Sandstone"; 
        Desc = "Weatherproof monolithic sandstone Buddha statue with hand-chiseled robe drapery for outdoor gardens and zen foyers."; 
        Material = "Gwalior Mint Sandstone & Moka Grey"; 
        Size = "3 ft to 10 ft Monolithic"; 
        Images = @(
            "/assets/images/statue.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/garden-article.jpg",
            "/assets/images/water-fountain.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\statue\index.html" `
    -title "Statues & Sculptures" `
    -metaDesc "Handcrafted marble deity idols and architectural stone sculptures by Shree Ram & Company Jaipur." `
    -categoryName "Statues" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/statue.jpg" `
    -introOverview "Sacred spiritual deity idols and classical human and figurative sculptures sculpted out of solid natural stone blocks." `
    -products $statueProds

# 3.6 Gazebos
$gazeboProds = @(
    @{ 
        Name = "Royal Rajasthani 8-Pillar Stone Gazebo (Baradari)"; 
        Desc = "Monumental open pavilion featuring intricately carved domed cupola, fluted pillars, and hanging stone brackets."; 
        Material = "Pink Sandstone Bansi Paharpur & Red Sandstone Karauli"; 
        Size = "10x10 ft, 15x15 ft, 20x20 ft"; 
        Images = @(
            "/assets/images/gazebo.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/garden-article.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Classical European Stone Gazebo with Iron Dome"; 
        Desc = "Carved solid marble columns supporting an ornate hand-wrought iron filigree dome for estate gardens."; 
        Material = "Gwalior Mint Sandstone & Indian White Marble"; 
        Size = "Custom Diameters"; 
        Images = @(
            "/assets/images/gazebo.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/garden-article.jpg",
            "/assets/images/water-fountain.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\gazebo\index.html" `
    -title "Stone Gazebos & Pavilions" `
    -metaDesc "Architectural hand-carved stone gazebos, garden baradaris, and pavilions by Shree Ram & Company Jaipur." `
    -categoryName "Gazebos" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/gazebo.jpg" `
    -introOverview "Majestic outdoor architectural pavilions and garden gazebos carved from natural stone to last for generations." `
    -products $gazeboProds

# 3.7 Arches & Mehrabs
$archProds = @(
    @{ 
        Name = "Traditional Mughal Cusped Mehrab Arch"; 
        Desc = "Multi-foil scalloped archway with relief floral spandrels and fluted side pilasters for palace-style interiors."; 
        Material = "Gwalior Mint Sandstone & Jaisalmer Sandstone"; 
        Size = "Custom Width (4 ft to 16 ft Span)"; 
        Images = @(
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/stone-jali.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Modern Fluted Stone Transition Arch"; 
        Desc = "Minimalist smooth-profile stone doorway arch connecting luxury living and dining spaces."; 
        Material = "Indian White Marble & Pink Sandstone Bansi Paharpur"; 
        Size = "Tailored to Doorway Opening"; 
        Images = @(
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/pillar.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\arch-mehrab\index.html" `
    -title "Arches & Mehrabs" `
    -metaDesc "Handcrafted natural stone arches, cusped mehrabs, and ornamental door frames by Shree Ram & Company." `
    -categoryName "Arches & Mehrabs" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/arch-mehrab.jpg" `
    -introOverview "Architectural passageway arches and ornamental prayer mehrabs sculptured with classical Indian and Mughal geometries." `
    -products $archProds

# 3.8 Pillars
$pillarProds = @(
    @{ 
        Name = "Classical Fluted Column with Corinthian Capital"; 
        Desc = "Load-bearing or cladding architectural pillars featuring vertical flutes and ornate carved floral capitals."; 
        Material = "Gwalior Mint Sandstone & Pink Sandstone Bansi Paharpur"; 
        Size = "8 ft to 20 ft Height (12-24 in Dia)"; 
        Images = @(
            "/assets/images/pillar.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/gazebo.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Rajasthani Elephant-Base Heritage Pillar"; 
        Desc = "Traditional palace-style pillar standing upon a sculpted elephant pedestal with multi-tier bracket heads."; 
        Material = "Pink Sandstone Bansi Paharpur & Indian White Marble"; 
        Size = "Custom Structural Blueprint Specs"; 
        Images = @(
            "/assets/images/pillar.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/temple.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\pillar\index.html" `
    -title "Stone Pillars & Columns" `
    -metaDesc "Monumental load-bearing and decorative carved stone columns and pillars by Shree Ram & Company." `
    -categoryName "Pillars" `
    -parentCategoryName "Temples & Statues" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/pillar.jpg" `
    -introOverview "Monumental columns and decorative pillars providing architectural majesty and timeless structural presence." `
    -products $pillarProds

# =========================================================================
# 4. HOME INTERIOR & DECOR
# =========================================================================

# 4.1 Water Fountain
$fountainProds = @(
    @{ 
        Name = "Indoor Tiered Waterfall Fountain"; 
        Desc = "Compact, splash-free natural stone cascading fountain designed for luxury living room foyers, penthouses, and corporate lobbies with warm LED backlighting."; 
        Material = "Indian White Marble & Kandla Grey Sandstone"; 
        Size = "3 ft to 5 ft Height (Customizable)"; 
        Images = @(
            "/assets/images/water-fountain.jpg",
            "/assets/images/garden-article.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/stone-carving.jpg"
        )
    },
    @{ 
        Name = "Small Balcony Corner Fountain"; 
        Desc = "Elegant tabletop and balcony corner stone water fountain with gentle trickling sound, ideal for compact Vastu-aligned residential spaces."; 
        Material = "Gwalior Mint Sandstone & Vietnam White Marble"; 
        Size = "2 ft to 3 ft Height (Portable & Self-Contained)"; 
        Images = @(
            "/assets/images/water-fountain.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/garden-article.jpg",
            "/assets/images/marble-inlay.jpg",
            "/assets/images/stone-carving.jpg"
        )
    },
    @{ 
        Name = "Grand Architectural Courtyard Fountain"; 
        Desc = "Monumental multi-tier architectural fountain featuring hand-sculpted pool surround, lion spout heads, and central cascading floral bowls."; 
        Material = "Pink Sandstone Bansi Paharpur & Gwalior Mint Sandstone"; 
        Size = "6 ft to 12 ft Height (Pool Dia 8-15 ft)"; 
        Images = @(
            "/assets/images/water-fountain.jpg",
            "/assets/images/gazebo.jpg",
            "/assets/images/garden-article.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/pillar.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\water-fountain\index.html" `
    -title "Water Fountains" `
    -metaDesc "Luxury handcrafted indoor and outdoor stone water fountains by master carvers of Shree Ram & Company Jaipur." `
    -categoryName "Water Fountain" `
    -parentCategoryName "Home Interior & Decor" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/water-fountain.jpg" `
    -introOverview "Soothing, majestic natural stone fountains bringing positive water energy and architectural luxury to indoor lobbies and gardens." `
    -products $fountainProds

# 4.2 Marble Table Tops
$tableTopProds = @(
    @{ 
        Name = "Handcrafted Inlay Marble Dining Table Top"; 
        Desc = "Exquisite floral gemstone inlay table top hand-polished to mirror finish, seating 6 to 10 persons."; 
        Material = "Indian White Marble & Semi-Precious Gemstone Inlay"; 
        Size = "6x3 ft, 8x4 ft, 10x4.5 ft"; 
        Images = @(
            "/assets/images/marble-table-tops.jpg",
            "/assets/images/marble-inlay.jpg",
            "/assets/images/handicrafts.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/stone-carving.jpg"
        )
    },
    @{ 
        Name = "Round Pietra Dura Coffee Table Top"; 
        Desc = "Classical round center table with intricate radial geometric intarsia and bullnose polished edge."; 
        Material = "Indian White Marble & Moka Grey"; 
        Size = "36 in to 60 in Diameter"; 
        Images = @(
            "/assets/images/marble-table-tops.jpg",
            "/assets/images/marble-inlay.jpg",
            "/assets/images/handicrafts.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\marble-table-tops\index.html" `
    -title "Marble Table Tops" `
    -metaDesc "Luxury handcrafted Pietra Dura marble dining table tops and center tables by Shree Ram & Company." `
    -categoryName "Marble Table Tops" `
    -parentCategoryName "Home Interior & Decor" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/marble-table-tops.jpg" `
    -introOverview "Luxury bespoke marble dining and center table tops inlaid with semi-precious natural minerals." `
    -products $tableTopProds

# 4.3 Handicrafts
$handicraftProds = @(
    @{ 
        Name = "Hand-Carved Marble Diya & Pooja Thali Sets"; 
        Desc = "Filigree lace-work white marble bowls, incense burner holders, and ceremonial sanctum accessories."; 
        Material = "Indian White Marble & Jaisalmer Sandstone"; 
        Size = "8 in to 18 in Diameter"; 
        Images = @(
            "/assets/images/handicrafts.jpg",
            "/assets/images/marble-inlay.jpg",
            "/assets/images/statue.jpg",
            "/assets/images/jaipur-artisan.jpg",
            "/assets/images/marble-table-tops.jpg"
        )
    },
    @{ 
        Name = "Ornamental Stone Urli with Floating Petals"; 
        Desc = "Traditional carved stone urli bowl with scalloped floral petals for entrance foyers and living rooms."; 
        Material = "Gwalior Mint Sandstone & Moka Grey"; 
        Size = "18 in to 36 in Diameter"; 
        Images = @(
            "/assets/images/handicrafts.jpg",
            "/assets/images/water-fountain.jpg",
            "/assets/images/garden-article.jpg",
            "/assets/images/marble-inlay.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\handicrafts\index.html" `
    -title "Stone Handicrafts & Decor" `
    -metaDesc "Artisan stone urlis, decorative bowls, and luxury home accents hand-sculpted in Jaipur by Shree Ram & Company." `
    -categoryName "Handicrafts" `
    -parentCategoryName "Home Interior & Decor" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/handicrafts.jpg" `
    -introOverview "Artisanal handcrafted stone tableware, accent bowls, and heritage home decor sculpted with generational skill." `
    -products $handicraftProds

# =========================================================================
# 5. CNC JALI WORK
# =========================================================================

# 5.1 Stone Jali
$stoneJaliProds = @(
    @{ 
        Name = "Architectural Sandstone Facade Jali"; 
        Desc = "High-precision geometric lattice screen engineered for exterior daylight filtering and ventilation."; 
        Material = "Gwalior Mint Sandstone & Red Sandstone Karauli"; 
        Size = "4x2 ft & Custom Large Format Panels"; 
        Images = @(
            "/assets/images/stone-jali.jpg",
            "/assets/images/mdf-jali.jpg",
            "/assets/images/wpc-jali.jpg",
            "/assets/images/elevation-facade.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Mughal Floral Perforated Stone Screen"; 
        Desc = "Traditional heritage floral cutwork panel for balcony parapets, courtyard shading, and window covers."; 
        Material = "Jaisalmer Sandstone & Gwalior Mint Sandstone"; 
        Size = "Bespoke Architectural Dimensions"; 
        Images = @(
            "/assets/images/stone-jali.jpg",
            "/assets/images/arch-mehrab.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/wpc-jali.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\stone-jali\index.html" `
    -title "Stone Jali Screens" `
    -metaDesc "Architectural perforated stone jali screens in natural sandstone and marble by Shree Ram & Company Jaipur." `
    -categoryName "Stone Jali" `
    -parentCategoryName "CNC Jali Work" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/stone-jali.jpg" `
    -introOverview "Breathable, light-diffusing architectural stone latticework blending privacy with timeless aesthetic grace." `
    -products $stoneJaliProds

# 5.2 MDF Jali
$mdfJaliProds = @(
    @{ 
        Name = "Modern Laser-Cut MDF Interior Screen"; 
        Desc = "High-precision CNC routered jali screen suitable for false ceiling inserts, wall accents, and cabinetry."; 
        Material = "Action TESA / Greenpanel HDMR"; 
        Size = "8x4 ft Sheets (12mm to 25mm thickness)"; 
        Images = @(
            "/assets/images/mdf-jali.jpg",
            "/assets/images/mdf-work.jpg",
            "/assets/images/stone-jali.jpg",
            "/assets/images/wpc-jali.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\mdf-jali\index.html" `
    -title "MDF Jali Screens" `
    -metaDesc "High-density moisture-resistant MDF and HDMR interior jali screens by Shree Ram & Company." `
    -categoryName "MDF Jali" `
    -parentCategoryName "CNC Jali Work" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/mdf-jali.jpg" `
    -introOverview "Crisp CNC router-cut decorative wooden screens engineered for luxury interior partitions and ceiling accents." `
    -products $mdfJaliProds

# 5.3 WPC Jali
$wpcJaliProds = @(
    @{ 
        Name = "100% Waterproof WPC Outdoor Jali"; 
        Desc = "Termite-proof, zero-maintenance wood-polymer composite perforated screen ideal for balconies and bathrooms."; 
        Material = "Virgin Polymer Composite (WPC)"; 
        Size = "8x4 ft Standard Sheets"; 
        Images = @(
            "/assets/images/wpc-jali.jpg",
            "/assets/images/stone-jali.jpg",
            "/assets/images/mdf-jali.jpg",
            "/assets/images/wall-cladding.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\wpc-jali\index.html" `
    -title "WPC Jali Screens" `
    -metaDesc "Waterproof and termite-proof WPC jali screens for exterior and high-humidity interior areas." `
    -categoryName "WPC Jali" `
    -parentCategoryName "CNC Jali Work" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/wpc-jali.jpg" `
    -introOverview "Durable, waterproof exterior and wet-area privacy screens crafted with modern high-precision cutting technology." `
    -products $wpcJaliProds

# 5.4 Partition Jali
$partitionJaliProds = @(
    @{ 
        Name = "Freestanding Folding Partition Jali"; 
        Desc = "Moveable luxury room divider screen with intricate geometric Islamic and floral patterns."; 
        Material = "Teak Sandstone & High-Density HDMR"; 
        Size = "6 ft Height x 4 Panels"; 
        Images = @(
            "/assets/images/stone-jali.jpg",
            "/assets/images/mdf-jali.jpg",
            "/assets/images/wpc-jali.jpg",
            "/assets/images/stone-carving.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Floor-to-Ceiling Partition Screen"; 
        Desc = "Fixed architectural divider separating living and dining areas with integrated brass accents."; 
        Material = "Kandla Grey Sandstone / WPC / HDMR"; 
        Size = "Custom Height up to 12 ft"; 
        Images = @(
            "/assets/images/mdf-jali.jpg",
            "/assets/images/stone-jali.jpg",
            "/assets/images/stone-wall-panel.jpg",
            "/assets/images/double-height-medallion-facade.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    },
    @{ 
        Name = "Mandir Pooja Enclosure Partition Jali"; 
        Desc = "Sacred Om and Gayatri mantra laser-cut partition screen for private prayer spaces."; 
        Material = "Indian White Marble & Teak Sandstone"; 
        Size = "Bespoke Dimensions"; 
        Images = @(
            "/assets/images/stone-jali.jpg",
            "/assets/images/marble-temple.jpg",
            "/assets/images/pooja-room.jpg",
            "/assets/images/mdf-jali.jpg",
            "/assets/images/jaipur-artisan.jpg"
        )
    }
)
Generate-ProductLeafPage `
    -pagePath "$baseDir\partition-jali\index.html" `
    -title "Partition Jali & Room Dividers" `
    -metaDesc "Luxury architectural partition jali screens and room dividers in stone, MDF, and WPC by Shree Ram & Company." `
    -categoryName "Partition Jali" `
    -parentCategoryName "CNC Jali Work" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/stone-jali.jpg" `
    -introOverview "Bespoke partition screens and spatial dividers tailored to create privacy with architectural sophistication." `
    -products $partitionJaliProds

Write-Host "All category leaf pages successfully upgraded with in-card 4-5 image sliders and lightbox CTA modal!"
