# tools/apply_super_unique_batch2b.ps1
$rootDir = Split-Path $PSScriptRoot -Parent
$jsonPath = Join-Path $PSScriptRoot "batch2b_data.json"
$pages = Get-Content $jsonPath -Raw -Encoding UTF8 | ConvertFrom-Json

$bespokeMap = @{
    "buddha-stone-art-mural" = @{
        FeatTitle = "Iconographic Mudras & Sculptural Detailing"
        FeatIntro = "Our sculptors follow classical Buddhist artistic canons to carve flowing robes, meditative mudras, and radiating Bodhi foliage in solid natural stone."
        PlaceTitle = "Mindful Sanctuaries & Serene Courtyard Integration"
        PlaceIntro = "Designed to instill tranquility in home meditation rooms, wellness spaces, indoor koi atriums, and zen garden courtyards."
        GalTitle = "Hand-Carved Buddha Reliefs & Completed Installations"
        GalIntro = "Photographs documenting custom Buddha relief panels chiseled at our Jaipur factory and installed in luxury private residences."
        CtaTitle = "Commission a Meditative Buddha Stone Mural"
        CtaIntro = "Connect directly with our master sculptors in Jaipur to discuss your peaceful prayer corner, wall niche dimensions, and natural stone finishes."
    }
    "durga-mata-ji-stone-art-mural" = @{
        FeatTitle = "Divine Weapons & Regal Simha Chisel Detailing"
        FeatIntro = "Every contour of Sherawali Maa, from the ferocious lion mount to her ten divine ayudhas, is hand-undercut with dimensional relief depth."
        PlaceTitle = "Sacred Temple Sanctums & Entrance Wall Integration"
        PlaceIntro = "Engineered to establish an aura of protective shakti, divine motherly grace, and auspicious security in family mandirs and grand foyers."
        GalTitle = "Maa Durga Relief Carvings & Temple Installations"
        GalIntro = "Visual documentation of bespoke Sherawali stone reliefs hand-finished at our Jaipur factory for home temples and exterior elevations."
        CtaTitle = "Commission a Sacred Maa Durga Stone Mural"
        CtaIntro = "Consult our Jaipur factory carvers for custom mandir elevations, Bansi Paharpur pink stone selection, and secure doorstep delivery."
    }
    "ganesh-ji-stone-art-mural" = @{
        FeatTitle = "Auspicious Vighnaharta Details & Chiseled Motifs"
        FeatIntro = "Delicate micro-chisel work highlights Lord Ganesha's curved trunk (Vakratunda), single unbroken tusk (Ekadanta), and bowl of sweet modaks."
        PlaceTitle = "Entrance Thresholds & Pooja Altar Integration"
        PlaceIntro = "Curated to welcome positive energy, intellectual clarity, and unobstructed success across living room foyers and prayer rooms."
        GalTitle = "Lord Ganesha Stone Murals & Foyer Highlights"
        GalIntro = "Showcase of handcrafted Ganesha stone reliefs sculpted in natural Rajasthan sandstone and white marble at our Jaipur factory."
        CtaTitle = "Commission an Auspicious Ganesha Wall Mural"
        CtaIntro = "Share your entrance foyer or mandir wall dimensions with our Jaipur sculptors for personalized 3D designs and quote factors."
    }
    "hanuman-ji-stone-art-mural" = @{
        FeatTitle = "Heroic Contours & Devotional Sacred Detailing"
        FeatIntro = "Capturing Bajrang Bali's dynamic prana through muscular stone sculpting, the lifted Dronagiri mountain, and his mighty golden gada."
        PlaceTitle = "Courtyards, Home Mandirs & Altar Integration"
        PlaceIntro = "Instills moral fearlessness, physical vitality, and steadfast devotion across residential prayer sanctuaries and wellness suites."
        GalTitle = "Bajrang Bali Relief Panels & Temple Walls"
        GalIntro = "Authentic project documentation of monumental Hanuman stone reliefs chiseled from Bansi Paharpur pink stone in Jaipur."
        CtaTitle = "Commission a Heroic Hanuman Stone Mural"
        CtaIntro = "Speak directly with our Jaipur artisans to design custom Sankat Mochan wall carvings tailored to your private prayer space."
    }
    "laxmi-ji-stone-art-mural" = @{
        FeatTitle = "Auspicious Gajalakshmi Symbols & Lotus Carving"
        FeatIntro = "Intricate lapidary chisel work renders layered lotus petals, twin showering royal elephants, and showering golden coins from the Varada mudra."
        PlaceTitle = "Wealth Corners & Residential Pooja Sanctums"
        PlaceIntro = "Harmoniously aligned for daily Sri Suktam worship, bringing cosmic abundance, grace, and satvik serenity into home mandirs."
        GalTitle = "Goddess Laxmi Marble Reliefs & Mandir Murals"
        GalIntro = "Portfolio of hand-buffed white marble and natural sandstone Laxmi murals crafted at our Jaipur factory for private shrines."
        CtaTitle = "Commission an Auspicious Laxmi Stone Mural"
        CtaIntro = "Contact our Jaipur factory design studio to plan custom dimensions, satvik marble selections, and insured worldwide delivery."
    }
    "ram-darbar-stone-art-mural" = @{
        FeatTitle = "Regal Dharmic Hierarchy & Divine Iconography"
        FeatIntro = "Sculpted with proportional majesty: Shri Ram holding his sacred Kodanda bow, Mata Sita's gentle grace, Lakshman's loyalty, and Hanuman's seva."
        PlaceTitle = "Family Prayer Halls & Double-Height Atriums"
        PlaceIntro = "Establishes a sanctuary of righteous dharma, mutual respect, and familial harmony in residential prayer halls and living rooms."
        GalTitle = "Shri Ram Darbar Compositions & Mandir Facades"
        GalIntro = "Documented monumental multi-panel Ram Darbar stone murals sculpted in Ayodhya-grade pink sandstone by master Jaipur sculptors."
        CtaTitle = "Commission a Monumental Ram Darbar Mural"
        CtaIntro = "Discuss your temple room or grand living wall scale with our Jaipur carving workshop for structural CAD layouts and crated delivery."
    }
    "shiv-ji-stone-art-mural" = @{
        FeatTitle = "Ascetic Transcendence & Meditative Detailing"
        FeatIntro = "Refined chisel undercutting captures the Adiyogi's serene facial stillness, cascading Ganga locks, crescent moon, and commanding Trishul."
        PlaceTitle = "Quiet Meditation Corners & Foyer Courtyards"
        PlaceIntro = "Transforms living spaces into serene havens of stillness, mental focus, and spiritual surrender along sacred Ishanya orientations."
        GalTitle = "Mahadev Stone Murals & Meditative Installations"
        GalIntro = "Visual chronicle of custom Lord Shiva bas-reliefs sculpted in natural Gwalior Mint and crystalline white marble at our Jaipur factory."
        CtaTitle = "Commission an Adiyogi Shiv Stone Mural"
        CtaIntro = "Connect with our Jaipur workshop to customize your meditation wall dimensions, stone finishes, and mounting brackets."
    }
    "shreenath-ji-stone-art-mural" = @{
        FeatTitle = "Govardhandhara Swaroop & Traditional Adornments"
        FeatIntro = "Meticulous sculpting captures the youthful Lord lifting Mount Govardhan, lotus petal eyes (Kamal Nayan), and radiant chin diamond."
        PlaceTitle = "Haveli-Style Mandirs & Intimate Prayer Rooms"
        PlaceIntro = "Brings the sanctified seva ambience of Nathdwara into private residences, enriching daily darshan, kirtan, and quiet contemplation."
        GalTitle = "Shreenath Ji Mukharvind & Haveli Murals"
        GalIntro = "Handcrafted Shreenath Ji stone panels documented in white marble and warm sandstone at our Jaipur artisan facility."
        CtaTitle = "Commission a Shreenath Ji Stone Wall Mural"
        CtaIntro = "Inquire with our Jaipur sculptors to design custom haveli archways, torans, and mirror-buffed marble reliefs for your home shrine."
    }
    "swaminarayan-ji-stone-art-mural" = @{
        FeatTitle = "Ceremonial Royal Pagh & Mandir Arch Detailing"
        FeatIntro = "Delicate chisel work defines Bhagwan Swaminarayan's ceremonial turban, sacred double kanthi, Abhaya mudra palm, and ornate Shikhara archway."
        PlaceTitle = "Central Prayer Sanctums & Devotional Halls"
        PlaceIntro = "Designed as an inspiring devotional anchor for daily aarti, spiritual meditation, and moral contemplation in family mandirs."
        GalTitle = "Swaminarayan Murti Reliefs & Temple Art"
        GalIntro = "High-resolution documentation of bespoke Swaminarayan marble murals and architectural panels sculpted in Jaipur."
        CtaTitle = "Commission a Swaminarayan Stone Mural"
        CtaIntro = "Consult our master sculptors in Jaipur to configure custom murti dimensions, Toran stone framing, and insured nationwide delivery."
    }
    "floral-stone-art" = @{
        FeatTitle = "Botanical Petal Contours & Relief Undercuts"
        FeatIntro = "Dynamic chisel work creates flowing acanthus vines, concentric lotus rosettes, and traditional Rajasthani palace friezes in natural stone."
        PlaceTitle = "Dining Niches, Wainscot Borders & Garden Walls"
        PlaceIntro = "Seamlessly integrates biophilic warmth and neoclassical geometry into living room feature elevations, hallways, and exterior facades."
        GalTitle = "Hand-Chiseled Flower Murals & Botanical Borders"
        GalIntro = "Photographs of custom architectural flower murals and stone relief panels crafted for luxury residential estates in Jaipur."
        CtaTitle = "Commission a Bespoke Stone Flower Mural"
        CtaIntro = "Share your wall dimensions or architectural blueprints with our Jaipur workshop for customized pattern layouts and material samples."
    }
    "village-stone-art-mural" = @{
        FeatTitle = "Pastoral Figurative Realism & Folk Details"
        FeatIntro = "Captures the candid humanity of rural Rajasthan through sculpted Panihari well scenes, village musicians, cattle, and banyan trees."
        PlaceTitle = "Heritage Farmhouses, Living Rooms & Resorts"
        PlaceIntro = "Infuses double-height staircases, expansive living rooms, and hospitality lounges with nostalgic warmth and rustic cultural pride."
        GalTitle = "Rural Heritage Murals & Narrative Panels"
        GalIntro = "Exhibition of panoramic village stone murals sculpted from warm Rajasthan sandstone at our Jaipur factory."
        CtaTitle = "Commission a Traditional Village Stone Mural"
        CtaIntro = "Speak with our master sculptors in Jaipur to conceptualize personalized rural narratives and panoramic multi-slab installations."
    }
}

