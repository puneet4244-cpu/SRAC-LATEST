$filePath = "c:\Users\shree\OneDrive\Desktop\NTRY\stone-jali\index.html"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# 1. Mega-menu CNC Jali Work header link
$oldNav = '<span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30">CNC Jali Work</span>'
$newNav = '<a href="/cnc-jali-work/" class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block pb-1 border-b border-luxury-gold/30 hover:underline">CNC Jali Work</a>'
$content = $content.Replace($oldNav, $newNav)

# 2. Breadcrumbs UI
$oldBc = '<a href="/#collection" class="hover:text-luxury-gold">CNC Jali Work</a>'
$newBc = '<a href="/cnc-jali-work/" class="hover:text-luxury-gold">CNC Jali Work</a>'
$content = $content.Replace($oldBc, $newBc)

# 3. Hero H1 and Subtitle
$oldHero = '<h1 class="font-serif text-4xl md:text-6xl text-white mb-6">CNC Natural Stone Jali Screen Manufacturer in Jaipur</h1>
            <p class="text-gray-300 max-w-2xl mx-auto text-sm md:text-base font-light leading-relaxed mb-8">Architectural sandstone and marble jali screens, ornamental facade lattices, and geometric partition panels crafted with 5-axis CNC diamond tooling and hand-chiseling.</p>'
$newHero = '<h1 class="font-serif text-4xl md:text-6xl text-white mb-6">Stone Jali</h1>
            <p class="text-gray-300 max-w-2xl mx-auto text-sm md:text-base font-light leading-relaxed mb-8">Custom architectural stone jali design in natural sandstone and marble. Perforated facade screens, ornamental ventilation lattices, and geometric partition panels handcrafted and precision-routed in Jaipur.</p>'
$content = $content.Replace($oldHero, $newHero)

# 4. Craftsmanship section text
$oldCraft = 'Chiseled from Bansi Paharpur pink sandstone, Gwalior Mint, and Makrana marble'
$newCraft = 'Chiseled from Bansi Paharpur pink sandstone, Gwalior Mint, and Rajasthan white marble'
$content = $content.Replace($oldCraft, $newCraft)

# 5. Table row
$oldTableRow = '<td class="p-4 border border-light-beige font-bold text-deep-charcoal">Makrana Pure White Marble</td>
                            <td class="p-4 border border-light-beige">Pooja Room Screens, Sacred Sanctum Doors, Luxury Foyers</td>
                            <td class="p-4 border border-light-beige text-emerald-600 font-medium">Supreme Crystalline Purity (Translucent Glow, Cool to Touch)</td>'
$newTableRow = '<td class="p-4 border border-light-beige font-bold text-deep-charcoal">Rajasthan White Marble</td>
                            <td class="p-4 border border-light-beige">Pooja Room Screens, Sacred Sanctum Doors, Luxury Foyers</td>
                            <td class="p-4 border border-light-beige text-emerald-600 font-medium">Translucent Crystalline Glow (Cool to Touch, Radiant Luster)</td>'
$content = $content.Replace($oldTableRow, $newTableRow)

