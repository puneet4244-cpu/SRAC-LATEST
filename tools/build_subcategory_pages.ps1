param(
    [string]$TargetSlug = "double-height-wall"
)
$workspace = "C:\Users\shree\OneDrive\Desktop\NTRY"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host " SUB-CATEGORY PAGE BUILDER (STONE CARVING)     " -ForegroundColor Cyan
Write-Host " Target: $TargetSlug                           " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

$jsonPath = "$workspace\tools\data\stone_carving_data.json"
$data = Get-Content $jsonPath -Raw -Encoding UTF8 | ConvertFrom-Json

$parent = $data.parentCategory
$subcategories = $data.subcategories

# Find the target subcategory or all
$targetsToBuild = if ([string]::IsNullOrWhiteSpace($TargetSlug) -or $TargetSlug -eq "all") {
    $subcategories
} else {
    $subcategories | Where-Object { $_.slug -eq $TargetSlug }
}

if (-not $targetsToBuild) {
    Write-Error "No subcategory found matching '$TargetSlug'"
    exit 1
}

foreach ($item in $targetsToBuild) {
    $slug = $item.slug
    $pageDir = "$workspace\stone-carving\$slug"
    if (-not (Test-Path $pageDir)) {
        New-Item -ItemType Directory -Path $pageDir -Force | Out-Null
    }
    $pageFile = "$pageDir\index.html"
    $canonicalUrl = "https://www.shreeramandcompany.com/stone-carving/$slug/"
    
    # Calculate sibling links for Explore More (Strictly other 5 subcategories)
    $otherSubcategories = $subcategories | Where-Object { $_.slug -ne $slug }

    # Generate FAQ JSON-LD entities
    $faqJsonItems = @()
    if ($item.faqs) {
        foreach ($f in $item.faqs) {
            $qEsc = $f.q.Replace('"', '\"')
            $aEsc = $f.a.Replace('"', '\"')
            $faqJsonItems += @"
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
    }
    $faqJsonBlock = if ($faqJsonItems.Count -gt 0) {
        $joined = $faqJsonItems -join ",`n"
        @"
    ,
    {
      "@context": "https://schema.org",
      "@type": "FAQPage",
      "mainEntity": [
$joined
      ]
    }
"@
    } else { "" }

    # Generate Gallery HTML
    $galleryHtml = ""
    if ($item.gallery) {
        foreach ($g in $item.gallery) {
            $galleryHtml += @"
                <div class="group relative overflow-hidden bg-white border border-light-beige shadow-sm hover:shadow-luxury transition-all duration-500 rounded-sm">
                    <div class="aspect-[3/4] overflow-hidden bg-[#F0EDE6] relative">
                        <img src="$($g.src)" alt="$($g.alt)" loading="lazy" class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-1000 ease-out">
                        <div class="absolute inset-0 bg-gradient-to-t from-deep-charcoal/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-5">
                            <span class="text-white text-xs font-serif tracking-wide">$($g.caption)</span>
                        </div>
                    </div>
                    <div class="p-3.5 bg-white text-center border-t border-light-beige/50">
                        <span class="text-[11px] font-semibold text-deep-charcoal tracking-wide block">$($g.caption)</span>
                    </div>
                </div>
"@
        }
    }

    # Generate Materials HTML
    $materialsHtml = ""
    if ($item.materials) {
        foreach ($m in $item.materials) {
            $materialsHtml += @"
                <div class="p-6 bg-white border border-light-beige hover:border-luxury-gold/50 shadow-sm hover:shadow-md transition-all duration-300 rounded-sm">
                    <div class="flex items-center gap-3 mb-3">
                        <div class="w-8 h-8 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-xs">
                            <i class="fa-solid fa-gem"></i>
                        </div>
                        <h4 class="font-serif text-lg text-deep-charcoal font-semibold">$($m.name)</h4>
                    </div>
                    <p class="text-gray-600 text-xs font-light leading-relaxed">$($m.note)</p>
                </div>
"@
        }
    }

    # Generate Customization HTML
    $customizationHtml = ""
    if ($item.customization -and $item.customization.points) {
        foreach ($c in $item.customization.points) {
            $customizationHtml += @"
                <div class="p-6 bg-[#FAF8F4] border border-light-beige/80 hover:border-luxury-gold/60 shadow-sm transition-all duration-300 rounded-sm">
                    <div class="w-10 h-10 rounded-full bg-white text-luxury-gold border border-luxury-gold/40 flex items-center justify-center text-sm font-bold mb-4 shadow-sm">
                        <i class="fa-solid fa-compass-drafting"></i>
                    </div>
                    <h4 class="font-serif text-lg text-deep-charcoal font-semibold mb-2">$($c.title)</h4>
                    <p class="text-gray-600 text-xs font-light leading-relaxed">$($c.desc)</p>
                </div>
"@
        }
    }

    # Generate Placement HTML
    $placementHtml = ""
    if ($item.placement) {
        $interiorItems = ""
        if ($item.placement.interior) {
            foreach ($p in $item.placement.interior) {
                $interiorItems += @"
                    <li class="flex items-start gap-3">
                        <i class="fa-solid fa-check text-luxury-gold text-xs mt-1 shrink-0"></i>
                        <div>
                            <strong class="text-deep-charcoal font-semibold text-xs tracking-wide block">$($p.spot)</strong>
                            <p class="text-gray-600 text-xs font-light leading-relaxed">$($p.impact)</p>
                        </div>
                    </li>
"@
            }
        }
        $exteriorItems = ""
        if ($item.placement.exterior) {
            foreach ($p in $item.placement.exterior) {
                $exteriorItems += @"
                    <li class="flex items-start gap-3">
                        <i class="fa-solid fa-check text-luxury-gold text-xs mt-1 shrink-0"></i>
                        <div>
                            <strong class="text-deep-charcoal font-semibold text-xs tracking-wide block">$($p.spot)</strong>
                            <p class="text-gray-600 text-xs font-light leading-relaxed">$($p.impact)</p>
                        </div>
                    </li>
"@
            }
        }
        $placementHtml = @"
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <!-- Interior Applications -->
                <div class="p-8 bg-white border border-light-beige shadow-sm rounded-sm">
                    <div class="flex items-center gap-3 pb-4 mb-6 border-b border-light-beige">
                        <div class="w-10 h-10 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-sm">
                            <i class="fa-solid fa-couch"></i>
                        </div>
                        <div>
                            <span class="text-luxury-gold text-[10px] tracking-widest font-bold uppercase block">Interior Spaces</span>
                            <h4 class="font-serif text-xl text-deep-charcoal font-semibold">Indoor Placement & Ambiance</h4>
                        </div>
                    </div>
                    <ul class="space-y-4">
                        $interiorItems
                    </ul>
                </div>

                <!-- Exterior Applications -->
                <div class="p-8 bg-white border border-light-beige shadow-sm rounded-sm">
                    <div class="flex items-center gap-3 pb-4 mb-6 border-b border-light-beige">
                        <div class="w-10 h-10 rounded-full bg-luxury-bg border border-luxury-gold flex items-center justify-center text-luxury-gold text-sm">
                            <i class="fa-solid fa-landmark"></i>
                        </div>
                        <div>
                            <span class="text-luxury-gold text-[10px] tracking-widest font-bold uppercase block">Exterior Spaces</span>
                            <h4 class="font-serif text-xl text-deep-charcoal font-semibold">Outdoor & Facade Placement</h4>
                        </div>
                    </div>
                    <ul class="space-y-4">
                        $exteriorItems
                    </ul>
                </div>
            </div>
"@
    }

    # Generate Benefits HTML
    $benefitsHtml = ""
    if ($item.benefits) {
        foreach ($b in $item.benefits) {
            $benefitsHtml += @"
                <div class="p-6 bg-white border border-light-beige/80 hover:border-luxury-gold/50 shadow-sm rounded-sm transition-all duration-300">
                    <div class="w-10 h-10 rounded-full bg-luxury-bg border border-luxury-gold/40 flex items-center justify-center text-luxury-gold text-sm mb-4">
                        <i class="fa-solid fa-award"></i>
                    </div>
                    <h4 class="font-serif text-lg text-deep-charcoal font-semibold mb-2">$($b.title)</h4>
                    <p class="text-gray-600 text-xs font-light leading-relaxed">$($b.desc)</p>
                </div>
"@
        }
    }

    # Generate FAQ HTML with accordion
    $faqHtml = ""
    if ($item.faqs) {
        $idx = 0
        foreach ($f in $item.faqs) {
            $idx++
            $faqHtml += @"
                <div class="border border-light-beige bg-white rounded-sm overflow-hidden transition-all duration-300">
                    <button type="button" onclick="toggleFaq('faq-$idx')" class="w-full p-5 text-left flex justify-between items-center gap-4 hover:bg-luxury-bg transition-colors">
                        <span class="font-serif text-base md:text-lg text-deep-charcoal font-medium">$($f.q)</span>
                        <i id="faq-icon-$idx" class="fa-solid fa-chevron-down text-luxury-gold text-xs transition-transform duration-300"></i>
                    </button>
                    <div id="faq-content-$idx" class="hidden px-5 pb-5 pt-1 text-gray-600 text-xs md:text-sm font-light leading-relaxed border-t border-light-beige/40">
                        <p>$($f.a)</p>
                    </div>
                </div>
"@
        }
    }

    # Generate Explore More HTML (Strictly other 5 subcategories + Back to Stone Carving)
    $exploreCardsHtml = ""
    foreach ($other in $otherSubcategories) {
        $otherImg = if ($other.primaryImage) { $other.primaryImage } else { "/assets/images/$($other.slug).webp" }
        $exploreCardsHtml += @"
            <a href="/stone-carving/$($other.slug)/" class="group block bg-white p-3 border border-transparent hover:border-luxury-gold/50 hover:shadow-[0_20px_40px_rgba(0,0,0,0.12)] hover:-translate-y-1.5 transition-all duration-500 cursor-pointer rounded-sm text-center">
                <div class="aspect-[3/4] overflow-hidden relative bg-luxury-bg rounded-sm">
                    <img src="$otherImg" alt="Explore $($other.name) Stone Carving - Shree Ram & Company Vijeta Stone" class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-1000 ease-out" loading="lazy">
                    <div class="absolute inset-0 bg-gradient-to-t from-deep-charcoal/95 via-deep-charcoal/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500 flex flex-col justify-end p-5">
                        <div class="flex items-center justify-center gap-2 text-luxury-gold text-[10px] font-bold tracking-widest uppercase transform translate-y-3 group-hover:translate-y-0 transition-transform duration-500">
                            Explore <i class="fa-solid fa-arrow-right-long"></i>
                        </div>
                    </div>
                </div>
                <div class="pt-4 pb-2 text-center">
                    <span class="text-gray-400 text-[9px] font-bold tracking-[0.2em] uppercase mb-1 block">Stone Carving</span>
                    <h4 class="font-serif text-lg text-deep-charcoal group-hover:text-luxury-gold transition-colors duration-300">$($other.name)</h4>
                </div>
            </a>
"@
    }

    # Assemble Complete HTML File
    $html = @"
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- SEO Meta Tags -->
    <title>$($item.metaTitle)</title>
    <meta name="description" content="$($item.metaDescription)">
    <meta name="keywords" content="$($item.keywords)">
    <meta name="author" content="Shree Ram & Company">
    <link rel="canonical" href="$canonicalUrl" />

    <!-- Favicon & Icons -->
    <link rel="icon" type="image/jpg" href="/assets/images/brand-logo.jpg">
    <link rel="shortcut icon" href="/assets/images/brand-logo.jpg">
    <link rel="apple-touch-icon" href="/assets/images/brand-logo.jpg">

    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="product">
    <meta property="og:title" content="$($item.metaTitle)">
    <meta property="og:description" content="$($item.metaDescription)">
    <meta property="og:url" content="$canonicalUrl">
    <meta property="og:image" content="https://www.shreeramandcompany.com$($item.primaryImage)">

    <!-- Twitter -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="$($item.metaTitle)">
    <meta name="twitter:description" content="$($item.metaDescription)">
    <meta name="twitter:image" content="https://www.shreeramandcompany.com$($item.primaryImage)">

    <!-- JSON-LD Structured Data: Breadcrumb, Service & FAQ -->
    <script type="application/ld+json">
    [
      {
        "@context": "https://schema.org",
        "@type": "BreadcrumbList",
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
            "name": "Stone Carving",
            "item": "https://www.shreeramandcompany.com/stone-carving/"
          },
          {
            "@type": "ListItem",
            "position": 3,
            "name": "$($item.name)",
            "item": "$canonicalUrl"
          }
        ]
      },
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "name": "$($item.h1)",
        "image": "https://www.shreeramandcompany.com$($item.primaryImage)",
        "description": "$($item.metaDescription)",
        "brand": {
          "@type": "Brand",
          "name": "Shree Ram & Company (Vijeta Stone)"
        },
        "offers": {
          "@type": "AggregateOffer",
          "priceCurrency": "INR",
          "priceRange": "\u20B9\u20B9\u20B9"
        }
      }
      $faqJsonBlock
    ]
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
                <img src="/assets/images/brand-logo-transparent.png" alt="Shree Ram & Company Logo" class="h-12 sm:h-14 lg:h-15 w-auto object-contain shrink-0 transition-transform duration-300 group-hover:scale-105 filter drop-shadow-sm">
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
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">Interior & Decor</span>
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
                                <a href="/stone-jali/" class="block py-1 hover:text-luxury-gold">Stone Jali</a>
                                <a href="/mdf-jali/" class="block py-1 hover:text-luxury-gold">MDF Jali</a>
                                <a href="/wpc-jali/" class="block py-1 hover:text-luxury-gold">WPC Jali</a>
                                <a href="/partition-jali/" class="block py-1 hover:text-luxury-gold">Partition Jali</a>
                            </div>
                        </div>
                    </div>
                </div>

                <a href="/articles/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">ARTICLES</a>
                <a href="/contact/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">CONTACT</a>
            </nav>

            <div class="hidden lg:flex items-center space-x-4">
                <a href="tel:6367607459" class="text-[11px] font-semibold tracking-widest uppercase border border-gray-200 text-deep-charcoal px-5 py-2.5 flex items-center gap-2 hover:border-luxury-gold hover:text-luxury-gold transition-all duration-300">
                    <i class="fa-solid fa-phone text-luxury-gold text-xs"></i> CALL NOW
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
                <img src="$($item.primaryImage)" alt="$($item.h1) - Shree Ram & Company" class="w-full h-full object-cover opacity-20 filter brightness-90">
                <div class="absolute inset-0 bg-gradient-to-b from-[#181818]/90 via-[#181818]/80 to-[#FAF8F4]"></div>
            </div>

            <div class="container mx-auto px-6 lg:px-12 relative z-10">
                <!-- Breadcrumb -->
                <nav aria-label="Breadcrumb" class="mb-6 flex items-center gap-2 text-[11px] tracking-widest text-gray-400 uppercase font-medium">
                    <a href="/" class="hover:text-luxury-gold transition-colors">Home</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-luxury-gold"></i>
                    <a href="/stone-carving/" class="hover:text-luxury-gold transition-colors">Stone Carving</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-luxury-gold"></i>
                    <span class="text-luxury-gold font-semibold">$($item.name)</span>
                </nav>

                <div class="max-w-3xl">
                    <span class="text-luxury-gold text-xs tracking-[0.25em] font-bold uppercase mb-3 block">Architectural Wall Surfaces</span>
                    <h1 class="font-serif text-4xl sm:text-5xl lg:text-6xl text-white font-medium leading-tight mb-6">$($item.h1)</h1>
                    <p class="text-gray-300 text-sm md:text-base font-light leading-relaxed mb-8">$($item.heroIntro)</p>
                    
                    <div class="flex flex-wrap items-center gap-4">
                        <a href="#contact" class="bg-luxury-gold hover:bg-[#b08c5c] text-white px-8 py-3.5 text-xs font-bold tracking-widest uppercase transition-colors inline-flex items-center gap-2 shadow-lg">
                            Request Custom Quotation <i class="fa-solid fa-arrow-right-long text-xs"></i>
                        </a>
                        <a href="https://wa.me/916367607459?text=Hello%20Shree%20Ram%20%26%20Company%2C%20I%20am%20interested%20in%20$($item.h1).%20Please%20share%20quotation%20and%20design%20catalog." target="_blank" rel="noopener noreferrer" class="border border-white/60 hover:bg-white hover:text-deep-charcoal text-white px-6 py-3.5 text-xs font-bold tracking-widest uppercase transition-colors inline-flex items-center gap-2">
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
                            <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase">Master Artisanship & Impact</span>
                        </div>
                        <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold leading-snug">Architectural Elegance That Redefines Vertical Space</h2>
                        <div class="text-gray-700 text-sm md:text-[15px] font-light leading-relaxed space-y-4">
                            <p>$($item.overview)</p>
                        </div>
                    </div>
                    
                    <div class="lg:col-span-5 bg-white p-8 border border-light-beige shadow-luxury space-y-5 rounded-sm">
                        <h3 class="font-serif text-xl text-deep-charcoal font-semibold border-b border-light-beige pb-3">Atelier Specifications</h3>
                        <div class="space-y-3.5 text-xs">
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Origin</span>
                                <span class="text-deep-charcoal font-bold">Jaipur, Rajasthan (India)</span>
                            </div>
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Material Options</span>
                                <span class="text-deep-charcoal font-bold">Sandstone, Marble, Limestone</span>
                            </div>
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Height Range</span>
                                <span class="text-deep-charcoal font-bold">12 ft to 32+ ft (Modular Engineered)</span>
                            </div>
                            <div class="flex justify-between py-1.5 border-b border-gray-100">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Installation Method</span>
                                <span class="text-deep-charcoal font-bold">SS-304/316 Mechanical Dry Cladding</span>
                            </div>
                            <div class="flex justify-between py-1.5">
                                <span class="text-gray-500 uppercase tracking-wider font-medium">Maintenance</span>
                                <span class="text-deep-charcoal font-bold">Hydrophobic Sealed &bull; Dry Dusting</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. FULLY CUSTOMIZABLE SECTION -->
        <section class="py-20 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Bespoke Fabrication</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Tailored to Your Exact Dimensions & Style</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light leading-relaxed">$($item.customization.intro)</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    $customizationHtml
                </div>
            </div>
        </section>

        <!-- 4. MATERIALS AVAILABLE SECTION -->
        <section class="py-20 bg-luxury-bg border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Sourced From Certified Mines</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Premium Natural Stones & Marble</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Every stone block is hand-selected from Rajasthan quarries for color consistency, compressive strength, and structural purity.</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    $materialsHtml
                </div>
            </div>
        </section>

        <!-- 5. REUSED PROCESS SECTION (EXACT FROM HOME PAGE) -->
        <section id="process" class="py-24 bg-white border-t border-light-beige relative z-0">
            <div class="container mx-auto px-6 lg:px-12 text-center reveal">
                <h3 class="font-serif text-4xl lg:text-5xl text-deep-charcoal mb-4">Our Creation Process</h3>
                <div class="w-12 h-[2px] bg-luxury-gold mx-auto mb-20"></div>

                <div class="relative timeline-line">
                    <div class="grid grid-cols-1 md:grid-cols-5 gap-12 text-center">
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">1</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Connect & Vision</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Share your space boundaries, architectural drawings, or reference photos with us over a quick call or WhatsApp.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">2</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Material & Design</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Select your preferred natural stone type, texture, and color. We finalize precise 2D/3D design blueprints together.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">3</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Carving Process</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Our master artisans and high-precision multi-axis CNC machines start transforming raw stone blocks into art.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">4</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Quality Check</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">We perform rigorous inspection of every dimension, edge finish, relief depth, and surface polish before dispatch.</p>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 rounded-full border border-luxury-gold bg-luxury-bg flex items-center justify-center text-luxury-gold font-serif text-xl mb-6 shadow-sm">5</div>
                            <h4 class="font-serif text-xl text-deep-charcoal mb-3">Delivery & Install</h4>
                            <p class="text-gray-500 text-xs font-light leading-relaxed">Safe protective packaging, worldwide shipping, and seamless installation guidance at your project site.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 6. WHERE TO PLACE SECTION -->
        <section class="py-20 bg-luxury-bg border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Architectural Placement</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Where to Feature This Design</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Engineered to bring architectural harmony to grand interior voids and palatial exterior facades alike.</p>
                </div>

                $placementHtml
            </div>
        </section>

        <!-- 7. BENEFITS / WHY INSTALL SECTION -->
        <section class="py-20 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Timeless Value</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Why Invest in Handcrafted Stone Art</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Natural carved stone outlives every artificial finish, providing generational durability and enduring luxury.</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    $benefitsHtml
                </div>
            </div>
        </section>

        <!-- 8. GALLERY SECTION -->
        <section class="py-20 bg-luxury-bg border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Craftsmanship Portfolio</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">$($item.name) Gallery</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Actual installed projects and atelier master carvings sculpted at our Jaipur workshop.</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                    $galleryHtml
                </div>
            </div>
        </section>

        <!-- 9. FAQ SECTION -->
        <section class="py-20 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12 max-w-4xl">
                <div class="text-center mb-16">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Clear Guidance</span>
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-semibold mb-4">Frequently Asked Questions</h2>
                    <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs md:text-sm font-light">Common questions on pricing, mechanical dry-cladding installation, and custom lead times.</p>
                </div>

                <div class="space-y-4">
                    $faqHtml
                </div>
            </div>
        </section>

        <!-- 10. EXPLORE MORE SECTION (Strictly other 5 subcategories + Back to Stone Carving) -->
        <section class="py-20 bg-luxury-bg border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12">
                <div class="text-center max-w-2xl mx-auto mb-12">
                    <span class="text-luxury-gold text-xs font-bold tracking-[0.2em] uppercase block mb-2">Explore Related Designs</span>
                    <h3 class="font-serif text-2xl md:text-3xl text-deep-charcoal font-semibold mb-3">Other Stone Carving Subcategories</h3>
                    <div class="w-12 h-[2px] bg-luxury-gold mx-auto mb-4"></div>
                    <p class="text-gray-600 text-xs">Discover our complete collection of architectural handcrafted stone wall reliefs.</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-5 mb-10">
                    $exploreCardsHtml
                </div>

                <div class="text-center pt-4">
                    <a href="/stone-carving/" class="inline-flex items-center gap-2.5 text-xs font-bold tracking-widest uppercase border border-deep-charcoal text-deep-charcoal px-8 py-3.5 hover:bg-deep-charcoal hover:text-white transition-all duration-300">
                        <i class="fa-solid fa-arrow-left-long text-xs"></i> Back to Stone Carving Collection
                    </a>
                </div>
            </div>
        </section>

        <!-- 11. FINAL CTA SECTION (EXACT FROM HOME PAGE) -->
        <section id="contact" class="py-24 bg-white border-t border-light-beige">
            <div class="container mx-auto px-6 lg:px-12 reveal">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-start">
                    <div>
                        <span class="text-luxury-gold tracking-[0.2em] text-[11px] font-bold uppercase mb-4 block">CONSULTATION STUDIO</span>
                        <h3 class="font-serif text-4xl lg:text-5xl text-deep-charcoal mb-6">Let's Carve Out Your Vision</h3>
                        <p class="text-gray-600 leading-relaxed mb-12">
                            Have a custom dimension, design drawing, or specific stone requirement for $($item.name)? Share your project details with our team and get a quick quote within 2 hours.
                        </p>

                        <div class="space-y-8">
                            <div class="flex items-start gap-5 group">
                                <div class="w-14 h-14 shrink-0 bg-luxury-bg border border-light-beige flex items-center justify-center text-luxury-gold text-xl shadow-sm group-hover:bg-luxury-gold group-hover:text-white transition-colors duration-300">
                                    <i class="fa-solid fa-location-dot"></i>
                                </div>
                                <div>
                                    <h5 class="text-luxury-gold text-[10px] tracking-[0.2em] font-bold uppercase mb-2">ATELIER WORKSHOP LOCATION</h5>
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
                                    <i class="fa-regular fa-clock"></i>
                                </div>
                                <div>
                                    <h5 class="text-luxury-gold text-[10px] tracking-[0.2em] font-bold uppercase mb-2">OPERATING HOURS</h5>
                                    <p class="text-gray-700 text-[15px]">Monday &ndash; Saturday: 9:00 AM &ndash; 7:00 PM (Sundays Closed)</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="relative group/form">
                        <div class="absolute -inset-1 bg-gradient-to-br from-luxury-gold/30 to-transparent opacity-0 group-hover/form:opacity-100 transition-opacity duration-700 blur-lg -z-10 rounded-sm"></div>

                        <div class="bg-white p-10 lg:p-12 shadow-2xl border border-gray-100 relative rounded-sm z-10">
                            <form action="https://formsubmit.co/shreeramandcompany07@gmail.com" method="POST" class="space-y-5">
                                <input type="hidden" name="_subject" value="New Inquiry for $($item.name) - Shree Ram & Company">
                                <input type="hidden" name="_captcha" value="false">
                                <input type="hidden" name="_template" value="table">
                                <input type="hidden" name="_next" value="https://www.shreeramandcompany.com/get-a-quote/?submitted=true">
                                <input type="hidden" name="Product_Subcategory" value="$($item.name) (Stone Carving)">

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                    <div class="relative">
                                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-gray-400">
                                            <i class="fa-regular fa-user"></i>
                                        </div>
                                        <input type="text" id="name" name="Name" placeholder="Your Name *" class="w-full bg-[#FAF8F4] border border-gray-200 pl-11 pr-4 py-4 text-sm focus:outline-none focus:border-luxury-gold focus:ring-1 focus:ring-luxury-gold transition-all text-gray-700 shadow-inner rounded-sm" required>
                                    </div>

                                    <div class="relative">
                                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-gray-400">
                                            <i class="fa-brands fa-whatsapp text-lg"></i>
                                        </div>
                                        <input type="tel" id="whatsapp" name="Phone_WhatsApp" placeholder="WhatsApp Number *" class="w-full bg-[#FAF8F4] border border-gray-200 pl-11 pr-4 py-4 text-sm focus:outline-none focus:border-luxury-gold focus:ring-1 focus:ring-luxury-gold transition-all text-gray-700 shadow-inner rounded-sm" required>
                                    </div>
                                </div>

                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-gray-400">
                                        <i class="fa-solid fa-location-dot"></i>
                                    </div>
                                    <input type="text" id="location" name="Location" placeholder="Project Location (City / State)" class="w-full bg-[#FAF8F4] border border-gray-200 pl-11 pr-4 py-4 text-sm focus:outline-none focus:border-luxury-gold focus:ring-1 focus:ring-luxury-gold transition-all text-gray-700 shadow-inner rounded-sm">
                                </div>

                                <div class="relative">
                                    <div class="absolute top-4 left-0 pl-4 flex items-start pointer-events-none text-gray-400">
                                        <i class="fa-regular fa-comment-dots"></i>
                                    </div>
                                    <textarea id="message" name="Message" rows="4" placeholder="Tell us about your requirements (approx wall dimensions, stone preference, carving theme)..." class="w-full bg-[#FAF8F4] border border-gray-200 pl-11 pr-4 py-4 text-sm focus:outline-none focus:border-luxury-gold focus:ring-1 focus:ring-luxury-gold transition-all resize-y text-gray-700 shadow-inner rounded-sm">I am interested in $($item.name) ($($item.h1)). Please share catalog, custom dimensions guidance, and a quotation.</textarea>
                                </div>

                                <div class="pt-2 space-y-3">
                                    <button type="submit" class="group w-full bg-gradient-to-r from-[#222222] to-[#3a3a3a] text-white py-4 text-xs tracking-[0.2em] font-semibold uppercase hover:from-luxury-gold hover:to-[#D4B386] transition-all duration-500 shadow-[0_10px_20px_rgba(0,0,0,0.15)] flex justify-center items-center gap-3 rounded-sm">
                                        SUBMIT REQUEST <i class="fa-solid fa-arrow-right transform group-hover:translate-x-1 transition-transform"></i>
                                    </button>

                                    <a href="https://wa.me/916367607459?text=Hello%20Shree%20Ram%20%26%20Company%2C%20I%20am%20interested%20in%20$($item.name)%20($($item.h1)).%20Please%20share%20quotation." target="_blank" class="w-full bg-gradient-to-r from-[#25D366] to-[#1DA851] text-white py-4 text-xs tracking-[0.2em] font-semibold uppercase flex items-center justify-center gap-2 hover:shadow-[0_8px_20px_rgba(37,211,102,0.4)] hover:-translate-y-0.5 transition-all duration-300 rounded-sm">
                                        <i class="fa-brands fa-whatsapp text-base"></i> INITIATE DIRECT WHATSAPP CHAT
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- REUSED FOOTER -->
    <footer class="bg-deep-charcoal text-white pt-20 pb-12 border-t border-luxury-gold/20">
        <div class="container mx-auto px-6 lg:px-12">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
                <div>
                    <div class="flex items-center gap-4 mb-5">
                        <img src="/assets/images/brand-logo.jpg" alt="Shree Ram & Company Logo" class="h-20 sm:h-24 w-auto object-contain rounded-full border-2 border-luxury-gold/50 shadow-xl">
                        <div class="flex flex-col justify-center">
                            <span class="font-serif text-xl sm:text-2xl tracking-widest text-white uppercase leading-tight block">Shree Ram &</span>
                            <span class="font-serif text-xl sm:text-2xl tracking-widest text-white uppercase leading-tight block">Company</span>
                            <span class="text-luxury-gold text-xs sm:text-sm tracking-[0.25em] font-semibold uppercase block mt-1">Vijeta Stone</span>
                        </div>
                    </div>
                    <p class="text-gray-400 text-xs leading-relaxed font-light mb-4">Generational stone artisans & luxury architectural carvers based in Jaipur, Rajasthan.</p>
                    <div class="flex space-x-3.5 mt-5">
                        <a href="https://www.facebook.com/profile.php?id=61560293691544&mibextid=ZbWKwL" target="_blank" rel="noopener noreferrer" title="Facebook" class="w-9 h-9 rounded-full bg-[#1877F2] text-white flex items-center justify-center shadow-md hover:scale-110 transition-transform"><i class="fa-brands fa-facebook-f text-sm"></i></a>
                        <a href="https://instagram.com/shreeramandcompanyvijetastone?igshid=MzNlNGNkZWQ4Mg==" target="_blank" rel="noopener noreferrer" title="Instagram" class="w-9 h-9 rounded-full bg-gradient-to-tr from-[#f09433] via-[#dc2743] to-[#bc1888] text-white flex items-center justify-center shadow-md hover:scale-110 transition-transform"><i class="fa-brands fa-instagram text-sm"></i></a>
                        <a href="https://youtube.com/@shreeramandcompanyvijetastone?si=3ogOT-0k8mtIOBn9" target="_blank" rel="noopener noreferrer" title="YouTube" class="w-9 h-9 rounded-full bg-[#FF0000] text-white flex items-center justify-center shadow-md hover:scale-110 transition-transform"><i class="fa-brands fa-youtube text-sm"></i></a>
                        <a href="https://share.google/bpdCxT1BCT38gSesw" target="_blank" rel="noopener noreferrer" title="Google Business Profile" class="w-9 h-9 rounded-full bg-[#4285F4] text-white flex items-center justify-center shadow-md hover:scale-110 transition-transform"><i class="fa-brands fa-google text-sm"></i></a>
                    </div>
                </div>
                <div>
                    <h4 class="font-serif text-lg text-white font-semibold mb-5 tracking-wider border-b border-gray-700 pb-2">Wall Surfaces</h4>
                    <ul class="space-y-2.5 text-xs text-gray-300">
                        <li><a href="/stone-carving/" class="hover:text-luxury-gold transition-colors">Stone Carving Walls</a></li>
                        <li><a href="/stone-art-murals/" class="hover:text-luxury-gold transition-colors">Stone Art & Murals</a></li>
                        <li><a href="/stone-wall-panels/" class="hover:text-luxury-gold transition-colors">Stone Wall Panels</a></li>
                        <li><a href="/mdf-hdmr-work/" class="hover:text-luxury-gold transition-colors">MDF HDMR Work</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-serif text-lg text-white font-semibold mb-5 tracking-wider border-b border-gray-700 pb-2">Elevation & Temples</h4>
                    <ul class="space-y-2.5 text-xs text-gray-300">
                        <li><a href="/elevation-facade/" class="hover:text-luxury-gold transition-colors">Elevation Facade</a></li>
                        <li><a href="/wall-cladding/" class="hover:text-luxury-gold transition-colors">Wall Cladding</a></li>
                        <li><a href="/marble-temple/" class="hover:text-luxury-gold transition-colors">Marble Temples</a></li>
                        <li><a href="/stone-temple/" class="hover:text-luxury-gold transition-colors">Stone Temple</a></li>
                        <li><a href="/statue/" class="hover:text-luxury-gold transition-colors">Statues</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-serif text-lg text-white font-semibold mb-5 tracking-wider border-b border-gray-700 pb-2">Decor & CNC Jali</h4>
                    <ul class="space-y-2.5 text-xs text-gray-300">
                        <li><a href="/stone-jali/" class="hover:text-luxury-gold transition-colors">Stone Jali</a></li>
                        <li><a href="/mdf-jali/" class="hover:text-luxury-gold transition-colors">MDF / HDMR Jali</a></li>
                        <li><a href="/partition-jali/" class="hover:text-luxury-gold transition-colors">Partition Jali</a></li>
                        <li><a href="/wpc-jali/" class="hover:text-luxury-gold transition-colors">PVC / WPC Jali</a></li>
                        <li><a href="/water-fountain/" class="hover:text-luxury-gold transition-colors">Water Fountains</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="border-t border-gray-800 pt-8 flex flex-col md:flex-row justify-between items-center text-xs text-gray-400 gap-4">
                <p>&copy; 2026 Shree Ram & Company (Vijeta Stone). All Rights Reserved.</p>
                <div class="flex space-x-6">
                    <a href="/privacy-policy/" class="hover:text-luxury-gold transition-colors">Privacy Policy</a>
                    <a href="/terms-of-service/" class="hover:text-luxury-gold transition-colors">Terms of Service</a>
                    <a href="/contact/" class="hover:text-luxury-gold transition-colors">Contact Atelier</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- MOBILE APP NAVIGATION DOCK -->
    <div class="lg:hidden fixed bottom-0 left-0 right-0 z-50 bg-white/95 backdrop-blur-md border-t border-light-beige shadow-[0_-5px_20px_rgba(0,0,0,0.08)] py-2 px-3">
        <div class="flex justify-around items-center">
            <a href="/" class="flex flex-col items-center justify-center text-deep-charcoal hover:text-luxury-gold active:scale-90 transition-transform">
                <i class="fa-solid fa-house text-base"></i>
                <span class="text-[8px] font-semibold tracking-wider uppercase mt-1">Home</span>
            </a>
            <a href="/stone-carving/" class="flex flex-col items-center justify-center text-luxury-gold active:scale-90 transition-transform">
                <i class="fa-solid fa-shapes text-base"></i>
                <span class="text-[8px] font-semibold tracking-wider uppercase mt-1">Carvings</span>
            </a>
            <a href="https://wa.me/916367607459" target="_blank" rel="noopener noreferrer" class="flex flex-col items-center justify-center text-[#25D366] -mt-5 active:scale-90 transition-transform">
                <div class="w-12 h-12 rounded-full bg-gradient-to-tr from-[#20B038] to-[#60D669] text-white flex items-center justify-center text-2xl shadow-lg border-2 border-white">
                    <i class="fa-brands fa-whatsapp"></i>
                </div>
                <span class="text-[8px] font-bold tracking-wider uppercase mt-1 text-gray-800">WhatsApp</span>
            </a>
            <a href="tel:6367607459" class="flex flex-col items-center justify-center text-gray-600 hover:text-luxury-gold active:scale-90 transition-transform">
                <i class="fa-solid fa-phone text-base"></i>
                <span class="text-[8px] font-semibold tracking-wider uppercase mt-1">Call</span>
            </a>
            <a href="#contact" class="flex flex-col items-center justify-center text-gray-600 hover:text-luxury-gold active:scale-90 transition-transform">
                <i class="fa-solid fa-paper-plane text-base"></i>
                <span class="text-[8px] font-bold tracking-wider uppercase mt-1">Quote</span>
            </a>
        </div>
    </div>

    <!-- JAVASCRIPT: Accordions & Reveal Observer -->
    <script>
        function toggleFaq(id) {
            const content = document.getElementById(id.replace('faq-', 'faq-content-'));
            const icon = document.getElementById(id.replace('faq-', 'faq-icon-'));
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

        document.addEventListener('DOMContentLoaded', () => {
            const revealElements = document.querySelectorAll('.reveal');
            const revealObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('active');
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.1, rootMargin: "0px 0px -50px 0px" });
            revealElements.forEach(el => revealObserver.observe(el));
        });
    </script>
</body>
</html>
"@

    [System.IO.File]::WriteAllText($pageFile, $html, [System.Text.Encoding]::UTF8)
    Write-Host "[OK] Built subcategory page: $pageFile ($([Math]::Round($html.Length / 1024, 1)) KB)" -ForegroundColor Green
}
