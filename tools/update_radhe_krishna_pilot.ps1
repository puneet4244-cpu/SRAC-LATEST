$path = 'c:\Users\shree\OneDrive\Desktop\NTRY\stone-art-murals\radhe-krishna-stone-art-mural\index.html'
$content = Get-Content $path -Raw

# 1. Vastu Update
$oldVastuQ = 'Where is the best Vastu placement for a Radha Krishna stone mural?'
$newVastuQ = 'Where is Vastu placement commonly suggested for a Radha Krishna stone mural?'
$content = $content.Replace($oldVastuQ, $newVastuQ)

$oldVastuA = 'According to Vastu Shastra, sacred deity artwork depicting Shri Radha Krishna is best installed on the East or North-East wall of a home, pooja mandir, or living foyer, so the deities face West or South-West, infusing peace, devotion, and harmonious energy into the living environment.'
$newVastuA = 'In traditional architectural design, sacred deity artwork depicting Shri Radha Krishna is commonly suggested for the East or North-East wall of a home, pooja mandir, or living foyer, so the deities face West or South-West. However, design traditions and regional orientations vary, and we advise consulting your personal Vastu consultant or spiritual advisor for site-specific guidance.'
$content = $content.Replace($oldVastuA, $newVastuA)

# 2. Dimensions Update
$oldDimA = 'Yes. Every mural is custom sculpted at our Jaipur workshop. Standard dimensions range from 3x4 ft and 4x6 ft up to grand multi-panel 8x12 ft installations for double-height foyer walls and temple backdrops.'
$newDimA = 'Yes. Every mural is custom sculpted at our Jaipur factory tailored to customer-specified sizes and architectural blueprints, from compact mandir niche reliefs to monumental multi-panel double-height wall installations.'
$content = $content.Replace($oldDimA, $newDimA)

$oldDimSpan = '<span class="text-deep-charcoal font-bold">3x4 ft, 4x6 ft, 5x8 ft, or Custom Scale</span>'
$newDimSpan = '<span class="text-deep-charcoal font-bold">Customised to Client Architectural Blueprint & Dimensions</span>'
$content = $content.Replace($oldDimSpan, $newDimSpan)

# 3. Timeline & Packaging Update
$oldTimeA = 'Handcrafted fabrication typically takes 2 to 4 weeks depending on panel dimensions and carving relief depth. Each mural is dry-fitted and photographed for client review before crating in secure wooden packaging for insured transit across India.'
$newTimeA = 'Fabrication timelines depend on customer-specified dimensions, stone block selection, and relief carving complexity. Each mural is dry-fitted and photographed for client review before packaging on wooden pallets or crates with protective foam or chemical foam safe packing for insured delivery to your doorstep across India or worldwide.'
$content = $content.Replace($oldTimeA, $newTimeA)

# 4. Atelier & Contact Update
$content = $content.Replace('ATELIER WORKSHOP LOCATION', 'FACTORY & WORKSHOP LOCATION')
$content = $content.Replace('Contact Atelier', 'Contact Us')

Set-Content $path -Value $content -NoNewline
Write-Host "Updated radhe-krishna-stone-art-mural/index.html successfully."