# 6. FAQ Block UI
$oldFaqUi = @'
            <div class="space-y-6">
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>What natural stones are recommended for outdoor architectural CNC jali screens?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">For exterior building facades, balcony railings, boundary walls, and sunshade screens, natural Rajasthan sandstones—specifically Red Agra Stone, Dholpur Beige Sandstone, Bansi Paharpur Pink Sandstone, and Gwalior Mint—are the most durable and structurally reliable materials. These sedimentary quartzitic sandstones possess high flexural strength (typically 8–15 MPa) and low thermal expansion, ensuring that delicate geometric frets and intricate floral perforations remain structurally intact without snapping under wind pressure or temperature swings. For semi-covered courtyards or luxury interior partitions, Makrana White Marble provides radiant beauty and timeless elegance. At Shree Ram & Company, all stone slabs used for jali screens are calibrated to uniform 35mm to 50mm thickness and inspected for hairline natural fissures to guarantee decades of structural stability in harsh exterior climates.</p>
                </div>
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>What is the price per square foot for custom stone jali in Jaipur, and what affects pricing?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">In Jaipur, the price for custom natural stone jali screens typically ranges from ₹450 to ₹1,800 per square foot. Standard geometric fretwork patterns in 30mm thick Red or Beige Sandstone generally cost between ₹450 and ₹750 per sq ft. Highly intricate Islamic, Mughal, or Mandala patterns with deep double-sided 3D profiling in 40mm–50mm thick Gwalior Mint or Bansi Paharpur Pink Sandstone range from ₹850 to ₹1,350 per sq ft. Luxury Makrana White Marble jali screens carved for pooja rooms or luxury villa elevations range from ₹1,400 to ₹2,800+ per sq ft. The main cost drivers include slab thickness, perforation percentage (cutout density), double-sided hand beveling, stone material grade, and stainless steel edge frame grooving for on-site structural anchoring.</p>
                </div>
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>How are stone jali screens mounted and anchored to withstand high wind loads on facades?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">Architectural stone jali screens are installed using a combination of structural perimeter sub-frames and concealed stainless steel (SS 304 or 316) anchor dowels. At Shree Ram & Company, our engineering team pre-slots the top, bottom, and side edges of each jali panel with 12mm deep grooves. On site, panels are either set into a perimeter mild-steel or aluminum powder-coated box section frame, or anchored directly into the structural masonry opening using SS pin dowels embedded in high-grade non-shrink epoxy grout. Silicone expansion joints (3mm to 5mm width) are maintained between adjacent multi-panel runs to absorb seismic micro-movement and thermal expansion, preventing cracking under wind loads exceeding 1.5 kPa on elevated building elevations.</p>
                </div>
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>How does CNC waterjet stone cutting compare to traditional hand-chiseled jali work?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">Modern architectural stone jali manufacturing achieves peak quality through a hybrid approach combining multi-axis CNC routers with master hand craftsmanship. Industrial CNC diamond tooling ensures millimeter-level symmetry, razor-sharp internal angles, and exact pattern replication across large multi-panel facade installations that would be impossible to standardize by hand alone. However, pure machine-cut edges can appear sharp and mechanical; therefore, master stone artisans at our Jaipur workshop hand-soften, chamfer, and chisel the perforated contours of every panel. This artisanal post-processing imbues the stone with natural organic warmth, light-catching chamfered depths, and the authentic tactile quality of generational Rajasthani stonework while preserving CAD engineering precision.</p>
                </div>
            </div>
'@

$newFaqUi = @'
            <div class="space-y-6">
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>What natural stones are recommended for outdoor architectural stone jali screens?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">For exterior building facades, balcony railings, boundary walls, and sunshade screens, natural Rajasthan sandstones—specifically Red Agra Stone, Dholpur Beige Sandstone, Bansi Paharpur Pink Sandstone, and Gwalior Mint—are the most durable and structurally reliable materials. These sedimentary quartzitic sandstones possess high flexural strength (typically 8–15 MPa) and low thermal expansion, ensuring that delicate geometric frets and intricate floral perforations remain structurally intact without snapping under wind pressure or temperature swings. For semi-covered courtyards or luxury interior partitions, high-grade Rajasthan White Marble provides radiant beauty and timeless elegance. At Shree Ram & Company, all stone slabs used for jali screens are calibrated to uniform 35mm to 50mm thickness and inspected for hairline natural fissures to guarantee decades of structural stability in harsh exterior climates.</p>
                </div>
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>How is pricing calculated for custom stone jali screens in Jaipur?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">Pricing is calculated based on stone material selection (natural sandstone vs white marble), slab calibration thickness (typically 30mm to 50mm), perforation density and design complexity (geometric fretwork vs multi-depth 3D floral carving), double-sided hand chamfering, and perimeter edge grooving for stainless steel anchor hardware. Contact our Jaipur workshop with your required dimensions and CAD/PDF drawings for an itemized quotation.</p>
                </div>
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>How are stone jali screens mounted and anchored to withstand high wind loads on facades?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">Architectural stone jali screens are installed using a combination of structural perimeter sub-frames and concealed stainless steel (SS 304 or 316) anchor dowels. At Shree Ram & Company, our engineering team pre-slots the top, bottom, and side edges of each jali panel with 12mm deep grooves. On site, panels are either set into a perimeter mild-steel or aluminum powder-coated box section frame, or anchored directly into the structural masonry opening using SS pin dowels embedded in high-grade non-shrink epoxy grout. Silicone expansion joints (3mm to 5mm width) are maintained between adjacent multi-panel runs to absorb seismic micro-movement and thermal expansion, preventing cracking under wind loads exceeding 1.5 kPa on elevated building elevations.</p>
                </div>
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>How does precision CNC cutting compare to traditional hand-chiseled stone jali work?</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">Modern architectural stone jali manufacturing achieves peak quality through a hybrid approach combining multi-axis CNC routers with master hand craftsmanship. Industrial diamond tooling ensures millimeter-level symmetry, razor-sharp internal angles, and exact pattern replication across large multi-panel facade installations that would be impossible to standardize by hand alone. However, uncorrected machine-cut edges can appear sharp and mechanical; therefore, master stone artisans at our Jaipur workshop hand-soften, chamfer, and chisel the perforated contours of every panel. This artisanal post-processing imbues the stone with natural organic warmth, light-catching chamfered depths, and the authentic tactile quality of traditional Rajasthani stonework while preserving CAD engineering precision.</p>
                </div>
            </div>
