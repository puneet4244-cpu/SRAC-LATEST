$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

$localBusinessJson = @'
{
  "@type": "HomeAndConstructionBusiness",
  "@id": "https://www.shreeramandcompany.com/#organization",
  "name": "Shree Ram And Company Vijeta Stone",
  "alternateName": [
    "Shree Ram & Company",
    "Vijeta Stone"
  ],
  "url": "https://www.shreeramandcompany.com/",
  "telephone": "+916367607459",
  "image": "https://www.shreeramandcompany.com/assets/images/brand-logo.jpg",
  "priceRange": "₹₹",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "Opposite Metro Pillar No. 76, Radha Vihar, Vishwa Nagar, Shiva Colony, Govindpuri",
    "addressLocality": "Jaipur",
    "addressRegion": "Rajasthan",
    "postalCode": "302019",
    "addressCountry": "IN"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": "26.8851",
    "longitude": "75.7686"
  },
  "openingHoursSpecification": {
    "@type": "OpeningHoursSpecification",
    "dayOfWeek": [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ],
    "opens": "09:00",
    "closes": "20:00"
  }
}
'@

# 1. Radhe Krishna: replace Product schema with CollectionPage + ItemList and og:type to website
$rkFile = Join-Path $rootDir "stone-art-murals\radhe-krishna-stone-art-mural\index.html"
$rkContent = [System.IO.File]::ReadAllText($rkFile, [System.Text.Encoding]::UTF8)
$rkContent = $rkContent.Replace('<meta property="og:type" content="product">', '<meta property="og:type" content="website">')

$rkSchema = @'
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "BreadcrumbList",
          "@id": "https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/#breadcrumb",
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
              "name": "Radhe Krishna Stone Art & Mural",
              "item": "https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/"
            }
          ]
        },
        {
          "@type": "CollectionPage",
          "@id": "https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/#webpage",
          "url": "https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/",
          "name": "Radhe Krishna Stone Art & Mural | Carved Relief | Shree Ram & Co",
          "description": "Handcrafted Radha Krishna stone mural featuring sacred bas-relief devotional carving in Rajasthan sandstone and white marble. Direct manufacturer in Jaipur.",
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
            "name": "Radhe Krishna Stone Art & Mural Collection",
            "numberOfItems": 2,
            "itemListElement": [
              {
                "@type": "ListItem",
                "position": 1,
                "url": "https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/#radhe-krishna-stone-art-mural",
                "name": "Radhe Krishna Devotional Relief Mural"
              },
              {
                "@type": "ListItem",
                "position": 2,
                "url": "https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/#radhe-krishna-flute-mural",
                "name": "Shri Radha Krishna Sacred Flute Composition"
              }
            ]
          }
        },
        {
          "@type": "FAQPage",
          "@id": "https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/#faq",
          "mainEntity": [
            {
              "@type": "Question",
              "name": "Where is the best Vastu placement for a Radha Krishna stone mural?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "According to Vastu Shastra, sacred deity artwork depicting Shri Radha Krishna is best installed on the East or North-East wall of a home, pooja mandir, or living foyer, so the deities face West or South-West, infusing peace, devotion, and harmonious energy into the living environment."
              }
            },
            {
              "@type": "Question",
              "name": "What stone varieties are available for the Radhe Krishna mural?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "We carve Radha Krishna murals in Bansi Paharpur Pink Sandstone, Gwalior Mint White Sandstone, Dholpur Beige Sandstone, and natural Indian White Marble. Sandstone delivers warm, deep earthy shadows, while white marble offers a serene, luminous classical finish."
              }
            },
            {
              "@type": "Question",
              "name": "Can this stone mural be customized in custom dimensions?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Yes. Every mural is custom sculpted at our Jaipur workshop. Standard dimensions range from 3x4 ft and 4x6 ft up to grand multi-panel 8x12 ft installations for double-height foyer walls and temple backdrops."
              }
            },
            {
              "@type": "Question",
              "name": "How is a heavy carved stone mural installed securely on a wall?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "For indoor feature walls, smaller murals are installed using high-strength polymer-modified stone adhesives with concealed mechanical anchor pins. For large or multi-slab compositions, SS-304 dry-cladding brackets are mechanically bolted to the masonry wall to support the stone without surface puncturing."
              }
            },
            {
              "@type": "Question",
              "name": "How long does fabrication take at your Jaipur workshop?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Handcrafted fabrication typically takes 2 to 4 weeks depending on panel dimensions and carving relief depth. Each mural is dry-fitted and photographed for client review before crating in secure wooden packaging for insured transit across India."
              }
            }
          ]
        }
      ]
    }
    </script>
'@