foreach ($p in $pages) {
    $slug = $p.Slug
    $b = $bespokeMap[$slug]
    if ($b) {
        $p | Add-Member -NotePropertyName "Bespoke" -NotePropertyValue $b -Force
    }
}

# Save updated JSON
$jsonContent = $pages | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($jsonPath, $jsonContent, [System.Text.Encoding]::UTF8)

# Now regenerate the HTML files with bespoke headers and intros
foreach ($p in $pages) {
    $slug = $p.Slug
    $targetDir = Join-Path $rootDir $p.TargetDir
    $targetFile = Join-Path $targetDir "index.html"
    $b = $bespokeMap[$slug]
    
    # Build FAQs JSON-LD
    $faqJsonArray = @()
    foreach ($faq in $p.Faqs) {
        $qEsc = $faq.Q.Replace('"', '\"')
        $aEsc = $faq.A.Replace('"', '\"')
        $faqJsonArray += @"
            {
              "@type": "Question",
              "name": "$qEsc",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "$aEsc"
              }
            }
"@
    }
    $faqJsonJoined = [string]::Join(",`n", $faqJsonArray)

    # Build Features HTML (6 cards)
    $featuresHtml = ""
    foreach ($f in $p.Features) {
        $featuresHtml += @"
                    <div class="p-6 bg-[#FAF8F4] border border-light-beige/80 hover:border-luxury-gold/60 shadow-sm transition-all duration-300 rounded-sm">
                        <div class="w-10 h-10 rounded-full bg-white text-luxury-gold border border-luxury-gold/40 flex items-center justify-center text-sm font-bold mb-4 shadow-sm">
                            <i class="fa-solid $($f.Icon)"></i>
                        </div>
                        <h4 class="font-serif text-lg text-deep-charcoal font-semibold mb-2">$($f.Title)</h4>
                        <p class="text-gray-600 text-xs font-light leading-relaxed">$($f.Desc)</p>
                    </div>
"@
    }

    # Build Unique Section HTML
    $u = $p.UniqueSection
    $col1Html = ""
    foreach ($item in $u.Col1Items) {
        $col1Html += @"
                            <li class="flex items-start gap-3">
                                <i class="fa-solid fa-ruler-combined text-luxury-gold text-xs mt-1 shrink-0"></i>
                                <span class="text-gray-700 text-xs md:text-sm leading-relaxed">$item</span>
                            </li>
"@
    }
    $col2Html = ""
    foreach ($item in $u.Col2Items) {
        $col2Html += @"
                            <li class="flex items-start gap-3">
                                <i class="fa-solid fa-gem text-luxury-gold text-xs mt-1 shrink-0"></i>
                                <span class="text-gray-700 text-xs md:text-sm leading-relaxed">$item</span>
                            </li>
"@
    }
    $col3Html = ""
    foreach ($item in $u.Col3Items) {
        $col3Html += @"
                            <li class="flex items-start gap-3">
                                <i class="fa-solid fa-compass-drafting text-luxury-gold text-xs mt-1 shrink-0"></i>
                                <span class="text-gray-700 text-xs md:text-sm leading-relaxed">$item</span>
                            </li>
"@
    }

    $uniqueSectionHtml = @"
    <!-- Bespoke Architectural Specifications & Sizing Section -->
    <section id="architectural-specifications" class="py-16 md:py-24 bg-white border-b border-light-beige">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center max-w-3xl mx-auto mb-16">
                <span class="text-luxury-gold text-xs tracking-widest uppercase font-semibold block mb-3">$($u.Subtitle)</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal mb-4">$($u.Title)</h2>
                <div class="w-16 h-0.5 bg-luxury-gold mx-auto mb-6"></div>
                <p class="text-gray-600 text-sm md:text-base font-light leading-relaxed">$($u.Intro)</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Sizing Card -->
                <div class="p-8 bg-luxury-bg border border-light-beige/90 shadow-sm rounded-sm hover:border-luxury-gold/50 transition-all duration-300">
                    <div class="w-12 h-12 rounded-full bg-white text-luxury-gold border border-luxury-gold/30 flex items-center justify-center text-lg mb-6 shadow-sm">
                        <i class="fa-solid fa-maximize"></i>
                    </div>
                    <h3 class="font-serif text-xl text-deep-charcoal font-semibold mb-4 pb-3 border-b border-light-beige">$($u.Col1Title)</h3>
                    <ul class="space-y-3.5">
