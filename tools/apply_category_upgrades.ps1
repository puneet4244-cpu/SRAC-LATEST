# tools/apply_category_upgrades.ps1
# Automates vertical-specific Craftsmanship, Material Table, and AEO FAQs across category pages

$jsonPath = Join-Path $PSScriptRoot "category_data.json"
if (-not (Test-Path $jsonPath)) {
    Write-Error "JSON file not found: $jsonPath"
    exit 1
}

$jsonText = [System.IO.File]::ReadAllText($jsonPath, [System.Text.Encoding]::UTF8)
$data = $jsonText | ConvertFrom-Json

# Helper function to generate Craftsmanship HTML
function Get-CraftsmanshipHtml($cfg) {
    $c1Title = $cfg.Card1.Title
    $c1Text = $cfg.Card1.Text
    $c2Title = $cfg.Card2.Title
    $c2Text = $cfg.Card2.Text
    $c3Title = $cfg.Card3.Title
    $c3Text = $cfg.Card3.Text

    return @"
    <!-- CRAFTSMANSHIP & MATERIAL OVERVIEW SECTION -->
    <section class="py-20 bg-white border-t border-light-beige">
        <div class="container mx-auto px-6 lg:px-12">
            <div class="max-w-4xl mx-auto text-center mb-12">
                <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block mb-2">$($cfg.CraftSubtitle)</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal mb-4">$($cfg.CraftTitle)</h2>
                <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-6"></div>
                <p class="text-gray-600 text-sm md:text-base leading-relaxed">
                    $($cfg.CraftText)
                </p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-left">
                <div class="p-6 bg-[#FAF8F4] border border-light-beige">
                    <div class="w-12 h-12 bg-white text-luxury-gold border border-light-beige flex items-center justify-center text-xl font-bold mb-4 rounded-full">01</div>
                    <h3 class="font-serif text-xl text-deep-charcoal font-semibold mb-2">$c1Title</h3>
                    <p class="text-gray-600 text-xs leading-relaxed">$c1Text</p>
                </div>
                <div class="p-6 bg-[#FAF8F4] border border-light-beige">
                    <div class="w-12 h-12 bg-white text-luxury-gold border border-light-beige flex items-center justify-center text-xl font-bold mb-4 rounded-full">02</div>
                    <h3 class="font-serif text-xl text-deep-charcoal font-semibold mb-2">$c2Title</h3>
                    <p class="text-gray-600 text-xs leading-relaxed">$c2Text</p>
                </div>
                <div class="p-6 bg-[#FAF8F4] border border-light-beige">
                    <div class="w-12 h-12 bg-white text-luxury-gold border border-light-beige flex items-center justify-center text-xl font-bold mb-4 rounded-full">03</div>
                    <h3 class="font-serif text-xl text-deep-charcoal font-semibold mb-2">$c3Title</h3>
                    <p class="text-gray-600 text-xs leading-relaxed">$c3Text</p>
                </div>
            </div>
        </div>
    </section>
"@
}

# Helper function to generate Table HTML
function Get-TableHtml($cfg) {
    $rowsHtml = ""
    foreach ($r in $cfg.Rows) {
        $color = "text-emerald-600"
        if ($r.Name -like "*Market Alternative*") { 
            $color = "text-rose-600" 
        } elseif ($r.Metric -like "*High*" -or $r.Metric -like "*Supreme*" -or $r.Metric -like "*Extreme*") { 
            $color = "text-emerald-600" 
        } elseif ($r.Metric -like "*Moderate*" -or $r.Metric -like "*Warm*") { 
            $color = "text-amber-600" 
        }
        
        $rowsHtml += @"
                        <tr class="hover:bg-[#FAF8F4]">
                            <td class="p-4 border border-light-beige font-bold text-deep-charcoal">$($r.Name)</td>
                            <td class="p-4 border border-light-beige">$($r.App)</td>
                            <td class="p-4 border border-light-beige $color font-medium">$($r.Metric)</td>
                            <td class="p-4 border border-light-beige">$($r.Maint)</td>
                            <td class="p-4 border border-light-beige font-semibold">$($r.Life)</td>
                        </tr>

"@
    }

    $col3 = $cfg.Col3

    return @"
    <!-- MATERIAL & PERFORMANCE COMPARISON TABLE -->
    <section class="py-20 bg-white border-t border-light-beige">
        <div class="container mx-auto px-6 lg:px-12">
            <div class="max-w-4xl mx-auto text-center mb-12">
                <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block mb-2">$($cfg.TableTitle)</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal mb-4">Material Performance & Durability Comparison</h2>
                <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-6"></div>
                <p class="text-gray-600 text-xs max-w-xl mx-auto">$($cfg.TableDesc)</p>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse border border-light-beige text-xs md:text-sm">
                    <thead>
                        <tr class="bg-deep-charcoal text-white font-serif tracking-wider">
                            <th class="p-4 border border-gray-700 font-semibold">Material Grade</th>
                            <th class="p-4 border border-gray-700 font-semibold">Ideal Application</th>
                            <th class="p-4 border border-gray-700 font-semibold">$col3</th>
                            <th class="p-4 border border-gray-700 font-semibold">Maintenance Level</th>
                            <th class="p-4 border border-gray-700 font-semibold">Longevity</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-light-beige text-gray-700 bg-white">
$rowsHtml                    </tbody>
                </table>
            </div>
        </div>
    </section>
"@
}

