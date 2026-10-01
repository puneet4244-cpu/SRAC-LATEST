import os

base_dir = r"c:\Users\shree\OneDrive\Desktop\NTRY"

# Python builder to generate full execute_all_category_generation.ps1

content = '''# Execution script to generate all 23 standalone sub-categories with full page content, comparison tables, FAQs, schema, internal links, and product cards
$baseDir = "c:\\Users\\shree\\OneDrive\\Desktop\\NTRY"

. "$baseDir\\master_page_builder.ps1"

Write-Host "Generating all 23 sub-category pages..."

# -------------------------------------------------------------------------
# 1. WALL SURFACES
# -------------------------------------------------------------------------

# 1.1 Stone Carving (/stone-carving/)
$scCraftsmanship = @"
<div class="max-w-4xl mx-auto">
    <span class="text-luxury-gold text-xs font-bold tracking-[0.25em] uppercase block mb-3 text-center">Master Craftsmanship</span>
    <h2 class="font-serif text-3xl md:text-5xl text-deep-charcoal text-center mb-8">Architectural Stone Carving & Wall Sculpting</h2>
    <p class="text-gray-600 text-sm md:text-base leading-relaxed mb-6">Hand-carved stone wall surfaces transform plain interior partitions and double-height building elevations into permanent architectural art. Mined directly from Rajasthan's famous quarry beds—including pink Bansi Paharpur sandstone, Jodhpur beige stone, and Makrana white marble—solid stone cladding panels provide deep 3D relief textures that age gracefully without surface fading or chemical degradation.</p>
    <p class="text-gray-600 text-sm md:text-base leading-relaxed">Our Jaipur stonemasons bring 40 years of generational heritage to custom stone relief work. Every panel is precision-squared, hand-chiseled with custom floral or geometric motifs, and sealed with breathable stone protectants.</p>
</div>
"@

$scTable = @"
<div class="max-w-5xl mx-auto overflow-x-auto">
    <div class="text-center mb-10"><span class="text-luxury-gold text-xs font-bold tracking-[0.25em] uppercase block mb-2">Material Benchmark</span><h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal">Natural Carved Stone vs. Manufactured Cladding</h2></div>
    <table class="w-full text-left border-collapse border border-light-beige text-xs md:text-sm">
        <thead><tr class="bg-luxury-bg text-deep-charcoal font-serif text-sm"><th class="p-4 border border-light-beige font-semibold">Feature / Property</th><th class="p-4 border border-light-beige font-semibold text-luxury-gold">Natural Carved Stone (Shree Ram & Co.)</th><th class="p-4 border border-light-beige font-semibold">Engineered Concrete / GRC</th><th class="p-4 border border-light-beige font-semibold">Synthetic Resin Wall Panels</th></tr></thead>
        <tbody class="divide-y divide-light-beige text-gray-600">
            <tr><td class="p-4 border border-light-beige font-medium">Material Origin</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">100% Solid Bansi Paharpur / Jodhpur Sandstone</td><td class="p-4 border border-light-beige">Cement slurry with glass fiber fill</td><td class="p-4 border border-light-beige">Polyurethane resin with stone dust</td></tr>
            <tr><td class="p-4 border border-light-beige font-medium">Carving Depth</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">Deep 3D hand-chiseled reliefs (up to 75mm)</td><td class="p-4 border border-light-beige">Shallow molded surface impressions</td><td class="p-4 border border-light-beige">Machine stamped shallow patterns</td></tr>
            <tr><td class="p-4 border border-light-beige font-medium">Outdoor Weathering</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">Impervious to rain, UV sun, & frost</td><td class="p-4 border border-light-beige">Hairline surface cracks form over time</td><td class="p-4 border border-light-beige">Fades, yellows, & turns brittle in sun</td></tr>
            <tr><td class="p-4 border border-light-beige font-medium">Lifespan</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">Centuries of generational durability</td><td class="p-4 border border-light-beige">15–20 years before surface decay</td><td class="p-4 border border-light-beige">5–8 years max lifespan</td></tr>
        </tbody>
    </table>
</div>
"@

$scFaqs = @(
    @{ Q = "What type of stone is best suited for interior stone carving walls?"; A = "Jodhpur beige sandstone, pink Bansi Paharpur sandstone, and Makrana white marble are ideal for interior stone carving walls. Their dense mineral structure allows intricate hand chiseling while maintaining structural stability and natural warmth." },
    @{ Q = "Can hand-carved stone panels be installed on double-height foyer walls?"; A = "Yes. We manufacture modular interlocking stone carving panels specifically engineered for double-height walls up to 30 feet tall. Panels are anchored using concealed stainless steel pins and structural stone adhesives for complete safety." },
    @{ Q = "How do I maintain and clean hand-carved stone wall surfaces?"; A = "Routine cleaning requires dusting with a soft brush or vacuum attachment. Occasional wiping with a damp microfiber cloth dipped in mild warm water removes surface dust without harming the sealed stone surface." },
    @{ Q = "Are stone carving panels customizable to architectural drawings?"; A = "Yes. Every stone carving wall is built to order. You can supply custom 2D drawings, 3D CAD models, or architectural blueprints, and our Jaipur master craftsmen will translate them into exact stone relief carvings." },
    @{ Q = "How are heavy stone carving panels delivered and installed safely?"; A = "Panels are individually numbered, packed inside foam-lined wooden crates, and shipped with detailed site placement drawings. Your site contractors can easily install the panels using our anchor pin guidelines." }
)

$scLinks = @"
<div class="text-center max-w-3xl mx-auto"><span class="text-luxury-gold text-xs font-bold tracking-widest uppercase block mb-2">Explore Related Categories</span><h3 class="font-serif text-2xl text-deep-charcoal mb-6">Enhance Your Interior Architecture</h3><div class="flex flex-wrap justify-center gap-4 text-xs font-semibold uppercase tracking-wider"><a href="/stone-art-murals/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Stone Art & Murals</a><a href="/stone-wall-panels/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Stone Wall Panels</a><a href="/arch-mehrab/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Arches & Mehrabs</a><a href="/pillar/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Pillars</a></div></div>
"@

$scProducts = @(
    @{ Name = "Double Height Wall"; Desc = "Monumental handcrafted stone carved elevations engineered for 15–30 ft soaring double-height villa lobbies, duplex atriums, and grand entrance halls. Featuring bespoke 3D contour reliefs, geometric faceted patterns, and botanical murals with integrated backlighting."; Material = "Pink Bansi Paharpur, Jodhpur Sandstone & Makrana Marble"; Size = "12 ft to 30+ ft (Modular interlocking panels)"; Placement = "Grand foyers, duplex stairwells & entrance halls"; Finish = "Deep 3D Relief, Honed Satin, Backlit Ready"; AltText = "double-height-carved-sandstone-foyer-wall-panels"; Images = @("/assets/images/double-height-wall-01.webp", "/assets/images/double-height-wall-02.webp", "/assets/images/double-height-wall-03.webp", "/assets/images/double-height-wall-04.webp", "/assets/images/double-height-wall-05.webp", "/assets/images/double-height-wall-06.webp") },
    @{ Name = "Staircase Wall"; Desc = "Slanted interlocking stone carving panels designed to follow staircase pitch lines, transforming blank stairwells into textured, hand-chiseled architectural accent walls."; Material = "Bansi Paharpur Sandstone / Makrana Marble"; Size = "Custom angled panels cut to stair pitch"; Placement = "Main residential stairwells & duplex corridors"; Finish = "Satin Polished, Bush-Hammered, Relief Carved"; AltText = "carved-stone-staircase-accent-wall-panel"; Images = @("/assets/images/staircase-mandala-radial-carving.jpg", "/assets/images/staircase-maple-leaf-relief.jpg", "/assets/images/staircase-ginkgo-backlit-panel.jpg", "/assets/images/double-height-lotus-backlit.jpg") },
    @{ Name = "Sofa Wall"; Desc = "Low-profile carved stone backdrops designed specifically behind living room seating, providing subtle 3D texture without interfering with sofa furniture placement."; Material = "Jodhpur Sandstone / White Makrana Marble"; Size = "8 ft x 4 ft to 12 ft x 6 ft feature panel"; Placement = "Formal living room sofa backdrop"; Finish = "Smooth Honed, Fine Tooling, Matte Sealed"; AltText = "carved-sandstone-sofa-backdrop-wall-living-room"; Images = @("/assets/images/sofa-wall.jpg", "/assets/images/staircase-ginkgo-backlit-panel.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Statement Wall"; Desc = "Bold, high-relief custom stone carvings featuring dramatic floral or geometric motifs, engineered to command immediate attention in grand entry lobbies."; Material = "Red Dholpur / Bansi Paharpur Pink Sandstone"; Size = "Custom full-wall dimensions up to 16 ft x 10 ft"; Placement = "Entrance foyers & hotel reception walls"; Finish = "Deep 3D Relief, Antiqued, Natural Polish"; AltText = "statement-hand-carved-pink-sandstone-feature-wall"; Images = @("/assets/images/statement-wall.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/double-height-medallion-facade.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Living Room Wall"; Desc = "Refined, medium-depth carved stone wall tiles designed for indoor living spaces, offering soft tactile warmth and glare-free acoustics under ambient lighting."; Material = "Beige Jodhpur Sandstone / Mint Sandstone"; Size = "600mm x 300mm / 600mm x 600mm interlocking tiles"; Placement = "Main living room TV walls & lounge accents"; Finish = "Satin Honed, Sandblasted, Fine Chiseled"; AltText = "living-room-carved-sandstone-accent-wall-tiles"; Images = @("/assets/images/living-room-wall.jpg", "/assets/images/staircase-maple-leaf-relief.jpg", "/assets/images/staircase-mandala-radial-carving.jpg", "/assets/images/stone-wall-panel.jpg") },
    @{ Name = "Featured Wall"; Desc = "Modular architectural stone tiles carved with interlocking geometric or traditional motifs, creating a focal accent wall for dining areas and executive suites."; Material = "Pink Sandstone / Makrana White Marble"; Size = "4 ft x 2 ft panels or custom modular grids"; Placement = "Dining room feature walls & executive offices"; Finish = "Matte Sealed, Hand-Punched, Diamond Polished"; AltText = "featured-carved-stone-wall-panel-dining-room"; Images = @("/assets/images/featured-wall.jpg", "/assets/images/double-height-medallion-facade.jpg", "/assets/images/staircase-mandala-radial-carving.jpg", "/assets/images/stone-carving.jpg") }
)

Generate-ProductLeafPage `
    -pagePath "$baseDir\\stone-carving\\index.html" `
    -title "Stone Carving Wall Surfaces" `
    -metaDesc "Discover luxury handcrafted stone carving collections by Shree Ram & Company Jaipur: Double Height Wall, Staircase Wall, Sofa Wall, Statement Wall, Living Room Wall, Featured Wall." `
    -categoryName "Stone Carving" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/double-height-wall-01.webp" `
    -introOverview "Bespoke architectural hand-carved natural stone walls for luxury residences, duplex atriums, and grand living spaces. Handcrafted in solid sandstone and Makrana marble." `
    -products $scProducts `
    -craftsmanshipHtml $scCraftsmanship `
    -comparisonTableHtml $scTable `
    -faqList $scFaqs `
    -internalLinksHtml $scLinks

foreach ($p in $scProducts) {
    $slug = ($p.Name.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
    Generate-RedirectStub -pagePath "$baseDir\\stone-carving\\$slug\\index.html" -targetUrl "/stone-carving/#$slug" -title $p.Name
}

# 1.2 Stone Art & Murals (/stone-art-murals/)
$samCraftsmanship = @"
<div class="max-w-4xl mx-auto">
    <span class="text-luxury-gold text-xs font-bold tracking-[0.25em] uppercase block mb-3 text-center">Sacred Stone Relief Art</span>
    <h2 class="font-serif text-3xl md:text-5xl text-deep-charcoal text-center mb-8">Hand-Carved Stone Murals & Divine Sculptures</h2>
    <p class="text-gray-600 text-sm md:text-base leading-relaxed mb-6">Devotional stone murals and relief art represent the pinnacle of Indian stone carving. Hand-sculpted from pure Makrana white marble, pink Bansi Paharpur sandstone, and dark Bhainslana marble, every mural captures sacred iconometry, fluid drapery, and expressive facial postures (bhav). Mined from Rajasthan's historic seams, these solid stone murals remain unaffected by ambient humidity, sun fading, or atmospheric pollution.</p>
    <p class="text-gray-600 text-sm md:text-base leading-relaxed">Our master sculptors (Moortikars) in Jaipur follow traditional Shilpa Shastra guidelines, hand-chiseling deep 3D relief layers that capture natural light and project spiritual gravitas across home mandirs, foyers, and sacred halls.</p>
</div>
"@

$samTable = @"
<div class="max-w-5xl mx-auto overflow-x-auto">
    <div class="text-center mb-10"><span class="text-luxury-gold text-xs font-bold tracking-[0.25em] uppercase block mb-2">Quality Comparison</span><h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal">Hand-Carved Stone Murals vs. Synthetic Reliefs</h2></div>
    <table class="w-full text-left border-collapse border border-light-beige text-xs md:text-sm">
        <thead><tr class="bg-luxury-bg text-deep-charcoal font-serif text-sm"><th class="p-4 border border-light-beige font-semibold">Quality Factor</th><th class="p-4 border border-light-beige font-semibold text-luxury-gold">Hand-Carved Natural Stone (Shree Ram & Co.)</th><th class="p-4 border border-light-beige font-semibold">Cast Polyresin & Fiber Murals</th><th class="p-4 border border-light-beige font-semibold">Printed Canvas / Fiberboard Panels</th></tr></thead>
        <tbody class="divide-y divide-light-beige text-gray-600">
            <tr><td class="p-4 border border-light-beige font-medium">Material Base</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">100% Solid Makrana Marble / Sandstone</td><td class="p-4 border border-light-beige">Polyurethane resin with stone dust</td><td class="p-4 border border-light-beige">Printed vinyl on MDF backing</td></tr>
            <tr><td class="p-4 border border-light-beige font-medium">Iconometric Accuracy</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">Hand-sculpted per Shilpa Shastra rules</td><td class="p-4 border border-light-beige">Mass-molded generic industrial models</td><td class="p-4 border border-light-beige">Flat 2D printed digital image</td></tr>
            <tr><td class="p-4 border border-light-beige font-medium">Color Permanence</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">Natural stone mineral colors; never fade</td><td class="p-4 border border-light-beige">Chemical paint chips & yellows in light</td><td class="p-4 border border-light-beige">Ink fades under direct UV sunlight</td></tr>
            <tr><td class="p-4 border border-light-beige font-medium">Durability</td><td class="p-4 border border-light-beige font-semibold text-deep-charcoal">Centuries of sacred permanence</td><td class="p-4 border border-light-beige">3–5 years before brittle fractures</td><td class="p-4 border border-light-beige">2–4 years before peeling</td></tr>
        </tbody>
    </table>
</div>
"@

$samFaqs = @(
    @{ Q = "What marble is best suited for carving sacred deity murals?"; A = "Pure Makrana white marble from Rajasthan is the gold standard for sacred deity carving. Its low porosity and high calcite purity allow sculptors to carve fine facial features without stone chipping or yellowing over time." },
    @{ Q = "Are your deity stone murals sculpted according to Shilpa Shastra guidelines?"; A = "Yes. Every sacred mural crafted by Shree Ram & Company strictly follows traditional Shilpa Shastra iconometry. We ensure that head-to-body ratios, hand mudras, and divine attributes align with Vedic texts." },
    @{ Q = "Can stone murals be installed on outdoor courtyard walls?"; A = "Yes. Bansi Paharpur pink sandstone and Jodhpur beige stone murals are completely weatherproof. They withstand rain, direct sunlight, and freezing temperatures without structural decay or color fading." },
    @{ Q = "What dimensions are available for custom stone murals?"; A = "We carve custom murals ranging from small 2 ft x 3 ft framed icons for home altars to sprawling 12 ft x 6 ft panoramic multi-slab wall installations for temple halls and foyers." },
    @{ Q = "How are delicate stone murals packaged for safe shipping?"; A = "Every stone mural is wrapped in protective foam layers, custom-crated inside heavy-duty wooden boxes lined with shock-absorbing foam, and shipped with full transit insurance." }
)

$samLinks = @"
<div class="text-center max-w-3xl mx-auto"><span class="text-luxury-gold text-xs font-bold tracking-widest uppercase block mb-2">Explore Related Categories</span><h3 class="font-serif text-2xl text-deep-charcoal mb-6">Complete Sacred Architecture</h3><div class="flex flex-wrap justify-center gap-4 text-xs font-semibold uppercase tracking-wider"><a href="/marble-temple/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Marble Temples</a><a href="/pooja-room/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Pooja Rooms</a><a href="/statue/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Statues</a><a href="/marble-inlay/" class="px-5 py-2.5 bg-luxury-bg border border-light-beige hover:border-luxury-gold hover:text-luxury-gold transition-colors">Marble Inlay</a></div></div>
"@

$samProducts = @(
    @{ Name = "Radhe Krishna Stone Art & Mural"; Desc = "Intricately hand-carved sandstone mural depicting Lord Krishna playing the flute alongside Radha beneath a lotus bower, sculpted with deep 3D grace."; Material = "Pink Bansi Paharpur Sandstone / Makrana Marble"; Size = "4 ft x 3 ft to 8 ft x 5 ft single/multi-slab"; Placement = "Pooja rooms, living room backdrops, & foyers"; Finish = "Deep Relief Carved, Polished, Gold-Highlighting"; AltText = "hand-carved-radhe-krishna-sandstone-mural"; Images = @("/assets/images/radhe-krishna-mural.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Meditating Buddha Stone Art & Mural"; Desc = "A tranquil 3D relief carving of Lord Buddha in Dhyana Mudra, sculpted from solid stone to evoke serenity in meditation corners and gardens."; Material = "Black Bhainslana Marble / Jodhpur Beige Sandstone"; Size = "3 ft x 3 ft circular or 5 ft x 3 ft panel"; Placement = "Meditation rooms, garden alcoves, & spa foyers"; Finish = "Satin Honed, Antiqued, Smooth Matte"; AltText = "meditating-buddha-carved-stone-wall-mural"; Images = @("/assets/images/statue.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/stone-wall-panel.jpg") },
    @{ Name = "Durga Mata Ji Stone Art & Mural"; Desc = "A powerful high-relief stone mural depicting Goddess Durga riding her lion, hand-chiseled with detailed weapons, fluid drapery, and divine expressions."; Material = "Pink Sandstone / Pure Makrana White Marble"; Size = "4 ft x 3 ft to 6 ft x 4 ft framed panel"; Placement = "Home mandir backdrops & temple entryways"; Finish = "High 3D Relief, Hand-Polished, Natural Stone"; AltText = "durga-mata-ji-carved-marble-wall-mural"; Images = @("/assets/images/durga-mata-mural.jpg", "/assets/images/mural-art.jpg", "/assets/images/statue.jpg", "/assets/images/jaipur-artisan.jpg") },
    @{ Name = "Ganesh Ji Stone Art & Mural"; Desc = "A sacred relief carving of Lord Ganesha seated on a lotus pedestal with intricate trunk and crown details, bringing auspicious presence to entryways."; Material = "Bansi Paharpur Sandstone / Makrana White Marble"; Size = "2 ft x 3 ft to 4 ft x 6 ft vertical panel"; Placement = "Main entrance foyers & pooja room walls"; Finish = "3D Deep Relief, Satin Polish, Gold Leaf Accents"; AltText = "lord-ganesh-ji-hand-carved-sandstone-mural"; Images = @("/assets/images/ganesh-ji-mural.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/mural-art.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Laxmi Ji Stone Art & Mural"; Desc = "Hand-carved marble mural of Goddess Laxmi seated on an open lotus flower holding lotus blooms, crafted to bring abundance to prayer sanctums."; Material = "Pure Makrana White Marble / Pink Sandstone"; Size = "3 ft x 4 ft to 5 ft x 3 ft wall panel"; Placement = "Pooja rooms, business foyers, & altars"; Finish = "Fine Hand-Chiseled, Polished, Pietra Dura Inlay"; AltText = "goddess-laxmi-carved-white-marble-mural"; Images = @("/assets/images/mural-art.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/statue.jpg") },
    @{ Name = "Ram Darbar Stone Art & Mural"; Desc = "A detailed devotional mural depicting Lord Ram, Sita, Lakshman, and Hanuman, carved from solid quarry stone with scriptural iconometric accuracy."; Material = "Pink Bansi Paharpur Sandstone / Makrana Marble"; Size = "5 ft x 3 ft to 8 ft x 4 ft wide panel"; Placement = "Main mandir backdrops & sacred hall walls"; Finish = "Deep Relief Carving, Natural Stone Finish"; AltText = "ram-darbar-carved-sandstone-wall-mural"; Images = @("/assets/images/ram-darbar-mural.jpg", "/assets/images/marble-temple.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg") },
    @{ Name = "Shiv Ji Stone Art & Mural"; Desc = "An evocative stone relief carving depicting Lord Shiva in meditative posture with the crescent moon, Ganges stream, and trident carved in deep detail."; Material = "Jodhpur Sandstone / Black Bhainslana Marble"; Size = "4 ft x 4 ft square to 6 ft x 4 ft panel"; Placement = "Pooja rooms, courtyard alcoves, & quiet lounges"; Finish = "Textured Relief, Antique Weathered, Honed"; AltText = "lord-shiv-ji-carved-stone-wall-mural"; Images = @("/assets/images/shiv-ji-mural.jpg", "/assets/images/statue.jpg", "/assets/images/mural-art.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Swaminarayan Ji Stone Art & Mural"; Desc = "A finely detailed sacred stone relief of Bhagwan Swaminarayan, hand-chiseled with serene facial features and traditional ornamental attire for temple sanctums."; Material = "Pure Makrana White Marble / Pink Sandstone"; Size = "3 ft x 4 ft to 6 ft x 4 ft vertical panel"; Placement = "Swaminarayan home mandirs & temple halls"; Finish = "High-Detail Hand Carving, Satin Polish"; AltText = "swaminarayan-ji-carved-marble-wall-mural"; Images = @("/assets/images/marble-temple.jpg", "/assets/images/stone-carving.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg") },
    @{ Name = "Shreenath Ji Stone Art & Mural"; Desc = "A sacred relief mural of Lord Shreenath Ji depicting the raised arm lifting Mount Govardhan, carved in traditional Haveli style with detailed adornments."; Material = "Pink Bansi Paharpur Sandstone / Makrana Marble"; Size = "3 ft x 4 ft to 5 ft x 3 ft framed panel"; Placement = "Pooja rooms & traditional Rajasthani foyers"; Finish = "Deep Bas-Relief, Natural Stone, Gold Accents"; AltText = "shreenath-ji-hand-carved-sandstone-mural"; Images = @("/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Rural Village Life Stone Art & Mural"; Desc = "A sprawling pictorial stone mural depicting traditional Rajasthani village scenes, musicians, and heritage lifeways, hand-carved with rich narrative depth."; Material = "Beige Jodhpur Sandstone / Dholpur Red Stone"; Size = "6 ft x 3 ft to 12 ft x 5 ft multi-panel mural"; Placement = "Resort lobbies, verandahs, & heritage hotels"; Finish = "Antique Weathered, Hand-Chiseled Relief"; AltText = "rural-rajasthani-village-life-stone-carving-mural"; Images = @("/assets/images/jaipur-artisan.jpg", "/assets/images/stone-carving.jpg", "/assets/images/mural-art.jpg", "/assets/images/staircase-maple-leaf-relief.jpg") },
    @{ Name = "Floral Stone Art"; Desc = "Elegant stone relief panels featuring hand-carved lotus blooms, vine scrolls, and botanical patterns, adding subtle organic texture to interior and exterior walls."; Material = "Pink Sandstone / Makrana White Marble"; Size = "2 ft x 4 ft panels / custom continuous runs"; Placement = "Living room walls, courtyard niches, & spa corridors"; Finish = "3D Botanical Relief, Honed, Sandblasted"; AltText = "floral-lotus-carved-sandstone-wall-mural"; Images = @("/assets/images/floral-stone-art.jpg", "/assets/images/marble-inlay.jpg", "/assets/images/double-height-lotus-backlit.jpg", "/assets/images/stone-carving.jpg") },
    @{ Name = "Hanuman Ji Stone Art & Mural"; Desc = "A heroic high-relief stone mural depicting Lord Hanuman carrying the Sanjeevani mountain, sculpted with dynamic muscle definition, devotion, and structural power."; Material = "Pink Bansi Paharpur Sandstone / Red Dholpur Stone"; Size = "3 ft x 4 ft to 6 ft x 4 ft vertical mural"; Placement = "Home mandir entrances, fitness pavilions, & courtyards"; Finish = "High 3D Relief, Natural Polish, Hand-Chiseled"; AltText = "lord-hanuman-ji-carved-sandstone-wall-mural"; Images = @("/assets/images/hanuman-ji-mural.jpg", "/assets/images/stone-carving.jpg", "/assets/images/mural-art.jpg", "/assets/images/jaipur-artisan.jpg") }
)

Generate-ProductLeafPage `
    -pagePath "$baseDir\\stone-art-murals\\index.html" `
    -title "Stone Art & Murals" `
    -metaDesc "Explore handcrafted divine spiritual stone murals and artistic wall reliefs by master stone sculptors of Shree Ram & Company Jaipur." `
    -categoryName "Stone Art & Murals" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/mural-art.jpg" `
    -introOverview "Divine spiritual stone murals, deity reliefs, and artistic wall sculptures handcrafted by Jaipur's master artisans in Makrana marble and natural sandstone." `
    -products $samProducts `
    -craftsmanshipHtml $samCraftsmanship `
    -comparisonTableHtml $samTable `
    -faqList $samFaqs `
    -internalLinksHtml $samLinks

Generate-ProductLeafPage `
    -pagePath "$baseDir\\murals-wall-art\\index.html" `
    -title "Stone Art & Murals" `
    -metaDesc "Explore handcrafted divine spiritual stone murals and artistic wall reliefs by master stone sculptors of Shree Ram & Company Jaipur." `
    -categoryName "Stone Art & Murals" `
    -parentCategoryName "Wall Surfaces" `
    -grandParentName "Wall Surfaces" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/mural-art.jpg" `
    -introOverview "Divine spiritual stone murals, deity reliefs, and artistic wall sculptures handcrafted by Jaipur's master artisans in Makrana marble and natural sandstone." `
    -products $samProducts `
    -craftsmanshipHtml $samCraftsmanship `
    -comparisonTableHtml $samTable `
    -faqList $samFaqs `
    -internalLinksHtml $samLinks

foreach ($p in $samProducts) {
    $slug = ($p.Name.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
    Generate-RedirectStub -pagePath "$baseDir\\stone-art-murals\\$slug\\index.html" -targetUrl "/stone-art-murals/#$slug" -title $p.Name
}

Write-Host "Page 2/23 deployed: Stone Art & Murals"
'''

with open(os.path.join(base_dir, "build_complete_deploy_ps1.py"), "w", encoding="utf-8") as f:
    f.write(content)

print("Updated build script for pages 1 and 2.")
