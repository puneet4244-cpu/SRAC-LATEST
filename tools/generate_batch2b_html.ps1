# generate_batch2b_html.ps1
$jsonFile = Join-Path $PSScriptRoot "batch2b_data.json"
$batch2bPages = Get-Content $jsonFile -Raw -Encoding UTF8 | ConvertFrom-Json

Write-Host "Loaded $($batch2bPages.Count) pages from batch2b_data.json"

foreach ($p in $batch2bPages) {
    $slug = $p.Slug
    $name = $p.Name
    $targetDir = Join-Path $PSScriptRoot "..\$($p.TargetDir)"
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }
    $targetFile = Join-Path $targetDir "index.html"
    
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

    # Build Gallery JSON-LD items
    $galleryJsonArray = @()
    $pos = 1
    foreach ($g in $p.Gallery) {
        $gTitleEsc = $g.Title.Replace('"', '\"')
        $galleryJsonArray += @"
              {
                "@type": "ListItem",
                "position": $pos,
                "url": "https://www.shreeramandcompany.com/stone-art-murals/$slug/#item-$pos",
                "name": "$gTitleEsc"
              }
"@
        $pos++
    }
    $galleryJsonJoined = [string]::Join(",`n", $galleryJsonArray)

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
                            <img src="$($rel.Img)" alt="$($rel.Name) - Shree Ram & Company" class="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-500" width="800" height="600" loading="lazy" decoding="async">
                        </div>
                        <h4 class="font-serif text-base text-deep-charcoal group-hover:text-luxury-gold transition-colors">$($rel.Name)</h4>
                    </a>
"@
    }

    # URL-encode whatsapp text
    $waText = [System.Uri]::EscapeDataString("Hello Shree Ram & Company, I am interested in $($p.Name). Please share design catalog, custom dimensions, and quotation.")

    # Assemble complete HTML
    $fullHtml = @"
