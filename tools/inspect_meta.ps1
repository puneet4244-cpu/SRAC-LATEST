$data = Get-Content 'tools/batch2b_data.json' -Raw -Encoding UTF8 | ConvertFrom-Json
foreach ($d in $data) {
    Write-Host "$($d.Slug) | Primary: $($d.Primary) | MetaLen: $($d.MetaDesc.Length) | TitleLen: $($d.Title.Length)"
    Write-Host "   Title: $($d.Title)"
    Write-Host "   Meta: $($d.MetaDesc)"
}
