param(
    [string]$Query = "sandstone temple"
)

$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
}

$encoded = [Uri]::EscapeDataString($Query)
$url = "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrnamespace=6&gsrsearch=$encoded&gsrlimit=10&prop=imageinfo&iiprop=url|size&format=json"

$res = Invoke-RestMethod -Uri $url -Headers $headers

if ($res.query -and $res.query.pages) {
    foreach ($p in $res.query.pages.PSObject.Properties) {
        $page = $p.Value
        if ($page.imageinfo) {
            $info = $page.imageinfo[0]
            [PSCustomObject]@{
                Title = $page.title
                Width = $info.width
                Height = $info.height
                Url = $info.url
            }
        }
    }
} else {
    Write-Host "No results found. Status:" ($res | ConvertTo-Json -Depth 2)
}