$col1Html
                    </ul>
                </div>
                <!-- Stone Grades Card -->
                <div class="p-8 bg-luxury-bg border border-light-beige/90 shadow-sm rounded-sm hover:border-luxury-gold/50 transition-all duration-300">
                    <div class="w-12 h-12 rounded-full bg-white text-luxury-gold border border-luxury-gold/30 flex items-center justify-center text-lg mb-6 shadow-sm">
                        <i class="fa-solid fa-cubes"></i>
                    </div>
                    <h3 class="font-serif text-xl text-deep-charcoal font-semibold mb-4 pb-3 border-b border-light-beige">$($u.Col2Title)</h3>
                    <ul class="space-y-3.5">
$col2Html
                    </ul>
                </div>
                <!-- Mounting & Lighting Card -->
                <div class="p-8 bg-luxury-bg border border-light-beige/90 shadow-sm rounded-sm hover:border-luxury-gold/50 transition-all duration-300">
                    <div class="w-12 h-12 rounded-full bg-white text-luxury-gold border border-luxury-gold/30 flex items-center justify-center text-lg mb-6 shadow-sm">
                        <i class="fa-solid fa-lightbulb"></i>
                    </div>
                    <h3 class="font-serif text-xl text-deep-charcoal font-semibold mb-4 pb-3 border-b border-light-beige">$($u.Col3Title)</h3>
                    <ul class="space-y-3.5">