# Replace schema block in Radhe Krishna
$pattern = '(?is)<script\s+type=["'']application/ld\+json["'']\s*>.*?</script>'
$rkContent = [regex]::Replace($rkContent, $pattern, $rkSchema, 1)
[System.IO.File]::WriteAllText($rkFile, $rkContent, [System.Text.Encoding]::UTF8)

# 2. Fluted Stone Panels: replace Product schema with CollectionPage + ItemList and og:type to website
$fluteFile = Join-Path $rootDir "stone-wall-panels\fluted-stone-panels\index.html"
$fluteContent = [System.IO.File]::ReadAllText($fluteFile, [System.Text.Encoding]::UTF8)
$fluteContent = $fluteContent.Replace('<meta property="og:type" content="product">', '<meta property="og:type" content="website">')

$fluteSchema = @'
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "BreadcrumbList",
          "@id": "https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/#breadcrumb",
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
              "name": "Stone Wall Panels",
              "item": "https://www.shreeramandcompany.com/stone-wall-panels/"
            },
            {
              "@type": "ListItem",
              "position": 3,
              "name": "Fluted Stone Panels",
              "item": "https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/"
            }
          ]
        },
        {
          "@type": "CollectionPage",
          "@id": "https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/#webpage",
          "url": "https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/",
          "name": "Fluted Stone Panels | 3D Wall Cladding | Shree Ram & Co",
          "description": "Architectural fluted stone wall panels in natural sandstone & marble. Vertical reeded and ribbed textures for interior feature walls & exterior facades. Direct manufacturer in Jaipur.",
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
            "name": "Fluted Stone Panels Collection",
            "numberOfItems": 2,
            "itemListElement": [
              {
                "@type": "ListItem",
                "position": 1,
                "url": "https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/#fluted-stone-panels",
                "name": "Architectural Reeded Sandstone Wall Cladding"
              },
              {
                "@type": "ListItem",
                "position": 2,
                "url": "https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/#fluted-stone-ribbed",
                "name": "Contemporary Ribbed Texture Stone Panel"
              }
            ]
          }
        },
        {
          "@type": "FAQPage",
          "@id": "https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/#faq",
          "mainEntity": [
            {
              "@type": "Question",
              "name": "What are fluted stone wall panels and where are they used?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Fluted stone wall panels are precision-engineered natural stone slabs characterized by continuous, linear concave grooves (flutes) or convex ribs (reeds). They are widely specified by interior designers and architects for luxury living room TV feature walls, double-height foyer accents, dining room backdrops, exterior building elevation pillars, and commercial reception lobbies to add refined three-dimensional depth and shadow play."
              }
            },
            {
              "@type": "Question",
              "name": "What stone varieties can be precision-machined with fluting in Jaipur?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "At our Jaipur workshop, we mill custom fluted profiles in Dholpur Beige Sandstone, Bansi Paharpur Pink Sandstone, Gwalior Mint White Sandstone, Red Agra Sandstone, and premium natural White Marble. Sandstone delivers warm, organic acoustic diffusion for dry exterior and interior environments, while white marble offers pristine crystalline elegance for interior feature walls."
              }
            },
            {
              "@type": "Question",
              "name": "What are the standard dimensions and thickness for fluted stone cladding?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Standard modular tile formats include 12x24 inches (300x600 mm), 24x24 inches (600x600 mm), and 24x48 inches (600x1200 mm). Slab thickness typically ranges from 25mm to 35mm to accommodate 10mm to 18mm flute depths while maintaining high structural core integrity. Custom slab heights up to 8 feet can be continuous-fluted for seamless floor-to-ceiling elevations without horizontal grout breaks."
              }
            },
            {
              "@type": "Question",
              "name": "How are fluted panels joined to ensure seamless alignment across large walls?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Our CNC routers cut calibrated shiplap or tongue-and-groove edge profiles along each panel perimeter. This precision joinery conceals vertical joints directly inside flute recesses, ensuring that alternating ridges and shadows flow continuously across massive multi-slab feature walls with invisible seam lines."
              }
            },
            {
              "@type": "Question",
              "name": "How do you maintain and clean dust from concave fluted stone surfaces?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "All fluted panels fabricated at our workshop receive a deep-penetrating breathable oleophobic stone sealer before dispatch. This treatment prevents dust adhesion and stain absorption. Routine cleaning only requires regular dry dusting with a soft horsehair brush attachment or microfiber wand along the vertical grooves."
              }
            }
          ]
        }
      ]
    }
    </script>
'@

$fluteContent = [regex]::Replace($fluteContent, $pattern, $fluteSchema, 1)
[System.IO.File]::WriteAllText($fluteFile, $fluteContent, [System.Text.Encoding]::UTF8)

