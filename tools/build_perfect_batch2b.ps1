# tools/build_perfect_batch2b.ps1
# Complete generator for Batch 2b Stone Art & Murals with:
# - Ram Darbar fixed: Kodanda bow is exclusively Shri Ram's divine bow
# - Ganesh fixed: Vakratunda is curved trunk, Ekadanta is single tusk
# - Zero sectarian claims (no "authentic Pushtimarg", no "authentic Akshar-Purushottam")
# - Swaminarayan: no specific sect name; describes sacred pagh, kanthi, abhaya mudra, mandir arch
# - Schema: WebPage + BreadcrumbList + FAQPage (no CollectionPage, no artificial ItemList)
# - Unique section per page: bespoke dimensions, stones, and architectural mounting
# - At least 3 real project/workshop images per page with unique descriptive alt text
# - Meta descriptions strictly <= 155 characters

$rootDir = Split-Path $PSScriptRoot -Parent

$pages = @(
    @{
        Slug = "buddha-stone-art-mural"
        Name = "Buddha Stone Art & Mural"
        TargetDir = "stone-art-murals\buddha-stone-art-mural"
        Title = "Buddha Wall Art & Stone Mural Relief | Shree Ram & Co"
        MetaDesc = "Handcrafted Buddha wall art in natural sandstone and marble. Meditative 3D wall murals sculpted in Jaipur with pan-India insured shipping."
        Primary = "buddha wall art"
        Keywords = "buddha wall art, Buddha stone mural, Meditative Buddha stone carving, Bodhi tree wall relief, Zen stone wall panel"
        H1 = "Buddha Wall Art & Stone Mural Relief"
        Badge = "Meditative Buddhist Relief Art"
        Lead = "Cultivate serene tranquility and mindful stillness in your home with handcrafted Buddha wall art, sculpted in natural Rajasthan sandstone and white marble by master artisans in Jaipur."
        OverviewH2 = "Contemplative Serenity Carved in Enduring Natural Stone"
        OverviewP1 = "Depicting Lord Buddha in deep meditative contemplation, our handcrafted stone wall murals capture profound stillness, spiritual grounding, and transcendent peace. Sculpted in non-sectarian Buddhist iconography, the central murti radiates gentle compassion through serene half-closed eyes, elongated earlobes symbolizing spiritual detachment, and the sacred Ushnisha wisdom crest."
        OverviewP2 = "Each relief composition is hand-chiseled with dimensional depth from quarry-selected Gwalior Mint sandstone, Bansi Paharpur pink stone, or crystalline white marble at our Jaipur factory. From tranquil private meditation rooms and peaceful living rooms to outdoor courtyards and water feature backdrops, these bespoke stone murals establish an enduring sanctuary of calm."
        Highlights = @(
            "Non-sectarian Buddhist iconography sculpted with reverence and delicate proportion.",
            "Handcrafted in quarry-selected natural sandstone, pink stone, and crystalline white marble.",
            "Dimensional high-relief carving bringing out fine drapery, lotus petals, and Bodhi canopy.",
            "Weather-resilient stone suitable for prayer spaces, foyer atriums, and garden courtyards.",
            "Factory-direct architectural manufacturing from Jaipur with custom sizes and worldwide crated delivery."
        )
        Features = @(
            @{ Icon = "fa-om"; Title = "Dhyana & Bhumisparsha Mudras"; Desc = "Reverently chiseled hand gestures depicting profound meditation (Dhyana) or the earth-witness gesture (Bhumisparsha) evoking grounding serenity." },
            @{ Icon = "fa-tree"; Title = "Bodhi Foliage Canopy"; Desc = "Delicate undercut leaf patterns framing the seated Buddha relief, sculpted with rhythmic depth and naturalistic motion." },
            @{ Icon = "fa-spa"; Title = "Padmasana Lotus Throne"; Desc = "Full-bloom layered lotus petals sculpted with rounded tiers, symbolizing spiritual purity rising above worldly distractions." },
            @{ Icon = "fa-hand-holding-heart"; Title = "Serene Countenance & Ushnisha"; Desc = "Subtle chiseling of compassionate facial expression, downcast meditative gaze, and cranial wisdom crest." },
            @{ Icon = "fa-layer-group"; Title = "Dimensional Bas-Relief Depth"; Desc = "Multi-tiered carving depths creating soft natural shadows that transform under ambient and grazing warm illumination." },
            @{ Icon = "fa-shield-halved"; Title = "Weatherproof Natural Stone"; Desc = "Dense, solid stone construction naturally resistant to indoor moisture, courtyard humidity, and seasonal temperature swings." }
        )
        UniqueSection = @{
            Title = "Bespoke Sizing Tiers, Stone Selections & Zen Placement"
            Subtitle = "Architectural Specifications for Mindful Living"
            Intro = "Every Buddha wall art installation is drafted to harmonious proportions that balance room dimensions, viewing distances, and tranquil aesthetic flow."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Meditation Room Alcove: 3 ft x 4 ft (35mm relief depth, single-slab focal panel)",
                "Living Room Feature Elevation: 5 ft x 7 ft (50mm relief depth, book-matched composition)",
                "Courtyard & Water Wall: 8 ft x 12 ft (65mm monumental relief across modular precision-jointed slabs)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Gwalior Mint Sandstone: Velvety ivory-cream tone bringing warmth to modern Scandinavian or Japandi interiors",
                "Pure Indian White Marble: Pristine satvik luminosity with hand-buffed satin sheen for dedicated meditation alcoves",
                "Bansi Paharpur Pink Stone: Earthy terracotta hues imparting historic temple courtyard character"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed 304 Stainless Steel dry-cladding Z-clamps anchored into reinforced civil walls",
                "Recessed wall niche installation with 2-inch border margins for integrated warm LED halo cove lighting",
                "Optimal 3000K warm grazing ceiling spotlights angled at 30 degrees to highlight facial calm and Bodhi leaves"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Indoor Meditation & Sanctuaries"
                Icon = "fa-house-chimney-window"
                Title = "Yoga Rooms, Study & Living Foyers"
                P1Title = "Centering Focal Presence"
                P1Desc = "Anchors private meditation rooms, peaceful living rooms, and entryway foyers with grounding stillness and timeless aesthetic grace."
                P2Title = "Subtle Warm Illumination"
                P2Desc = "Pairs magnificently with 3000K warm grazing cove lights, revealing delicate drapery folds and meditative facial contours."
            },
            @{
                Tag = "Architectural Courtyards & Atriums"
                Icon = "fa-water"
                Title = "Garden Courts, Water Walls & Spas"
                P1Title = "Harmonious Water Feature Backdrop"
                P1Desc = "Natural sandstone withstands water splash and courtyard humidity, making it an exquisite backdrop for indoor koi ponds and waterfalls."
                P2Title = "Resilient Exterior Longevity"
                P2Desc = "Solid natural stone endures decades of atmospheric exposure without fading, warping, or peeling like painted resins."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/statue.webp"; Title = "Meditative Buddha Sandstone Relief Panel"; Alt = "Meditative Buddha stone art mural sculpted in natural Gwalior Mint sandstone relief - Shree Ram & Company Jaipur" },
            @{ Img = "/assets/images/marble-statue.webp"; Title = "Luminous White Marble Buddha Relief"; Alt = "Bespoke white marble Buddha wall relief panel with smooth hand-buffed contours - Shree Ram & Company Jaipur" },
            @{ Img = "/assets/images/jaipur-artisan.jpg"; Title = "Master Artisan Detailing Buddha Carving"; Alt = "Jaipur master artisan hand-carving intricate stone relief details for Buddha wall mural" }
        )
        Faqs = @(
            @{ Q = "What does the Bhumisparsha mudra represent in a Buddha stone mural?"; A = "The Bhumisparsha mudra, or earth-witness gesture, depicts Lord Buddha touching the ground with his right fingertips while seated in meditation, calling the earth to witness his spiritual resolve and enlightenment. In home interiors, it symbolizes unwavering stability, inner clarity, and grounding peace." },
            @{ Q = "Which stone variety is most recommended for a Buddha wall relief?"; A = "Gwalior Mint Sandstone is exceptionally popular for its velvety ivory cream tone that imparts modern Scandinavian or Japandi warmth. For formal indoor sanctums, dense Indian White Marble provides immaculate luminosity, while Bansi Paharpur Pink Sandstone yields an earthy historic temple character." },
            @{ Q = "Can the Buddha stone mural be installed near water features or outdoor courtyards?"; A = "Yes. Natural sandstone and crystalline marble withstand outdoor weather gracefully. When placed adjacent to fountains or in open atriums, we coat the stone with breathable penetrating water repellents that guard against algae and water spotting without creating artificial sheen." },
            @{ Q = "What is the delivery and packaging protocol from your Jaipur factory?"; A = "Each panel is pre-assembled, dry-fitted, and inspected at our Jaipur factory before dispatch. Panels are packed in heavy-duty foam-lined wooden pallets with corner armor for fully insured doorstep delivery across India and worldwide." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/floral-stone-art/"; Title = "Floral Stone Art"; Img = "/assets/images/floral-stone-art.webp" },
            @{ Url = "/stone-art-murals/radhe-krishna-stone-art-mural/"; Title = "Radhe Krishna Mural"; Img = "/assets/images/radhe-krishna-mural.webp" },
            @{ Url = "/stone-art-murals/shiv-ji-stone-art-mural/"; Title = "Shiv Ji Mural"; Img = "/assets/images/shiv-ji-mural.webp" },
            @{ Url = "/stone-art-murals/village-stone-art-mural/"; Title = "Village Stone Art"; Img = "/assets/images/village-stone-art.webp" }
        )
    },
    @{
        Slug = "durga-mata-ji-stone-art-mural"
        Name = "Durga Mata Ji Stone Art & Mural"
        TargetDir = "stone-art-murals\durga-mata-ji-stone-art-mural"
        Title = "Durga Stone Mural & 3D Wall Art Relief | Shree Ram & Co"
        MetaDesc = "Bespoke Durga stone mural in Rajasthan sandstone and marble. Handcrafted Sherawali Maa wall carvings made in Jaipur with insured shipping."
        Primary = "Durga stone mural"
        Keywords = "Durga stone mural, Maa Durga stone wall art, Sherawali Mata stone relief, 3D Durga mural Jaipur, Temple stone carving panel"
        H1 = "Durga Stone Mural & 3D Wall Art Relief"
        Badge = "Divine Shakti & Sherawali Maa Relief"
        Lead = "Invite divine protection, fierce courage, and auspicious shakti into your home with a handcrafted Durga stone mural, chiseled in natural pink sandstone and white marble by master sculptors in Jaipur."
        OverviewH2 = "Monumental Shakti & Protective Grace in Handcrafted Stone"
        OverviewP1 = "Embodying supreme Shakti, our Durga stone murals depict Sherawali Maa seated majestically upon her royal lion (Simha vahana). Her serene yet commanding countenance radiates divine motherly grace, while her multiple arms bear sacred divine emblems including the Trishul (trident), Sudarshana Chakra, Shankha (conch), bow and arrow, and protective Abhaya mudra."
        OverviewP2 = "Every fold of Maa Durga's flowing saree, the intricate crowns (Mukut), and the powerful anatomy of the royal lion are hand-undercut with dimensional relief depth ranging from 30mm to 70mm. Handcrafted at our Jaipur factory from time-honored Bansi Paharpur pink stone or pure Indian white marble, these sacred murals form awe-inspiring centerpieces for home temples, entrance foyers, and grand courtyards."
        Highlights = @(
            "Iconographically disciplined depiction of Sherawali Maa on her noble royal lion mount.",
            "Detailed rendering of sacred divine emblems: Trishul, Sudarshana Chakra, Shankha, and Abhaya mudra.",
            "Hand-sculpted in quarry-selected Bansi Paharpur pink sandstone and Makrana/Ambaji white marble.",
            "Deep multi-level undercutting producing bold shadows and striking sculptural depth.",
            "Direct factory manufacturing in Jaipur with custom dimensions and insured worldwide shipping."
        )
        Features = @(
            @{ Icon = "fa-shield-halved"; Title = "Sacred Ayudhas & Symbols"; Desc = "Sharp chisel work detailing the Trishul, Sudarshana Chakra, Conch, and bow, representing divine balance and righteousness." },
            @{ Icon = "fa-paw"; Title = "Majestic Simha Vahana"; Desc = "Powerful muscular sculpting of the lion vahana with flowing mane and vigilant poise, symbolizing unyielding valor." },
            @{ Icon = "fa-sun"; Title = "Radiant Prabhavali Halo"; Desc = "Ornate circular halo featuring lotus petal fretwork and floral relief, framing Devi's tranquil maternal countenance." },
            @{ Icon = "fa-crown"; Title = "Royal Mukut & Shringar"; Desc = "Delicate micro-chiseled mukut (crown), Kundal earrings, and ornate necklaces reflecting traditional royal sculpture." },
            @{ Icon = "fa-hand-back-fist"; Title = "Protective Abhaya Mudra"; Desc = "The raised right palm offering fearlessness, protection, and unconditional benevolence to the family." },
            @{ Icon = "fa-gem"; Title = "Quarry-Direct Material Integrity"; Desc = "Carved purely from dense, enduring natural sandstone and crystalline marble with zero synthetic aggregates." }
        )
        UniqueSection = @{
            Title = "Sanctum Dimensions, Sacred Stone Grades & Temple Mounting"
            Subtitle = "Engineering & Architectural Guidelines for Shakti Wall Reliefs"
            Intro = "Our engineering team produces scaled CAD architectural drawings before stone extraction to guarantee structural safety and perfect proportional harmony."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Home Mandir Sanctum Panel: 3.5 ft x 5 ft (40mm relief depth, monolithic or book-matched slab)",
                "Main Entrance Foyer Elevation: 6 ft x 8 ft (55mm relief depth, striking protective centerpiece)",
                "Monumental Courtyard / Temple Wall: 9 ft x 12 ft (70mm relief depth across precision-jointed modular slabs)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Bansi Paharpur Pink Sandstone: The revered sacred stone of North Indian temple architecture embodying warmth and shakti",
                "Ambaji & Makrana White Marble: Luminous crystalline marble with satin hand-buffed finish for immaculate indoor sanctums",
                "Agra Red Sandstone: Rich earthy red stone creating bold historic fort and mandir grandeur"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed Grade-304 stainless steel dry-cladding brackets with non-staining structural adhesive",
                "Minimum recommended elevation: 24 inches above finished floor level for sacred respect",
                "Warm 2700K golden perimeter LED backlighting creating a radiant aura around Devi's lion vahana and halo"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Home Mandir & Pooja Sanctum"
                Icon = "fa-om"
                Title = "Central Altar & Mandir Backdrop"
                P1Title = "Divine Protective Presence"
                P1Desc = "Installs as the commanding backdrop of residential pooja rooms, blessing daily prayers with spiritual strength and purity."
                P2Title = "Traditional Orientation Advisory"
                P2Desc = "Traditionally oriented on the East or North-East (Ishanya) wall, facing West so worshippers face East during daily aarti."
            },
            @{
                Tag = "Grand Entrance Foyer & Courtyard"
                Icon = "fa-landmark"
                Title = "Main Entrance & Villa Atrium"
                P1Title = "Auspicious Protective Focal Point"
                P1Desc = "Welcomes guests and family with an unmistakable aura of dignity, protection, and traditional artistic mastery."
                P2Title = "Enduring Material Resiliency"
                P2Desc = "Dense natural sandstone resists thermal shifts and UV exposure, retaining its regal beauty across generations."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/durga-mata-mural.webp"; Title = "Maa Durga Pink Sandstone Mural"; Alt = "Maa Durga stone art mural in Bansi Paharpur pink sandstone with lion vahana - Shree Ram & Company Jaipur" },
            @{ Img = "/assets/images/stone-carving.jpg"; Title = "Artisan Detailing Divine Ayudhas"; Alt = "Artisan detailing divine weapons and high-relief carving for Durga Mata temple wall panel" },
            @{ Img = "/assets/images/jaipur-artisan.jpg"; Title = "Master Sculptor Finishing Relief"; Alt = "Master sculptor hand-finishing intricate sandstone relief at Shree Ram & Company Jaipur factory" }
        )
        Faqs = @(
            @{ Q = "What does Sherawali Maa's posture represent in this stone mural?"; A = "Maa Durga seated upon her lion mount represents mastership over ego, fear, and instinctual passions. Her eight or ten arms holding divine weapons signify complete cosmic balance and readiness to protect righteousness." },
            @{ Q = "What stone is recommended for an indoor Durga Mata pooja room?"; A = "Bansi Paharpur Pink Sandstone is revered for its warm temple sanctity and exceptional chisel fidelity. Indian White Marble from Ambaji or Makrana is equally chosen for pure indoor sanctums that require smooth touch and luminous reflections." },
            @{ Q = "Can this Durga stone mural be installed outdoors or on entrance elevations?"; A = "Yes. Natural sandstone is an inherently durable architectural material tested by centuries of palace and temple use. We seal outdoor installations with breathable penetrating hydro-repellents to prevent moisture absorption and algae." },
            @{ Q = "How is a heavy stone mural safely mounted to residential walls?"; A = "We engineer our panels with rear anchor slots that engage heavy-duty Grade-304 stainless steel Z-clamps mechanically anchored into the masonry wall, distributing weight safely without visible front fasteners." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/shiv-ji-stone-art-mural/"; Title = "Shiv Ji Mural"; Img = "/assets/images/shiv-ji-mural.webp" },
            @{ Url = "/stone-art-murals/hanuman-ji-stone-art-mural/"; Title = "Hanuman Ji Mural"; Img = "/assets/images/hanuman-ji-mural.webp" },
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" },
            @{ Url = "/stone-art-murals/ram-darbar-stone-art-mural/"; Title = "Ram Darbar Mural"; Img = "/assets/images/ram-darbar-mural.webp" }
        )
    },
    @{
        Slug = "ganesh-ji-stone-art-mural"
        Name = "Ganesh Ji Stone Art & Mural"
        TargetDir = "stone-art-murals\ganesh-ji-stone-art-mural"
        Title = "Ganesha Mural Art & Stone Wall Relief | Shree Ram & Co"
        MetaDesc = "Handcrafted Ganesha mural art in natural sandstone and marble. Auspicious Vighnaharta 3D stone wall reliefs from Jaipur with custom sizes."
        Primary = "ganesha mural art"
        Keywords = "ganesha mural art, Ganesh stone mural, Lord Ganesha wall relief, Vighnaharta stone carving, Ganeshji stone panel Jaipur"
        H1 = "Ganesha Mural Art & Stone Wall Relief"
        Badge = "Auspicious Vighnaharta & Pratham Pujya Relief"
        Lead = "Bless your residence with wisdom, prosperity, and unobstructed success through handcrafted Ganesha mural art, sculpted in natural Rajasthan sandstone and marble at our Jaipur factory."
        OverviewH2 = "Auspicious Beginnings & Enduring Grace in Hand-Carved Stone"
        OverviewP1 = "As Pratham Pujya and the divine remover of obstacles (Vighnaharta), Lord Ganesha is the most auspicious presence in Indian home architecture. Our master stone sculptors in Jaipur hand-chisel Lord Ganesha with benign, benevolent grace, depicting his pot-bellied form symbolizing universal abundance, his large ears filtering wisdom, and his gentle eyes bestowing blessings."
        OverviewP2 = "Every nuance-from the single tusk (Ekadanta) representing focused discernment to the gracefully curved trunk (Vakratunda) holding sacred nectar, the bowl of modaks (Modakpatra), and the humble mouse (Mushaka) at his feet-is sculpted with dimensional relief depths of 25mm to 65mm. Carved from quarry-selected natural sandstone or white marble at our Jaipur factory, these sacred murals create an indelible first impression on entrance foyers, living rooms, and pooja sanctuaries."
        Highlights = @(
            "Iconographically disciplined depiction of Vighnaharta Ganesha in benevolent sitting posture.",
            "Meticulous chisel work on the curved trunk (Vakratunda) and single sacred tusk (Ekadanta).",
            "Hand-sculpted in natural Gwalior Mint, Bansi Paharpur pink stone, and pure white marble.",
            "Dimensional high-relief carving creating soft shadows and captivating tactile elegance.",
            "Factory-direct manufacturing in Jaipur with customized dimensions and insured delivery."
        )
        Features = @(
            @{ Icon = "fa-om"; Title = "Vakratunda Curved Trunk"; Desc = "Carefully chiseled curved trunk (Vakratunda) turning gracefully to the left or right, holding sacred amrit or modak." },
            @{ Icon = "fa-gem"; Title = "Ekadanta & Modakpatra"; Desc = "Delicate rendering of the single unbroken tusk symbolizing wisdom, and the bowl of modaks representing divine sweetness." },
            @{ Icon = "fa-sun"; Title = "Carved Floral Prabhavali"; Desc = "Ornate archway with traditional lotus rosettes, acanthus scrolls, and auspicious Kalash finials framing the deity." },
            @{ Icon = "fa-hand-back-fist"; Title = "Abhaya & Varada Mudras"; Desc = "Four arms holding the sacred Ankusha (goad), Pasha (noose), and offering fearless protection and prosperity." },
            @{ Icon = "fa-shield-halved"; Title = "Mushaka Vahana Seva"; Desc = "Humble mouse vahana sculpted at the base in devoted posture, symbolizing mastery over restless desires." },
            @{ Icon = "fa-layer-group"; Title = "Multi-Depth Chisel Relief"; Desc = "Graduated carving depths from subtle background incising to bold 65mm foreground relief." }
        )
        UniqueSection = @{
            Title = "Auspicious Sizing, Stone Selections & Foyer Placement"
            Subtitle = "Architectural Guidelines for Vighnaharta Stone Murals"
            Intro = "Selecting the ideal proportion, stone variety, and entryway orientation ensures your Ganesha mural becomes an auspicious blessing for family and arriving guests."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Main Entrance Niche: 2.5 ft x 3.5 ft (30mm relief depth, single-slab portrait)",
                "Living Room Focal Elevation: 4 ft x 6 ft (45mm relief depth, framed with carved stone moldings)",
                "Grand Mandir Backdrop: 7 ft x 10 ft (60mm relief depth, monumental high-relief composition)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Gwalior Mint Sandstone: Warm ivory-beige tones that harmonize beautifully with modern wooden and brass accents",
                "Ambaji White Marble: Flawless satvik purity for dedicated indoor home temples and prayer niches",
                "Dholpur Beige Sandstone: Fine-grained, weather-resilient stone suitable for sheltered outdoor porticos"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed mechanical dry-cladding anchors or recessed architectural wall niches with flush perimeter",
                "Position facing the main entrance or on the North-East / North wall of the home for auspicious energy flow",
                "Ceiling-mounted warm 3000K narrow-beam spot lamps directed onto the curved trunk, crown, and modak bowl"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Main Entrance & Welcome Foyer"
                Icon = "fa-door-open"
                Title = "Entrance Foyer & Portico"
                P1Title = "Auspicious Threshold Protection"
                P1Desc = "Placed opposite the front door or in the entrance foyer, greeting arriving family and guests with positive spiritual vibration."
                P2Title = "Traditional Placement Advisory"
                P2Desc = "Traditionally recommended facing North or East; avoid placing on walls that share boundaries with washrooms or stair under-spaces."
            },
            @{
                Tag = "Pooja Room & Living Room"
                Icon = "fa-landmark"
                Title = "Pooja Sanctum & Family Living Area"
                P1Title = "Daily Devotional Anchor"
                P1Desc = "Forms a deeply revered centerpiece for family aarti and morning meditation, radiating tranquil joy and wisdom."
                P2Title = "Architectural Frame Integration"
                P2Desc = "Integrates seamlessly with recessed stone moldings, wooden paneling, and warm concealed LED cove lighting."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/ganesh-ji-mural.webp"; Title = "Ganesha Sandstone Wall Relief"; Alt = "Ganesha mural art in Rajasthan sandstone featuring Ekadanta and Vakratunda curved trunk - Shree Ram & Company" },
            @{ Img = "/assets/images/handicrafts.webp"; Title = "Handcrafted Stone Sacred Relatives"; Alt = "Handcrafted Vighnaharta stone carving and auspicious relief artwork at Jaipur factory" },
            @{ Img = "/assets/images/jaipur-artisan.jpg"; Title = "Artisan Detailing Modakpatra & Crown"; Alt = "Sculptor delicately carving modakpatra and floral prabhavali for custom Ganesha stone mural" }
        )
        Faqs = @(
            @{ Q = "What does the curved trunk (Vakratunda) signify in Lord Ganesha's mural?"; A = "Vakratunda refers to Lord Ganesha's curved trunk (vakra = curved, tunda = trunk), symbolizing the divine capacity to master complex cosmic obstacles. When carved turning to the left (Vamamukhi), it represents peaceful household prosperity, while turning to the right (Dakshinabhimukhi) is associated with disciplined spiritual detachment." },
            @{ Q = "Which stone is best suited for a foyer entrance Ganesha mural?"; A = "Gwalior Mint Sandstone is exceptionally popular for entrance foyers because its warm ivory cream shade blends effortlessly with modern luxury interiors. Ambaji White Marble is equally favored for dedicated indoor pooja sanctums." },
            @{ Q = "What is the recommended height for mounting a Ganesha stone mural?"; A = "For respect and viewing ergonomics, the eye level of the standing viewer should align with Lord Ganesha's chest or lotus base, typically mounted with the bottom edge 24 to 36 inches above the finished floor level." },
            @{ Q = "How does Shree Ram & Company ship heavy stone murals safely across India?"; A = "All panels are pre-assembled and dry-fitted at our Jaipur factory, then securely packed in heavy-duty wooden crates lined with expanded polyethylene foam and corner armor for insured doorstep delivery nationwide." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/laxmi-ji-stone-art-mural/"; Title = "Laxmi Ji Mural"; Img = "/assets/images/laxmi-ji-mural.webp" },
            @{ Url = "/stone-art-murals/shiv-ji-stone-art-mural/"; Title = "Shiv Ji Mural"; Img = "/assets/images/shiv-ji-mural.webp" },
            @{ Url = "/stone-art-murals/durga-mata-ji-stone-art-mural/"; Title = "Durga Mata Ji Mural"; Img = "/assets/images/durga-mata-mural.webp" },
            @{ Url = "/stone-art-murals/ram-darbar-stone-art-mural/"; Title = "Ram Darbar Mural"; Img = "/assets/images/ram-darbar-mural.webp" }
        )
    },
    @{
        Slug = "hanuman-ji-stone-art-mural"
        Name = "Hanuman Ji Stone Art & Mural"
        TargetDir = "stone-art-murals\hanuman-ji-stone-art-mural"
        Title = "Hanuman Stone Mural & Devotional Carving | Shree Ram & Co"
        MetaDesc = "Sacred Hanuman stone mural sculpted in Bansi pink stone and white marble. Hand-carved Bajrang Bali wall art in Jaipur with custom sizes."
        Primary = "Hanuman stone mural"
        Keywords = "Hanuman stone mural, Bajrang Bali stone wall art, Lord Hanuman wall carving, Veer Hanuman stone relief, Sankat Mochan stone panel"
        H1 = "Hanuman Stone Mural & Devotional Carving"
        Badge = "Heroic Devotion & Sankat Mochan Relief"
        Lead = "Channel unwavering courage, physical vitality, and supreme devotion into your living space with a sacred Hanuman stone mural, hand-chiseled in pink sandstone and white marble by Jaipur master carvers."
        OverviewH2 = "Heroic Strength & Humble Bhakti Embodied in Natural Stone"
        OverviewP1 = "Lord Hanuman represents the highest synthesis of invincible strength (Veera) and selfless devotion (Bhakti). In our bespoke stone wall reliefs, our master sculptors capture Bajrang Bali either in his heroic flying posture carrying the sacred Dronagiri mountain with Sanjeevani herbs, wielding his mighty golden mace (Gada), or seated in peaceful Anjali mudra devotion before Prabhu Shri Ram."
        OverviewP2 = "Every anatomical contour, the dynamic movement of his tail (Langula), the flying drapery, and his resolute yet compassionate expression are sculpted with relief depths of 30mm to 70mm. Handcrafted from historic Bansi Paharpur pink sandstone, Red Agra stone, or Indian white marble at our Jaipur factory, these monumental murals instill an aura of fearlessness and protection."
        Highlights = @(
            "Iconographically disciplined depiction of Sankat Mochan Hanuman in Veer or Bhakti posture.",
            "Dynamic sculpted details: Dronagiri mountain, powerful Gada, and flowing sacred drapery.",
            "Hand-chiseled in sacred Bansi Paharpur pink sandstone, Agra Red, and crystalline white marble.",
            "Multi-tiered high relief producing bold shadow lines and heroic physical presence.",
            "Direct factory manufacturing in Jaipur with custom scaling and insured worldwide crated delivery."
        )
        Features = @(
            @{ Icon = "fa-mountain"; Title = "Dronagiri Parvat & Herbs"; Desc = "Carefully chiseled mountain held aloft on one palm, complete with micro-relief foliage representing the life-saving Sanjeevani." },
            @{ Icon = "fa-shield-halved"; Title = "Mighty Gada (Mace)"; Desc = "Solid stone mace carved with ornamental ridges and fluting, resting with commanding poise alongside Bajrang Bali." },
            @{ Icon = "fa-hands-praying"; Title = "Anjali Mudra Bhakti"; Desc = "Hands folded in humble, selfless reverence to Shri Ram, radiating deep spiritual humility alongside supreme power." },
            @{ Icon = "fa-wind"; Title = "Dynamic Musculature & Tail"; Desc = "Vibrant anatomical sculpting of shoulders, chest, and arched tail representing dynamic cosmic prana and vitality." },
            @{ Icon = "fa-crown"; Title = "Sacred Mukut & Kundals"; Desc = "Chiseled royal crown, celestial earrings, and sacred sacred thread (Yajnopavita) carved with millimeter fidelity." },
            @{ Icon = "fa-gem"; Title = "Quarry-Direct Material Authenticity"; Desc = "Sculpted exclusively from dense natural sandstone and crystalline marble blocks free from artificial additives." }
        )
        UniqueSection = @{
            Title = "Monumental Dimensions, Heroic Stone Selection & Altar Mounting"
            Subtitle = "Architectural Guidelines for Bajrang Bali Wall Reliefs"
            Intro = "Hanuman stone murals demand robust structural backing and precise orientation to capture their heroic energy and devotional presence."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Private Pooja Niche: 3 ft x 4.5 ft (35mm relief depth, single-slab portrait)",
                "Courtyard & Fitness Sanctuary Elevation: 5 ft x 7 ft (50mm relief depth, dynamic Veer posture)",
                "Monumental Boundary Wall / Temple Facade: 8 ft x 11 ft (65mm relief depth across interlocking slabs)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Bansi Paharpur Pink Sandstone: Sacred pink stone embodying the heroic Veer rasa and historic temple sanctity",
                "Agra Red Sandstone: Deep terra-cotta red stone projecting commanding terrestrial power and rustic warmth",
                "Pure Indian White Marble: Pristine crystalline stone chosen for quiet, devotional Anjali mudra pooja rooms"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Heavy-duty Grade-304 stainless steel anchor bolts with high-strength structural anchoring epoxy",
                "Traditionally oriented on the South or South-West wall in accordance with traditional Hanuman upasana principles",
                "Directional 3500K neutral-warm spotlighting casting dramatic shadows across the muscular contours and mountain"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Home Temple & Devotional Space"
                Icon = "fa-om"
                Title = "Pooja Room & Prayer Sanctum"
                P1Title = "Sankat Mochan Protection"
                P1Desc = "Infuses the family shrine with divine protection against negative energies, instilling moral courage and peace."
                P2Title = "Sacred Placement Advisory"
                P2Desc = "Traditionally oriented facing South or East; consult personal family traditions for individual altar alignment."
            },
            @{
                Tag = "Courtyard, Gym & Entry Elevation"
                Icon = "fa-dumbbell"
                Title = "Courtyard, Wellness & Entrance"
                P1Title = "Vitality & Inner Discipline"
                P1Desc = "Inspires daily vitality, focused willpower, and self-mastery in private home wellness suites and open courtyards."
                P2Title = "Weatherproof Outdoor Strength"
                P2Desc = "Carved from dense sandstone that endures direct sunlight, monsoon rain, and temperature fluctuations with grace."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/hanuman-ji-mural.webp"; Title = "Hanuman Ji Pink Sandstone Mural"; Alt = "Hanuman stone mural sculpted in Bansi Paharpur pink stone holding sacred Dronagiri mountain - Shree Ram & Company" },
            @{ Img = "/assets/images/stone-temple.webp"; Title = "Temple Facade Integration"; Alt = "Sacred Bajrang Bali stone wall carving integrated into hand-chiseled temple wall facade" },
            @{ Img = "/assets/images/stone-carving.jpg"; Title = "Artisan Detailing Musculature"; Alt = "Master artisan hand-chiseling muscular relief contours for monumental Hanuman stone mural" }
        )
        Faqs = @(
            @{ Q = "What does the Dronagiri mountain posture represent in this Hanuman mural?"; A = "Depicting Lord Hanuman flying with Mount Dronagiri represents his unconditional willingness to overcome insurmountable obstacles to save Lakshman's life. In the home, it symbolizes immediate help in times of adversity (Sankat Mochan) and selfless loyalty." },
            @{ Q = "Which stone is most traditional for a Lord Hanuman wall carving?"; A = "Bansi Paharpur Pink Sandstone is historically the most revered stone for Bajrang Bali, matching the natural sindoor hue associated with traditional Hanuman worship. Agra Red Sandstone and Indian White Marble are equally requested." },
            @{ Q = "Can this stone mural be installed outdoors or on terrace walls?"; A = "Yes. Natural sandstone is an inherently weather-hardy material that has survived for centuries in Rajasthan forts and temples. We apply breathable penetrating sealers to exterior installations to prevent dust accumulation." },
            @{ Q = "What packaging is used for interstate delivery?"; A = "Every panel is packed in heavy-duty timber pallets with impact-absorbing chemical foam cushioning and waterproof wrapping, ensuring zero transit damage to protruding hands, gada, or facial features." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/ram-darbar-stone-art-mural/"; Title = "Ram Darbar Mural"; Img = "/assets/images/ram-darbar-mural.webp" },
            @{ Url = "/stone-art-murals/durga-mata-ji-stone-art-mural/"; Title = "Durga Mata Ji Mural"; Img = "/assets/images/durga-mata-mural.webp" },
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" },
            @{ Url = "/stone-art-murals/shiv-ji-stone-art-mural/"; Title = "Shiv Ji Mural"; Img = "/assets/images/shiv-ji-mural.webp" }
        )
    },
    @{
        Slug = "laxmi-ji-stone-art-mural"
        Name = "Laxmi Ji Stone Art & Mural"
        TargetDir = "stone-art-murals\laxmi-ji-stone-art-mural"
        Title = "Laxmi Stone Mural & Gajalakshmi Wall Art | Shree Ram & Co"
        MetaDesc = "Auspicious Laxmi stone mural and Gajalakshmi bas-relief wall art in natural marble and sandstone. Custom handcrafted in Jaipur for homes."
        Primary = "Laxmi stone mural"
        Keywords = "Laxmi stone mural, Gajalakshmi stone wall art, Goddess Lakshmi wall relief, Mahalaxmi stone panel, Marble Laxmi mural Jaipur"
        H1 = "Laxmi Stone Mural & Gajalakshmi Wall Art"
        Badge = "Auspicious Gajalakshmi & Prosperity Relief"
        Lead = "Welcome enduring prosperity, spiritual grace, and domestic abundance with an auspicious Laxmi stone mural, hand-carved in pure white marble and natural sandstone at our Jaipur factory."
        OverviewH2 = "Cosmic Abundance & Serene Grace in Hand-Chiseled Stone"
        OverviewP1 = "Goddess Laxmi is the divine embodiment of auspiciousness, spiritual wealth, and cosmic grace. In our masterfully carved stone wall murals, Maa Laxmi is portrayed seated gracefully in Padmasana upon a full-bloom thousand-petal lotus. In the revered Gajalakshmi composition, she is flanked by twin royal elephants holding holy water urns in gentle celestial abhisheka."
        OverviewP2 = "Her four arms hold twin blooming lotuses signifying purity and self-realization, while her lower right hand bestows blessings in Varada mudra with a delicate shower of coins, and her left hand offers protective shelter. Handcrafted from pristine Indian white marble or warm Gwalior Mint sandstone at our Jaipur factory, these relief murals radiate radiant tranquility in residential mandirs and formal living rooms."
        Highlights = @(
            "Iconographically disciplined depiction of Goddess Laxmi in Padmasana on a multi-tiered lotus.",
            "Revered Gajalakshmi composition with twin royal elephants performing celestial abhisheka.",
            "Handcrafted in quarry-selected Indian White Marble and velvety Gwalior Mint sandstone.",
            "Delicate micro-chisel work on floral halos, jewelry, and showering coin details.",
            "Factory-direct manufacturing in Jaipur with bespoke dimensions and safe crated delivery."
        )
        Features = @(
            @{ Icon = "fa-spa"; Title = "Sahasradala Lotus Throne"; Desc = "Multi-tiered lotus throne with delicately rounded overlapping petals, symbolizing spiritual illumination and pure grace." },
            @{ Icon = "fa-elephant"; Title = "Twin Gajalakshmi Elephants"; Desc = "Royal elephants sculpted on either side with raised trunks holding sacred kalash urns, signifying cosmic abundance." },
            @{ Icon = "fa-coins"; Title = "Varada Mudra & Dhan Shower"; Desc = "Open hand gesture bestowing boons, paired with hand-carved showers of gold coins symbolizing material and spiritual wealth." },
            @{ Icon = "fa-crown"; Title = "Royal Mukut & Kangan Detailing"; Desc = "Exquisite micro-undercutting of ornate crowns, pearl necklaces, bangles, and flowing sheer stone drapery." },
            @{ Icon = "fa-sun"; Title = "Sacred Radiant Halo (Prabha)"; Desc = "Intricately carved floral halo with radial fluting casting graceful shadows under soft grazing illumination." },
            @{ Icon = "fa-gem"; Title = "Luminous Marble & Stone"; Desc = "Carved purely from dense, crystalline natural stone that accepts high hand-buffed finishes without chemical coatings." }
        )
        UniqueSection = @{
            Title = "Auspicious Dimensions, Marble Selection & Prosperity Alignment"
            Subtitle = "Architectural Guidelines for Gajalakshmi Wall Murals"
            Intro = "Selecting the ideal proportion, stone variety, and entryway orientation ensures your Laxmi mural becomes a perpetual blessing for family prosperity."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Home Mandir Central Panel: 3 ft x 4 ft (35mm relief depth, monolithic marble plaque)",
                "Living Room Wealth Niche: 5 ft x 6.5 ft (45mm relief depth, Gajalakshmi composition)",
                "Grand Hall Focal Wall: 7 ft x 9 ft (60mm relief depth, multi-panel architectural installation)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Pure Ambaji & Makrana White Marble: Unblemished satvik luminosity for Sri Suktam daily worship and indoor sanctums",
                "Gwalior Mint Sandstone: Delicate warm ivory-gold undertones that harmonize with warm architectural timber accents",
                "Vietnam White Marble: Ultra-fine crystalline grain delivering razor-sharp precision on jewelry and elephant trunks"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed mechanical dry-cladding anchors or recessed architectural wall niches with flush perimeter",
                "Position on the North or North-East wall (associated with cosmic wealth and Lord Kuber) for ideal harmony",
                "Warm 2800K perimeter halo LED strip lighting casting gentle illumination across the elephants and lotus throne"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Home Temple & Pooja Room"
                Icon = "fa-om"
                Title = "Pooja Altar & Mandir Sanctum"
                P1Title = "Supreme Auspicious Anchor"
                P1Desc = "Serves as the sanctum backdrop for daily prayers, Diwali celebrations, and Lakshmi pujan, radiating peaceful grace."
                P2Title = "Traditional Orientation Advisory"
                P2Desc = "Traditionally recommended on the North or North-East wall of the pooja room, as North is associated with cosmic prosperity."
            },
            @{
                Tag = "Entrance Foyer & Formal Living"
                Icon = "fa-landmark"
                Title = "Wealth Foyer & Living Room Feature"
                P1Title = "Grand Cultural Focal Point"
                P1Desc = "Greets entering guests with a dignified aura of abundance, royal Indian heritage, and fine artisanal luxury."
                P2Title = "Refined Architectural Presence"
                P2Desc = "Complements modern luxury interiors with soft neutral stone textures that transcend fleeting interior trends."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/laxmi-ji-mural.webp"; Title = "Goddess Laxmi White Marble Mural"; Alt = "Goddess Laxmi stone mural in white marble seated on lotus with twin Gajalakshmi elephants - Shree Ram & Company" },
            @{ Img = "/assets/images/marble-temple.webp"; Title = "Mandir Wall Panel Integration"; Alt = "Sacred Mahalaxmi white marble mandir wall panel with mirror-buffed floral halo" },
            @{ Img = "/assets/images/marble-inlay.webp"; Title = "Delicate Floral Lotus Detailing"; Alt = "Delicate marble carving and lotus petal detailing crafted by Jaipur artisans" }
        )
        Faqs = @(
            @{ Q = "What is the spiritual significance of the Gajalakshmi composition?"; A = "Gajalakshmi depicts Goddess Lakshmi flanked by two royal elephants showering holy water from their trunks. In traditional iconography, it symbolizes royal dignity, fertility, spiritual majesty, and the unceasing showering of cosmic grace upon the household." },
            @{ Q = "Which stone variety is most recommended for a Laxmi Ji mural?"; A = "Pristine Indian White Marble from Ambaji or Makrana is the premier choice for indoor pooja rooms due to its immaculate satvik purity and smooth, mirror-buffed touch. Gwalior Mint Sandstone is equally popular for contemporary foyers and living rooms." },
            @{ Q = "What is the recommended placement according to traditional home design?"; A = "Traditionally, Goddess Laxmi is placed on the North or North-East wall, as the North is the direction governed by Kubera (the treasurer of the gods). We advise consulting your personal spiritual advisor for specific home layouts." },
            @{ Q = "Can custom dimensions be accommodated for an existing wall niche?"; A = "Yes. Every stone mural at Shree Ram & Company is manufactured factory-direct in Jaipur to custom millimeter dimensions based on your architectural drawings or on-site niche measurements." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" },
            @{ Url = "/stone-art-murals/ram-darbar-stone-art-mural/"; Title = "Ram Darbar Mural"; Img = "/assets/images/ram-darbar-mural.webp" },
            @{ Url = "/stone-art-murals/radhe-krishna-stone-art-mural/"; Title = "Radhe Krishna Mural"; Img = "/assets/images/radhe-krishna-mural.webp" },
            @{ Url = "/stone-art-murals/floral-stone-art/"; Title = "Floral Stone Art"; Img = "/assets/images/floral-stone-art.webp" }
        )
    },
    @{
        Slug = "ram-darbar-stone-art-mural"
        Name = "Ram Darbar Stone Art & Mural"
        TargetDir = "stone-art-murals\ram-darbar-stone-art-mural"
        Title = "Ram Darbar Stone Mural & Carved Wall Art | Shree Ram & Co"
        MetaDesc = "Sacred Ram Darbar stone mural featuring Shri Ram with Kodanda bow, Sita, Lakshman, and Hanuman. Hand-sculpted in natural stone at Jaipur."
        Primary = "Ram Darbar stone mural"
        Keywords = "Ram Darbar stone mural, Shri Ram Darbar wall relief, Ram Sita Lakshman Hanuman stone carving, Ayodhya stone wall art, Temple stone relief Jaipur"
        H1 = "Ram Darbar Stone Mural & Carved Wall Art"
        Badge = "Maryada Purushottam & Divine Court Relief"
        Lead = "Establish the supreme ideals of dharma, family harmony, and righteous grace in your home with a sacred Ram Darbar stone mural, hand-carved in pink sandstone and marble by Jaipur master sculptors."
        OverviewH2 = "Dharmic Royalty & Unwavering Devotion Carved in Enduring Stone"
        OverviewP1 = "The Ram Darbar depicts Maryada Purushottam Bhagwan Shri Ram presiding in divine court alongside Mata Sita, his devoted brother Lakshman, and his ardent bhakt Hanuman. This monumental sacred composition represents the perfection of dharma, righteous governance, family unity, and unshakeable spiritual loyalty."
        OverviewP2 = "Sculpted in expansive multi-layered depths of 30mm to 70mm, each figure showcases distinctive regal attributes: Shri Ram holding his divine Kodanda bow in hand with his right hand in Abhaya blessing, Mata Sita's graceful poise holding a lotus blossom, brother Lakshman standing attentively beside with his bow in hand, and Hanuman Ji seated in humble folded-hands devotion at Shri Ram's feet. Chiseled from Bansi Paharpur sandstone or high-grade white marble, these monumental murals become revered spiritual focal points for family prayer sanctuaries and grand double-height living rooms."
        Highlights = @(
            "Iconographically disciplined depiction of Shri Ram with his divine Kodanda bow, Mata Sita, Lakshman, and Hanuman.",
            "Multi-figure compositional harmony with proportional hierarchy and expressive facial grace.",
            "Hand-chiseled in sacred Bansi Paharpur pink sandstone and pristine white marble.",
            "Deep multi-plane relief carving creating extraordinary lifelike presence and architectural depth.",
            "Factory-direct manufacturing in Jaipur with custom dimensions and fully insured worldwide delivery."
        )
        Features = @(
            @{ Icon = "fa-shield-halved"; Title = "Sacred Kodanda Bow of Shri Ram"; Desc = "Millimeter-precision chisel work detailing Shri Ram's divine Kodanda bow, quiver of arrows, and royal Abhaya mudra blessing." },
            @{ Icon = "fa-spa"; Title = "Mata Sita's Graceful Form"; Desc = "Sculpted with maternal dignity, delicate jewelry, flowing drapery, and holding the sacred lotus blossom symbolizing auspicious purity." },
            @{ Icon = "fa-shield"; Title = "Lakshman's Loyal Presence"; Desc = "Attentive standing posture of brother Lakshman holding his bow, representing steadfast vigilance, duty, and fraternal devotion." },
            @{ Icon = "fa-hands-praying"; Title = "Hanuman Ji's Humble Bhakti"; Desc = "Lord Hanuman seated at the lotus feet (charan) of Shri Ram with folded hands in Anjali mudra, embodying supreme selfless seva." },
            @{ Icon = "fa-crown"; Title = "Regal Royal Crowns (Mukut)"; Desc = "Elaborate multi-tiered mukuts and royal ornaments chiseled with intricate micro-relief details following classical temple sculpture." },
            @{ Icon = "fa-landmark"; Title = "Ornate Mandir Archway"; Desc = "Framed by a classical architectural archway with floral kalash finials, lotus borders, and royal chhatras." }
        )
        UniqueSection = @{
            Title = "Family Sanctum Dimensions, Royal Stone Selection & Temple Architecture"
            Subtitle = "Engineering Guidelines for Ram Darbar Wall Murals"
            Intro = "A multi-figure composition like Ram Darbar requires precise compositional balance and structural anchoring to ensure every divine figure commands proportional majesty."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Residential Mandir Wall: 4 ft x 6 ft (40mm relief depth, book-matched two-slab composition)",
                "Living Room Statement Elevation: 6 ft x 9 ft (55mm relief depth, multi-panel architectural installation)",
                "Grand Villa Double-Height Courtyard: 9 ft x 14 ft (70mm relief depth across precision-jointed modular stone slabs)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Bansi Paharpur Pink Sandstone: The authentic sacred temple stone of Ayodhya and Rajasthan, projecting warm dharmic grandeur",
                "Pristine Indian White Marble: Pure crystalline stone delivering smooth satvik radiance for indoor family mandirs",
                "Dholpur Beige Sandstone: Fine-textured natural stone offering clean neoclassical warmth for formal living rooms"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed Grade-304 stainless steel anchor bracket system engineered to support heavy multi-slab stone panels",
                "Optimal orientation on the East or North-East wall facing West so worshippers face East during daily prayer",
                "Warm 2800K cove lighting washing down over Shri Ram's Kodanda bow, Mata Sita, Lakshman, and Hanuman Ji"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Home Temple & Pooja Sanctum"
                Icon = "fa-om"
                Title = "Central Family Prayer Sanctum"
                P1Title = "Sanctuary of Dharmic Harmony"
                P1Desc = "Anchors the family prayer room with the divine presence of Maryada Purushottam, fostering household unity, peace, and mutual respect."
                P2Title = "Traditional Orientation Advisory"
                P2Desc = "Traditionally placed on the East or North-East wall facing West, so devotees face East while offering prayers and aarti."
            },
            @{
                Tag = "Grand Living Room & Courtyard"
                Icon = "fa-landmark"
                Title = "Double-Height Living & Foyer Elevation"
                P1Title = "Monumental Statement Wall"
                P1Desc = "Commands attention in double-height living rooms and grand villa courtyards as an awe-inspiring tribute to Indian heritage."
                P2Title = "Heirloom Architectural Value"
                P2Desc = "Sculpted from dense natural stone that endures for generations without degradation, becoming a timeless family heirloom."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/ram-darbar-mural.webp"; Title = "Ram Darbar Sandstone Wall Relief"; Alt = "Sacred Ram Darbar stone mural featuring Shri Ram with Kodanda bow, Mata Sita, Lakshman, and Hanuman - Shree Ram & Company" },
            @{ Img = "/assets/images/hero-peacock-carving.webp"; Title = "Architectural Floral Border Carving"; Alt = "Architectural sandstone relief panel carving with royal floral borders for temple wall" },
            @{ Img = "/assets/images/jaipur-artisan.jpg"; Title = "Artisan Detailing Facial Expressions"; Alt = "Artisan in Jaipur factory refining devotional facial expressions on Ram Darbar stone relief" }
        )
        Faqs = @(
            @{ Q = "What does the Kodanda bow represent in Shri Ram's hand?"; A = "The Kodanda bow is the divine bow of Bhagwan Shri Ram, symbolizing his status as the protector of dharma (righteousness) and guardian of the virtuous. While holding the Kodanda bow, Shri Ram's right hand offers the Abhaya mudra, assuring devotees of divine protection." },
            @{ Q = "What stone variety is most recommended for Ram Darbar reliefs?"; A = "Bansi Paharpur Pink Sandstone is historically revered for Shri Ram murals because it is the exact sacred stone used in historic temple architecture in Rajasthan and Ayodhya. Indian White Marble is equally chosen for luminous, refined indoor temple sanctums." },
            @{ Q = "How are multiple figures proportionally balanced in a custom mural?"; A = "Our master sculptors adhere to classical Shilpa Shastra proportions, with Shri Ram as the central commanding figure, Mata Sita standing gracefully by his side, Lakshman standing loyally with bow, and Hanuman Ji seated devotionally at their feet." },
            @{ Q = "How is a large modular Ram Darbar mural assembled on site?"; A = "Large panels are carved in modular tiles with precision-milled edges at our Jaipur factory. During dry cladding installation, panels are mounted on concealed stainless steel brackets with hairline joints that blend seamlessly." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/hanuman-ji-stone-art-mural/"; Title = "Hanuman Ji Mural"; Img = "/assets/images/hanuman-ji-mural.webp" },
            @{ Url = "/stone-art-murals/laxmi-ji-stone-art-mural/"; Title = "Laxmi Ji Mural"; Img = "/assets/images/laxmi-ji-mural.webp" },
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" },
            @{ Url = "/stone-art-murals/shiv-ji-stone-art-mural/"; Title = "Shiv Ji Mural"; Img = "/assets/images/shiv-ji-mural.webp" }
        )
    },
    @{
        Slug = "shiv-ji-stone-art-mural"
        Name = "Shiv Ji Stone Art & Mural"
        TargetDir = "stone-art-murals\shiv-ji-stone-art-mural"
        Title = "Shiv Stone Mural & Mahadev Wall Relief | Shree Ram & Co"
        MetaDesc = "Handcrafted Shiv stone mural and Mahadev meditative wall art in natural sandstone and marble. Direct manufacturer in Jaipur with custom sizes."
        Primary = "Shiv stone mural"
        Keywords = "Shiv stone mural, Mahadev wall relief, Lord Shiva stone carving, Adiyogi stone mural Jaipur, Kailash Shiva wall panel"
        H1 = "Shiv Stone Mural & Mahadev Wall Relief"
        Badge = "Adiyogi & Meditative Kailash Relief"
        Lead = "Invoke supreme meditative stillness, cosmic detachment, and transformative spiritual grace with a handcrafted Shiv stone mural, sculpted in natural sandstone and marble by Jaipur master carvers."
        OverviewH2 = "Adiyogi's Silent Transcendence Carved in Enduring Stone"
        OverviewP1 = "Lord Shiva, as Adiyogi and Mahadev, represents absolute consciousness, cosmic stillness, and the eternal source of yoga. In our handcrafted stone wall murals, Lord Shiva is portrayed in deep Kailash Dhyana, seated upon a tiger skin (Vyaghrasana) with the crescent moon (Chandra) adorning his matted locks (Jata) and the sacred Ganga descending in divine flow."
        OverviewP2 = "Every sacred iconographic emblem-from the third eye (Trinetra) on his brow to the coiled serpent Vasuki around his neck, the Trishul (trident) with tied Damru, and the ash-smeared meditative calm of his countenance-is hand-carved with dimensional relief depths of 30mm to 70mm. Sculpted from Gwalior Mint sandstone, Bansi pink stone, or pristine white marble at our Jaipur factory, these murals create an atmosphere of profound meditative focus."
        Highlights = @(
            "Iconographically disciplined depiction of Adiyogi Shiva in deep meditative Kailash Dhyana.",
            "Meticulous chisel work on sacred emblems: Trishul, Damru, crescent moon, and coiled serpent.",
            "Handcrafted in quarry-selected Gwalior Mint sandstone, Bansi pink stone, and white marble.",
            "Deep dimensional relief creating serene shadow play under ambient and grazing lighting.",
            "Factory-direct manufacturing in Jaipur with custom sizing and worldwide crated shipping."
        )
        Features = @(
            @{ Icon = "fa-moon"; Title = "Crescent Moon & Jata"; Desc = "Delicate chiseling of the crescent moon nestled in Lord Shiva's matted locks, symbolizing the mastery of time and mind." },
            @{ Icon = "fa-water"; Title = "Sacred River Ganga Flow"; Desc = "Graceful stone ripples capturing the descent of holy Ganga from his locks, signifying spiritual purification." },
            @{ Icon = "fa-shield-halved"; Title = "Trishul & Damru"; Desc = "Commanding trident representing the three gunas, paired with the hourglass drum representing cosmic sound (Nada)." },
            @{ Icon = "fa-eye"; Title = "Trinetra & Serene Brow"; Desc = "Micro-carved third eye of spiritual insight resting on a tranquil brow, projecting deep meditative stillness." },
            @{ Icon = "fa-ring"; Title = "Coiled Vasuki Serpent"; Desc = "Serpent gracefully resting around the neck of Neelkanth, sculpted with intricate scale textures and watchful poise." },
            @{ Icon = "fa-gem"; Title = "Pure Natural Stone Purity"; Desc = "Carved purely from dense, enduring sandstone and crystalline marble blocks with zero synthetic fillers." }
        )
        UniqueSection = @{
            Title = "Meditative Dimensions, Ascetic Stone Grades & Sacred Installation"
            Subtitle = "Architectural Guidelines for Mahadev Wall Murals"
            Intro = "Selecting the ideal proportion, stone variety, and entryway orientation ensures your Shiv mural becomes an inspiring sanctuary of tranquil contemplation."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Meditation Room Alcove: 3.5 ft x 5 ft (35mm relief depth, monolithic relief panel)",
                "Living Room Feature Elevation: 5.5 ft x 8 ft (50mm relief depth, book-matched composition)",
                "Grand Garden Pavilion / Courtyard Wall: 8 ft x 12 ft (65mm relief depth across precision-jointed modular slabs)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Gwalior Mint Sandstone: Understated ash-ivory tone imparting peaceful meditative calm to minimalist interiors",
                "Pure Indian White Marble: Himalayan snow radiance with smooth hand-buffed finish for dedicated indoor shrines",
                "Bansi Paharpur Pink Sandstone: Earthy warm stone projecting historic temple sanctity and rustic grandeur"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed Grade-304 stainless steel dry-cladding brackets with structural non-staining adhesive",
                "Position on the North-East (Ishanya, the realm of Lord Shiva) or North wall for ideal spiritual alignment",
                "Low-glare 3000K warm grazing illumination bringing out the matted locks, crescent moon, and Trishul"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Meditation & Yoga Sanctum"
                Icon = "fa-om"
                Title = "Yoga Studio & Meditation Room"
                P1Title = "Supreme Centering Presence"
                P1Desc = "Creates a tranquil atmosphere of mental silence, inner detachment, and concentrated focus during daily dhyana."
                P2Title = "Traditional Alignment Advisory"
                P2Desc = "Traditionally oriented on the North-East (Ishanya) wall, which is considered the sacred realm of Mahadev."
            },
            @{
                Tag = "Living Room & Courtyard Feature"
                Icon = "fa-landmark"
                Title = "Living Room & Indoor Atrium"
                P1Title = "Monumental Cultural Grandeur"
                P1Desc = "Serves as an architectural conversation piece that commands deep reverence and artistic appreciation."
                P2Title = "Enduring Weatherproof Solidity"
                P2Desc = "Dense natural sandstone withstands seasonal temperature shifts gracefully, retaining its sculptural dignity."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/shiv-ji-mural.webp"; Title = "Shiv Ji Sandstone Wall Relief"; Alt = "Shiv stone mural depicting Adiyogi in Kailash Dhyana with crescent moon and Trishul - Shree Ram & Company Jaipur" },
            @{ Img = "/assets/images/marble-statue.webp"; Title = "Luminous White Marble Shiva Relief"; Alt = "Luminous white marble Lord Shiva meditative relief carving with serene countenance" },
            @{ Img = "/assets/images/stone-carving.jpg"; Title = "Artisan Detailing Damru & Ganga"; Alt = "Sculptor hand-carving Damru and flowing Ganga locks on sandstone Mahadev wall mural" }
        )
        Faqs = @(
            @{ Q = "What does Adiyogi in Kailash Dhyana represent in this mural?"; A = "Adiyogi in Dhyana posture depicts Lord Shiva in profound cosmic meditation, representing the origin of yoga, inner stillness, and the transcendence of physical limitations. It establishes a grounding atmosphere of spiritual peace in residential spaces." },
            @{ Q = "Which stone variety is most popular for Lord Shiva wall murals?"; A = "Gwalior Mint Sandstone is exceptionally popular for its soothing ivory-ash tone, reflecting the ascetic character of Mount Kailash. Pristine White Marble from Ambaji or Makrana is equally chosen for pure indoor sanctums." },
            @{ Q = "Where should a Lord Shiva stone mural be placed in the home?"; A = "According to traditional architecture principles, Lord Shiva's relief is ideally placed on the North-East (Ishanya) corner, which is considered the most sacred quadrant for spiritual contemplation. Consult your personal Vastu advisor for individual room layouts." },
            @{ Q = "What is the dispatch protocol for large Shiv Ji murals?"; A = "Each mural is test-assembled and inspected at our Jaipur factory, then packed into heavy-duty wooden crates lined with high-density foam and corner armor for insured doorstep delivery nationwide." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/durga-mata-ji-stone-art-mural/"; Title = "Durga Mata Ji Mural"; Img = "/assets/images/durga-mata-mural.webp" },
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" },
            @{ Url = "/stone-art-murals/hanuman-ji-stone-art-mural/"; Title = "Hanuman Ji Mural"; Img = "/assets/images/hanuman-ji-mural.webp" },
            @{ Url = "/stone-art-murals/ram-darbar-stone-art-mural/"; Title = "Ram Darbar Mural"; Img = "/assets/images/ram-darbar-mural.webp" }
        )
    },
    @{
        Slug = "shreenath-ji-stone-art-mural"
        Name = "Shreenath Ji Stone Art & Mural"
        TargetDir = "stone-art-murals\shreenath-ji-stone-art-mural"
        Title = "Shree Nath Ji Wall Mural & 3D Stone Art | Shree Ram & Co"
        MetaDesc = "Devotional Shree Nath ji wall mural in Govardhandhara swaroop. Hand-carved Mukharvind sandstone and marble wall art crafted in Jaipur."
        Primary = "Shree Nath ji wall mural"
        Keywords = "Shree Nath ji wall mural, Shree Nath Ji wall 3d art, Shree Nath ji wall panel, Shreenath Ji Mukharvind 3D wall art, Govardhandhara stone relief"
        H1 = "Shree Nath Ji Wall Mural & 3D Stone Art"
        Badge = "Sacred Govardhandhara Darshan"
        Lead = "Experience the blissful divine presence of Nathdwara in your home with handcrafted Shreenath Ji stone wall murals, sculpted in sacred Govardhandhara iconography by master carvers in Jaipur."
        OverviewH2 = "Govardhandhara Swaroop & Divine Grace Carved in Enduring Stone"
        OverviewP1 = "Shreenath Ji is the beloved childhood manifestation (Balak) of Shri Krishna as Govardhandhara, lifting Mount Govardhan to protect the inhabitants of Vraja. In this deeply reverent composition, our Jaipur sculptors depict Shreenath Ji lifting the sacred mountain with his left hand raised, his right fist resting gently upon his waist, and his gaze downward bestowing grace upon devotees."
        OverviewP2 = "Every sacred iconographic detail-from the large compassionate lotus eyes (Kamal Nayan) and the sparkling diamond upon his chin (Chibuk Chhibi) to his ornate garland (Vanamala), peacock feather turban, and the sacred cows gathered at his feet-is hand-carved with dimensional relief depth of 25mm to 65mm. Handcrafted from pristine white marble or warm sandstone at our Jaipur factory, these reliefs bring the sanctified atmosphere of a traditional Haveli into private prayer rooms."
        Highlights = @(
            "Iconographically disciplined depiction of Shreenath Ji in sacred Govardhandhara swaroop.",
            "Meticulous chisel work on Mukharvind details, lotus eyes, chin gem, and ornate shringar.",
            "Handcrafted in quarry-selected Indian White Marble and velvety Gwalior Mint sandstone.",
            "Dimensional high-relief carving bringing out fine garlands, drapery folds, and holy cows.",
            "Factory-direct manufacturing in Jaipur with bespoke sizing and insured worldwide shipping."
        )
        Features = @(
            @{ Icon = "fa-hand-holding-hand"; Title = "Govardhandhara Left Hand"; Desc = "Sacred raised left hand posture lifting Mount Govardhan, sculpted with delicate finger grace and poise." },
            @{ Icon = "fa-eye"; Title = "Kamal Nayan (Lotus Eyes)"; Desc = "Large, compassionate downward-glancing lotus petal eyes sculpted with gentle serenity and maternal grace." },
            @{ Icon = "fa-gem"; Title = "Chibuk Chhibi (Chin Gem)"; Desc = "Carefully chiseled depiction of the radiant diamond on the chin, capturing the divine adornment of Nathdwara." },
            @{ Icon = "fa-spa"; Title = "Ornate Shringar & Vanamala"; Desc = "Exquisite multi-strand pearl necklaces, flowing Vanamala garland, and ceremonial pagh with peacock feather." },
            @{ Icon = "fa-hands"; Title = "Right Hand at Waist"; Desc = "Right fist resting gently on the waist in a posture of royal divine majesty and reassuring protection." },
            @{ Icon = "fa-landmark"; Title = "Haveli-Style Archway"; Desc = "Framed by traditional carved Torans, Kalash finials, and floral borders inspired by historic Haveli architecture." }
        )
        UniqueSection = @{
            Title = "Haveli Proportions, Luminous Stone Selection & Shringar Elevation"
            Subtitle = "Architectural Guidelines for Shreenath Ji Wall Murals"
            Intro = "Selecting the ideal proportion, stone variety, and entryway orientation ensures your Shreenath Ji mural becomes a joyful focal point for daily seva and darshan."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Private Mandir Mukharvind Niche: 2.5 ft x 3.5 ft (35mm relief depth, single-slab focal panel)",
                "Living Room Haveli Elevation: 4.5 ft x 6 ft (50mm relief depth, framed with carved stone moldings)",
                "Monumental Prayer Hall Backdrop: 7 ft x 10 ft (65mm relief depth across precision-jointed modular slabs)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Pristine Indian White Marble: Mirror-smooth satvik polish for traditional daily seva, shringar, and pure reflections",
                "Gwalior Mint Sandstone: Warm organic golden hue delivering earthy warmth to contemporary luxury Havelis",
                "Bansi Paharpur Pink Sandstone: Regal pink stone carrying deep historic Rajasthan temple resonance"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed mechanical dry-cladding anchors or recessed architectural wall niches with flush perimeter",
                "Central focal placement in the pooja room or North-East wall, elevated 24 to 36 inches above floor level",
                "Soft 2700K warm directional illumination focused on the lotus eyes, raised left hand, and chin diamond"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Home Temple & Daily Seva"
                Icon = "fa-om"
                Title = "Pooja Room & Haveli Mandir"
                P1Title = "Sacred Darshan Sanctum"
                P1Desc = "Transforms the family mandir into a blessed Haveli sanctum, elevating daily prayers, bhajan, and aarti with divine joy."
                P2Title = "Traditional Orientation Advisory"
                P2Desc = "Traditionally placed as the central focal point of the prayer room facing East or North for serene morning prayers."
            },
            @{
                Tag = "Formal Living & Foyer Feature"
                Icon = "fa-landmark"
                Title = "Living Room & Foyer Elevation"
                P1Title = "Graceful Cultural Statement"
                P1Desc = "Captivates family and visitors with deep spiritual beauty, fine micro-relief carving, and serene divine countenance."
                P2Title = "Timeless Handcrafted Integrity"
                P2Desc = "Carved from pure natural stone that retains its crisp sculptural definition across generations."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/shreenath-ji-mural.webp"; Title = "Shreenath Ji Sandstone Wall Relief"; Alt = "Shree Nath ji wall mural in sacred Govardhandhara swaroop with lotus eyes - Shree Ram & Company Jaipur" },
            @{ Img = "/assets/images/marble-temple.webp"; Title = "Mukharvind Marble Mandir Panel"; Alt = "Sacred Shreenath Ji Mukharvind marble wall relief installed in luxury home prayer room" },
            @{ Img = "/assets/images/jaipur-artisan.jpg"; Title = "Artisan Detailing Chin Diamond"; Alt = "Master craftsman chiseling delicate diamond chin and shringar adornments for Shreenath Ji stone panel" }
        )
        Faqs = @(
            @{ Q = "What makes Shreenath Ji's iconography unique in stone sculpture?"; A = "Shreenath Ji is depicted in the Govardhandhara posture with his left hand raised supporting Mount Govardhan, right fist resting upon his waist, large compassionate lotus eyes, and the radiant diamond upon his chin. Our sculptors adhere strictly to these revered traditional canons." },
            @{ Q = "Which stone variety is most popular for a family temple?"; A = "Pristine Indian White Marble is highly favored for its luminous purity and smooth touch during darshan. Gwalior Mint Sandstone and Bansi Pink are equally chosen for their organic, warm Rajasthani heritage resonance." },
            @{ Q = "Can additional shringar elements like cows and foliage be included?"; A = "Yes. We frequently carve complete pastoral compositions including Surabhi cows gazing upward in devotion, Kadamba trees, and hovering Yamuna lotuses around the central Govardhandhara form." },
            @{ Q = "How is a custom-sized Shreenath Ji mural ordered from Jaipur?"; A = "Clients provide their wall dimensions or niche elevations. Our design studio produces scaled CAD drawings for approval before stone carving begins at our Jaipur factory, followed by insured crated delivery." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/radhe-krishna-stone-art-mural/"; Title = "Radhe Krishna Mural"; Img = "/assets/images/radhe-krishna-mural.webp" },
            @{ Url = "/stone-art-murals/laxmi-ji-stone-art-mural/"; Title = "Laxmi Ji Mural"; Img = "/assets/images/laxmi-ji-mural.webp" },
            @{ Url = "/stone-art-murals/ram-darbar-stone-art-mural/"; Title = "Ram Darbar Mural"; Img = "/assets/images/ram-darbar-mural.webp" },
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" }
        )
    },
    @{
        Slug = "swaminarayan-ji-stone-art-mural"
        Name = "Swaminarayan Ji Stone Art & Mural"
        TargetDir = "stone-art-murals\swaminarayan-ji-stone-art-mural"
        Title = "Swaminarayan Stone Mural & Mandir Relief | Shree Ram & Co"
        MetaDesc = "Sacred Swaminarayan stone mural hand-carved in sandstone and white marble. Temple-grade bas-relief artwork crafted by Jaipur artisans."
        Primary = "Swaminarayan stone mural"
        Keywords = "Swaminarayan stone mural, Bhagwan Swaminarayan stone carving, Swaminarayan marble relief, Swaminarayan wall art Jaipur, Mandir stone relief panel"
        H1 = "Swaminarayan Stone Mural & Mandir Relief"
        Badge = "Bhagwan Swaminarayan Darshan"
        Lead = "Experience the divine grace, spiritual purity, and serene majesty of Bhagwan Swaminarayan with a sacred stone wall mural, hand-carved in white marble and sandstone by Jaipur master artisans."
        OverviewH2 = "Divine Poise & Temple Artistry Carved in Enduring Natural Stone"
        OverviewP1 = "Bhagwan Swaminarayan is revered for his divine presence, supreme spiritual compassion, and establishment of pure moral dharma. In our bespoke stone wall reliefs, our master sculptors capture Bhagwan Swaminarayan with regal serenity, adorned in the ceremonial royal pagh (turban) with ornamental kalgi crest, the sacred double-strand kanthi around his neck, and his right hand raised in protective Abhaya mudra."
        OverviewP2 = "Sculpted in multi-tiered relief depths of 30mm to 70mm, each panel features intricate temple architectural framing-including delicate Torans, carved Kalash pillars, and lotus petal motifs. Sculpted from pristine Indian white marble or velvety sandstone at our Jaipur factory, these sacred murals form breathtaking centerpieces for private home mandirs, prayer sanctums, and devotional halls."
        Highlights = @(
            "Iconographically disciplined depiction of Bhagwan Swaminarayan in regal ceremonial darshan.",
            "Delicate chisel work on royal pagh (turban), sacred kanthi, and protective Abhaya mudra.",
            "Handcrafted in quarry-selected Indian White Marble and fine-textured sandstone.",
            "Architectural mandir framing with carved Torans, Kalash finials, and floral borders.",
            "Direct factory manufacturing in Jaipur with custom dimensions and insured worldwide shipping."
        )
        Features = @(
            @{ Icon = "fa-crown"; Title = "Sacred Pagh & Kanthi Detailing"; Desc = "Carefully chiseled ceremonial royal turban (pagh), ornamental kalgi crest, and double-strand sacred kanthi." },
            @{ Icon = "fa-hand-back-fist"; Title = "Abhaya Mudra Blessings"; Desc = "Raised right hand offering divine protection, inner peace, and unconditional spiritual shelter to devotees." },
            @{ Icon = "fa-landmark"; Title = "Mandir Shikhara Archway"; Desc = "Intricately carved architectural mandir frame featuring lotus medallions, balusters, and ornate stone cornices." },
            @{ Icon = "fa-spa"; Title = "Delicate Drapery & Robes"; Desc = "Flowing sculpted angavastra and dhoti folds rendered with graceful fluidity and deep textural undercutting." },
            @{ Icon = "fa-sun"; Title = "Tranquil Facial Countenance"; Desc = "Compassionate facial carving radiating sublime spiritual poise, gentle peace, and divine reassurance." },
            @{ Icon = "fa-gem"; Title = "Pure Natural Stone Integrity"; Desc = "Sculpted purely from dense natural sandstone and crystalline marble blocks free from artificial binders." }
        )
        UniqueSection = @{
            Title = "Temple Sanctum Proportions, Marble Grade & Archway Framing"
            Subtitle = "Architectural Guidelines for Swaminarayan Stone Murals"
            Intro = "Selecting the ideal proportion, stone variety, and entryway orientation ensures your Swaminarayan mural becomes an uplifting sanctuary of daily prayer and contemplation."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Home Mandir Central Murti Panel: 3 ft x 4.5 ft (40mm relief depth, monolithic marble plaque)",
                "Foyer Devotional Elevation: 5 ft x 7 ft (50mm relief depth, framed with carved Toran moldings)",
                "Grand Prayer Hall Backdrop: 7 ft x 10 ft (65mm relief depth across precision-jointed modular slabs)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "High-Grade Indian White Marble: Pure crystalline white stone delivering luminous temple darshan and satin finish",
                "Gwalior Mint Sandstone: Warm velvety surface offering organic warmth for contemporary prayer spaces",
                "Bansi Paharpur Pink Sandstone: Traditional stone carrying deep Rajasthan temple carving character"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed Grade-304 stainless steel dry-cladding brackets with structural non-staining adhesive",
                "Central sanctum wall placement in the prayer room facing East or North for serene morning aarti",
                "Even warm 3000K cove lighting washing down over the royal pagh (turban), sacred kanthi, and archway"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Home Mandir & Devotional Sanctum"
                Icon = "fa-om"
                Title = "Central Altar & Mandir Wall"
                P1Title = "Blessed Daily Darshan"
                P1Desc = "Forms the holy centerpiece of the household mandir, inspiring morning prayers, arti, and spiritual reflection."
                P2Title = "Traditional Orientation Advisory"
                P2Desc = "Traditionally recommended on the East or North wall of the prayer room, allowing devotees to face the deity with quiet devotion."
            },
            @{
                Tag = "Devotional Hall & Living Room"
                Icon = "fa-landmark"
                Title = "Prayer Hall & Foyer Feature"
                P1Title = "Dignified Architectural Presence"
                P1Desc = "Enriches family gathering spaces and entryway foyers with an unmistakable aura of sacred peace and cultural beauty."
                P2Title = "Generational Material Longevity"
                P2Desc = "Carved from solid natural stone that endures for decades without fading, warping, or surface degradation."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/swaminarayan-ji-mural.webp"; Title = "Swaminarayan Stone Relief Mural"; Alt = "Swaminarayan stone mural hand-carved in marble and sandstone with royal pagh and kanthi - Shree Ram & Company" },
            @{ Img = "/assets/images/marble-temple.webp"; Title = "Mandir Shikhara Archway Panel"; Alt = "Temple-grade Swaminarayan stone wall relief framed by intricately carved mandir shikhara archway" },
            @{ Img = "/assets/images/stone-temple.webp"; Title = "Architectural Stone Relief Integration"; Alt = "Architectural stone temple relief panel handcrafted by Jaipur artisans for residential sanctum" }
        )
        Faqs = @(
            @{ Q = "What does Bhagwan Swaminarayan's posture represent in this stone mural?"; A = "Bhagwan Swaminarayan is depicted in serene standing or seated posture with his right hand raised in the Abhaya mudra, offering fearlessness, protection, and divine grace. He is adorned in his ceremonial pagh (turban) and sacred kanthi, symbolizing spiritual royalty and purity." },
            @{ Q = "Which stone variety is most recommended for a home mandir mural?"; A = "Pristine Indian White Marble is the most favored material for its immaculate satvik purity, smooth hand-buffed sheen, and ability to capture microscopic chisel details on the royal turban and ornaments. Gwalior Mint Sandstone is equally popular for organic warmth." },
            @{ Q = "Can custom architectural archways (Torans) be carved around the deity?"; A = "Yes. Our Jaipur artisans specialize in framing the central Swaminarayan relief with elaborate carved Torans, Kalash finials, and Shikhara motifs customized to your exact room height." },
            @{ Q = "How are Swaminarayan stone murals packaged for long-distance transit?"; A = "Every panel is carefully inspected and packed in customized timber crates lined with dense polyethylene foam and protective corner armor for fully insured doorstep delivery." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/ram-darbar-stone-art-mural/"; Title = "Ram Darbar Mural"; Img = "/assets/images/ram-darbar-mural.webp" },
            @{ Url = "/stone-art-murals/radhe-krishna-stone-art-mural/"; Title = "Radhe Krishna Mural"; Img = "/assets/images/radhe-krishna-mural.webp" },
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" },
            @{ Url = "/stone-art-murals/laxmi-ji-stone-art-mural/"; Title = "Laxmi Ji Mural"; Img = "/assets/images/laxmi-ji-mural.webp" }
        )
    },
    @{
        Slug = "floral-stone-art"
        Name = "Floral Stone Art"
        TargetDir = "stone-art-murals\floral-stone-art"
        Title = "Flower Mural & Stone Floral Wall Art | Shree Ram & Co"
        MetaDesc = "Handcrafted stone flower mural and botanical relief panels in natural sandstone and marble. Bespoke architectural wall art carved in Jaipur."
        Primary = "flower mural"
        Keywords = "flower mural, floral art, floral mural designs, stone floral wall art, botanical stone relief panel"
        H1 = "Flower Mural & Stone Floral Wall Art"
        Badge = "Architectural Botanical & Lotus Relief Art"
        Lead = "Infuse timeless organic beauty, biophilic elegance, and architectural grace into your interiors with a handcrafted stone flower mural, sculpted in natural Rajasthan sandstone and marble in Jaipur."
        OverviewH2 = "Organic Harmony & Classical Flora Carved in Enduring Stone"
        OverviewP1 = "Inspired by classical Rajasthani palace friezes and timeless botanical patterns, our stone flower murals bring nature's living geometry into luxury architectural spaces. Featuring deeply undercut blooming lotus rosettes, rhythmic acanthus foliage, and delicate bel-buta wall vines, each panel celebrates the organic balance of natural plant life."
        OverviewP2 = "Sculpted in multi-tiered relief depths of 20mm to 55mm, the overlapping petals and contoured leaves create natural light-and-shadow dynamics that shift throughout the day. Handcrafted from fine-grained Dholpur beige sandstone, velvety Gwalior Mint, or Indian white marble at our Jaipur factory, these panels bring understated biophilic elegance to living rooms, dining alcoves, and exterior elevations."
        Highlights = @(
            "Inspired by classical Rajasthani palace carvings and timeless natural botanical motifs.",
            "Multi-depth undercutting on blooming lotus petals, scrolling vines, and acanthus leaves.",
            "Handcrafted in quarry-selected Dholpur beige, Gwalior Mint sandstone, and pure white marble.",
            "Versatile architectural application across interior feature walls, dining niches, and facade borders.",
            "Factory-direct manufacturing in Jaipur with custom modular scaling and insured delivery."
        )
        Features = @(
            @{ Icon = "fa-spa"; Title = "Multi-Layered Lotus Rosettes"; Desc = "Concentric layers of hand-carved lotus petals with gentle outward curvature, capturing nature's perfect symmetry." },
            @{ Icon = "fa-leaf"; Title = "Scrolling Acanthus Vines"; Desc = "Dynamic, rhythmic vine tendrils and leaf clusters sculpted with deep undercuts that cast rich natural shadows." },
            @{ Icon = "fa-border-all"; Title = "Traditional Bel-Buta Borders"; Desc = "Delicate floral banding and perimeter border detailing inspired by historic Rajasthani palace architecture." },
            @{ Icon = "fa-circle-nodes"; Title = "Biophilic Architectural Flow"; Desc = "Brings organic botanical rhythm into geometric modern interiors, promoting relaxation and natural calm." },
            @{ Icon = "fa-layer-group"; Title = "Multi-Plane Chisel Depth"; Desc = "Graduated carving depths from subtle 20mm background textures to prominent 55mm central floral relief." },
            @{ Icon = "fa-gem"; Title = "Solid Natural Stone Longevity"; Desc = "Carved purely from dense, enduring sandstone and marble slabs that age gracefully across decades." }
        )
        UniqueSection = @{
            Title = "Architectural Border Proportions, Stone Selection & Facade Integration"
            Subtitle = "Design & Installation Guidelines for Floral Relief Panels"
            Intro = "Botanical stone murals adapt effortlessly across interior focal walls, dining alcoves, and outdoor facades with custom sizing."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Dining Room Accent Niche: 3 ft x 5 ft (30mm relief depth, single-slab botanical plaque)",
                "Living Room Dado / Wainscot Band: 2 ft x 8 ft (25mm relief depth continuous floral frieze)",
                "Exterior Courtyard Medallion: 6 ft x 6 ft circular or 8 ft x 10 ft rectangular multi-slab composition"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Dholpur Beige Sandstone: Fine-textured stone ideal for intricate acanthus leaf undercutting and smooth borders",
                "Gwalior Mint Sandstone: Soft ivory cream delivering light biophilic warmth to contemporary interiors",
                "Pure Indian White Marble: Refined palace-grade elegance with satin hand-buffed sheen for luxury living rooms"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Flush-mounted dry-cladding anchors or recessed picture-frame niche installation",
                "Versatile placement on living room accent walls, dining niches, staircase landings, and exterior courtyards",
                "Grazing side-light or upper pelmet LED lighting revealing multi-layer petal relief and undercut shadows"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Interior Living & Dining Spaces"
                Icon = "fa-house-chimney"
                Title = "Living Room & Dining Alcove"
                P1Title = "Biophilic Elegance"
                P1Desc = "Enriches dining room niches, living room feature walls, and entryway consoles with understated organic luxury."
                P2Title = "Warm Ambient Illumination"
                P2Desc = "Pairs beautifully with warm grazing downlights that accentuate the layered petals and scrolling vine contours."
            },
            @{
                Tag = "Exterior Facade & Garden Courtyard"
                Icon = "fa-tree"
                Title = "Exterior Elevation & Garden Courtyard"
                P1Title = "Weatherproof Outdoor Art"
                P1Desc = "Natural sandstone withstands exterior sun and rain gracefully, serving as an enduring focal point for garden courtyards."
                P2Title = "Seamless Architectural Friezes"
                P2Desc = "Can be carved in repeating modular tiles to create continuous exterior wainscoting and classical wall borders."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/floral-stone-art.webp"; Title = "Botanical Sandstone Floral Mural"; Alt = "Stone flower mural with hand-chiseled lotus rosettes and botanical acanthus relief - Shree Ram & Company" },
            @{ Img = "/assets/images/hero-peacock-carving.webp"; Title = "Traditional Rajasthani Floral Border"; Alt = "Traditional Rajasthani floral bel-buta wall border carving in natural beige sandstone" },
            @{ Img = "/assets/images/staircase-mandala-radial-carving.webp"; Title = "Radial Floral Mandala Panel"; Alt = "Radial floral mandala stone carving panel for luxury interior feature wall" }
        )
        Faqs = @(
            @{ Q = "What floral motifs are most popular for stone wall murals?"; A = "Blooming lotus rosettes, scrolling acanthus vines, and traditional Rajasthani bel-buta borders are the most requested. We also create customized botanical compositions featuring champa, jasmine, and stylized Mughal floral motifs." },
            @{ Q = "Which stone variety is most recommended for a flower mural?"; A = "Dholpur Beige and Gwalior Mint Sandstone are ideal for their fine grain, allowing intricate chisel undercutting on thin petal edges. Indian White Marble provides a luminous, refined finish for formal interior spaces." },
            @{ Q = "Can floral stone panels be used as repeating wall cladding borders?"; A = "Yes. We design and carve modular repeating panels that align seamlessly edge-to-edge, creating continuous floral dado borders, staircase stringers, and ceiling friezes." },
            @{ Q = "How are delicate carved floral petals protected during shipping?"; A = "Every panel is packed in custom timber crates lined with thick closed-cell foam and wrapped in moisture-barrier film to ensure protruding petals and undercut leaves arrive in pristine condition." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/village-stone-art-mural/"; Title = "Village Stone Art"; Img = "/assets/images/village-stone-art.webp" },
            @{ Url = "/stone-art-murals/buddha-stone-art-mural/"; Title = "Buddha Stone Art"; Img = "/assets/images/statue.webp" },
            @{ Url = "/stone-art-murals/radhe-krishna-stone-art-mural/"; Title = "Radhe Krishna Mural"; Img = "/assets/images/radhe-krishna-mural.webp" },
            @{ Url = "/stone-art-murals/laxmi-ji-stone-art-mural/"; Title = "Laxmi Ji Mural"; Img = "/assets/images/laxmi-ji-mural.webp" }
        )
    },
    @{
        Slug = "village-stone-art-mural"
        Name = "Village Stone Art & Mural"
        TargetDir = "stone-art-murals\village-stone-art-mural"
        Title = "Village Stone Mural & Rural Folk Wall Art | Shree Ram & Co"
        MetaDesc = "Traditional village stone mural capturing rural Indian heritage. Hand-chiseled sandstone wall reliefs by Jaipur sculptors with custom sizes."
        Primary = "village stone mural"
        Keywords = "village stone mural, Indian village wall art, rural stone relief panel, Rajasthani folk wall carving, traditional stone mural Jaipur"
        H1 = "Village Stone Mural & Rural Folk Wall Art"
        Badge = "Rustic Heritage & Pastoral Folk Relief"
        Lead = "Celebrate the warm soul, timeless community, and rural heritage of traditional India with a handcrafted village stone mural, sculpted in natural Rajasthan sandstone by master artisans in Jaipur."
        OverviewH2 = "Pastoral Heritage & Communal Warmth Carved in Enduring Stone"
        OverviewP1 = "Capturing the idyllic charm and communal vitality of rural Rajasthan, our village stone murals depict pastoral everyday life: women carrying water pots (Panihari) from village wells, shepherds tending grazing livestock, elders gathered beneath the spreading shade of a banyan tree, and village musicians playing folk instruments."
        OverviewP2 = "Sculpted in multi-tiered narrative relief depths of 25mm to 65mm, each scene captures rich folkloric details: the woven textures of charpais, carved earthen pots, flowing rustic textiles, and gentle facial camaraderie. Sculpted from warm Bansi Paharpur sandstone or Dholpur beige stone at our Jaipur factory, these cultural murals become captivating conversation centerpieces in luxury heritage homes, farmhouses, ethnic restaurants, and boutique resorts."
        Highlights = @(
            "Rich narrative storytelling depicting traditional rural Indian life, Panihari well scenes, and folk musicians.",
            "Dynamic figurative sculpture capturing candid human expressions, rustic drapery, and village architecture.",
            "Handcrafted in warm, character-rich Bansi Paharpur pink sandstone and Dholpur beige stone.",
            "Deep multi-plane relief carving creating extraordinary lifelike perspective and pastoral depth.",
            "Factory-direct manufacturing in Jaipur with custom narrative scaling and insured shipping."
        )
        Features = @(
            @{ Icon = "fa-people-group"; Title = "Pastoral Figurative Narratives"; Desc = "Expressive sculpting capturing candid village gatherings, musicians, and traditional rural crafts." },
            @{ Icon = "fa-jar"; Title = "Panihari Water Well Scenes"; Desc = "Graceful depictions of rural women carrying stacked matkas from village stepwells, symbolizing life and bounty." },
            @{ Icon = "fa-tree"; Title = "Spreading Banyan & Village Flora"; Desc = "Detailed micro-relief carving of village banyan trees, thatched huts, and cattle resting in cool shade." },
            @{ Icon = "fa-guitar"; Title = "Folk Musicians & Instruments"; Desc = "Carefully rendered kamaycha, dholak, and flute players bringing dynamic musical cadence to the stone relief." },
            @{ Icon = "fa-layer-group"; Title = "Deep Multi-Plane Perspective"; Desc = "Graduated carving depths that establish a realistic foreground, middle ground, and distant village horizon." },
            @{ Icon = "fa-gem"; Title = "Dense Sandstone Authenticity"; Desc = "Carved purely from natural sandstone blocks that showcase organic sedimentary grain and earthy warmth." }
        )
        UniqueSection = @{
            Title = "Narrative Wall Proportions, Sandstone Selection & Rustic Interior Styling"
            Subtitle = "Architectural Guidelines for Village Folk Murals"
            Intro = "Narrative folk murals bring cultural warmth and storytelling into spacious heritage homes, farmhouses, and boutique resorts."
            Col1Title = "Curated Size Configurations"
            Col1Items = @(
                "Foyer Heritage Plaque: 4 ft x 6 ft (35mm relief depth, single-slab village narrative)",
                "Farmhouse Living Room Feature: 6 ft x 9 ft (50mm relief depth, expansive pastoral scene)",
                "Grand Resort Atrium / Double-Height Wall: 8 ft x 14 ft (65mm relief depth multi-slab panoramic composition)"
            )
            Col2Title = "Recommended Stone Selections"
            Col2Items = @(
                "Bansi Paharpur Pink Sandstone: Earthy rustic warmth capturing the terracotta tones of rural Rajasthan village life",
                "Dholpur Beige Sandstone: Fine-grain definition delivering clean chisel fidelity on human figures and woven textiles",
                "Agra Red Sandstone: Bold terra-cotta strength creating dramatic contrast against neutral lime-plastered walls"
            )
            Col3Title = "Mounting & Lighting Protocol"
            Col3Items = @(
                "Concealed Grade-304 stainless steel dry-cladding brackets with precision-jointed modular seams",
                "Ideal on wide accent walls in living rooms, double-height staircases, farmhouses, and hospitality lounges",
                "Warm 2700K spotlighting sweeping across the village musicians, earthen pots, and shade trees to produce dramatic textural depth"
            )
        }
        PlaceCards = @(
            @{
                Tag = "Heritage Homes & Farmhouses"
                Icon = "fa-house-chimney-window"
                Title = "Farmhouse & Heritage Living Space"
                P1Title = "Warm Cultural Focal Point"
                P1Desc = "Infuses expansive living areas and double-height staircases with nostalgic warmth, celebrating the timeless dignity of rural life."
                P2Title = "Rich Architectural Conversation Piece"
                P2Desc = "Invites guests into engaging conversation as they discover micro-relief details of village artisans and musicians."
            },
            @{
                Tag = "Boutique Hospitality & Resorts"
                Icon = "fa-hotel"
                Title = "Heritage Resort & Ethnic Dining"
                P1Title = "Authentic Rajasthani Ambience"
                P1Desc = "Captivates domestic and international travelers with traditional Rajasthani cultural heritage right at reception and dining halls."
                P2Title = "Rugged Natural Durability"
                P2Desc = "Endures heavy commercial foot traffic and environmental exposure without requiring delicate maintenance."
            }
        )
        Gallery = @(
            @{ Img = "/assets/images/village-stone-art.webp"; Title = "Pastoral Village Sandstone Mural"; Alt = "Village stone mural capturing Rajasthani rural folk heritage and panihari well scenes - Shree Ram & Company" },
            @{ Img = "/assets/images/jaipur-artisan.jpg"; Title = "Artisan Carving Figurative Details"; Alt = "Jaipur sculptor hand-chiseling figurative details of pastoral Indian village life on sandstone" },
            @{ Img = "/assets/images/stone-carving.jpg"; Title = "Multi-Layered Deep Relief Detailing"; Alt = "Multi-layered deep relief stone carving depicting traditional banyan tree and village musicians" }
        )
        Faqs = @(
            @{ Q = "What scenes are most commonly depicted in a village stone mural?"; A = "Traditional compositions feature Panihari women carrying earthen pots from village wells, shepherds with flocks under banyan trees, village elders in panchayat discussions, and folk musicians playing the dholak and kamaycha." },
            @{ Q = "Which stone variety best captures rural folk themes?"; A = "Bansi Paharpur Pink Sandstone and Dholpur Beige Sandstone are the preferred materials. Their earthy, warm tones evoke the traditional mud and lime architecture of rural Rajasthan." },
            @{ Q = "Can specific custom scenes or family village memories be sculpted?"; A = "Yes. Our sculptors can interpret historical photographs, sketches, or custom thematic descriptions to create bespoke narrative relief panels tailored to your family's heritage." },
            @{ Q = "How are panoramic multi-slab village murals joined on site?"; A = "Large horizontal murals are sculpted in modular interlocking stone slabs with concealed stainless steel anchor slots. On site, panels are dry-clad with hair-thin joints that preserve the panoramic continuity." }
        )
        Related = @(
            @{ Url = "/stone-art-murals/floral-stone-art/"; Title = "Floral Stone Art"; Img = "/assets/images/floral-stone-art.webp" },
            @{ Url = "/stone-art-murals/radhe-krishna-stone-art-mural/"; Title = "Radhe Krishna Mural"; Img = "/assets/images/radhe-krishna-mural.webp" },
            @{ Url = "/stone-art-murals/buddha-stone-art-mural/"; Title = "Buddha Stone Art"; Img = "/assets/images/statue.webp" },
            @{ Url = "/stone-art-murals/ganesh-ji-stone-art-mural/"; Title = "Ganesh Ji Mural"; Img = "/assets/images/ganesh-ji-mural.webp" }
        )
    }
)

# Save the structured data to JSON
$jsonPath = Join-Path $PSScriptRoot "batch2b_data.json"
$jsonContent = $pages | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($jsonPath, $jsonContent, [System.Text.Encoding]::UTF8)
Write-Host "Updated batch2b_data.json with $($pages.Count) pages"

# Now generate the HTML files
foreach ($p in $pages) {
    $slug = $p.Slug
    $targetDir = Join-Path $rootDir $p.TargetDir
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
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal mb-4">Sculptural Highlights & Technical Detailing</h2>
                <div class="w-16 h-0.5 bg-luxury-gold mx-auto mb-6"></div>
                <p class="text-gray-600 text-sm md:text-base font-light leading-relaxed">Every mural undergoes multi-stage CNC rough profiling followed by meticulous hand-undercutting by generational Jaipur stone carvers.</p>
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
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal mb-4">Placement Environments & Sacred Sanctums</h2>
                <div class="w-16 h-0.5 bg-luxury-gold mx-auto mb-6"></div>
                <p class="text-gray-600 text-sm md:text-base font-light leading-relaxed">Whether commissioned for a private prayer altar or an expansive double-height foyer, our stone reliefs adapt harmoniously to distinct architectural contexts.</p>
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
                    <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal font-normal">Real Project Compositions & Carvings</h2>
                </div>
                <p class="text-gray-500 text-xs sm:text-sm font-light max-w-md">Authentic reliefs documented in production and post-installation across private residences, mandirs, and luxury estates.</p>
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
            <h2 class="font-serif text-3xl md:text-4xl mb-4 font-normal">Commission a Custom Stone Mural</h2>
            <p class="text-gray-400 text-sm md:text-base font-light mb-8 max-w-xl mx-auto">Discuss your sanctum or feature wall dimensions with our master sculptors in Jaipur for custom 3D drafts and quote factors.</p>
            <div class="flex flex-wrap justify-center gap-4">
                <a href="/get-a-quote/" class="inline-flex items-center justify-center px-8 py-3.5 bg-luxury-gold hover:bg-[#b58f5c] text-white text-xs uppercase tracking-widest font-semibold transition-all duration-300 shadow-luxury rounded-sm">
                    Request Project Quote
                </a>
                <a href="https://wa.me/916367607459?text=Hello%20Shree%20Ram%20%26%20Company,%20I%20am%20inquiring%20about%20$($p.Name)" target="_blank" rel="noopener noreferrer" class="inline-flex items-center justify-center px-8 py-3.5 border border-white/30 hover:border-white text-white text-xs uppercase tracking-widest font-light transition-all duration-300 rounded-sm">
                    <i class="fa-brands fa-whatsapp text-green-400 mr-2 text-sm"></i> WhatsApp Us
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
    Write-Host "Generated perfect HTML for $($p.Slug) -> $targetFile"
}

Write-Host "Batch 2b HTML generation completed successfully."
