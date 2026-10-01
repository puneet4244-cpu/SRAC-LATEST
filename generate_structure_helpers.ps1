# Complete Site Structure and Category Page Generator
$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

# Template generator for Parent / Menu-Only Subcategory Hubs (NO product cards, only links to child subcategories)
function Generate-MenuOnlyHubPage {
    param(
        [string]$pagePath,
        [string]$title,
        [string]$metaDesc,
        [string]$categoryName,
        [string]$parentCategoryName = "Wall Surfaces",
        [string]$heroBg = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1920&q=80",
        [array]$children
    )

    $parentDir = Split-Path $pagePath -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    $cardsHtml = ""
    foreach ($child in $children) {
        $cName = $child.Name
        $cUrl = $child.Url
        $cDesc = $child.Desc
        $cImg = $child.Img

        $cardsHtml += @"
            <!-- Subcategory Card -->
            <a href="$cUrl" class="group bg-white border border-light-beige hover:border-luxury-gold shadow-sm hover:shadow-luxury transition-all duration-300 flex flex-col overflow-hidden">
                <div class="relative h-64 overflow-hidden bg-gray-100">
                    <img src="$cImg" alt="$cName" class="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-700">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-60 group-hover:opacity-40 transition-opacity"></div>
                    <span class="absolute bottom-4 left-4 text-white font-serif text-2xl drop-shadow-md">$cName</span>
                </div>
                <div class="p-6 flex-1 flex flex-col justify-between">
                    <p class="text-gray-600 text-sm font-light leading-relaxed mb-6">$cDesc</p>
                    <div class="flex items-center text-luxury-gold text-xs font-bold tracking-widest uppercase group-hover:translate-x-1 transition-transform">
                        <span>Explore Designs & Products</span>
                        <i class="fa-solid fa-arrow-right ml-2 text-[10px]"></i>
                    </div>
                </div>
            </a>
"@
    }

    $html = @"
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title | Shree Ram & Company Jaipur</title>
    <meta name="description" content="$metaDesc">
    <meta name="author" content="Shree Ram & Company">
    <link rel="canonical" href="https://www.shreeramandcompany.com$([System.IO.Path]::GetDirectoryName($pagePath).Replace($baseDir, '').Replace('\', '/'))/" />

    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Tailwind CSS -->
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
    <style>
        body { background-color: #FAF8F4; color: #222222; overflow-x: hidden; }
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #FAF8F4; }
        ::-webkit-scrollbar-thumb { background: #C6A16E; border-radius: 4px; }
        .custom-scrollbar::-webkit-scrollbar { width: 4px; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #C6A16E; border-radius: 4px; }
        .reveal { opacity: 0; transform: translateY(30px); transition: all 0.8s cubic-bezier(0.5, 0, 0, 1); }
        .reveal.active { opacity: 1; transform: translateY(0); }
        .nav-link { position: relative; }
        .nav-link::after { content: ''; position: absolute; width: 0; height: 1px; bottom: -4px; left: 0; background-color: #C6A16E; transition: width 0.3s ease; }
        .nav-link:hover::after { width: 100%; }
    </style>
</head>
<body class="antialiased font-sans">

    <!-- HEADER -->
    <header id="header" class="fixed w-full z-50 transition-all duration-500 py-4 top-0 bg-white shadow-sm border-b border-light-beige">
        <div class="container mx-auto px-6 lg:px-12 flex justify-between items-center">
            <a href="/" class="flex flex-col z-50">
                <span class="font-serif text-[20px] md:text-[26px] tracking-[0.15em] text-deep-charcoal uppercase leading-none font-semibold">Shree Ram & Company</span>
                <span class="text-[9px] md:text-[10px] font-medium tracking-[0.3em] text-[#C6A16E] uppercase mt-1 self-end md:mr-1">Vijeta Stone</span>
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
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">1. Wall Surfaces</span>
                            <div class="space-y-3 text-xs">
                                <div>
                                    <a href="/stone-carving/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">Stone Carving</a>
                                    <div class="pl-2.5 space-y-1 text-gray-600 text-[11px] border-l border-light-beige">
                                        <a href="/stone-carving/double-height-wall/" class="block hover:text-luxury-gold">Double Height Wall</a>
                                        <a href="/stone-carving/staircase-wall/" class="block hover:text-luxury-gold">Staircase Wall</a>
                                        <a href="/stone-carving/sofa-wall/" class="block hover:text-luxury-gold">Sofa Wall</a>
                                        <a href="/stone-carving/statement-wall/" class="block hover:text-luxury-gold">Statement Wall</a>
                                        <a href="/stone-carving/living-room-wall/" class="block hover:text-luxury-gold">Living Room Wall</a>
                                        <a href="/stone-carving/featured-wall/" class="block hover:text-luxury-gold">Featured Wall</a>
                                    </div>
                                </div>
                                <div>
                                    <a href="/stone-art-murals/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">Stone Art & Murals</a>
                                    <div class="pl-2.5 space-y-1 text-gray-600 text-[11px] border-l border-light-beige max-h-32 overflow-y-auto custom-scrollbar">
                                        <a href="/stone-art-murals/radhe-krishna/" class="block hover:text-luxury-gold">Radhe Krishna</a>
                                        <a href="/stone-art-murals/buddha/" class="block hover:text-luxury-gold">Buddha</a>
                                        <a href="/stone-art-murals/hanuman-ji/" class="block hover:text-luxury-gold">Hanuman Ji</a>
                                        <a href="/stone-art-murals/durga-mata-ji/" class="block hover:text-luxury-gold">Durga Mata Ji</a>
                                        <a href="/stone-art-murals/ganesh-ji/" class="block hover:text-luxury-gold">Ganesh Ji</a>
                                        <a href="/stone-art-murals/laxmi-ji/" class="block hover:text-luxury-gold">Laxmi Ji</a>
                                        <a href="/stone-art-murals/ram-darbar/" class="block hover:text-luxury-gold">Ram Darbar</a>
                                        <a href="/stone-art-murals/shiv-ji/" class="block hover:text-luxury-gold">Shiv Ji</a>
                                        <a href="/stone-art-murals/swaminarayan-ji/" class="block hover:text-luxury-gold">Swaminarayan Ji</a>
                                        <a href="/stone-art-murals/shreenath-ji/" class="block hover:text-luxury-gold">Shreenath Ji</a>
                                        <a href="/stone-art-murals/village-stone-art/" class="block hover:text-luxury-gold">Village Art</a>
                                        <a href="/stone-art-murals/floral-stone-art/" class="block hover:text-luxury-gold">Floral Art</a>
                                    </div>
                                </div>
                                <div>
                                    <a href="/stone-wall-panels/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">Stone Wall Panels</a>
                                    <div class="pl-2.5 space-y-1 text-gray-600 text-[11px] border-l border-light-beige">
                                        <a href="/stone-wall-panels/fluted/" class="block hover:text-luxury-gold">Fluted Panels</a>
                                        <a href="/stone-wall-panels/textured/" class="block hover:text-luxury-gold">Textured Panels</a>
                                        <a href="/stone-wall-panels/wave/" class="block hover:text-luxury-gold">Wave Panels</a>
                                        <a href="/stone-wall-panels/geometrical/" class="block hover:text-luxury-gold">Geometrical Panels</a>
                                    </div>
                                </div>
                                <div>
                                    <a href="/mdf-hdmr-work/" class="font-bold text-deep-charcoal hover:text-luxury-gold block mb-1">MDF HDMR Work</a>
                                    <div class="pl-2.5 space-y-1 text-gray-600 text-[11px] border-l border-light-beige">
                                        <a href="/mdf-hdmr-work/wall-panels/" class="block hover:text-luxury-gold">Wall Panels</a>
                                        <a href="/mdf-hdmr-work/fluted/" class="block hover:text-luxury-gold">Fluted MDF</a>
                                        <a href="/mdf-hdmr-work/textured/" class="block hover:text-luxury-gold">Textured MDF</a>
                                        <a href="/mdf-hdmr-work/wave/" class="block hover:text-luxury-gold">Wave MDF</a>
                                        <a href="/mdf-hdmr-work/geometrical/" class="block hover:text-luxury-gold">Geometrical MDF</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Col 2: EXTERIOR ELEVATION -->
                        <div class="space-y-4 border-r border-light-beige/60 pr-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">2. Exterior Elevation</span>
                            <div class="space-y-2 text-xs font-medium text-gray-700">
                                <a href="/elevation-facade/" class="block py-1 hover:text-luxury-gold">Elevation Facade</a>
                                <a href="/customised-name-plate/" class="block py-1 hover:text-luxury-gold">Customised Name Plates</a>
                                <a href="/wall-cladding/" class="block py-1 hover:text-luxury-gold">Wall Cladding</a>
                                <a href="/garden-article/" class="block py-1 hover:text-luxury-gold">Garden Articles</a>
                            </div>
                        </div>

                        <!-- Col 3: TEMPLES & STATUES -->
                        <div class="space-y-4 border-r border-light-beige/60 pr-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">3. Temples & Statues</span>
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
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">4. Interior & Decor</span>
                            <div class="space-y-2 text-xs font-medium text-gray-700">
                                <a href="/handicrafts/" class="block py-1 hover:text-luxury-gold">Handicrafts</a>
                                <a href="/marble-table-tops/" class="block py-1 hover:text-luxury-gold">Marble Table Tops</a>
                                <a href="/water-fountain/" class="block py-1 hover:text-luxury-gold">Water Fountains</a>
                            </div>
                        </div>

                        <!-- Col 5: CNC JALI WORK -->
                        <div class="space-y-4">
                            <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">5. CNC Jali Work</span>
                            <div class="space-y-2 text-xs font-medium text-gray-700">
                                <a href="/stone-jali/" class="block py-1 hover:text-luxury-gold">Stone Jali</a>
                                <a href="/mdf-jali/" class="block py-1 hover:text-luxury-gold">MDF / HDMR Jali</a>
                                <a href="/partition-jali/" class="block py-1 hover:text-luxury-gold">Partition Jali</a>
                                <a href="/wpc-jali/" class="block py-1 hover:text-luxury-gold">PVC / WPC Jali</a>
                            </div>
                        </div>
                    </div>
                </div>

                <a href="/articles/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">ARTICLES</a>
                <a href="/#process" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">PROCESS</a>
                <a href="/get-a-quote/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">CONTACT</a>
            </nav>

            <div class="hidden lg:flex items-center space-x-3">
                <a href="tel:6367607459" class="text-[11px] font-semibold tracking-widest uppercase border border-gray-200 text-deep-charcoal px-5 py-2.5 flex items-center gap-2 hover:border-luxury-gold hover:text-luxury-gold transition-all duration-300">
                    <i class="fa-solid fa-phone text-[#C6A16E]"></i> CALL NOW
                </a>
                <a href="/get-a-quote/" class="text-[11px] font-semibold tracking-widest uppercase bg-[#222222] text-white px-5 py-2.5 border border-[#222222] hover:bg-black transition-all duration-300">
                    REQUEST QUOTE
                </a>
            </div>
            
            <a href="tel:6367607459" class="lg:hidden text-lg text-luxury-gold font-bold flex items-center gap-2">
                <i class="fa-solid fa-phone"></i>
            </a>
        </div>
    </header>

    <!-- BREADCRUMB -->
    <div class="bg-white border-b border-light-beige pt-28 pb-4">
        <div class="container mx-auto px-6 lg:px-12">
            <nav class="flex text-xs font-medium text-gray-500 uppercase tracking-wider space-x-2">
                <a href="/" class="hover:text-luxury-gold">Home</a>
                <span>/</span>
                <a href="/#collection" class="hover:text-luxury-gold">$parentCategoryName</a>
                <span>/</span>
                <span class="text-luxury-gold font-semibold">$categoryName</span>
            </nav>
        </div>
    </div>

    <!-- HERO -->
    <section class="relative py-20 lg:py-28 bg-[#181818] overflow-hidden text-center text-white">
        <div class="absolute inset-0 z-0">
            <img src="$heroBg" alt="$categoryName Background" class="w-full h-full object-cover opacity-25">
            <div class="absolute inset-0 bg-black/50"></div>
        </div>
        <div class="container mx-auto px-6 lg:px-12 relative z-10">
            <span class="text-luxury-gold text-xs font-bold tracking-[0.25em] uppercase block mb-3">$parentCategoryName</span>
            <h1 class="font-serif text-4xl md:text-6xl text-white mb-6">$categoryName</h1>
            <p class="text-gray-300 max-w-2xl mx-auto text-sm md:text-base font-light leading-relaxed mb-8">$metaDesc</p>
            <div class="inline-flex items-center gap-2 text-xs tracking-widest uppercase text-luxury-gold border-b border-luxury-gold pb-1">
                Select a collection below to view bespoke products & designs
            </div>
        </div>
    </section>

    <!-- SUB-CATEGORY CARDS GRID -->
    <section class="py-20 bg-luxury-bg">
        <div class="container mx-auto px-6 lg:px-12">
            <div class="text-center mb-16">
                <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block mb-2">Explore Collections</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal mb-4">$categoryName Categories</h2>
                <div class="w-16 h-[2px] bg-luxury-gold mx-auto"></div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                $cardsHtml
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="bg-deep-charcoal text-white pt-20 pb-12 border-t border-luxury-gold/20">
        <div class="container mx-auto px-6 lg:px-12">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
                <div>
                    <span class="font-serif text-2xl tracking-widest text-white uppercase block mb-2">Shree Ram & Company</span>
                    <span class="text-luxury-gold text-xs tracking-[0.25em] uppercase block mb-6">Vijeta Stone</span>
                    <p class="text-gray-400 text-xs leading-relaxed font-light mb-6">Generational stone artisans & luxury architectural carvers based in Jaipur, Rajasthan.</p>
                </div>
                <div>
                    <span class="text-sm font-bold tracking-widest uppercase text-luxury-gold block mb-6">Quick Links</span>
                    <ul class="space-y-3 text-xs text-gray-400 font-light">
                        <li><a href="/" class="hover:text-white transition-colors">Home</a></li>
                        <li><a href="/about-us/" class="hover:text-white transition-colors">About Us</a></li>
                        <li><a href="/articles/" class="hover:text-white transition-colors">Stone Articles & Guides</a></li>
                        <li><a href="/get-a-quote/" class="hover:text-white transition-colors">Get Custom Quote</a></li>
                    </ul>
                </div>
                <div>
                    <span class="text-sm font-bold tracking-widest uppercase text-luxury-gold block mb-6">Main Collections</span>
                    <ul class="space-y-3 text-xs text-gray-400 font-light">
                        <li><a href="/stone-carving/" class="hover:text-white transition-colors">Stone Carving</a></li>
                        <li><a href="/stone-art-murals/" class="hover:text-white transition-colors">Stone Art & Murals</a></li>
                        <li><a href="/stone-wall-panels/" class="hover:text-white transition-colors">Stone Wall Panels</a></li>
                        <li><a href="/mdf-hdmr-work/" class="hover:text-white transition-colors">MDF HDMR Work</a></li>
                    </ul>
                </div>
                <div>
                    <span class="text-sm font-bold tracking-widest uppercase text-luxury-gold block mb-6">Contact Studio</span>
                    <div class="space-y-3 text-xs text-gray-400 font-light">
                        <p><i class="fa-solid fa-location-dot text-luxury-gold mr-2"></i> Jaipur, Rajasthan, India</p>
                        <p><i class="fa-solid fa-phone text-luxury-gold mr-2"></i> <a href="tel:6367607459" class="hover:text-white">+91 63676 07459</a></p>
                        <p><i class="fa-brands fa-whatsapp text-luxury-gold mr-2"></i> <a href="https://wa.me/916367607459" class="hover:text-white">WhatsApp Chat</a></p>
                    </div>
                </div>
            </div>
            <div class="border-t border-gray-800 pt-8 flex flex-col md:flex-row justify-between items-center text-xs text-gray-500">
                <p>&copy; 2026 Shree Ram & Company (Vijeta Stone). All Rights Reserved.</p>
                <p class="mt-4 md:mt-0">Handcrafted Luxury Stone Architecture</p>
            </div>
        </div>
    </footer>

    <!-- STICKY FLOATING WHATSAPP -->
    <a href="https://wa.me/916367607459" target="_blank" rel="noopener noreferrer" class="fixed bottom-6 right-6 z-40 bg-[#25D366] text-white w-14 h-14 rounded-full flex items-center justify-center text-2xl shadow-luxury hover:scale-110 transition-transform">
        <i class="fa-brands fa-whatsapp"></i>
    </a>
</body>
</html>
"@

    Set-Content -Path $pagePath -Value $html -Encoding UTF8
    Write-Host "Generated Menu-Only Hub: $pagePath"
}

Write-Host "Generator functions ready."
