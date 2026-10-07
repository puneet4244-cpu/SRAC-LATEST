$path = 'c:\Users\shree\OneDrive\Desktop\NTRY\stone-wall-panels\fluted-stone-panels\index.html'
$content = Get-Content $path -Raw

# Meta description and Schema description match
$metaDesc = "Architectural fluted stone wall panels in natural sandstone and marble. Custom CNC reed and scallop textures crafted at our Jaipur factory with worldwide doorstep delivery."

# Update meta description
$content = [regex]::Replace($content, '<meta name="description" content="[^"]*">', "<meta name=`"description`" content=`"$metaDesc`">")
$content = [regex]::Replace($content, '<meta property="og:description" content="[^"]*">', "<meta property=`"og:description`" content=`"$metaDesc`">")
$content = [regex]::Replace($content, '<meta name="twitter:description" content="[^"]*">', "<meta name=`"twitter:description`" content=`"$metaDesc`">")

# Update schema CollectionPage description
$content = [regex]::Replace($content, '(?s)("@type":\s*"CollectionPage",\s*"@id":\s*"[^"]*",\s*"url":\s*"[^"]*",\s*"name":\s*"[^"]*",\s*"description":\s*")[^"]*(")', "`${1}$metaDesc`${2}")

# Update schema FAQ 3 if present
$oldSchemaFaqQ = '"name": "How do fluted stone panels improve interior acoustics?"'
$newSchemaFaqQ = '"name": "How do fluted stone panels affect interior acoustics?"'
$content = $content.Replace($oldSchemaFaqQ, $newSchemaFaqQ)

$oldSchemaFaqA = '"text": "The repetitive alternating concave and convex surface grooves break up flat sound reflections, diffusing flutter echoes and acoustic resonance in spacious living rooms, double-height foyers, and commercial lobbies."'
$newSchemaFaqA = '"text": "Natural stone is an inherently dense, hard, and acoustically reflective surface that does not absorb sound waves. However, the repetitive alternating concave and convex surface ridges help scatter and diffuse sound reflections rather than allowing direct slap-back flutter echoes, softening acoustic harshness in spacious living rooms, double-height foyers, and commercial lobbies."'
$content = $content.Replace($oldSchemaFaqA, $newSchemaFaqA)

# Update Acoustic body card
$oldAcousticCard = 'The multi-faceted rhythmic geometry disperses acoustic reflections, dampening echo in cavernous lobbies and double-height living areas.'
$newAcousticCard = 'Natural stone is a dense, reflective surface that does not absorb sound; however, the multi-faceted rhythmic ridges help scatter and diffuse sound reflections to soften harsh flutter echo across large spaces.'
$content = $content.Replace($oldAcousticCard, $newAcousticCard)

# Update Sealer body card
$oldSealerCard = 'Factory impregnated with deep-penetrating fluoropolymer sealers to resist moisture penetration, oil spots, and atmospheric dust.'
$newSealerCard = 'Treated upon request with breathable penetrating stone sealers to help resist surface moisture, dust, and daily wear while preserving natural stone breathability.'
$content = $content.Replace($oldSealerCard, $newSealerCard)

# Update FAQ 3 in body
$oldFaq3Q = 'How do fluted stone panels improve interior acoustics?'
$newFaq3Q = 'How do fluted stone panels affect interior acoustics?'
$content = $content.Replace($oldFaq3Q, $newFaq3Q)

$oldFaq3A = 'The repetitive alternating concave and convex surface grooves break up flat sound reflections, diffusing flutter echoes and acoustic resonance in spacious living rooms, double-height foyers, and commercial lobbies.'
$newFaq3A = 'Natural stone is an inherently dense, hard, and acoustically reflective surface that does not absorb sound waves. However, the repetitive alternating concave and convex surface ridges help scatter and diffuse sound reflections rather than allowing direct slap-back flutter echoes, softening acoustic harshness in spacious living rooms, double-height foyers, and commercial lobbies.'
$content = $content.Replace($oldFaq3A, $newFaq3A)

# Update Atelier and contact
$content = $content.Replace('ATELIER WORKSHOP LOCATION', 'FACTORY & WORKSHOP LOCATION')
$content = $content.Replace('Contact Atelier', 'Contact Us')

Set-Content $path -Value $content -NoNewline
Write-Host "Updated fluted-stone-panels/index.html successfully."
