$samplePages = @(
    "stone-art-murals/ram-darbar-stone-art-mural/index.html",
    "stone-art-murals/buddha-stone-art-mural/index.html"
)

foreach ($p in $samplePages) {
    Write-Host "`nPage: $p"
    $c = Get-Content $p -Raw
    $matches = [regex]::Matches($c, '<img[^>]+>')
    foreach ($m in $matches) {
        Write-Host "  " $m.Value
    }
}
