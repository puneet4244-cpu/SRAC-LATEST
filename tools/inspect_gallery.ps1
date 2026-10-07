$data = Get-Content 'tools/batch2b_data.json' -Raw -Encoding UTF8 | ConvertFrom-Json
foreach ($d in $data) {
    Write-Host "=== $($d.Slug) ==="
    foreach ($g in $d.Gallery) {
        Write-Host "  IMG: $($g.Img) | ALT: $($g.Alt)"
    }
}
