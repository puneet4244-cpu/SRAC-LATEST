$samplePages = @(
    "index.html",
    "stone-carving\staircase-wall\index.html",
    "stone-wall-panels\fluted-stone-panels\index.html",
    "cnc-jali-work\index.html",
    "stone-art-murals\ram-darbar-stone-art-mural\index.html",
    "stone-art-murals\buddha-stone-art-mural\index.html"
)

foreach ($sp in $samplePages) {
    $c = Get-Content $sp -Raw -Encoding UTF8
    Write-Host "=== Audit: $sp ==="
    
    # Check WhatsApp
    $hasWa = $c -match 'wa\.me/916367607459'
    Write-Host "  WhatsApp link (916367607459): $hasWa"
    
    # Check Phone
    $hasTel = ($c -match 'tel:\+916367607459') -or ($c -match 'tel:6367607459')
    Write-Host "  Tel link: $hasTel"
    
    # Check Fonts
    $hasFonts = ($c -match 'fonts\.googleapis\.com') -and ($c -match 'Cormorant\+Garamond')
    Write-Host "  Google Fonts loaded: $hasFonts"
    
    # Check Font Awesome
    $hasFa = $c -match 'font-awesome'
    Write-Host "  Font Awesome loaded: $hasFa"
    
    # Check Quote CTA / form link
    $hasQuote = $c -match '/get-a-quote/'
    Write-Host "  Quote CTA link: $hasQuote"
    
    # Check Images missing width/height
    $imgTags = [regex]::Matches($c, '<img[^>]+>')
    $missingDim = 0
    foreach ($m in $imgTags) {
        if ($m.Value -notmatch 'width=' -or $m.Value -notmatch 'height=') {
            $missingDim++
        }
    }
    Write-Host "  Images count: $($imgTags.Count) | Missing dimensions: $missingDim"
}
