$path = 'c:\Users\shree\OneDrive\Desktop\NTRY\stone-carving\staircase-wall\index.html'
$content = Get-Content $path -Raw

# 1. Atelier references
$content = $content.Replace(
    'Every panel is sculpted in our Jaipur atelier from authentic Rajasthan sandstones and high-density marbles, calibrated to follow the precise pitch and angle of helical, cantilevered, or dog-legged stairs.',
    'Every panel is sculpted in our Jaipur factory from authentic Rajasthan sandstones and high-grade marbles, calibrated to follow the precise pitch and angle of helical, cantilevered, or dog-legged stairs.'
)
$content = $content.Replace('Atelier Specifications', 'Factory & Technical Specifications')
$content = $content.Replace('Actual installed projects and atelier master carvings sculpted at our Jaipur workshop.', 'Actual installed projects and master carvings sculpted at our Jaipur factory.')
$content = $content.Replace('ATELIER WORKSHOP LOCATION', 'FACTORY & WORKSHOP LOCATION')
$content = $content.Replace('Contact Atelier', 'Contact Us')

# 2. Sealer claims
$oldSealer1 = 'When treated with our deep-penetrating fluoropolymer sealer, the stone repels hand oils and smudges, maintaining a pristine matte appearance.'
$newSealer1 = 'When treated upon request with breathable penetrating stone sealers, the stone helps resist hand oils and smudges while maintaining an authentic natural matte texture.'
$content = $content.Replace($oldSealer1, $newSealer1)

$oldSealer2 = 'Impregnated with breathable silane hydrophobic sealers that prevent hand grease or water droplets from penetrating stone pores.'
$newSealer2 = 'Treated upon request with breathable penetrating stone sealers that help protect stone pores from hand smudges and surface moisture.'
$content = $content.Replace($oldSealer2, $newSealer2)

# 3. Timeline & Packaging
$oldTime = 'Fabrication for custom staircase walls (150–350 sq. ft.) typically takes 2 to 3 weeks. Slabs are numbered systematically to correspond with installation shop drawings, crated with high-density foam padding, and delivered directly to your site.'
$newTime = 'Fabrication timelines are tailored to each staircase elevation shop drawing and dimensional scope. Slabs are numbered systematically to correspond with installation blueprints, packed securely on wooden pallets or crates with protective foam or chemical foam safe packing, and delivered directly to your site across India or worldwide.'
$content = $content.Replace($oldTime, $newTime)

# Also check for regex variation of 150-350 sq ft in schema if unicode was mangled
$content = [regex]::Replace($content, 'Fabrication for custom staircase walls [^.]*typically takes 2 to 3 weeks\.[^"]*', 'Fabrication timelines are tailored to each staircase elevation shop drawing and dimensional scope. Slabs are numbered systematically to correspond with installation blueprints, packed securely on wooden pallets or crates with protective foam or chemical foam safe packing, and delivered directly to your site across India or worldwide.')

# 4. Durability claim
$oldDur = 'Natural carved stone outlives every artificial finish, providing decades of architectural durability and enduring elegance.'
$newDur = 'Natural carved stone outlives artificial finishes, providing enduring architectural elegance.'
$content = $content.Replace($oldDur, $newDur)

Set-Content $path -Value $content -NoNewline
Write-Host "Updated staircase-wall/index.html successfully."
