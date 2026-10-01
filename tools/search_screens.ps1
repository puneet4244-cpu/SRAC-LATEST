. ./tools/image_processor.ps1

$headers = @{
    "User-Agent" = "VietaStoneImageFetcher/1.0 (contact@shreeramstone.com)"
}

function Search-And-List {
    param([string]$query)
    $encoded = [Uri]::EscapeDataString($query)
    $url = "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrnamespace=6&gsrsearch=$encoded&gsrlimit=10&prop=imageinfo&iiprop=url|size&format=json"
    $res = Invoke-RestMethod -Uri $url -Headers $headers
    if ($res.query -and $res.query.pages) {
        foreach ($p in $res.query.pages.PSObject.Properties) {
            $page = $p.Value
            if ($page.imageinfo) {
                $info = $page.imageinfo[0]
                if ($info.url -match '\.(jpg|jpeg|png|webp)($|\?)') {
                    [PSCustomObject]@{
                        Title = $page.title
                        Width = $info.width
                        Height = $info.height
                        Url = $info.url
                    }
                }
            }
        }
    }
}

Write-Host "=== Search: fretwork screen OR wooden screen ==="
Search-And-List -query "fretwork screen OR wooden screen" | Format-Table -AutoSize

Write-Host "=== Search: lattice balcony OR trellis screen ==="
Search-And-List -query "lattice balcony OR trellis screen" | Format-Table -AutoSize
