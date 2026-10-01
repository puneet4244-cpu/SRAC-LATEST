$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
}

function Get-CommonsFileUrl {
    param([string]$fileName)
    $title = "File:" + $fileName.TrimStart("File:")
    $encoded = [Uri]::EscapeDataString($title)
    $url = "https://commons.wikimedia.org/w/api.php?action=query&titles=$encoded&prop=imageinfo&iiprop=url|size&format=json"
    $res = Invoke-RestMethod -Uri $url -Headers $headers
    foreach ($p in $res.query.pages.PSObject.Properties) {
        if ($p.Value.imageinfo) {
            return $p.Value.imageinfo[0].url
        }
    }
    return $null
}

$files = @(
    "Cenotaphs at Bada Bagh, Jaisalmer.jpg",
    "0121821 Parvati Temple, Khajuraho Madhya Pradesh 011.jpg",
    "Carved stone pillar.jpg",
    "PIETRA DURA - Agra - India.png",
    "Marble Dagadusheth Halwai Ganapati Statue from Maliyas.com Jaipur India.jpg",
    "Stone Urn, Trent Park, Enfield.jpg"
)

foreach ($f in $files) {
    $u = Get-CommonsFileUrl -fileName $f
    Write-Host "$f => $u"
}
