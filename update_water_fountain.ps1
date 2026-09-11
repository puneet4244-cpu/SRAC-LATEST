# Update water-fountain/index.html with all 6 requested products
$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
. "$baseDir\master_page_builder.ps1"

$waterFountainProds = @(
    @{ 
        Name = "Indoor Water Fountain"; 
        Desc = "Compact, splash-free natural stone cascading fountain designed for luxury living room foyers, penthouses, and corporate lobbies with warm LED backlighting."; 
        Material = "Pure Makrana White Marble / Polished Sandstone"; 
        Size = "3 ft to 5 ft Height (Customizable)"; 
        Img = "/assets/images/water-fountain.jpg" 
    },
    @{ 
        Name = "Small Water Fountain"; 
        Desc = "Elegant tabletop and balcony corner stone water fountain with gentle trickling sound, ideal for compact Vastu-aligned residential spaces."; 
        Material = "Dholpur Mint Stone / Vietnam White Marble"; 
        Size = "2 ft to 3 ft Height (Portable & Self-Contained)"; 
        Img = "/assets/images/jaipur-artisan.jpg" 
    },
    @{ 
        Name = "Large Water Fountain"; 
        Desc = "Monumental multi-tier architectural fountain featuring hand-sculpted pool surround, lion spout heads, and central cascading floral bowls."; 
        Material = "Natural Dholpur Sandstone / Granite / Marble"; 
        Size = "8 ft to 18 ft Height / 10-25 ft Basin Diameter"; 
        Img = "/assets/images/water-fountain.jpg" 
    },
    @{ 
        Name = "Outdoor Water Fountain"; 
        Desc = "Weatherproof, heavy-duty natural stone garden fountain engineered for villa front courtyards, luxury resort lawns, and farmhouses."; 
        Material = "Weather-Resistant Teakwood & Pink Sandstone"; 
        Size = "5 ft to 12 ft Height"; 
        Img = "/assets/images/gazebo.jpg" 
    },
    @{ 
        Name = "Sandstone Water Fountain"; 
        Desc = "Traditional Rajasthani hand-carved fountain sculpted in rich textured Dholpur, Khatu, and Jaisalmer sandstones with timeless heritage motifs."; 
        Material = "Authentic Dholpur Pink / Khatu Teak Sandstone"; 
        Size = "Custom Built as per Landscaping Specs"; 
        Img = "/assets/images/stone-carving.jpg" 
    },
    @{ 
        Name = "Marble Water Fountain"; 
        Desc = "Ultra-luxurious hand-polished pure white Makrana and Italian marble fountain with intricate floral carvings and glowing translucent aesthetic."; 
        Material = "100% Authentic Makrana White Marble / Statuario"; 
        Size = "Bespoke Single-Piece & Multi-Tier Sizing"; 
        Img = "/assets/images/marble-temple.jpg" 
    }
)

Generate-ProductLeafPage `
    -pagePath "$baseDir\water-fountain\index.html" `
    -title "Water Fountains - Indoor, Outdoor & Marble Cascades" `
    -metaDesc "Explore handcrafted indoor, outdoor, small, large, sandstone, and marble water fountains by Shree Ram & Company Jaipur." `
    -categoryName "Water Fountains" `
    -parentCategoryName "Home Interior & Decor" `
    -grandParentName "Collections" `
    -parentUrl "/#collection" `
    -heroBg "/assets/images/water-fountain.jpg" `
    -introOverview "Hand-carved natural stone and pure marble cascading fountains designed for courtyards, indoor foyers, and luxury landscapes." `
    -products $waterFountainProds

Write-Host "Water fountain category successfully updated with all 6 products!"