'@
$content = $content.Replace($oldFaqUi, $newFaqUi)

# 7. Related Collections Link to CNC Jali Work Hub
$oldRelated = '<a href="/stone-jali/" class="p-4 border border-light-beige bg-[#FAF8F4] hover:bg-white hover:border-luxury-gold hover:text-luxury-gold transition-all rounded-sm">Stone CNC Jali</a>'
$newRelated = '<a href="/cnc-jali-work/" class="p-4 border border-luxury-gold/60 bg-luxury-gold/10 font-bold text-luxury-gold hover:bg-luxury-gold hover:text-white transition-all rounded-sm">All CNC Jali Work Hub</a>'
$content = $content.Replace($oldRelated, $newRelated)

# 8. Contact & Footer Cleanups
$content = $content.Replace('FACTORY & WORKSHOP', 'WORKSHOP & STUDIO')
$content = $content.Replace('Generational stone artisans', 'Master stone artisans')

# 9. JSON-LD structured data replacement
# Extract everything between <script type="application/ld+json"> and </script>
$schemaStartTag = '<script type="application/ld+json">'
$schemaEndTag = '</script>'

$startPos = $content.IndexOf($schemaStartTag)
if ($startPos -ge 0) {
    $endPos = $content.IndexOf($schemaEndTag, $startPos)
    if ($endPos -ge 0) {
        $newSchema = @'
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@graph": [
        {
            "@type": "BreadcrumbList",
            "@id": "https://www.shreeramandcompany.com/stone-jali/#breadcrumb",
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
                    "name": "CNC Jali Work",
                    "item": "https://www.shreeramandcompany.com/cnc-jali-work/"
                },
                {
                    "@type": "ListItem",
                    "position": 3,
                    "name": "Stone Jali",
                    "item": "https://www.shreeramandcompany.com/stone-jali/"
                }
            ]
        },
        {
            "@type": "CollectionPage",
            "@id": "https://www.shreeramandcompany.com/stone-jali/#webpage",
            "url": "https://www.shreeramandcompany.com/stone-jali/",
            "name": "Stone Jali Design & Architectural Lattice | Shree Ram & Co",
            "description": "Custom natural stone jali design in sandstone & marble. Architectural lattice screens for facades, balconies, elevations & mandirs. Direct manufacturer in Jaipur.",
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
                "telephone": "+916367607459"
            },
            "mainEntity": {
                "@type": "ItemList",
                "name": "Stone Jali Collection",
                "numberOfItems": 2,
                "itemListElement": [
                    {
                        "@type": "ListItem",
                        "position": 1,
                        "url": "https://www.shreeramandcompany.com/stone-jali/#collection",
                        "name": "Architectural Sandstone Facade Jali"
                    },
                    {
                        "@type": "ListItem",
                        "position": 2,
                        "url": "https://www.shreeramandcompany.com/stone-jali/#collection",
                        "name": "Mughal Floral Perforated Stone Screen"
                    }
                ]
            }
        },
        {
            "@type": "FAQPage",
            "@id": "https://www.shreeramandcompany.com/stone-jali/#faq",
            "mainEntity": [
                {
                    "@type": "Question",
                    "name": "What natural stones are recommended for outdoor architectural stone jali screens?",
                    "acceptedAnswer": {
                        "@type": "Answer",
                        "text": "For exterior building facades, balcony railings, boundary walls, and sunshade screens, natural Rajasthan sandstones—specifically Red Agra Stone, Dholpur Beige Sandstone, Bansi Paharpur Pink Sandstone, and Gwalior Mint—are the most durable and structurally reliable materials. These sedimentary quartzitic sandstones possess high flexural strength (typically 8–15 MPa) and low thermal expansion, ensuring that delicate geometric frets and intricate floral perforations remain structurally intact without snapping under wind pressure or temperature swings. For semi-covered courtyards or luxury interior partitions, high-grade Rajasthan White Marble provides radiant beauty and timeless elegance. At Shree Ram & Company, all stone slabs used for jali screens are calibrated to uniform 35mm to 50mm thickness and inspected for hairline natural fissures to guarantee decades of structural stability in harsh exterior climates."
                    }
                },
                {
                    "@type": "Question",
                    "name": "How is pricing calculated for custom stone jali screens in Jaipur?",
                    "acceptedAnswer": {
                        "@type": "Answer",
                        "text": "Pricing is calculated based on stone material selection (natural sandstone vs white marble), slab calibration thickness (typically 30mm to 50mm), perforation density and design complexity (geometric fretwork vs multi-depth 3D floral carving), double-sided hand chamfering, and perimeter edge grooving for stainless steel anchor hardware. Contact our Jaipur workshop with your required dimensions and CAD/PDF drawings for an itemized quotation."
                    }
                },
                {
                    "@type": "Question",
                    "name": "How are stone jali screens mounted and anchored to withstand high wind loads on facades?",
                    "acceptedAnswer": {
                        "@type": "Answer",
                        "text": "Architectural stone jali screens are installed using a combination of structural perimeter sub-frames and concealed stainless steel (SS 304 or 316) anchor dowels. At Shree Ram & Company, our engineering team pre-slots the top, bottom, and side edges of each jali panel with 12mm deep grooves. On site, panels are either set into a perimeter mild-steel or aluminum powder-coated box section frame, or anchored directly into the structural masonry opening using SS pin dowels embedded in high-grade non-shrink epoxy grout. Silicone expansion joints (3mm to 5mm width) are maintained between adjacent multi-panel runs to absorb seismic micro-movement and thermal expansion, preventing cracking under wind loads exceeding 1.5 kPa on elevated building elevations."
                    }
                },
                {
                    "@type": "Question",
                    "name": "How does precision CNC cutting compare to traditional hand-chiseled stone jali work?",
                    "acceptedAnswer": {
                        "@type": "Answer",
                        "text": "Modern architectural stone jali manufacturing achieves peak quality through a hybrid approach combining multi-axis CNC routers with master hand craftsmanship. Industrial diamond tooling ensures millimeter-level symmetry, razor-sharp internal angles, and exact pattern replication across large multi-panel facade installations that would be impossible to standardize by hand alone. However, uncorrected machine-cut edges can appear sharp and mechanical; therefore, master stone artisans at our Jaipur workshop hand-soften, chamfer, and chisel the perforated contours of every panel. This artisanal post-processing imbues the stone with natural organic warmth, light-catching chamfered depths, and the authentic tactile quality of traditional Rajasthani stonework while preserving CAD engineering precision."
                    }
                }
            ]
        }
    ]
}
</script>
'@
        $content = $content.Substring(0, $startPos) + $newSchema + $content.Substring($endPos + $schemaEndTag.Length)
    }
}

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Output "Successfully updated stone-jali/index.html"
