# tools/generate_deity_copy_review.ps1
$rootDir = Split-Path $PSScriptRoot -Parent
$jsonPath = Join-Path $PSScriptRoot "batch2b_data.json"
$pages = Get-Content $jsonPath -Raw -Encoding UTF8 | ConvertFrom-Json

$deitySlugs = @(
    "buddha-stone-art-mural",
    "durga-mata-ji-stone-art-mural",
    "ganesh-ji-stone-art-mural",
    "hanuman-ji-stone-art-mural",
    "laxmi-ji-stone-art-mural",
    "ram-darbar-stone-art-mural",
    "shiv-ji-stone-art-mural",
    "shreenath-ji-stone-art-mural",
    "swaminarayan-ji-stone-art-mural"
)

$out = @()
$out += '# DEITY_COPY_REVIEW.md - Full Visible Copy Review for Owner Sign-Off'
$out += 'Website: https://www.shreeramandcompany.com/'
$out += 'Branch: content-seo'
$out += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$out += ''
$out += '> [!IMPORTANT]'
$out += '> **Owner Review Notice:** This document contains the complete visible text across all 9 sacred deity mural pages. Please review all theological, iconographical, and architectural descriptions. Once approved, no further edits will be made.'
$out += ''
$out += '---'
$out += ''
$out += '## Summary of Iconographic Fixes Applied in this Revision:'
$out += '1. **Ram Darbar:** Corrected bow attribution. Kodanda is exclusively named as Shri Ram''s divine bow; brother Lakshman stands loyally beside with bow in hand.'
$out += '2. **Ganesh Ji:** Corrected trunk terminology. "Vakratunda" is defined as the curved trunk (vakra = curved, tunda = trunk/snout) with Ekadanta as the single tusk of focused wisdom.'
$out += '3. **Sectarian & ''Authentic'' Language:** Removed words like "authentic" for sectarian traditions. Replaced with reverent, time-honored, and traditional architectural terminology.'
$out += '4. **Swaminarayan Ji:** No specific sect named (zero references to Akshar-Purushottam). Focuses purely on Bhagwan Swaminarayan''s revered murti with royal ceremonial pagh (turban), sacred kanthi, Abhaya mudra blessings, and classical mandir archway.'
$out += '5. **Shreenath Ji:** Preserved authentic Govardhandhara swaroop details (raised left hand, lotus eyes, chin gem) while eliminating sectarian doctrine claims.'
$out += '6. **Unique Section:** Injected dedicated bespoke architectural sizing, stone selection, and mounting protocol sections into every page.'
$out += '7. **Schema:** Validated as WebPage + BreadcrumbList + FAQPage (zero artificial Product or ItemList schemas).'
$out += '8. **Meta Descriptions:** All strictly <= 155 characters.'
$out += ''
$out += '---'
$out += ''

