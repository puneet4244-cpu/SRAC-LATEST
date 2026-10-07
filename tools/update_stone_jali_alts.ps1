$path = 'c:\Users\shree\OneDrive\Desktop\NTRY\stone-jali\index.html'
$content = Get-Content $path -Raw

# Replace Card 1 alt texts
$content = $content.Replace('Architectural Sandstone Facade Jali Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 1', 'Perforated geometric natural stone jali screen panel')
$content = $content.Replace('Architectural Sandstone Facade Jali Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 2', 'Precision CNC routed decorative lattice panel')
$content = $content.Replace('Architectural Sandstone Facade Jali Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 3', 'White exterior lattice screen panel with geometric pattern')
$content = $content.Replace('Architectural Sandstone Facade Jali Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 4', 'Architectural building facade featuring stone cladding and lattice jali screens')
$content = $content.Replace('Architectural Sandstone Facade Jali Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 5', 'Craftsman hand-detailing intricate stone carving with chisel')

# Replace Card 2 alt texts
$content = $content.Replace('Mughal Floral Perforated Stone Screen Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 1', 'Handcrafted floral perforated stone jali screen')
$content = $content.Replace('Mughal Floral Perforated Stone Screen Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 2', 'Carved natural stone arch mehrab with ornate relief details')
$content = $content.Replace('Mughal Floral Perforated Stone Screen Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 3', 'Architectural stone carving with delicate floral tracery')
$content = $content.Replace('Mughal Floral Perforated Stone Screen Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 4', 'Durable outdoor lattice panel with geometric perforations')
$content = $content.Replace('Mughal Floral Perforated Stone Screen Architectural Handcrafted Natural Stone Carving - Shree Ram &amp; Company Jaipur - View 5', 'Jaipur artisan refining carved relief details on stone')

Set-Content $path -Value $content -NoNewline
Write-Host "Updated alt texts in stone-jali/index.html successfully."
