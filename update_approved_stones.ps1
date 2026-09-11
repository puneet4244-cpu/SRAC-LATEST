# Update execute_all_category_generation.ps1 with strictly approved stones
$file = "$PSScriptRoot\execute_all_category_generation.ps1"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$replacements = @{
    'Material = "Dholpur Beige / Jodhpur Pink Sandstone";' = 'Material = "Gwalior Mint Sandstone & Pink Sandstone Bansi Paharpur";'
    'Material = "White Mint Stone / Charcoal Grey Granite";' = 'Material = "Gwalior Mint Sandstone & Kandla Grey Sandstone";'
    'Material = "Authentic Jaisalmer Yellow & Red Sandstone";' = 'Material = "Jaisalmer Sandstone & Red Sandstone Karauli";'
    
    'Material = "Black Granite / White Makrana Marble";' = 'Material = "Indian White Marble & Moka Grey";'
    'Material = "Dholpur Beige / Jaisalmer Yellow";' = 'Material = "Gwalior Mint Sandstone & Jaisalmer Sandstone";'
    'Material = "Teakwood Sandstone & Titanium Gold";' = 'Material = "Teak Sandstone & Indian White Marble";'
    
    'Material = "Mint Sandstone / Dholpur Beige";' = 'Material = "Gwalior Mint Sandstone & Kandla Grey Sandstone";'
    'Material = "Jodhpur Sandstone / Gwalior White";' = 'Material = "Gwalior Mint Sandstone & Moka Grey";'
    'Material = "Dholpur Pink & Teakwood Sandstone";' = 'Material = "Pink Sandstone Bansi Paharpur & Teak Sandstone";'
    
    'Material = "Dholpur Pink Sandstone / Teak Stone";' = 'Material = "Pink Sandstone Bansi Paharpur & Teak Sandstone";'
    'Material = "Jaisalmer Yellow & Mint Sandstone";' = 'Material = "Jaisalmer Sandstone & Gwalior Mint Sandstone";'
    'Material = "Granite & Natural Sandstone";' = 'Material = "Kandla Grey Sandstone & Red Sandstone Karauli";'
    
    'Material = "100% Authentic Makrana Marble";' = 'Material = "Indian White Marble";'
    'Material = "White Marble / Vietnam Marble";' = 'Material = "Indian White Marble & Vietnam White Marble";'
    'Material = "Pure Makrana Albeta Marble";' = 'Material = "Indian White Marble";'
    
    'Material = "Dholpur Pink / Red Sandstone";' = 'Material = "Pink Sandstone Bansi Paharpur & Red Sandstone Karauli";'
    'Material = "Khatu Teak Sandstone";' = 'Material = "Teak Sandstone";'
    'Material = "Bansi Paharpur / Dholpur Stone";' = 'Material = "Pink Sandstone Bansi Paharpur & Gwalior Mint Sandstone";'
    
    'Material = "Makrana White Marble & Gold Leaf";' = 'Material = "Indian White Marble & Vietnam White Marble";'
    'Material = "Dholpur Sandstone & Teak Wood";' = 'Material = "Pink Sandstone Bansi Paharpur & Teak Sandstone";'
    
    'Material = "Makrana Marble & Semi-Precious Gemstones";' = 'Material = "Indian White Marble & Semi-Precious Inlay";'
    'Material = "White Marble with Black & Green Inlay";' = 'Material = "Indian White Marble & Vietnam White Marble";'
    
    'Material = "Makrana Super White Marble";' = 'Material = "Vietnam White Marble & Indian White Marble";'
    'Material = "Dholpur Beige / Black Granite";' = 'Material = "Gwalior Mint Sandstone & Moka Grey";'
    
    'Material = "Dholpur Pink & Teak Sandstone";' = 'Material = "Pink Sandstone Bansi Paharpur & Red Sandstone Karauli";'
    'Material = "White Mint Sandstone / White Marble";' = 'Material = "Gwalior Mint Sandstone & Indian White Marble";'
    
    'Material = "Banswara White Marble / Sandstone";' = 'Material = "Indian White Marble & Pink Sandstone Bansi Paharpur";'
    'Material = "Dholpur Beige / Gwalior Sandstone";' = 'Material = "Gwalior Mint Sandstone & Pink Sandstone Bansi Paharpur";'
    'Material = "Authentic Pink Sandstone & Marble";' = 'Material = "Pink Sandstone Bansi Paharpur & Indian White Marble";'
    
    'Material = "Pure Makrana White Marble / Polished Sandstone";' = 'Material = "Indian White Marble & Kandla Grey Sandstone";'
    'Material = "Dholpur Mint Stone / Vietnam White Marble";' = 'Material = "Gwalior Mint Sandstone & Vietnam White Marble";'
    'Material = "Solid Natural Dholpur Sandstone";' = 'Material = "Pink Sandstone Bansi Paharpur & Gwalior Mint Sandstone";'
    
    'Material = "Makrana Marble & Semi-Precious Inlay";' = 'Material = "Indian White Marble & Semi-Precious Gemstone Inlay";'
    'Material = "White Marble / Black Kadappa";' = 'Material = "Indian White Marble & Moka Grey";'
    
    'Material = "Pure Makrana Marble & Gold Leaf";' = 'Material = "Indian White Marble & Jaisalmer Sandstone";'
    'Material = "Dholpur Mint Stone / Black Granite";' = 'Material = "Gwalior Mint Sandstone & Moka Grey";'
    
    'Material = "Dholpur Beige / Red Sandstone";' = 'Material = "Gwalior Mint Sandstone & Red Sandstone Karauli";'
    'Material = "Jaisalmer Yellow / Mint Stone";' = 'Material = "Jaisalmer Sandstone & Gwalior Mint Sandstone";'
    
    'Material = "Teak Sandstone / High-Density MDF";' = 'Material = "Teak Sandstone & High-Density HDMR";'
    'Material = "Natural Stone / WPC / HDMR";' = 'Material = "Kandla Grey Sandstone / WPC / HDMR";'
    'Material = "Solid White Marble / Teak MDF";' = 'Material = "Indian White Marble & Teak Sandstone";'
}

foreach ($key in $replacements.Keys) {
    $content = $content.Replace($key, $replacements[$key])
}

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "Updated execute_all_category_generation.ps1 with strictly approved 9 stone materials!"