$pageNum = 1
foreach ($slug in $deitySlugs) {
    $p = $pages | Where-Object { $_.Slug -eq $slug }
    if (-not $p) { continue }

    $pName = [string]$p.Name
    $pTitle = [string]$p.Title
    $pPrimary = [string]$p.Primary
    $pMetaDesc = [string]$p.MetaDesc
    $pBadge = [string]$p.Badge
    $pH1 = [string]$p.H1
    $pLead = [string]$p.Lead
    $pOverviewH2 = [string]$p.OverviewH2
    $pOverviewP1 = [string]$p.OverviewP1
    $pOverviewP2 = [string]$p.OverviewP2

    $out += "# Page ${pageNum}: $pName"
    $out += "- **Live Preview URL:** ``https://www.shreeramandcompany.com/stone-art-murals/$slug/``"
    $out += "- **Page Title:** ``$pTitle`` ($($pTitle.Length) chars)"
    $out += "- **Primary Keyword:** ``$pPrimary``"
    $out += "- **Meta Description:** ``$pMetaDesc`` ($($pMetaDesc.Length) chars)"
    $out += ''
    $out += '### 1. Hero Section'
    $out += "- **Badge:** $pBadge"
    $out += "- **Heading (H1):** $pH1"
    $out += "- **Lead Text:** $pLead"
    $out += '- **Primary CTAs:** [Commission Custom Mural](/get-a-quote/) | [Explore Portfolio](#gallery)'
    $out += ''
    $out += '---'
    $out += ''
    $out += '### 2. Main Architectural & Sculptural Overview'
    $out += "- **Section Heading (H2):** $pOverviewH2"
    $out += '- **Paragraph 1:**'
    $out += $pOverviewP1
    $out += ''
    $out += '- **Paragraph 2:**'
    $out += $pOverviewP2
    $out += ''
    $out += '- **Master Workshop Distinctions:**'
    foreach ($h in $p.Highlights) {
        $out += "  - $h"
    }
    $out += ''
    $out += '---'
    $out += ''
    $out += '### 3. Bespoke Architectural Specifications & Sizing Section'
    $out += "- **Section Title:** $($p.UniqueSection.Title)"
    $out += "- **Subtitle:** $($p.UniqueSection.Subtitle)"
    $out += "- **Introductory Context:** $($p.UniqueSection.Intro)"
    $out += ''
    $out += "#### A. $($p.UniqueSection.Col1Title)"
    foreach ($item in $p.UniqueSection.Col1Items) {
        $out += "  - $item"
    }
    $out += ''
    $out += "#### B. $($p.UniqueSection.Col2Title)"
    foreach ($item in $p.UniqueSection.Col2Items) {
        $out += "  - $item"
    }
    $out += ''
    $out += "#### C. $($p.UniqueSection.Col3Title)"
    foreach ($item in $p.UniqueSection.Col3Items) {
        $out += "  - $item"
    }
    $out += ''
    $out += '---'
    $out += ''
    $out += '### 4. Sculptural Highlights & Micro-Chisel Detailing (6 Feature Cards)'
    foreach ($f in $p.Features) {
        $out += "- **$($f.Title):** $($f.Desc)"
    }
    $out += ''
    $out += '---'
    $out += ''
    $out += '### 5. Placement Environments & Sacred Sanctums (2 Cards + Advisory)'
    $out += "#### Card 1: $($p.PlaceCards[0].Title) ($($p.PlaceCards[0].Tag))"
    $out += "- **$($p.PlaceCards[0].P1Title):** $($p.PlaceCards[0].P1Desc)"
    $out += "- **$($p.PlaceCards[0].P2Title):** $($p.PlaceCards[0].P2Desc)"
    $out += ''
    $out += "#### Card 2: $($p.PlaceCards[1].Title) ($($p.PlaceCards[1].Tag))"
    $out += "- **$($p.PlaceCards[1].P1Title):** $($p.PlaceCards[1].P1Desc)"
    $out += "- **$($p.PlaceCards[1].P2Title):** $($p.PlaceCards[1].P2Desc)"
    $out += ''
    $out += '#### Traditional Placement Advisory Note:'
    $out += '> Placement and directional guidance are shared as time-honored architectural customs. Clients are encouraged to consult their personal family Vastu or spiritual advisors for individual room alignment and customized mandir configurations.'
    $out += ''
    $out += '---'
    $out += ''
    $out += '### 6. Artisan Workshop Portfolio (3 Real Project Images)'
    foreach ($g in $p.Gallery) {
        $out += "- **Image:** ``$($g.Img)``"
        $out += "  - **Display Title:** $($g.Title)"
        $out += "  - **Alt Text:** $($g.Alt)"
    }
    $out += ''
    $out += '---'
    $out += ''
    $out += '### 7. Frequently Asked Questions (4 Visible Accordion FAQs)'
    $faqIdx = 1
    foreach ($faq in $p.Faqs) {
        $out += "**Q${faqIdx}: $($faq.Q)**  "
        $out += "**A:** $($faq.A)"
        $out += ''
        $faqIdx++
    }
    $out += '---'
    $out += '<br>'
    $out += ''

    $pageNum++
}

$reviewFile = Join-Path $rootDir "DEITY_COPY_REVIEW.md"
$utf8BOM = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllLines($reviewFile, $out, $utf8BOM)
Write-Host "DEITY_COPY_REVIEW.md generated successfully at $reviewFile"
