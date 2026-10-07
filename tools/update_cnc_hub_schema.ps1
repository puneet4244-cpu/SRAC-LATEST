$cncFile = "c:\Users\shree\OneDrive\Desktop\NTRY\cnc-jali-work\index.html"
$cncContent = [System.IO.File]::ReadAllText($cncFile, [System.Text.Encoding]::UTF8)

$cncSchema = @'
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "BreadcrumbList",
          "@id": "https://www.shreeramandcompany.com/cnc-jali-work/#breadcrumb",
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
            }
          ]
        },
        {
          "@type": "CollectionPage",
          "@id": "https://www.shreeramandcompany.com/cnc-jali-work/#webpage",
          "name": "CNC Jali Design & Cutting Work | Shree Ram & Company Jaipur",
          "description": "Architectural CNC jali design and cutting hub spanning natural stone jali, interior MDF/HDMR fretwork, room partition screens, and waterproof WPC lattices. Direct manufacturer in Jaipur.",
          "url": "https://www.shreeramandcompany.com/cnc-jali-work/",
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
          "hasPart": [
            {
              "@type": "WebPage",
              "name": "Stone Jali",
              "url": "https://www.shreeramandcompany.com/stone-jali/"
            },
            {
              "@type": "WebPage",
              "name": "MDF / HDMR Jali",
              "url": "https://www.shreeramandcompany.com/mdf-jali/"
            },
            {
              "@type": "WebPage",
              "name": "Partition Jali",
              "url": "https://www.shreeramandcompany.com/partition-jali/"
            },
            {
              "@type": "WebPage",
              "name": "PVC / WPC Jali",
              "url": "https://www.shreeramandcompany.com/wpc-jali/"
            }
          ]
        },
        {
          "@type": "FAQPage",
          "@id": "https://www.shreeramandcompany.com/cnc-jali-work/#faq",
          "mainEntity": [
            {
              "@type": "Question",
              "name": "What materials are used for custom CNC jali design?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "We manufacture CNC jali screens across four primary materials: natural Rajasthan stone (sandstone and marble for facades and mandirs), high-density moisture-resistant MDF/HDMR (for painted interior partitions and pooja rooms), engineered partition composites, and waterproof/termite-proof WPC (for outdoor balconies and wet areas)."
              }
            },
            {
              "@type": "Question",
              "name": "How does CNC machine cutting differ between stone and MDF/WPC?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Stone jali manufacturing utilizes heavy-duty water-cooled diamond router tooling and CNC bridge cutters operating at high torque with continuous slurry lubrication to carve through dense quartzitic sandstone and marble, followed by artisanal hand-finishing. In contrast, MDF and WPC jalis are cut using high-speed carbide spiral bits on dry vacuum-bed routers for razor-sharp geometric fretwork ready for PU paint or direct architectural installation."
              }
            },
            {
              "@type": "Question",
              "name": "What thickness is recommended for exterior facade jali screens versus interior partitions?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "For exterior facades exposed to wind load and weather, we recommend 35mm to 50mm calibrated natural stone, or 18mm to 25mm exterior-grade WPC with perimeter structural frame anchoring. For indoor room partitions, pooja mandir screens, and decorative ceiling panels, 12mm to 18mm MDF/HDMR provides ideal rigidity and clean aesthetic lines."
              }
            },
            {
              "@type": "Question",
              "name": "Can I provide my own custom AutoCAD/vector design for cutting?",
              "acceptedAnswer": {
                "@type": "Answer",
                "text": "Yes. Our technical design studio accepts DXF, DWG, AI, and high-resolution PDF vector files. Our CNC engineers optimize bridge thicknesses and structural web supports to ensure the chosen material maintains full structural integrity before fabrication begins at our Jaipur workshop."
              }
            }
          ]
        }
      ]
    }
    </script>
'@

$pattern = '(?is)<script\s+type=["'']application/ld\+json["'']\s*>.*?</script>'
$cncContent = [regex]::Replace($cncContent, $pattern, $cncSchema, 1)
[System.IO.File]::WriteAllText($cncFile, $cncContent, [System.Text.Encoding]::UTF8)
Write-Output "Successfully updated cnc-jali-work/index.html schema with @graph and full LocalBusiness provider!"
