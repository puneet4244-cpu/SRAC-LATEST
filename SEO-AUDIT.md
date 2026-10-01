# Comprehensive SEO, AEO & GEO Audit Report
**Website:** [Shree Ram & Company (Vijeta Stone)](https://www.shreeramandcompany.com/)  
**Audit Date:** October 2026  
**Auditor:** Senior SEO, AEO & GEO Engineering Team  
**Methodology:** Grounded in Google Search Central Documentation, Google AI Optimization Guide (May 2026), and Claude SEO Playbook.

---

## Executive Summary & Scorecard

| Area | Score (0–100) | Status | Primary Focus |
| :--- | :---: | :---: | :--- |
| **A. Technical SEO** | **78 / 100** | ⚠️ Needs Fixes | Custom 404, server redirects (vercel.json), robots meta tags, Tailwind CDN |
| **B. Image Optimization** | **68 / 100** | ⚠️ High Impact | 645 missing width/height attributes (CLS), WebP migration, image sitemap |
| **C. On-Page & Content** | **72 / 100** | ⚠️ Moderate | De-boilerplate category pages, buyer-intent commercial titles, pricing guide |
| **D. Schema & Structured Data** | **65 / 100** | ⚠️ High Impact | Deprecated FAQPage cleanup, @id entity graph, CollectionPage & ItemList |
| **E. Local SEO (Jaipur / India)** | **75 / 100** | 🟡 Solid | Complete LocalBusiness schema (geo, openingHours, areaServed), GBP strategy |
| **F. E-E-A-T Quality Signals** | **66 / 100** | ⚠️ Moderate | Replace Unsplash stock with workshop photos, add founder/artisan bio |
| **G. Answer Engine Optimization (AEO)** | **62 / 100** | ⚠️ High Impact | 130–170 word self-contained answer blocks with technical units & costs |
| **H. GEO / AI-Search Readiness** | **70 / 100** | 🟡 Solid | Explicit AI crawler allowlist, clean sameAs URLs, authority directory citations |
| **OVERALL SEO HEALTH SCORE** | **72 / 100** | 🟡 Good Base | Substantial organic growth potential via technical & schema fixes |

---

## Detailed Findings by Area (A through H)

### A. Technical SEO (Score: 78/100)

#### [Critical] A-1: Missing Custom 404 Error Page (`404.html`)
* **File Path:** `/404.html` (Missing)
* **Why it Matters:** When crawlers or users hit a broken link or outdated URL, Vercel/Cloudflare displays an unbranded default error page. A custom branded 404 page preserves crawl budget, retains bounce traffic, and directs visitors back to core product categories.
* **Exact Fix:** Create `/404.html` maintaining the luxury design system with links to the 5 primary verticals (Wall Surfaces, Exterior Elevation, Temples, Home Decor, CNC Jali) and contact CTAs.
* **How to Verify:** Request a non-existent path like `https://www.shreeramandcompany.com/random-url-test` in browser and confirm branded 404 page renders with HTTP 404 status.

#### [Critical] A-2: 42 Client-Side Redirect Stubs (`meta http-equiv="refresh"`) Instead of Server-Side 301 Redirects
* **File Path:** 42 files across `/stone-art-murals/*/index.html`, `/stone-wall-panels/*/index.html`, and `/mdf-hdmr-work/*/index.html`
* **Why it Matters:** Client-side HTML refresh redirects (`meta http-equiv="refresh" content="0; url=..."`) are slow, waste crawl budget, and delay or dilute PageRank pass-through compared to permanent HTTP 301 redirects.
* **Exact Fix:** Add a `vercel.json` file defining server-level `redirects` with status `301`, or native Cloudflare `_redirects`. Clean URLs should redirect permanently at the CDN edge.
* **How to Verify:** Test headers using `curl -I https://www.shreeramandcompany.com/stone-art-murals/buddha/` and confirm `HTTP/2 301` with `Location` header.

#### [High] A-3: Missing Robots Meta Tag on All Content Pages
* **File Path:** All 38 content HTML pages (`/index.html`, `/about-us/index.html`, category pages)
* **Why it Matters:** Without explicit directives, Google defaults to standard indexing, but misses `max-image-preview:large`, which is required for high-resolution visual previews in Google Discover and Google Image Search.
* **Exact Fix:** Add `<meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">` in `<head>` of all 38 pages.
* **How to Verify:** Inspect page source on any page and verify presence of robots tag.

#### [High] A-4: Tailwind Play CDN Loaded at Runtime in Production
* **File Path:** `<head>` of `index.html` and other pages (`<script src="https://cdn.tailwindcss.com"></script>`)
* **Why it Matters:** The Tailwind CDN script downloads a ~3MB browser compiler that parses utility classes dynamically on the client, degrading First Contentful Paint (FCP) and Largest Contentful Paint (LCP).
* **Exact Fix:** In production, use compiled CSS or preload critical styles. For static sites, add preconnect and defer non-critical scripts.
* **How to Verify:** Run Google PageSpeed Insights; audit Total Blocking Time (TBT) and First Contentful Paint.

#### [Medium] A-5: Truncated Titles (> 65 Chars) & Duplicate Titles
* **File Path:** `index.html` (66 chars), `about-us/index.html` (66 chars), `murals-wall-art/index.html` vs `stone-art-murals/index.html`
* **Why it Matters:** Google SERP title displays truncate at ~60-65 characters (or 600px width). Duplicate titles on `murals-wall-art` and `stone-art-murals` cause keyword cannibalization.
* **Exact Fix:** Shorten and differentiate titles. Add distinct high-intent focus for each:
  - `index.html`: `Shree Ram & Company | Luxury Stone Carving & Temples Jaipur` (58 chars)
  - `about-us/index.html`: `About Us | 40-Year Stone Carving Legacy - Shree Ram & Co` (56 chars)
  - `murals-wall-art/index.html`: `Murals & Wall Art Manufacturer Jaipur | Shree Ram & Co` (53 chars)
  - `stone-art-murals/index.html`: `Stone Art Murals & Relief Panels Jaipur | Shree Ram & Co` (55 chars)
* **How to Verify:** Run SERP preview simulator or length validator script to confirm title pixel width < 600px.

#### [Medium] A-6: Meta Descriptions Exceeding 160 Characters
* **File Path:** `about-us/index.html` (174), `contact/index.html` (161), `get-a-quote/index.html` (163), `privacy-policy/index.html` (173), `stone-carving/index.html` (180), `terms-of-service/index.html` (163)
* **Why it Matters:** Meta descriptions exceeding 155-160 characters get cut off with ellipses `...` in search snippets, reducing CTR.
* **Exact Fix:** Rewrite each to 140–155 characters featuring clear buyer intent and phone CTA.
* **How to Verify:** Verify length in `audit_results_all.csv` remains strictly between 130 and 155 characters.

---

### B. Image Optimization (Score: 68/100)

#### [Critical] B-1: 645 Images Missing Explicit `width` and `height` Attributes (CLS Risk)
* **File Path:** 645 `<img>` tags across all 38 content pages
* **Why it Matters:** Browsers calculate layout before image assets finish loading. Missing intrinsic width and height causes Cumulative Layout Shift (CLS), a direct Google Core Web Vitals ranking signal.
* **Exact Fix:** Inject intrinsic `width` and `height` attributes matching the native asset aspect ratio (e.g. `width="800" height="600"` or `width="600" height="800"` for vertical carvings) along with CSS `aspect-ratio` or `object-cover`.
* **How to Verify:** Run Lighthouse Core Web Vitals audit; CLS must be 0.00.

#### [High] B-2: HTML Pages Still Referencing Legacy JPG Instead of WebP
* **File Path:** Image references across all category cards (e.g. `statement-wall.jpg`, `elevation-facade.jpg`)
* **Why it Matters:** Modern `.webp` versions exist in `assets/images/` and are 40-70% lighter than JPG counterparts. Serving JPG needlessly consumes mobile bandwidth and slows LCP.
* **Exact Fix:** Update image tags to serve `.webp` as the default source or wrap in `<picture><source srcset="...webp" type="image/webp"><img src="...jpg" ...></picture>`.
* **How to Verify:** Check network tab in Chrome DevTools to ensure served format is `image/webp`.

#### [High] B-3: Missing Dedicated Image XML Sitemap
* **File Path:** `/sitemap.xml`
* **Why it Matters:** Google Image Search is a top discovery channel for interior designers, architects, and temple committees. Standard XML sitemaps without Google Image extension tags (`<image:image>`, `<image:loc>`) miss indexing thousands of image queries.
* **Exact Fix:** Add Google Image extension markup to `sitemap.xml` or create `sitemap-images.xml` indexing all high-res product carvings.
* **How to Verify:** Validate sitemap in Google Search Console Sitemaps tool; confirm image count appears under indexed entities.

#### [Medium] B-4: External Unsplash Stock Image Dependencies
* **File Path:** `index.html` and `about-us/index.html`
* **Why it Matters:** External third-party images introduce extra DNS lookup latencies and present trust/authenticity issues for a master carving studio.
* **Exact Fix:** Replace external Unsplash URLs with local brand workshop photography from `assets/images/`.
* **How to Verify:** Confirm zero external image URLs in page sources.

---

### C. On-Page & Content (Score: 72/100)

#### [High] C-1: Templated Boilerplate Across 18 Category Pages
* **File Path:** All 18 category pages generated via `master_page_builder.ps1`
* **Why it Matters:** Sections like "40 Years of Stone Carving Excellence", "Quarry Direct Sourcing", and "Material Performance Comparison" are copied verbatim across 18 pages. Google's Helpful Content System penalizes repetitive site-wide boilerplate.
* **Exact Fix:** Rewrite each category's introduction and material guide with specific nuances (e.g. Bansi Paharpur sandstone suitability for outdoor temple weather resistance vs Makrana marble for indoor pooja rooms; structural weight and anchoring for gazebos vs lightweight CNC screens).
* **How to Verify:** Check textual similarity score across category pages; ensure unique content ratio exceeds 70%.

#### [High] C-2: Missing Commercial Intent Modifiers in Titles & H1s
* **File Path:** Category HTML pages
* **Why it Matters:** High-value customers search for "manufacturer", "supplier", "exporter", "custom mandir manufacturer Jaipur", not just generic category names.
* **Exact Fix:** Integrate commercial modifiers naturally:
  - `marble-temple`: `Marble Temple Manufacturer Jaipur | Custom Mandir - Shree Ram & Co`
  - `stone-wall-panels`: `Stone Wall Panels Manufacturer Jaipur | 3D CNC Wall Art`
  - `stone-carving`: `Stone Carving Manufacturer in Jaipur | Handcrafted Relief Work`
* **How to Verify:** Verify SERP presence for B2B/B2C manufacturer queries.

#### [Medium] C-3: Thin Content on Essential Brand Pages
* **File Path:** `about-us/index.html` (387 words), `articles/index.html` (307 words)
* **Why it Matters:** The About page is the cornerstone of E-E-A-T evaluation. 387 words is insufficient to demonstrate 40 years of architectural history, quarry relationships, workshop capabilities, and artisan lineages.
* **Exact Fix:** Expand `/about-us/` to 800+ words covering the founding story, workshop location, artisan techniques, stone selection criteria, quality inspection stages, and worldwide export packaging.
* **How to Verify:** Re-run word count audit; verify word count > 800.

---

### D. Schema & Structured Data (Score: 65/100)

#### [Critical] D-1: Deprecated `FAQPage` Schema Markup Present on 31 Pages
* **File Path:** 31 category pages
* **Why it Matters:** Google retired `FAQPage` rich results for all commercial websites on May 7, 2026. While not penalized, relying on FAQPage for SERP rich snippets is obsolete.
* **Exact Fix:** Retain the visible FAQs for user experience and AEO citation, but transition the structured data focus to `CollectionPage`, `ItemList`, and `BreadcrumbList`.
* **How to Verify:** Test via Google Rich Results Test; confirm no deprecated schema warnings.

#### [High] D-2: Entity Pollution & Missing `@id` Graph Cross-Referencing
* **File Path:** All category pages
* **Why it Matters:** Each category page currently defines an isolated `LocalBusiness` object with generic properties. In Knowledge Graph SEO, an organization should have a single authoritative `@id` (e.g. `https://www.shreeramandcompany.com/#organization` or `https://www.shreeramandcompany.com/#localbusiness`), and all child pages should cross-reference this ID rather than creating disconnected duplicate entities.
* **Exact Fix:** Structure JSON-LD with `@graph`:
  - Define master `LocalBusiness` / `HomeAndConstructionBusiness` on homepage and contact page with `@id: "https://www.shreeramandcompany.com/#localbusiness"`.
  - On category pages, declare `CollectionPage` with `publisher: { "@id": "https://www.shreeramandcompany.com/#localbusiness" }`.
* **How to Verify:** Validate via Schema.org validator; confirm graph nodes resolve to a single unified business entity.

#### [High] D-3: Category Pages Missing `CollectionPage` and `ItemList` Schema
* **File Path:** Category pages (`arch-mehrab`, `gazebo`, `temple`, etc.)
* **Why it Matters:** Category pages are catalog collections. `CollectionPage` with an `ItemList` array specifying product names, image URLs, and descriptions helps search engines understand the exact catalog taxonomy.
* **Exact Fix:** Inject `CollectionPage` schema with an `ItemList` linking to visible product showcase items.
* **How to Verify:** Schema validator shows `CollectionPage` with `hasPart` or `mainEntity: { "@type": "ItemList" }`.

#### [Medium] D-4: Category Root Pages Missing `BreadcrumbList` Schema
* **File Path:** `arch-mehrab/index.html`, `gazebo/index.html`, `stone-jali/index.html`, etc.
* **Why it Matters:** Breadcrumbs enhance search result snippets with navigational trails (`shreeramandcompany.com > CNC Jali > Stone Jali`).
* **Exact Fix:** Add `BreadcrumbList` schema to all category pages:
  - Item 1: Home (`https://www.shreeramandcompany.com/`)
  - Item 2: Category (`https://www.shreeramandcompany.com/category-slug/`)
* **How to Verify:** Verify breadcrumb trail rendering in Google Rich Results Test.

---

### E. Local SEO (Score: 75/100)

#### [High] E-1: Missing Geo Coordinates & Opening Hours in LocalBusiness Schema
* **File Path:** Schema blocks on `index.html` and `contact/index.html`
* **Why it Matters:** Proximity and operational hours represent 55%+ of local pack ranking variance. Omitting `geo` coordinates and `openingHoursSpecification` weakens Google Maps local entity anchoring.
* **Exact Fix:** Add:
  - `"geo": { "@type": "GeoCoordinates", "latitude": 26.8838, "longitude": 75.7645 }` (matching Govindpuri Metro Pillar 76, Jaipur).
  - `"openingHoursSpecification"`: Mon–Sat 09:00–20:00, Sun 10:00–18:00.
  - `"priceRange"`: `"₹₹₹"`
  - `"areaServed"`: `["Jaipur", "Rajasthan", "Delhi NCR", "Mumbai", "India", "Worldwide"]`
* **How to Verify:** Validate LocalBusiness schema in Rich Results Test; verify geo coordinates and hours display correctly.

#### [Medium] E-2: Lack of Review Schema & Structured Testimonials
* **File Path:** `index.html`
* **Why it Matters:** Real customer reviews drive high local conversion. While self-serving `AggregateRating` without real data must be avoided, customer reviews can be presented with author names and cities.
* **Exact Fix:** Integrate real Google Business Profile customer testimonials with city/project citations (e.g. "Pooja Mandir in Mansarovar, Jaipur", "Sandstone Elevation in Delhi").
* **How to Verify:** Confirm verified client testimonials appear with location tags.

---

### F. E-E-A-T Quality Signals (Score: 66/100)

#### [High] F-1: Stock Photography Diluting Authentic Jaipur Craftsmanship
* **File Path:** `about-us/index.html`
* **Why it Matters:** Google's Quality Rater Guidelines (QRG) specifically reward "first-hand experience" and penalize sites claiming artisan heritage while showing generic Unsplash stock photos.
* **Exact Fix:** Replace stock photos with genuine images of the workshop, artisans hand-chiseling sandstone, CNC machine operations, and completed installation sites.
* **How to Verify:** Ensure all images on `/about-us/` are hosted locally in `/assets/images/` and show actual workshop projects.

#### [Medium] F-2: Missing Named Founder / Master Artisan Bylines
* **File Path:** `about-us/index.html`
* **Why it Matters:** Google's "Who created it" heuristic favors clear human leadership, craftsman lineage, and master artisan credentials over anonymous corporate text.
* **Exact Fix:** Add a dedicated "Master Artisans & Leadership" section highlighting the founder, workshop director, and head sculptors with their years of craft experience.
* **How to Verify:** Check `/about-us/` text for explicit artisan and leadership attributions.

---

### G. Answer Engine Optimization (AEO) (Score: 62/100)

#### [High] G-1: FAQ Answers Too Brief for AI Overview Citations
* **File Path:** FAQ sections across category pages
* **Why it Matters:** AI engines (Google AI Overviews, Perplexity, ChatGPT Search) favor self-contained answer blocks of 130–170 words that provide complete, standalone explanations with direct answers in the first 40–60 words. Existing answers are 30–40 words and too brief to be quoted as authoritative reference passages.
* **Exact Fix:** Rewrite high-value questions into 130–170 word answer blocks with concrete facts, stone grades (Bansi Paharpur Pink, Gwalior Mint, Makrana Marble), compressive strengths, cost benchmarks (₹/sq ft), and maintenance protocols.
* **How to Verify:** Run word count and readability check on answer blocks; ensure 130–170 words with direct answer upfront.

#### [High] G-2: Missing Core High-Intent Buyer Comparison Questions
* **File Path:** Key category pages
* **Why it Matters:** High-converting buyers search for comparisons before purchasing:
  - "Pink Sandstone vs Marble for outdoor temple in North India climate"
  - "What is the cost of hand-carved stone wall panels per square foot in Jaipur?"
  - "How to install heavy stone wall panels on brick or RCC walls?"
  - "Vastu rules for home pooja room temple direction and idol placement"
* **Exact Fix:** Add dedicated question-style `<h2>` / `<h3>` sections addressing these exact comparison queries.
* **How to Verify:** Search queries in Perplexity/Gemini to test whether passages from the site are extracted.

---

### H. GEO / AI-Search Readiness (Score: 70/100)

#### [High] H-1: `robots.txt` Lacks Explicit Declarations for AI Search Crawlers
* **File Path:** `/robots.txt`
* **Why it Matters:** While `User-agent: *` allows all crawlers by default, explicit declarations for AI search engines ensure CDN firewalls (Cloudflare/Vercel) do not flag them as aggressive scrapers.
* **Exact Fix:** Explicitly allow search and citation crawlers:
  ```robots.txt
  User-agent: Googlebot
  Allow: /

  User-agent: OAI-SearchBot
  Allow: /

  User-agent: PerplexityBot
  Allow: /

  User-agent: Claude-SearchBot
  Allow: /

  User-agent: Applebot
  Allow: /

  User-agent: *
  Allow: /

  Sitemap: https://www.shreeramandcompany.com/sitemap.xml
  ```
* **How to Verify:** Test robots.txt using Google Search Console robots tester or curl.

#### [Medium] H-2: Tracking Parameters in Schema `sameAs` Links
* **File Path:** Schema blocks on `index.html` and other pages
* **Why it Matters:** URLs like `instagram.com/shreeramandcompanyvijetastone?igshid=MzNlNGNkZWQ4Mg==` and `youtube.com/@shreeramandcompanyvijetastone?si=3ogOT-0k8mtIOBn9` contain transient session parameters that confuse entity resolution models across Wikidata, Wikipedia, and Google Knowledge Graph.
* **Exact Fix:** Clean `sameAs` URLs to their canonical base form:
  - `https://www.facebook.com/profile.php?id=61560293691544`
  - `https://www.instagram.com/shreeramandcompanyvijetastone/`
  - `https://www.youtube.com/@shreeramandcompanyvijetastone`
* **How to Verify:** Inspect schema JSON-LD; confirm zero query parameters in `sameAs` links.

---

## Prioritized Implementation Action Plan

### 🔴 Critical Priority (Must Fix First)
1. **[A-1] Create branded `/404.html`** error page.
2. **[A-2] Create `vercel.json`** with server-side 301 redirects, security headers, clean URLs, and static asset caching.
3. **[B-1] Inject explicit `width` and `height`** on all 645 `<img>` tags to eliminate CLS layout shift.
4. **[D-1] Update schema architecture**: de-emphasize retired `FAQPage`, implement `@id` entity cross-referencing, and add `CollectionPage` + `ItemList` to category pages.

### 🟠 High Priority (Rank & Visibility Drivers)
5. **[A-3] Add robots meta tags** (`max-image-preview:large`) across all 38 content pages.
6. **[B-2] Migrate image links** to modern `.webp` format across all product cards.
7. **[B-3] Create Image XML Sitemap** indexing all luxury stone carvings for Google Image Search.
8. **[C-1 & C-2] Optimize category titles and H1s** with commercial buyer-intent modifiers ("Manufacturer Jaipur", "Supplier", "Custom Mandirs").
9. **[E-1] Complete LocalBusiness Schema** with precise GPS coordinates, opening hours, price range, and service areas.
10. **[G-1 & G-2] Implement AEO answer blocks** (130–170 words) for high-intent customer questions.
11. **[H-1] Update `robots.txt`** with explicit AI search crawler allowances.

### 🟡 Medium Priority (Quality & E-E-A-T Polish)
12. **[A-5 & A-6] Fix truncated titles and meta descriptions** (>65 chars / >160 chars).
13. **[C-3 & F-1] Enhance `/about-us/`** with authentic workshop photography and 800+ words of heritage content.
14. **[D-4] Add `BreadcrumbList` schema** across all category root pages.
15. **[H-2] Clean tracking parameters** from all social `sameAs` schema URLs.

---

## Verification & Testing Checklist
- [ ] **Google Rich Results Test:** Verify zero syntax errors and validate `LocalBusiness`, `BreadcrumbList`, and `CollectionPage`.
- [ ] **Google PageSpeed Insights:** Verify CLS = 0.00 and Mobile Performance score > 90.
- [ ] **Sitemap Validation:** Confirm valid XML without redirects, 404s, or orphan URLs.
- [ ] **HTTP Response Codes:** Verify server-level 301 redirect responses via `curl -I`.
