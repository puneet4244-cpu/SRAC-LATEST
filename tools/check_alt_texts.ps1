$pages = @(
    "stone-art-murals/index.html",
    "stone-wall-panels/index.html",
    "mdf-hdmr-work/index.html",
    "stone-carving/index.html",
    "index.html"
)

foreach ($p in $pages) {
    if (Test-Path $p) {
        Write-Host "`n=== Page: $p ==="
        $content = Get-Content $p -Raw
        $matches = [regex]::Matches($content, '<img[^>]+src=["'']([^"'']+)["''][^>]*alt=["'']([^"'']*)["''][^>]*>')
        foreach ($m in $matches | Select-Object -First 10) {
            Write-Host "  Src: $($m.Groups[1].Value)"
            Write-Host "  Alt: $($m.Groups[2].Value)"
        }
    }
}
