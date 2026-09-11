# Category and Subcategory Structure Builder for Shree Ram & Company

$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

# Helper for Header Mega Menu HTML
function Get-HeaderHtml {
    param([string]$activeCategory = "")
    return @"
    <!-- HEADER -->
    <header id="header" class="fixed w-full z-50 transition-all duration-500 py-4 top-0 bg-white shadow-sm border-b border-light-beige">
        <div class="container mx-auto px-6 lg:px-12 flex justify-between items-center">
            
            <!-- Logo -->
            <a href="/" class="flex flex-col z-50">
                <span class="font-serif text-[20px] md:text-[26px] tracking-[0.15em] text-deep-charcoal uppercase leading-none font-semibold">Shree Ram & Company</span>
                <span class="text-[9px] md:text-[10px] font-medium tracking-[0.3em] text-[#C6A16E] uppercase mt-1 self-end md:mr-1">Vijeta Stone</span>
            </a>
            
            <!-- Desktop Navigation -->
            <nav class="hidden lg:flex space-x-8 items-center ml-auto mr-10">
                <a href="/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">HOME</a>
                <a href="/about-us/" class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase">ABOUT</a>
                
                <!-- Collections Mega Dropdown -->
                <div class="relative group">
                    <button class="nav-link text-xs font-semibold tracking-widest text-gray-800 uppercase flex items-center gap-1.5 py-2 group-hover:text-luxury-gold transition-colors">
                        <span>COLLECTIONS</span>
                        <i class="fa-solid fa-chevron-down text-[10px] transition-transform duration-300 group-hover:rotate-180 text-luxury-gold"></i>
                    </button>
                    
                    <!-- Mega Menu Container -->
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
                                    <div class="pl-2.5 space-y-1 text-gray-600 text-[11px] border-l border-light-beige max-h-36 overflow-y-auto custom-scrollbar">
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

            <!-- Desktop CTA Buttons -->
            <div class="hidden lg:flex items-center space-x-3">
                <a href="tel:6367607459" class="text-[11px] font-semibold tracking-widest uppercase border border-gray-200 text-deep-charcoal px-5 py-2.5 flex items-center gap-2 hover:border-luxury-gold hover:text-luxury-gold transition-all duration-300">
                    <i class="fa-solid fa-phone text-[#C6A16E]"></i> CALL NOW
                </a>
                <a href="/get-a-quote/" class="text-[11px] font-semibold tracking-widest uppercase bg-[#222222] text-white px-5 py-2.5 border border-[#222222] hover:bg-black transition-all duration-300">
                    REQUEST QUOTE
                </a>
            </div>
            
            <!-- Mobile Menu Toggle Button -->
            <button id="mobile-menu-btn" class="lg:hidden text-[24px] text-deep-charcoal focus:outline-none p-2" aria-label="Toggle Navigation">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>
    </header>
"@
}

Write-Host "Header template loaded successfully."
