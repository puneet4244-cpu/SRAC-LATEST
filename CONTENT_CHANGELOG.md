# CONTENT_CHANGELOG.md — SEO Content & Blog Changelog
Website: https://shreeramandcompany.com
Branch: `content-seo`

---

## [Phase 0: Discovery & Setup] — 2026-10-06
- **Branch created:** `content-seo`.
- **Site Audit:** Cataloged all 81 HTML files (39 full pages, 42 redirect stubs). Exported to `tools/phase0_page_inventory.csv`.
- **Domain Verification:** Confirmed 0 references to legacy/external domain `vijetastone.com` across all site files.
- **Business Directives Established:**
  - Model set to Direct **Manufacturer** in Jaipur.
  - Confirmed: **Manufacturer of stone & marble moldings**; **no mosaics**. Blog #39 (*Marble Molding Design for Home*) approved.
  - Marble Table Tops: Scope locked to handcrafted natural **tabletops only** ("upar ka top"); bases/chairs excluded.
- **Created Core Governance Files:**
  - `OWNER_CONFIRM.md`: Verification log of verified vs pending facts.
  - `AUTO_KEYWORDS.md`: Derived keyword targets for GAP and Thin coverage pages.
  - `CONTENT_PROGRESS.md`: Batch-by-batch progress tracking.
  - `CONTENT_CHANGELOG.md`: Detailed changelog.

---

## [Phase 1: 5-Page Pilot Execution & STOP GATE 2 QA] — 2026-10-06
- **STOP GATE 1 Ten Conditions Implemented:**
  1. *Vercel Stubs Cleanup:* Removed 301 rules from `vercel.json` for 21 converted stubs; stripped meta refresh redirects from all 21 files.
  2. *Duplicate Cleanups:* Removed canonical duplicates `/murals-wall-art/` and `/temple/` from `sitemap.xml`; redirected to `/stone-art-murals/` and `/marble-temple/`. Set `404.html` to `noindex, nofollow` without canonical to root.
  3. *Host Standardization:* Primary host permanently locked to `https://www.shreeramandcompany.com/`. Confirmed DNS for `vijetastone.com` is non-resolving.
  4. *Rule 4 Audit:* Scanned all 81 files for unverified terms ("Makrana", "Pietra Dura", "generational", "pure", "factory", "Vedic"). Report generated in `tools/rule4_sweep_report.md` (386 total hits).
  5. *Deity Guardrails:* Eliminated "Akshardham style" and "Ayodhya style" from all keyword maps and copy. Respected authentic Vaishnava/Shilpa Shastra iconography.
  6. *Blog Cannibalization Fixes:* Differentiated Blog #4 (`modern jali design` @ 4,400/mo) from money page `/cnc-jali-work/`. Differentiated Blog #1 (informational Vastu pooja guide) from commercial `/pooja-room/`.
  7. *Pricing Guardrails:* Removed fictitious square-foot pricing brackets; replaced with transparent pricing factors.
  8. *Blog Hub Structure:* Upgraded `articles/index.html` with plain crawlable `<a href>` post links.
  9. *Search Volume Honesty:* Guaranteed GAP derived terms display no fabricated search numbers.
  10. *Local Preview Integrity:* Executed strictly on branch `content-seo` with local HTTP/CDP verification; zero direct production push.
- **Pilot Pages Completed:**
  - **Pilot #1 (Homepage):** `index.html` — Head terms aligned to `stone work in Jaipur`, schema & canonical locked to www, zero banned words.
  - **Pilot #2 (Commercial Carving):** `stone-carving/staircase-wall/index.html` — H1 locked to `Staircase Wall`, primary keyword `staircase wall design` (8,100/mo), fake sq ft prices replaced with pricing factors.
  - **Pilot #3 (Converted Deity Page):** `stone-art-murals/radhe-krishna-stone-art-mural/index.html` — H1 locked to `Radhe Krishna Stone Art & Mural`, primary keyword `radha krishna mural` (390/mo), standalone master template conversion.
  - **Pilot #4 (Converted Architectural Panel):** `stone-wall-panels/fluted-stone-panels/index.html` — H1 locked to `Fluted Stone Panels`, primary keyword `fluted stone wall panels` (GAP term), full architectural specifications.
  - **Pilot #5 (Option B Pillar Hub & Child Re-scope):**
    - `cnc-jali-work/index.html` — Dedicated head hub targeting `cnc jali design` (12,100/mo) with parent-child links down to all 4 lattice materials.
    - `stone-jali/index.html` — Re-scoped to `stone jali design` (480/mo) natural stone lattices; breadcrumbs and links linked up to `/cnc-jali-work/`.
- **STOP GATE 2 QA Test Results:**
  - **URL Inventory Diff:** 81 before -> 82 after. Zero frozen URLs lost (+1 intended pillar hub `/cnc-jali-work/`).
  - **HTTP Status Check:** 100% of pilot URLs serve HTTP 200 (not 301, not 404).
  - **Schema Validation:** 100% valid JSON-LD schemas across all pilot pages; 0 banned words in schemas; correct `www` host everywhere.
  - **Content Overlap:** All pairwise pilot page overlaps are between 17.27% and 26.76% (well below the 30% ceiling).
  - **HTML Structure:** Exactly 1 `<h1>` per page, balanced tags (0 div delta).
  - **Responsive & Viewport Screenshots:** Tested at desktop (1280px) and mobile (375px) via Edge CDP — 0 horizontal scroll overflow on any page. 12 screenshot artifacts generated.