$col3Html
                    </ul>
                </div>
            </div>
        </div>
    </section>
"@

    # Build Placement Cards HTML (2 cards)
    $placeHtml = ""
    foreach ($pc in $p.PlaceCards) {
        $placeHtml += @"
                    <div class="p-8 bg-white border border-light-beige shadow-sm rounded-sm">
                        <div class="flex items-center gap-3 pb-4 mb-6 border-b border-light-beige">
                            <div class="w-10 h-10 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-sm">
                                <i class="fa-solid $($pc.Icon)"></i>
                            </div>
                            <div>
                                <span class="text-luxury-gold text-[10px] tracking-widest font-bold uppercase block">$($pc.Tag)</span>
                                <h4 class="font-serif text-xl text-deep-charcoal font-semibold">$($pc.Title)</h4>
                            </div>
                        </div>
                        <ul class="space-y-4">
                            <li class="flex items-start gap-3">
                                <i class="fa-solid fa-check text-luxury-gold text-xs mt-1 shrink-0"></i>
                                <div>
                                    <strong class="text-deep-charcoal font-semibold text-xs tracking-wide block">$($pc.P1Title)</strong>
                                    <p class="text-gray-600 text-xs font-light leading-relaxed">$($pc.P1Desc)</p>
                                </div>
                            </li>
                            <li class="flex items-start gap-3">
                                <i class="fa-solid fa-check text-luxury-gold text-xs mt-1 shrink-0"></i>
                                <div>
                                    <strong class="text-deep-charcoal font-semibold text-xs tracking-wide block">$($pc.P2Title)</strong>
                                    <p class="text-gray-600 text-xs font-light leading-relaxed">$($pc.P2Desc)</p>
                                </div>
                            </li>
                        </ul>
                    </div>
"@
    }

    # Build Gallery Cards HTML
    $galleryHtml = ""
    foreach ($g in $p.Gallery) {
        $galleryHtml += @"
                    <div class="group relative overflow-hidden bg-white border border-light-beige shadow-sm hover:shadow-luxury transition-all duration-500 rounded-sm">
                        <div class="aspect-[3/4] overflow-hidden bg-[#F0EDE6] relative">
                            <img src="$($g.Img)" alt="$($g.Alt)" loading="lazy" class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-1000 ease-out" width="800" height="600" decoding="async">
                            <div class="absolute inset-0 bg-gradient-to-t from-deep-charcoal/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-5">
                                <span class="text-white text-xs font-serif tracking-wide">$($g.Title)</span>
                            </div>
                        </div>
                        <div class="p-3.5 bg-white text-center border-t border-light-beige/50">
                            <span class="text-[11px] font-semibold text-deep-charcoal tracking-wide block">$($g.Title)</span>
                        </div>
                    </div>
"@
    }

    # Build FAQs HTML
    $faqsHtml = ""
    $faqIdx = 1
    foreach ($faq in $p.Faqs) {
        $faqsHtml += @"
                    <div class="border border-light-beige bg-white rounded-sm overflow-hidden transition-all duration-300">
                        <button type="button" onclick="toggleFaq('faq-$faqIdx')" class="w-full p-5 text-left flex justify-between items-center gap-4 hover:bg-luxury-bg transition-colors">
                            <span class="font-serif text-base md:text-lg text-deep-charcoal font-medium">$($faq.Q)</span>
                            <i id="faq-icon-$faqIdx" class="fa-solid fa-chevron-down text-luxury-gold text-xs transition-transform duration-300"></i>
                        </button>
                        <div id="faq-content-$faqIdx" class="hidden px-5 pb-5 pt-1 text-gray-600 text-xs md:text-sm font-light leading-relaxed border-t border-light-beige/40">
                            <p>$($faq.A)</p>
                        </div>
                    </div>
"@
        $faqIdx++
    }

    # Build Related HTML
    $relatedHtml = ""
    foreach ($rel in $p.Related) {
        $relatedHtml += @"
                    <a href="$($rel.Url)" class="group block bg-[#FAF8F4] p-3 border border-transparent hover:border-luxury-gold/50 hover:shadow-lg transition-all duration-300 rounded-sm text-center">
                        <div class="aspect-[3/4] overflow-hidden relative bg-white rounded-sm mb-3">
                            <img src="$($rel.Img)" alt="$($rel.Title) - Shree Ram & Company" class="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-500" width="800" height="600" loading="lazy" decoding="async">
                        </div>
                        <h4 class="font-serif text-sm font-semibold text-deep-charcoal group-hover:text-luxury-gold transition-colors">$($rel.Title)</h4>
                        <span class="text-[10px] text-gray-500 tracking-wider uppercase block mt-1">View Details &rarr;</span>
                    </a>
"@
    }

    # Highlights HTML
    $highHtml = ""
    foreach ($h in $p.Highlights) {
        $highHtml += @"
                            <li class="flex items-start gap-3">
                                <i class="fa-solid fa-circle-check text-luxury-gold text-sm mt-0.5 shrink-0"></i>
                                <span class="text-gray-700 text-xs md:text-sm font-light leading-relaxed">$h</span>
                            </li>
"@
    }

    # Full HTML Template
    $html = @"
