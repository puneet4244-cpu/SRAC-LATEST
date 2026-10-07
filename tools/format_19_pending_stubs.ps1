$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

$stubsInfo = @(
    # Stone Art & Murals (11)
    @{ Path = "stone-art-murals\buddha-stone-art-mural\index.html"; Name = "Buddha Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\durga-mata-ji-stone-art-mural\index.html"; Name = "Durga Mata Ji Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\floral-stone-art\index.html"; Name = "Floral Stone Art"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\ganesh-ji-stone-art-mural\index.html"; Name = "Ganesh Ji Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\hanuman-ji-stone-art-mural\index.html"; Name = "Hanuman Ji Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\laxmi-ji-stone-art-mural\index.html"; Name = "Laxmi Ji Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\ram-darbar-stone-art-mural\index.html"; Name = "Ram Darbar Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\shiv-ji-stone-art-mural\index.html"; Name = "Shiv Ji Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\shreenath-ji-stone-art-mural\index.html"; Name = "Shreenath Ji Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\swaminarayan-ji-stone-art-mural\index.html"; Name = "Swaminarayan Ji Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    @{ Path = "stone-art-murals\village-stone-art-mural\index.html"; Name = "Village Stone Art & Mural"; Parent = "Stone Art & Murals"; ParentUrl = "/stone-art-murals/" },
    # Stone Wall Panels (3)
    @{ Path = "stone-wall-panels\geometrical-stone-panels\index.html"; Name = "Geometrical Stone Panels"; Parent = "Stone Wall Panels"; ParentUrl = "/stone-wall-panels/" },
    @{ Path = "stone-wall-panels\textured-stone-panels\index.html"; Name = "Textured Stone Panels"; Parent = "Stone Wall Panels"; ParentUrl = "/stone-wall-panels/" },
    @{ Path = "stone-wall-panels\wave-stone-panels\index.html"; Name = "Wave Stone Panels"; Parent = "Stone Wall Panels"; ParentUrl = "/stone-wall-panels/" },
    # MDF / HDMR Work (5)
    @{ Path = "mdf-hdmr-work\fluted-mdf-panels\index.html"; Name = "Fluted MDF Panels"; Parent = "MDF HDMR Work"; ParentUrl = "/mdf-hdmr-work/" },
    @{ Path = "mdf-hdmr-work\geometrical-mdf-panels\index.html"; Name = "Geometrical MDF Panels"; Parent = "MDF HDMR Work"; ParentUrl = "/mdf-hdmr-work/" },
    @{ Path = "mdf-hdmr-work\mdf-hdmr-wall-panels\index.html"; Name = "MDF HDMR Wall Panels"; Parent = "MDF HDMR Work"; ParentUrl = "/mdf-hdmr-work/" },
    @{ Path = "mdf-hdmr-work\textured-mdf-panels\index.html"; Name = "Textured MDF Panels"; Parent = "MDF HDMR Work"; ParentUrl = "/mdf-hdmr-work/" },
    @{ Path = "mdf-hdmr-work\wave-mdf-panels\index.html"; Name = "Wave MDF Panels"; Parent = "MDF HDMR Work"; ParentUrl = "/mdf-hdmr-work/" }
)

foreach ($item in $stubsInfo) {
    $fullPath = Join-Path $rootDir $item.Path
    $name = $item.Name
    $parent = $item.Parent
    $parentUrl = $item.ParentUrl

    $html = @"
<!DOCTYPE html>
<html lang="en-IN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="noindex, follow">
    <title>$name | Shree Ram & Company Jaipur</title>
    <meta name="description" content="Explore custom $name handcrafted by master stone artisans at Shree Ram & Company in Jaipur, Rajasthan.">
    <link rel="icon" type="image/jpg" href="/assets/images/brand-logo.jpg">

    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                        'serif': ['"Cormorant Garamond"', 'serif'],
                        'sans': ['Inter', 'sans-serif']
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-luxury-bg text-deep-charcoal font-sans antialiased flex flex-col min-h-screen">

    <!-- Brand Header -->
    <header class="w-full bg-white border-b border-light-beige py-4 px-6 md:px-12 flex justify-between items-center shadow-sm">
        <a href="/" class="flex items-center gap-3">
            <img src="/assets/images/brand-logo-transparent.png" alt="Shree Ram & Company Logo" class="h-12 w-auto object-contain" width="180" height="48">
            <div class="flex flex-col">
                <span class="font-serif text-lg font-semibold tracking-wider uppercase leading-none">Shree Ram & Company</span>
                <span class="text-[9px] font-bold tracking-widest text-luxury-gold uppercase mt-1">Vijeta Stone</span>
            </div>
        </a>
        <div class="flex items-center gap-4 text-xs font-semibold">
            <a href="$parentUrl" class="text-luxury-gold hover:underline uppercase tracking-wider">All $parent</a>
            <a href="tel:6367607459" class="bg-deep-charcoal text-white px-4 py-2 hover:bg-luxury-gold transition-colors uppercase tracking-wider hidden sm:inline-block">Call Workshop</a>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow flex items-center justify-center py-20 px-6">
        <div class="max-w-xl mx-auto text-center bg-white p-10 md:p-14 border border-light-beige shadow-lg rounded-sm">
            <span class="text-luxury-gold text-xs font-bold tracking-[0.25em] uppercase block mb-3">$parent Collection</span>
            <h1 class="font-serif text-3xl md:text-4xl text-deep-charcoal mb-4 font-semibold">$name</h1>
            <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-6"></div>
            <p class="text-gray-600 text-sm md:text-base leading-relaxed mb-8">
                Detailed bespoke catalogue, high-resolution photographs, and architectural specifications for <strong>$name</strong> are currently being curated for our upcoming batch update.
            </p>
            <p class="text-gray-500 text-xs mb-8">
                In the meantime, view our full parent gallery or connect directly with our master craftsmen in Jaipur for custom project dimensions and stone samples.
            </p>
            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <a href="$parentUrl" class="bg-deep-charcoal text-white hover:bg-luxury-gold px-6 py-3 text-xs font-semibold uppercase tracking-widest transition-colors inline-flex items-center justify-center gap-2">
                    <i class="fa-solid fa-arrow-left"></i> View $parent Gallery
                </a>
                <a href="https://wa.me/916367607459?text=Hello%20Shree%20Ram%20%26%20Company%2C%20I%20want%20to%20inquire%20about%20$([System.Uri]::EscapeDataString($name))." target="_blank" rel="noopener noreferrer" class="bg-[#25D366] text-white hover:bg-[#20ba59] px-6 py-3 text-xs font-semibold uppercase tracking-widest transition-colors inline-flex items-center justify-center gap-2">
                    <i class="fa-brands fa-whatsapp text-sm"></i> WhatsApp Inquiry
                </a>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-deep-charcoal text-white py-6 text-center text-xs text-gray-400 border-t border-gray-800">
        <p>&copy; 2026 Shree Ram & Company (Vijeta Stone), Jaipur. All Rights Reserved.</p>
    </footer>

</body>
</html>
"@

    [System.IO.File]::WriteAllText($fullPath, $html, [System.Text.Encoding]::UTF8)
}

Write-Output "Successfully converted all 19 unwritten stubs into dignified, responsive, noindexed placeholder pages with zero 'Redirecting...' text!"