# Helper function to generate FAQ HTML
function Get-FaqHtml($cfg) {
    $faqsHtml = ""
    foreach ($q in $cfg.Faqs) {
        $faqsHtml += @"
                <div class="border border-light-beige bg-white p-6 md:p-8 rounded-sm shadow-sm hover:border-luxury-gold/50 transition-colors">
                    <h3 class="font-serif text-lg md:text-xl text-deep-charcoal font-semibold mb-3 flex items-start gap-3">
                        <span class="text-luxury-gold font-bold">Q.</span>
                        <span>$($q.Q)</span>
                    </h3>
                    <p class="text-gray-600 text-sm md:text-[15px] leading-relaxed pl-7">$($q.A)</p>
                </div>

"@
    }

    return @"
    <!-- FREQUENTLY ASKED QUESTIONS (AEO FAQ BLOCK) -->
    <section class="py-20 bg-luxury-bg border-t border-light-beige">
        <div class="container mx-auto px-6 lg:px-12 max-w-4xl">
            <div class="text-center mb-14">
                <span class="text-luxury-gold text-[11px] font-bold tracking-widest uppercase block mb-2">$($cfg.FaqTitle)</span>
                <h2 class="font-serif text-3xl md:text-4xl text-deep-charcoal mb-4">Frequently Asked Questions</h2>
                <div class="w-16 h-[2px] bg-luxury-gold mx-auto mb-6"></div>
            </div>
            <div class="space-y-6">
$faqsHtml            </div>
        </div>
    </section>
"@
}

# Process each category
$updatedCount = 0
$categories = $data.psobject.properties.Name

foreach ($cat in $categories) {
    $filePath = Join-Path $PSScriptRoot "..\$cat\index.html"
    if (-not (Test-Path $filePath)) {
        Write-Warning "File not found: $filePath"
        continue
    }

    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    $cfg = $data.$cat

    # Markers
    $m1 = "<!-- CRAFTSMANSHIP & MATERIAL OVERVIEW SECTION -->"
    $m2 = "<!-- PRODUCT CARDS GRID -->"
    $m3 = "<!-- MATERIAL & PERFORMANCE COMPARISON TABLE -->"
    $m4 = "<!-- FREQUENTLY ASKED QUESTIONS (AEO FAQ BLOCK) -->"
    $m5 = "<!-- INTERNAL LINKING & RELATED CATEGORIES -->"

    $p1 = $content.IndexOf($m1)
    $p2 = $content.IndexOf($m2)
    $p3 = $content.IndexOf($m3)
    $p4 = $content.IndexOf($m4)
    $p5 = $content.IndexOf($m5)

    if ($p1 -lt 0 -or $p2 -lt 0 -or $p3 -lt 0 -or $p4 -lt 0 -or $p5 -lt 0) {
        Write-Warning "Markers missing in $cat/index.html (p1=$p1, p2=$p2, p3=$p3, p4=$p4, p5=$p5)"
        continue
    }

    # Step 1: Replace Craftsmanship (between $p1 and $p2)
    $newCraft = (Get-CraftsmanshipHtml $cfg).Trim() + "`r`n`r`n    "
    $beforeCraft = $content.Substring(0, $p1)
    $afterCraft = $content.Substring($p2)
    $content = $beforeCraft + $newCraft + $afterCraft

    # Recalculate p3, p4, p5
    $p3 = $content.IndexOf($m3)
    $p4 = $content.IndexOf($m4)
    $p5 = $content.IndexOf($m5)

    # Step 2: Replace Table (between $p3 and $p4)
    $newTable = (Get-TableHtml $cfg).Trim() + "`r`n`r`n    "
    $beforeTable = $content.Substring(0, $p3)
    $afterTable = $content.Substring($p4)
    $content = $beforeTable + $newTable + $afterTable

    # Step 3: Replace FAQs (between new p4 and p5) unless PreserveFaq is true
    if (-not $cfg.PreserveFaq) {
        $p4 = $content.IndexOf($m4)
        $p5 = $content.IndexOf($m5)

        $newFaq = (Get-FaqHtml $cfg).Trim() + "`r`n`r`n    "
        $beforeFaq = $content.Substring(0, $p4)
        $afterFaq = $content.Substring($p5)
        $content = $beforeFaq + $newFaq + $afterFaq
    }

    [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Successfully upgraded: $cat/index.html"
    $updatedCount++
}

Write-Host "`nTotal categories upgraded: $updatedCount out of $($categories.Count)"