<!DOCTYPE html>
<html lang="en-IN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$($p.Title)</title>
    <meta name="description" content="$($p.MetaDesc)">
    <meta name="keywords" content="$($p.Keywords)">
    <meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
    <link rel="canonical" href="https://www.shreeramandcompany.com/stone-art-murals/$slug/">

    <!-- Open Graph Tags -->
    <meta property="og:type" content="article">
    <meta property="og:title" content="$($p.Title)">
    <meta property="og:description" content="$($p.MetaDesc)">
    <meta property="og:url" content="https://www.shreeramandcompany.com/stone-art-murals/$slug/">
    <meta property="og:image" content="https://www.shreeramandcompany.com$($p.Gallery[0].Img)">
    <meta property="og:site_name" content="Shree Ram & Company">

    <!-- Twitter Card Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="$($p.Title)">
    <meta name="twitter:description" content="$($p.MetaDesc)">
    <meta name="twitter:image" content="https://www.shreeramandcompany.com$($p.Gallery[0].Img)">

    <!-- Favicon -->
    <link rel="icon" type="image/jpg" href="/assets/images/brand-logo.jpg">

    <!-- Schema.org JSON-LD (WebPage + BreadcrumbList + FAQPage strictly compliant) -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "WebPage",
          "@id": "https://www.shreeramandcompany.com/stone-art-murals/$slug/#webpage",
          "url": "https://www.shreeramandcompany.com/stone-art-murals/$slug/",
          "name": "$($p.Title)",
          "description": "$($p.MetaDesc)",
          "isPartOf": {
            "@type": "WebSite",
            "@id": "https://www.shreeramandcompany.com/#website",
            "url": "https://www.shreeramandcompany.com/",
            "name": "Shree Ram And Company Vijeta Stone"
          },
          "breadcrumb": {
            "@id": "https://www.shreeramandcompany.com/stone-art-murals/$slug/#breadcrumb"
          },
          "inLanguage": "en-IN"
        },
        {
          "@type": "BreadcrumbList",
          "@id": "https://www.shreeramandcompany.com/stone-art-murals/$slug/#breadcrumb",
          "itemListElement": [
            {
              "@type": "ListItem",
              "position": 1,
              "name": "Home",
              "item": "https://www.shreeramandcompany.com/"
            },
            {
              "@type": "ListItem",
              "position": 2,
              "name": "Stone Art & Murals",
              "item": "https://www.shreeramandcompany.com/stone-art-murals/"
            },
            {
              "@type": "ListItem",
              "position": 3,
              "name": "$($p.Name)",
              "item": "https://www.shreeramandcompany.com/stone-art-murals/$slug/"
            }
          ]
        },
        {
          "@type": "FAQPage",
          "@id": "https://www.shreeramandcompany.com/stone-art-murals/$slug/#faq",
          "mainEntity": [
$faqJsonJoined
          ]
        }
      ]
    }
    </script>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Tailwind CSS (Tailored Luxury Palette) -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'luxury-bg': '#FAF8F4',
                        'luxury-gold': '#C6A16E',
                        'deep-charcoal': '#222222',
                        'light-beige': '#E5E0D8'
                    },
                    fontFamily: {
                        serif: ['"Cormorant Garamond"', 'serif'],
                        sans: ['"Inter"', 'sans-serif']
                    },
                    boxShadow: {
                        'luxury': '0 20px 40px -15px rgba(34, 34, 34, 0.07)',
                        'gold-glow': '0 0 25px rgba(198, 161, 110, 0.2)'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-luxury-bg text-deep-charcoal font-sans antialiased selection:bg-luxury-gold selection:text-white">

    <!-- Navigation Header -->
    <header class="sticky top-0 z-50 bg-[#FAF8F4]/95 backdrop-blur-md border-b border-light-beige transition-all duration-300">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-20 sm:h-24">
                <a href="/" class="flex items-center gap-3 sm:gap-4 group focus:outline-none" aria-label="Shree Ram & Company Home">
                    <img src="/assets/images/brand-logo-transparent.png" alt="Shree Ram & Company Logo" class="h-12 sm:h-14 lg:h-15 w-auto object-contain shrink-0 transition-transform duration-300 group-hover:scale-105 filter drop-shadow-sm" width="240" height="60" decoding="async">
                </a>
                <nav class="hidden md:flex items-center space-x-8 text-xs font-medium tracking-widest uppercase">
                    <a href="/" class="text-deep-charcoal hover:text-luxury-gold transition-colors py-2">Home</a>
                    <a href="/stone-carving/" class="text-deep-charcoal hover:text-luxury-gold transition-colors py-2">Stone Carving</a>
                    <a href="/stone-art-murals/" class="text-luxury-gold border-b border-luxury-gold py-2 font-semibold">Stone Art & Murals</a>
                    <a href="/stone-wall-panels/" class="text-deep-charcoal hover:text-luxury-gold transition-colors py-2">Wall Panels</a>
                    <a href="/cnc-jali-work/" class="text-deep-charcoal hover:text-luxury-gold transition-colors py-2">CNC Jali</a>
                    <a href="/contact/" class="text-deep-charcoal hover:text-luxury-gold transition-colors py-2">Contact</a>
                </nav>
                <div class="hidden sm:flex items-center space-x-4">
                    <a href="/get-a-quote/" class="inline-flex items-center justify-center px-5 py-2.5 text-xs font-medium uppercase tracking-widest text-white bg-deep-charcoal hover:bg-luxury-gold transition-all duration-300 shadow-sm rounded-sm">
                        Request Quote
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Breadcrumb Navigation -->
    <nav class="bg-white border-b border-light-beige py-3" aria-label="Breadcrumb">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <ol class="flex items-center space-x-2 text-xs text-gray-500 font-light">
                <li><a href="/" class="hover:text-luxury-gold transition-colors">Home</a></li>
                <li><span class="text-gray-300">/</span></li>
                <li><a href="/stone-art-murals/" class="hover:text-luxury-gold transition-colors">Stone Art & Murals</a></li>
                <li><span class="text-gray-300">/</span></li>
                <li class="text-deep-charcoal font-normal truncate" aria-current="page">$($p.Name)</li>
            </ol>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative py-16 md:py-24 bg-deep-charcoal text-white overflow-hidden">
        <div class="absolute inset-0 z-0">
            <img src="$($p.Gallery[0].Img)" alt="$($p.Name) sculpted in natural stone relief" class="w-full h-full object-cover opacity-25 filter brightness-90" width="800" height="600" decoding="async">
            <div class="absolute inset-0 bg-gradient-to-r from-deep-charcoal via-deep-charcoal/90 to-transparent"></div>
        </div>
        <div class="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="max-w-3xl">
                <span class="inline-block px-3 py-1 bg-luxury-gold/20 border border-luxury-gold/40 text-luxury-gold text-xs tracking-widest uppercase mb-6 rounded-sm backdrop-blur-sm">
                    $($p.Badge)
                </span>
                <h1 class="font-serif text-3xl sm:text-4xl md:text-5xl lg:text-6xl text-white font-normal leading-tight tracking-tight mb-6">
                    $($p.H1)
                </h1>
                <p class="text-gray-300 text-sm sm:text-base md:text-lg font-light leading-relaxed mb-8 max-w-2xl">
                    $($p.Lead)
                </p>
                <div class="flex flex-wrap items-center gap-4">
                    <a href="/get-a-quote/" class="inline-flex items-center justify-center px-7 py-3.5 bg-luxury-gold hover:bg-[#b58f5c] text-white text-xs uppercase tracking-widest font-semibold transition-all duration-300 shadow-luxury rounded-sm">
                        Commission Custom Mural
                    </a>
                    <a href="#gallery" class="inline-flex items-center justify-center px-7 py-3.5 border border-white/30 hover:border-white text-white text-xs uppercase tracking-widest font-light transition-all duration-300 rounded-sm">
                        Explore Portfolio
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Architectural & Sculptural Overview -->
    <section class="py-16 md:py-24 bg-white border-b border-light-beige">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-16 items-center">
                <div class="lg:col-span-7 space-y-6">
                    <div class="border-l-2 border-luxury-gold pl-4">
                        <span class="text-luxury-gold text-xs tracking-widest uppercase font-semibold block mb-1">Architectural Craftsmanship</span>
                        <h2 class="font-serif text-2xl sm:text-3xl md:text-4xl text-deep-charcoal font-normal">
                            $($p.OverviewH2)
                        </h2>
                    </div>
                    <p class="text-gray-600 text-sm sm:text-base font-light leading-relaxed">
                        $($p.OverviewP1)
                    </p>
                    <p class="text-gray-600 text-sm sm:text-base font-light leading-relaxed">
                        $($p.OverviewP2)
                    </p>
                    <div class="pt-4 border-t border-light-beige/60">
                        <h3 class="font-serif text-lg text-deep-charcoal font-semibold mb-3">Master Workshop Distinctions</h3>
                        <ul class="space-y-2.5">
$highHtml
                        </ul>
                    </div>
                </div>
                <div class="lg:col-span-5">
                    <div class="relative bg-luxury-bg p-4 sm:p-6 border border-light-beige shadow-luxury rounded-sm">
                        <div class="aspect-[4/5] overflow-hidden rounded-sm relative bg-[#EFECE6]">
                            <img src="$($p.Gallery[0].Img)" alt="$($p.Gallery[0].Alt)" class="w-full h-full object-cover transform hover:scale-105 transition-transform duration-700 ease-out" width="800" height="600" loading="lazy" decoding="async">
                        </div>
                        <div class="mt-4 p-4 bg-white border border-light-beige/80 rounded-sm text-center">
                            <span class="text-luxury-gold text-[10px] tracking-widest uppercase font-bold block mb-1">Factory Direct Manufacturing</span>
                            <p class="text-deep-charcoal font-serif text-base font-semibold">Jaipur Workshop Handcrafting</p>
                            <p class="text-gray-500 text-xs font-light mt-1">Quarry-selected Indian sandstone and crystalline marble</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    $uniqueSectionHtml

    <!-- Detailed Iconographic & Sculptural Features (6 Cards) -->
    <section class="py-16 md:py-24 bg-luxury-bg border-b border-light-beige">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center max-w-3xl mx-auto mb-16">
                <span class="text-luxury-gold text-xs tracking-widest uppercase font-semibold block mb-3">Micro-Chisel Protocol</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal mb-4">$($b.FeatTitle)</h2>
                <div class="w-16 h-0.5 bg-luxury-gold mx-auto mb-6"></div>
                <p class="text-gray-600 text-sm md:text-base font-light leading-relaxed">$($b.FeatIntro)</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8">
$featuresHtml
            </div>
        </div>
    </section>

    <!-- Placement & Architectural Setting (2 Cards + Vastu Advisory Disclaimer) -->
    <section class="py-16 md:py-24 bg-white border-b border-light-beige">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center max-w-3xl mx-auto mb-16">
                <span class="text-luxury-gold text-xs tracking-widest uppercase font-semibold block mb-3">Architectural Integration</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal mb-4">$($b.PlaceTitle)</h2>
                <div class="w-16 h-0.5 bg-luxury-gold mx-auto mb-6"></div>
                <p class="text-gray-600 text-sm md:text-base font-light leading-relaxed">$($b.PlaceIntro)</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
$placeHtml
            </div>
            <!-- Vastu Advisory Disclaimer Note -->
            <div class="p-4 bg-luxury-bg border-l-4 border-luxury-gold text-gray-500 text-xs font-light leading-relaxed rounded-r-sm">
                <strong class="text-deep-charcoal font-semibold">Traditional Placement Advisory:</strong> Placement and directional guidance are shared as time-honored architectural customs. Clients are encouraged to consult their personal family Vastu or spiritual advisors for individual room alignment and customized mandir configurations.
            </div>
        </div>
    </section>

    <!-- Project Gallery Showcase -->
    <section id="gallery" class="py-16 md:py-24 bg-luxury-bg border-b border-light-beige">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-12 gap-4">
                <div>
                    <span class="text-luxury-gold text-xs tracking-widest uppercase font-semibold block mb-2">Artisan Workshop Portfolio</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal">$($b.GalTitle)</h2>
                </div>
                <p class="text-gray-500 text-xs sm:text-sm font-light max-w-md">$($b.GalIntro)</p>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8">
$galleryHtml
            </div>
        </div>
    </section>

    <!-- Frequently Asked Questions (Accordion) -->
    <section id="faqs" class="py-16 md:py-24 bg-white border-b border-light-beige">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <span class="text-luxury-gold text-xs tracking-widest uppercase font-semibold block mb-3">Architectural Inquiries</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal mb-4">Frequently Asked Questions</h2>
                <div class="w-16 h-0.5 bg-luxury-gold mx-auto"></div>
            </div>
            <div class="space-y-4">
$faqsHtml
            </div>
        </div>
    </section>

    <!-- Related Stone Art Murals -->
    <section class="py-16 md:py-20 bg-luxury-bg border-b border-light-beige">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <span class="text-luxury-gold text-xs tracking-widest uppercase font-semibold block mb-2">Explore Related Art</span>
                <h3 class="font-serif text-2xl md:text-3xl text-deep-charcoal font-normal">Complementary Stone Art & Murals</h3>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4 sm:gap-6">
$relatedHtml
            </div>
        </div>
    </section>

    <!-- Bottom CTA Bar -->
    <section class="py-16 bg-deep-charcoal text-white text-center">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <h2 class="font-serif text-3xl md:text-4xl mb-4 font-normal">$($b.CtaTitle)</h2>
            <p class="text-gray-400 text-sm md:text-base font-light mb-8 max-w-xl mx-auto">$($b.CtaIntro)</p>
            <div class="flex flex-wrap justify-center gap-4">
                <a href="/get-a-quote/" class="inline-flex items-center justify-center px-8 py-3.5 bg-luxury-gold hover:bg-[#b58f5c] text-white text-xs uppercase tracking-widest font-semibold transition-all duration-300 shadow-luxury rounded-sm">
                    Request Project Quote
                </a>
                <a href="tel:+916367607459" class="inline-flex items-center justify-center px-8 py-3.5 border border-white/30 hover:border-white text-white text-xs uppercase tracking-widest font-light transition-all duration-300 rounded-sm">
                    <i class="fa-solid fa-phone text-luxury-gold mr-2 text-sm"></i> Call +91 63676 07459
                </a>
                <a href="https://wa.me/916367607459?text=Hello%20Shree%20Ram%20%26%20Company,%20I%20am%20inquiring%20about%20$($p.Name)" target="_blank" rel="noopener noreferrer" class="inline-flex items-center justify-center px-8 py-3.5 bg-[#25D366]/20 border border-[#25D366]/50 hover:bg-[#25D366]/30 text-white text-xs uppercase tracking-widest font-light transition-all duration-300 rounded-sm">
                    <i class="fa-brands fa-whatsapp text-[#25D366] mr-2 text-sm"></i> WhatsApp Us
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-deep-charcoal text-gray-400 text-xs py-12 border-t border-gray-800">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-4">
            <p class="font-serif text-lg text-white font-normal">Shree Ram & Company</p>
            <p class="font-light max-w-md mx-auto text-gray-400">Direct manufacturer of architectural natural stone carvings, temple mandirs, and luxury 3D wall art in Jaipur, Rajasthan.</p>
            <p class="text-gray-500 pt-4 border-t border-gray-800">&copy; 2026 Shree Ram & Company. All Rights Reserved. Primary Host: https://www.shreeramandcompany.com/</p>
        </div>
    </footer>

    <!-- FAQ Toggle Script -->
    <script>
        function toggleFaq(id) {
            const content = document.getElementById('faq-content-' + id.split('-')[1]);
            const icon = document.getElementById('faq-icon-' + id.split('-')[1]);
            if (!content) return;
            const isHidden = content.classList.contains('hidden');
            if (isHidden) {
                content.classList.remove('hidden');
                if (icon) icon.classList.add('rotate-180');
            } else {
                content.classList.add('hidden');
                if (icon) icon.classList.remove('rotate-180');
            }
        }
    </script>
</body>
</html>
"@

    [System.IO.File]::WriteAllText($targetFile, $html, [System.Text.Encoding]::UTF8)
    Write-Host "Generated ultra-unique HTML for $($p.Slug) -> $targetFile"
}

Write-Host "All 11 pages updated with bespoke headers and intros."