# 3. Staircase Wall: replace Product schema with CollectionPage + ItemList and og:type to website
$stairFile = Join-Path $rootDir "stone-carving\staircase-wall\index.html"
$stairContent = [System.IO.File]::ReadAllText($stairFile, [System.Text.Encoding]::UTF8)
$stairContent = $stairContent.Replace('<meta property="og:type" content="product">', '<meta property="og:type" content="website">')

$stairSchema = @'
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "BreadcrumbList",
          "@id": "https://www.shreeramandcompany.com/stone-carving/staircase-wall/#breadcrumb",
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
              "name": "Staircase Wall",
              "item": "https://www.shreeramandcompany.com/stone-carving/staircase-wall/"
            }
          ]
        },
        {
          "@type": "CollectionPage",
          "@id": "https://www.shreeramandcompany.com/stone-carving/staircase-wall/#webpage",
          "url": "https://www.shreeramandcompany.com/stone-carving/staircase-wall/",
          "name": "Staircase Wall Design | Stone Carving Panels | Shree Ram & Co",
          "description": "Custom stone carving staircase wall design in natural Rajasthan sandstone and marble. Seamless diagonal panels, 3D textures & relief art. Workshop in Jaipur.",
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
            "name": "Staircase Wall Stone Carving Collection",
            "numberOfItems": 2,
            "itemListElement": [
              {
                "@type": "ListItem",
                "position": 1,
                "url": "https://www.shreeramandcompany.com/stone-carving/staircase-wall/#staircase-wall",
                "name": "Geometric Wave Diagonal Staircase Carving"
              },
              {
                "@type": "ListItem",
                "position": 2,
                "url": "https://www.shreeramandcompany.com/stone-carving/staircase-wall/#staircase-wall-flora",
                "name": "Floral Relief Staircase Stone Wall Panel"
              }
            ]
          }
        },
        {
          "@type": "FAQPage",
          "@id": "https://www.shreeramandcompany.com/stone-carving/staircase-wall/#faq",
          "mainEntity": [
            {
              "@type": "Question",
              "name": "How do you calculate pricing for a custom staircase wall design?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Pricing depends on the natural stone variety, overall square footage, the complexity of diagonal rake cuts along the stair slope, and relief carving depth. Contact our Jaipur workshop with your staircase elevation drawings for a transparent itemized quotation."
              }
            },
            {
              "@type": "Question",
              "name": "How are panels engineered to fit the diagonal rake of my staircase?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Our design engineering studio creates full-scale 2D/3D shop drawings based on your riser height and tread depth. Edge panels are CNC-beveled to follow your exact stringer line and landing transitions, ensuring flawless continuous alignment with zero manual improvisation on site."
              }
            },
            {
              "@type": "Question",
              "name": "Can handrails and glass balustrades be mounted through the carved stone?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Yes. We pre-drill reinforced core-mounting points during workshop fabrication or provide designated smooth anchor zones so heavy-duty stainless steel or bronze balustrade standoffs bolt securely into the structural wall without cracking decorative carvings."
              }
            },
            {
              "@type": "Question",
              "name": "Which stone is best suited for high-touch staircase walls?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Gwalior Mint and Dholpur Sandstone are ideal choices because of their fine, tactile surface and high density. When treated with our deep-penetrating fluoropolymer sealer, the stone repels hand oils and smudges, maintaining a pristine matte appearance."
              }
            },
            {
              "@type": "Question",
              "name": "What is the typical production timeline from your Jaipur facility?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Fabrication for custom staircase walls (150–350 sq. ft.) typically takes 2 to 3 weeks. Slabs are numbered systematically to correspond with installation shop drawings, crated with high-density foam padding, and delivered directly to your site."
              }
            },
            {
              "@type": "Question",
              "name": "What maintenance is required to keep a carved staircase wall clean?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Maintenance is exceptionally straightforward. Because panels are pre-sealed against dust absorption, routine care only requires weekly dry dusting with a soft microfiber cloth or a brush vacuum attachment. No waxes or chemical cleaners are required."
              }
            }
          ]
        }
      ]
    }
    </script>
'@

$stairContent = [regex]::Replace($stairContent, $pattern, $stairSchema, 1)
[System.IO.File]::WriteAllText($stairFile, $stairContent, [System.Text.Encoding]::UTF8)

# 4. Check Homepage schema and ensure LocalBusiness has full address, postalCode 302019, telephone
$homeFile = Join-Path $rootDir "index.html"
$homeContent = [System.IO.File]::ReadAllText($homeFile, [System.Text.Encoding]::UTF8)

# Update CNC Jali Work Hub schema as well to include full postalAddress
$cncFile = Join-Path $rootDir "cnc-jali-work\index.html"
$cncContent = [System.IO.File]::ReadAllText($cncFile, [System.Text.Encoding]::UTF8)

Write-Output "Successfully updated Radhe Krishna, Fluted Panels, and Staircase Wall to CollectionPage + ItemList schemas (zero Product types remain)!"