<!DOCTYPE html>
<html lang="en-IN" class="scroll-smooth">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">

    <!-- SEO Meta Tags -->
    <title>$($p.Title)</title>
    <meta name="description" content="$($p.MetaDesc)">
    <meta name="keywords" content="$($p.Keywords)">
    <meta name="author" content="Shree Ram & Company">
    <link rel="canonical" href="https://www.shreeramandcompany.com/stone-art-murals/$slug/" />

    <!-- Favicon & Icons -->
    <link rel="icon" type="image/jpg" href="/assets/images/brand-logo.jpg">
    <link rel="shortcut icon" href="/assets/images/brand-logo.jpg">
    <link rel="apple-touch-icon" href="/assets/images/brand-logo.jpg">

    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="$($p.Title)">
    <meta property="og:description" content="$($p.MetaDesc)">
    <meta property="og:url" content="https://www.shreeramandcompany.com/stone-art-murals/$slug/">
    <meta property="og:image" content="https://www.shreeramandcompany.com$($p.HeroImg)">

    <!-- Twitter -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="$($p.Title)">
    <meta name="twitter:description" content="$($p.MetaDesc)">
    <meta name="twitter:image" content="https://www.shreeramandcompany.com$($p.HeroImg)">

    <!-- JSON-LD Structured Data: Breadcrumb, CollectionPage & FAQ -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
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
          "@type": "CollectionPage",
          "@id": "https://www.shreeramandcompany.com/stone-art-murals/$slug/#webpage",
          "url": "https://www.shreeramandcompany.com/stone-art-murals/$slug/",
          "name": "$($p.Title)",
          "description": "$($p.MetaDesc)",
          "isPartOf": {
            "@type": "WebSite",
            "@id": "https://www.shreeramandcompany.com/#website",
            "name": "Shree Ram & Company"
          },
          "provider": {
            "@type": "HomeAndConstructionBusiness",
            "@id": "https://www.shreeramandcompany.com/#organization",
            "name": "Shree Ram And Company Vijeta Stone",
            "alternateName": [
              "Shree Ram & Company",
              "Vijeta Stone"
            ],
            "url": "https://www.shreeramandcompany.com/",
            "telephone": "+916367607459",
            "address": {
              "@type": "PostalAddress",
              "streetAddress": "Opposite Metro Pillar No. 76, Radha Vihar, Vishwa Nagar, Shiva Colony, Govindpuri",
              "addressLocality": "Jaipur",
              "addressRegion": "Rajasthan",
              "postalCode": "302019",
              "addressCountry": "IN"
            }
          },
          "mainEntity": {
            "@type": "ItemList",
            "name": "$($p.Name) Collection",
            "numberOfItems": $($p.Gallery.Count),
            "itemListElement": [
$galleryJsonJoined
            ]
          }
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
                        'soft-ivory': '#FFFFF0',
                        'light-beige': '#E5E0D8'
                    },
                    fontFamily: {
                        'serif': ['"Cormorant Garamond"', 'serif'],
                        'sans': ['Inter', 'sans-serif']
                    },
                    boxShadow: {
                        'luxury': '0 20px 40px rgba(0,0,0,0.06)',
                        'gold-glow': '0 10px 30px rgba(198, 161, 110, 0.2)'
                    }
                }
            }
        }
    </script>

    <!-- Custom CSS -->
    <style>
        body { background-color: #FAF8F4; color: #222222; overflow-x: hidden; }
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #FAF8F4; }
        ::-webkit-scrollbar-thumb { background: #C6A16E; border-radius: 4px; }
        .custom-scrollbar::-webkit-scrollbar { width: 4px; height: 4px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #E5E0D8; border-radius: 10px; }
        .custom-scrollbar:hover::-webkit-scrollbar-thumb { background: #C6A16E; }
        .reveal { opacity: 0; transform: translateY(30px); transition: all 0.8s cubic-bezier(0.5, 0, 0, 1); }
        .reveal.active { opacity: 1; transform: translateY(0); }
        .nav-link { position: relative; }
        .nav-link::after { content: ''; position: absolute; width: 0; height: 1px; bottom: -4px; left: 0; background-color: #C6A16E; transition: width 0.3s ease; }
        .nav-link:hover::after { width: 100%; }
        .timeline-line::before { content: ''; position: absolute; top: 24px; left: 50px; right: 50px; height: 1px; background-color: #E5E0D8; z-index: -1; }
        @media (max-width: 768px) { .timeline-line::before { left: 24px; top: 0; bottom: 0; width: 1px; height: 100%; right: auto; } }
    </style>
</head>

<body class="antialiased font-sans">

    <!-- REUSED HEADER / NAVBAR -->
    <header id="header" class="fixed w-full z-50 transition-all duration-500 py-3.5 top-0 bg-white/95 backdrop-blur-md shadow-sm border-b border-light-beige">
        <div class="container mx-auto px-6 lg:px-12 flex justify-between items-center h-16 sm:h-18">
            <a href="/" class="flex items-center gap-3.5 z-50 group my-auto">
                <img src="/assets/images/brand-logo-transparent.png" alt="Shree Ram & Company Logo" class="h-12 sm:h-14 lg:h-15 w-auto object-contain shrink-0 transition-transform duration-300 group-hover:scale-105 filter drop-shadow-sm" width="240" height="60" decoding="async">
                <div class="flex flex-col justify-center items-end text-right">
                    <span class="font-serif text-[18px] sm:text-[21px] md:text-[23px] tracking-[0.12em] text-deep-charcoal uppercase leading-none font-semibold">Shree Ram & Company</span>
                    <span class="text-[9px] md:text-[10px] font-bold tracking-[0.25em] text-[#C6A16E] uppercase mt-1 leading-none self-end">Vijeta Stone</span>
                </div>
            </a>
            
            <nav class="hidden lg:flex space-x-8 items-center ml-auto mr-10">
                <a href="/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">HOME</a>
                <a href="/about-us/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">ABOUT</a>
                
                <div class="relative group">
                    <button class="nav-link text-xs font-semibold tracking-widest text-luxury-gold uppercase flex items-center gap-1.5 py-2">
                        <span>COLLECTIONS</span>
                        <i class="fa-solid fa-chevron-down text-[10px] transition-transform duration-300 group-hover:rotate-180"></i>
                    </button>
                    
                    <div class="absolute left-1/2 -translate-x-1/2 top-full w-[94vw] max-w-[1200px] bg-white border border-light-beige shadow-2xl p-8 rounded-none opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 grid grid-cols-5 gap-6 text-left max-h-[82vh] overflow-y-auto custom-scrollbar">
                        <!-- Col 1: WALL SURFACES -->
                        <div class="space-y-4 border-r border-light-beige/60 pr-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">Wall Surfaces</span>
                            <div class="space-y-3 text-xs">
                                <div><a href="/stone-carving/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">Stone Carving</a></div>
                                <div><a href="/stone-art-murals/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">Stone Art & Murals</a></div>
                                <div><a href="/stone-wall-panels/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">Stone Wall Panels</a></div>
                                <div><a href="/mdf-hdmr-work/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">MDF HDMR Work</a></div>
                            </div>
                        </div>

                        <!-- Col 2: EXTERIOR ELEVATION -->
                        <div class="space-y-4 border-r border-light-beige/60 pr-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">Exterior Elevation</span>
                            <div class="space-y-2 text-xs font-medium text-gray-700">
                                <a href="/elevation-facade/" class="block py-1 hover:text-luxury-gold">Elevation Facade</a>
                                <a href="/customised-name-plate/" class="block py-1 hover:text-luxury-gold">Customised Name Plates</a>
                                <a href="/wall-cladding/" class="block py-1 hover:text-luxury-gold">Wall Cladding</a>
                                <a href="/garden-article/" class="block py-1 hover:text-luxury-gold">Garden Articles</a>
                            </div>
                        </div>

                        <!-- Col 3: TEMPLES & STATUES -->
                        <div class="space-y-4 border-r border-light-beige/60 pr-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">Temples & Statues</span>
                            <div class="space-y-2 text-xs font-medium text-gray-700">
                                <a href="/marble-temple/" class="block py-1 hover:text-luxury-gold">Marble Temples</a>
                                <a href="/stone-temple/" class="block py-1 hover:text-luxury-gold">Stone Temple</a>
                                <a href="/pooja-room/" class="block py-1 hover:text-luxury-gold">Pooja Rooms</a>
                                <a href="/marble-inlay/" class="block py-1 hover:text-luxury-gold">Marble Inlay</a>
                                <a href="/statue/" class="block py-1 hover:text-luxury-gold">Statues</a>
                                <a href="/gazebo/" class="block py-1 hover:text-luxury-gold">Gazebos</a>
                                <a href="/arch-mehrab/" class="block py-1 hover:text-luxury-gold">Arches & Mehrabs</a>
                                <a href="/pillar/" class="block py-1 hover:text-luxury-gold">Pillars</a>
                            </div>
                        </div>

                        <!-- Col 4: HOME INTERIOR & DECOR -->
                        <div class="space-y-4 border-r border-light-beige/60 pr-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">Home Interior & Decor</span>
                            <div class="space-y-2 text-xs font-medium text-gray-700">
                                <a href="/handicrafts/" class="block py-1 hover:text-luxury-gold">Handicrafts</a>
                                <a href="/marble-table-tops/" class="block py-1 hover:text-luxury-gold">Marble Table Tops</a>
                                <a href="/water-fountain/" class="block py-1 hover:text-luxury-gold">Water Fountains</a>
                            </div>
                        </div>

                        <!-- Col 5: CNC JALI WORK -->
                        <div class="space-y-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">CNC Jali Work</span>
                            <div class="space-y-2 text-xs font-medium text-gray-700">
                                <a href="/cnc-jali-work/" class="block py-1 font-bold text-deep-charcoal hover:text-luxury-gold">All CNC Jali Designs</a>
                                <a href="/stone-jali/" class="block py-1 hover:text-luxury-gold">Stone Jali</a>
                                <a href="/mdf-jali/" class="block py-1 hover:text-luxury-gold">MDF / HDMR Jali</a>
                                <a href="/partition-jali/" class="block py-1 hover:text-luxury-gold">Partition Jali</a>
                                <a href="/wpc-jali/" class="block py-1 hover:text-luxury-gold">PVC / WPC Jali</a>
                            </div>
                        </div>
                    </div>
                </div>

                <a href="/articles/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">ARTICLES</a>
                <a href="/contact/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">CONTACT</a>
            </nav>

            <div class="hidden lg:flex items-center gap-4">
                <a href="tel:6367607459" class="text-xs font-bold tracking-widest text-luxury-gold flex items-center gap-2">
                    <i class="fa-solid fa-phone"></i> +91 63676 07459
                </a>
                <a href="#contact" class="text-[11px] font-bold tracking-widest uppercase bg-deep-charcoal hover:bg-black text-white px-5 py-2.5 transition-colors duration-300">
                    GET A QUOTE
                </a>
            </div>

            <!-- Mobile Call Button -->
            <a href="tel:6367607459" class="lg:hidden text-lg text-luxury-gold font-bold flex items-center gap-2">
                <i class="fa-solid fa-phone"></i>
            </a>
        </div>
    </header>

    <main>
        <!-- 1. HERO SECTION -->
        <section class="relative pt-32 pb-20 md:pt-40 md:pb-28 bg-[#181818] text-white overflow-hidden">
            <div class="absolute inset-0 z-0">
                <img src="$($p.HeroImg)" alt="$($p.HeroAlt)" class="w-full h-full object-cover opacity-25 filter brightness-90" width="800" height="600" decoding="async">
                <div class="absolute inset-0 bg-gradient-to-b from-[#181818]/90 via-[#181818]/80 to-[#FAF8F4]"></div>
            </div>

            <div class="container mx-auto px-6 lg:px-12 relative z-10">
                <!-- Breadcrumb -->
                <nav aria-label="Breadcrumb" class="mb-6 flex items-center gap-2 text-[11px] tracking-widest text-gray-400 uppercase font-medium">
                    <a href="/" class="hover:text-luxury-gold transition-colors">Home</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-luxury-gold"></i>
                    <a href="/stone-art-murals/" class="hover:text-luxury-gold transition-colors">Stone Art & Murals</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-luxury-gold"></i>
                    <span class="text-luxury-gold font-semibold">$($p.Name)</span>
                </nav>

                <div class="max-w-3xl">
                    <span class="text-luxury-gold text-xs tracking-[0.25em] font-bold uppercase mb-3 block">$($p.Badge)</span>
                    <h1 class="font-serif text-4xl sm:text-5xl lg:text-6xl text-white font-medium leading-tight mb-6">$($p.H1)</h1>
                    <p class="text-gray-300 text-sm md:text-base font-light leading-relaxed mb-8">$($p.Lead)</p>
                    
                    <div class="flex flex-wrap items-center gap-4">
                        <a href="#contact" class="bg-luxury-gold hover:bg-[#b08c5c] text-white px-8 py-3.5 text-xs font-bold tracking-widest uppercase transition-colors inline-flex items-center gap-2 shadow-lg">
                            Request Custom Quotation <i class="fa-solid fa-arrow-right-long text-xs"></i>
                        </a>
                        <a href="https://wa.me/916367607459?text=$waText" target="_blank" rel="noopener noreferrer" class="border border-white/60 hover:bg-white hover:text-deep-charcoal text-white px-6 py-3.5 text-xs font-bold tracking-widest uppercase transition-colors inline-flex items-center gap-2">
                            <i class="fa-brands fa-whatsapp text-sm text-[#25D366]"></i> WhatsApp Inquiry
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- 2. PRODUCT OVERVIEW SECTION -->
        <section class="py-20 bg-[#FAF8F4]">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
                    <div class="lg:col-span-7 space-y-6">
                        <div class="flex items-center gap-3">
                            <div class="w-12 h-[2px] bg-luxury-gold"></div>
                            <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase">$($p.OverviewSub)</span>
                        </div>
                        <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold leading-snug">$($p.OverviewH2)</h2>
                        <div class="text-gray-700 text-sm md:text-[15px] font-light leading-relaxed space-y-4">
                            <p>$($p.OverviewP1)</p>
                            <p>$($p.OverviewP2)</p>
                        </div>
                    </div>
                    
                    <div class="lg:col-span-5 bg-white p-8 border border-light-beige shadow-luxury space-y-5 rounded-sm">
                        <h3 class="font-serif text-xl text-deep-charcoal font-semibold border-b border-light-beige pb-3">Artisanal Specifications</h3>
                        <div class="space-y-3.5 text-xs">
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Origin</span>
                                <span class="text-deep-charcoal font-bold">$($p.SpecOrigin)</span>
                            </div>
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Stone Mediums</span>
                                <span class="text-deep-charcoal font-bold">$($p.SpecMediums)</span>
                            </div>
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Relief Depth</span>
                                <span class="text-deep-charcoal font-bold">$($p.SpecDepth)</span>
                            </div>
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Standard Sizing</span>
                                <span class="text-deep-charcoal font-bold">$($p.SpecSizing)</span>
                            </div>
                            <div class="flex justify-between py-1.5">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Installation Method</span>
                                <span class="text-deep-charcoal font-bold">$($p.SpecInstall)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. BESPOKE FABRICATION SECTION -->
        <section class="py-20 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Artisanal Mastery</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Sculptural Details Carved with Precision</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light leading-relaxed">Every facet of the $($p.Name) is planned in our Jaipur design studio to ensure authentic proportions, deep relief undercuts, and long-lasting structural strength.</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
$featuresHtml
                </div>
            </div>
        </section>

        <!-- 4. MATERIALS AVAILABLE SECTION -->
        <section class="py-20 bg-luxury-bg border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Quarry Selected Mediums</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Natural Rajasthan Stones & Marble</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Each stone block is carefully examined from certified Rajasthan quarries for uniform mineral density, tensile strength, and fine chiseling response.</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div class="p-6 bg-white border border-light-beige hover:border-luxury-gold/50 shadow-sm transition-all duration-300 rounded-sm">
                        <div class="flex items-center gap-3 mb-3">
                            <div class="w-8 h-8 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-xs">
                                <i class="fa-solid fa-gem"></i>
                            </div>
                            <h4 class="font-serif text-lg text-deep-charcoal font-semibold">Bansi Paharpur Pink Stone</h4>
                        </div>
                        <p class="text-gray-600 text-xs font-light leading-relaxed">Historic terracotta-pink sandstone celebrated in temple architecture, offering rich natural warmth and high structural durability.</p>
                    </div>

                    <div class="p-6 bg-white border border-light-beige hover:border-luxury-gold/50 shadow-sm transition-all duration-300 rounded-sm">
                        <div class="flex items-center gap-3 mb-3">
                            <div class="w-8 h-8 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-xs">
                                <i class="fa-solid fa-gem"></i>
                            </div>
                            <h4 class="font-serif text-lg text-deep-charcoal font-semibold">Gwalior Mint Sandstone</h4>
                        </div>
                        <p class="text-gray-600 text-xs font-light leading-relaxed">Fine-grained pale ivory sandstone with velvety texture, imparting soft contemporary elegance to modern luxury interiors.</p>
                    </div>

                    <div class="p-6 bg-white border border-light-beige hover:border-luxury-gold/50 shadow-sm transition-all duration-300 rounded-sm">
                        <div class="flex items-center gap-3 mb-3">
                            <div class="w-8 h-8 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-xs">
                                <i class="fa-solid fa-gem"></i>
                            </div>
                            <h4 class="font-serif text-lg text-deep-charcoal font-semibold">Indian White Marble</h4>
                        </div>
                        <p class="text-gray-600 text-xs font-light leading-relaxed">Dense crystalline marble achieving mirror polish and brilliant translucence, ideal for sacred prayer rooms and mandirs.</p>
                    </div>

                    <div class="p-6 bg-white border border-light-beige hover:border-luxury-gold/50 shadow-sm transition-all duration-300 rounded-sm">
                        <div class="flex items-center gap-3 mb-3">
                            <div class="w-8 h-8 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-xs">
                                <i class="fa-solid fa-gem"></i>
                            </div>
                            <h4 class="font-serif text-lg text-deep-charcoal font-semibold">Dholpur Beige Sandstone</h4>
                        </div>
                        <p class="text-gray-600 text-xs font-light leading-relaxed">Warm sandy-buff tone that blends effortlessly with timber wall cabinetry, limestone tiles, and ambient recessed lighting.</p>
                    </div>

                    <div class="p-6 bg-white border border-light-beige hover:border-luxury-gold/50 shadow-sm transition-all duration-300 rounded-sm">
                        <div class="flex items-center gap-3 mb-3">
                            <div class="w-8 h-8 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-xs">
                                <i class="fa-solid fa-gem"></i>
                            </div>
                            <h4 class="font-serif text-lg text-deep-charcoal font-semibold">Jaisalmer Yellow Stone</h4>
                        </div>
                        <p class="text-gray-600 text-xs font-light leading-relaxed">Golden honey sandstone providing sunny illumination and royal Rajasthani warmth, radiant in entryway feature arches.</p>
                    </div>

                    <div class="p-6 bg-white border border-light-beige hover:border-luxury-gold/50 shadow-sm transition-all duration-300 rounded-sm">
                        <div class="flex items-center gap-3 mb-3">
                            <div class="w-8 h-8 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-xs">
                                <i class="fa-solid fa-gem"></i>
                            </div>
                            <h4 class="font-serif text-lg text-deep-charcoal font-semibold">Teakwood Sandstone</h4>
                        </div>
                        <p class="text-gray-600 text-xs font-light leading-relaxed">Organic wood-grain striations delivering natural visual depth behind relief contours, marrying organic stone with fine craft.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 5. CRAFTSMANSHIP PROCESS SECTION -->
        <section id="process" class="py-24 bg-white border-t border-light-beige relative z-0">
            <div class="container mx-auto px-6 lg:px-12 text-center reveal">
                <h3 class="font-serif text-4xl lg:text-5xl text-deep-charcoal mb-4">Our Creation Process</h3>
                <div class="w-12 h-[2px] bg-luxury-gold mx-auto mb-20"></div>

                <div class="relative timeline-line">
                    <div class="grid grid-cols-1 md:grid-cols-5 gap-12 text-center">
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">1</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Consultation</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Share your wall dimensions, preferred iconography, and stone variety via WhatsApp or telephone consultation.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">2</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">CAD & 3D Drafting</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Our Jaipur studio drafts calibrated proportional elevations ensuring details adhere to traditional architectural proportions.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">3</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Hand Sculpting</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Master stone carvers detail facial expressions, jewelry tracery, and drapery folds using fine chisel-and-mallet work.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">4</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Dry Fit & Inspection</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">The mural is fully dry-fitted and inspected under directional lighting at our Jaipur workshop, with client photographic approval.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">5</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Insured Delivery</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Packed in foam-cushioned wooden crates and dispatched with comprehensive transit insurance directly to your site across India.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 6. WHERE TO PLACE SECTION -->
        <section class="py-20 bg-luxury-bg border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">$($p.PlaceSub)</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">$($p.PlaceH2)</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">$($p.PlaceLead)</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
$placeHtml
                </div>
            </div>
        </section>

        <!-- 7. CRAFTSMANSHIP PORTFOLIO / GALLERY SECTION -->
        <section class="py-20 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Portfolio</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">$($p.Name) Gallery</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Natural stone relief compositions sculpted at our workshop in Jaipur.</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
$galleryHtml
                </div>
            </div>
        </section>

        <!-- 8. FAQ SECTION -->
        <section class="py-20 bg-luxury-bg border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12 max-w-4xl">
                <div class="text-center mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Clear Guidance</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Frequently Asked Questions</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Comprehensive details regarding stone selection, customization, and architectural wall installation.</p>
                </div>

                <div class="space-y-4">
$faqsHtml
                </div>
            </div>
        </section>

        <!-- 9. EXPLORE RELATED DESIGNS SECTION -->
        <section class="py-20 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-12">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Explore Related Art</span>
                    <h3 class="font-serif text-2xl md:text-3xl text-deep-charcoal font-semibold mb-3">Other Sacred & Architectural Murals</h3>
                    <div class="w-12 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs">Discover our complete collection of handcrafted stone wall reliefs.</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 mb-10">
$relatedHtml
                </div>

                <div class="text-center pt-4">
                    <a href="/stone-art-murals/" class="inline-flex items-center gap-2.5 text-xs font-bold tracking-widest uppercase border border-deep-charcoal text-deep-charcoal px-8 py-3.5 hover:bg-deep-charcoal hover:text-white transition-all duration-300">
                        <i class="fa-solid fa-arrow-left-long text-xs"></i> Back to Stone Art & Murals Collection
                    </a>
                </div>
            </div>
        </section>

        <!-- 10. CONTACT / INQUIRY SECTION -->
        <section id="contact" class="py-24 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12 reveal">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-start">
                    <div>
                        <span class="text-luxury-gold tracking-[0.2em] text-[11px] font-bold uppercase mb-4 block">CONSULTATION STUDIO</span>
                        <h3 class="font-serif text-4xl lg:text-5xl text-deep-charcoal mb-6">Commission Your Bespoke Mural</h3>
                        <p class="text-gray-600 leading-relaxed mb-12">
                            Share your wall dimensions, stone preferences, and artistic requirements with our Jaipur team to receive custom CAD drawings and direct manufacturer quotation within 2 hours.
                        </p>

                        <div class="space-y-8">
                            <div class="flex items-start gap-5 group">
                                <div class="w-14 h-14 shrink-0 bg-luxury-bg border border-light-beige flex items-center justify-center text-luxury-gold text-xl shadow-sm group-hover:bg-luxury-gold group-hover:text-white transition-colors duration-300">
                                    <i class="fa-solid fa-location-dot"></i>
                                </div>
                                <div>
                                    <h5 class="text-luxury-gold text-[10px] tracking-[0.2em] font-bold uppercase mb-2">FACTORY & WORKSHOP LOCATION</h5>
                                    <p class="text-gray-700 text-[15px] leading-relaxed">Opposite Metro Pillar No. 76, Radha Vihar, Vishwa Nagar, Shiva Colony, Govindpuri, Jaipur, Rajasthan 302019</p>
                                </div>
                            </div>

                            <div class="flex items-start gap-5 group">
                                <div class="w-14 h-14 shrink-0 bg-luxury-bg border border-light-beige flex items-center justify-center text-luxury-gold text-xl shadow-sm group-hover:bg-luxury-gold group-hover:text-white transition-colors duration-300">
                                    <i class="fa-solid fa-phone-volume"></i>
                                </div>
                                <div>
                                    <h5 class="text-luxury-gold text-[10px] tracking-[0.2em] font-bold uppercase mb-2">DIRECT CALL / WHATSAPP</h5>
                                    <p class="text-deep-charcoal text-[15px] font-semibold">+91 6367607459</p>
                                </div>
                            </div>

                            <div class="flex items-start gap-5 group">
                                <div class="w-14 h-14 shrink-0 bg-luxury-bg border border-light-beige flex items-center justify-center text-luxury-gold text-xl shadow-sm group-hover:bg-luxury-gold group-hover:text-white transition-colors duration-300">
                                    <i class="fa-regular fa-envelope"></i>
                                </div>
                                <div>
                                    <h5 class="text-luxury-gold text-[10px] tracking-[0.2em] font-bold uppercase mb-2">EMAIL US</h5>
                                    <p class="text-deep-charcoal text-[15px] font-medium">shreeramandcompany07@gmail.com</p>
                                </div>
                            </div>

                            <div class="flex items-start gap-5 group">
                                <div class="w-14 h-14 shrink-0 bg-luxury-bg border border-light-beige flex items-center justify-center text-luxury-gold text-xl shadow-sm group-hover:bg-luxury-gold group-hover:text-white transition-colors duration-300">
                                    <i class="fa-solid fa-truck-fast"></i>
                                </div>
                                <div>
                                    <h5 class="text-luxury-gold text-[10px] tracking-[0.2em] font-bold uppercase mb-2">DISPATCH & DELIVERY</h5>
                                    <p class="text-gray-700 text-[15px] leading-relaxed">Wooden crate packaging with transit insurance for doorstep delivery across India and worldwide exports.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Form Column -->
                    <div class="bg-[#FAF8F4] border border-light-beige p-8 lg:p-12 shadow-luxury rounded-sm">
                        <h4 class="font-serif text-2xl text-deep-charcoal font-semibold mb-2">Direct Workshop Inquiry</h4>
                        <p class="text-gray-500 text-xs mb-8">Direct manufacturer pricing with no middlemen commissions.</p>

                        <form action="https://formspree.io/f/mqaeawbl" method="POST" class="space-y-5">
                            <input type="hidden" name="_subject" value="New Inquiry for $($p.Name)">
                            <input type="hidden" name="product" value="$($p.Name)">
                            
                            <div>
                                <label class="block text-xs font-bold uppercase tracking-wider text-gray-600 mb-2">Your Full Name *</label>
                                <input type="text" name="name" required class="w-full bg-white border border-light-beige px-4 py-3 text-xs text-deep-charcoal focus:border-luxury-gold focus:outline-none transition-colors" placeholder="e.g. Rajesh Sharma">
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-xs font-bold uppercase tracking-wider text-gray-600 mb-2">Phone / WhatsApp *</label>
                                    <input type="tel" name="phone" required class="w-full bg-white border border-light-beige px-4 py-3 text-xs text-deep-charcoal focus:border-luxury-gold focus:outline-none transition-colors" placeholder="+91 98765 43210">
                                </div>
                                <div>
                                    <label class="block text-xs font-bold uppercase tracking-wider text-gray-600 mb-2">Delivery City *</label>
                                    <input type="text" name="city" required class="w-full bg-white border border-light-beige px-4 py-3 text-xs text-deep-charcoal focus:border-luxury-gold focus:outline-none transition-colors" placeholder="e.g. Mumbai, Delhi, Bengaluru">
                                </div>
                            </div>

                            <div>
                                <label class="block text-xs font-bold uppercase tracking-wider text-gray-600 mb-2">Wall Dimensions & Stone Preference</label>
                                <textarea name="message" rows="4" class="w-full bg-white border border-light-beige px-4 py-3 text-xs text-deep-charcoal focus:border-luxury-gold focus:outline-none transition-colors" placeholder="e.g. Approximate wall height and width (e.g. 5x7 ft), preferred stone variety, or custom ideas."></textarea>
                            </div>

                            <button type="submit" class="w-full bg-deep-charcoal hover:bg-black text-white font-bold py-4 text-xs uppercase tracking-widest transition-colors duration-300 shadow-md">
                                Submit Direct Inquiry
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- FOOTER -->
    <footer class="bg-deep-charcoal text-white pt-16 pb-12 border-t border-gray-800">
        <div class="container mx-auto px-6 lg:px-12">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-10 pb-12 border-b border-gray-800">
                <div class="lg:col-span-2 space-y-4">
                    <div class="flex items-center gap-3">
                        <img src="/assets/images/brand-logo-transparent.png" alt="Shree Ram & Company Logo" class="h-14 w-auto object-contain filter brightness-200" width="180" height="48" decoding="async">
                        <div class="flex flex-col">
                            <span class="font-serif text-lg tracking-widest text-white uppercase">Shree Ram & Company</span>
                            <span class="text-[9px] font-bold tracking-[0.25em] text-[#C6A16E] uppercase">Vijeta Stone</span>
                        </div>
                    </div>
                    <p class="text-gray-400 text-xs font-light leading-relaxed max-w-sm">Master stone artisans & luxury architectural carvers based in Jaipur, Rajasthan. Handcrafting bespoke natural stone murals, jalis, and cladding since establishment.</p>
                </div>

                <div>
                    <span class="text-luxury-gold text-xs font-bold tracking-widest uppercase block mb-4">Wall Surfaces</span>
                    <ul class="space-y-2 text-xs text-gray-300 font-light">
                        <li><a href="/stone-carving/" class="hover:text-luxury-gold transition-colors">Stone Carving</a></li>
                        <li><a href="/stone-art-murals/" class="hover:text-luxury-gold transition-colors">Stone Art & Murals</a></li>
                        <li><a href="/stone-wall-panels/" class="hover:text-luxury-gold transition-colors">Stone Wall Panels</a></li>
                        <li><a href="/mdf-hdmr-work/" class="hover:text-luxury-gold transition-colors">MDF HDMR Work</a></li>
                    </ul>
                </div>

                <div>
                    <span class="text-luxury-gold text-xs font-bold tracking-widest uppercase block mb-4">Temples & Statues</span>
                    <ul class="space-y-2 text-xs text-gray-300 font-light">
                        <li><a href="/marble-temple/" class="hover:text-luxury-gold transition-colors">Marble Temples</a></li>
                        <li><a href="/stone-temple/" class="hover:text-luxury-gold transition-colors">Stone Temple</a></li>
                        <li><a href="/pooja-room/" class="hover:text-luxury-gold transition-colors">Pooja Rooms</a></li>
                        <li><a href="/marble-inlay/" class="hover:text-luxury-gold transition-colors">Marble Inlay</a></li>
                        <li><a href="/statue/" class="hover:text-luxury-gold transition-colors">Statues</a></li>
                    </ul>
                </div>

                <div>
                    <span class="text-luxury-gold text-xs font-bold tracking-widest uppercase block mb-4">CNC Jali Work</span>
                    <ul class="space-y-2 text-xs text-gray-300 font-light">
                        <li><a href="/cnc-jali-work/" class="hover:text-luxury-gold transition-colors">All CNC Jali Designs</a></li>
                        <li><a href="/stone-jali/" class="hover:text-luxury-gold transition-colors">Stone Jali</a></li>
                        <li><a href="/mdf-jali/" class="hover:text-luxury-gold transition-colors">MDF / HDMR Jali</a></li>
                        <li><a href="/partition-jali/" class="hover:text-luxury-gold transition-colors">Partition Jali</a></li>
                        <li><a href="/wpc-jali/" class="hover:text-luxury-gold transition-colors">PVC / WPC Jali</a></li>
                    </ul>
                </div>
            </div>

            <div class="pt-8 flex flex-col md:flex-row justify-between items-center text-xs text-gray-400 gap-4">
                <p>&copy; 2026 Shree Ram & Company (Vijeta Stone), Jaipur. All Rights Reserved.</p>
                <div class="flex space-x-6">
                    <a href="/privacy-policy/" class="hover:text-luxury-gold transition-colors">Privacy Policy</a>
                    <a href="/terms-of-service/" class="hover:text-luxury-gold transition-colors">Terms of Service</a>
                    <a href="/contact/" class="hover:text-luxury-gold transition-colors">Contact Workshop</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- STICKY MOBILE ACTION BAR -->
    <div class="fixed bottom-0 left-0 right-0 z-40 bg-white border-t border-light-beige flex lg:hidden shadow-lg">
        <a href="tel:6367607459" class="flex-1 py-3 text-center text-xs font-bold uppercase tracking-wider text-deep-charcoal border-r border-light-beige flex items-center justify-center gap-2">
            <i class="fa-solid fa-phone text-luxury-gold"></i> Call Workshop
        </a>
        <a href="https://wa.me/916367607459?text=$waText" target="_blank" rel="noopener noreferrer" class="flex-1 py-3 text-center text-xs font-bold uppercase tracking-wider text-white bg-[#25D366] flex items-center justify-center gap-2">
            <i class="fa-brands fa-whatsapp text-sm"></i> WhatsApp
        </a>
    </div>

    <!-- FAQ Toggle Script -->
    <script>
        function toggleFaq(id) {
            const content = document.getElementById(id.replace('faq-', 'faq-content-'));
            const icon = document.getElementById(id.replace('faq-', 'faq-icon-'));
            if (content.classList.contains('hidden')) {
                content.classList.remove('hidden');
                icon.classList.add('rotate-180');
            } else {
                content.classList.add('hidden');
                icon.classList.remove('rotate-180');
            }
        }
    </script>

</body>
</html>
"@

    [System.IO.File]::WriteAllText($targetFile, $fullHtml, [System.Text.Encoding]::UTF8)
    Write-Host "Generated: $targetFile (Title: $($p.Title.Length) chars, Meta: $($p.MetaDesc.Length) chars)"
}

Write-Host "All $($batch2bPages.Count) Batch 2b pages successfully generated!"
