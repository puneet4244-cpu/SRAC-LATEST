$root = (Get-Location).Path
$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\\.git\\'
}

# 1. URLs Before
$urlsBefore = @()
foreach ($file in $htmlFiles) {
    $rel = $file.FullName.Substring($root.Length).TrimStart('\').Replace('\', '/')
    $url = "/" + $rel
    if ($url.EndsWith("index.html")) {
        $url = $url.Substring(0, $url.Length - 10)
    }
    $urlsBefore += $url
}
$urlsBefore | Sort-Object | Out-File -FilePath "$root/tools/urls_before.txt" -Encoding utf8
Write-Host "URLs Before recorded: $($urlsBefore.Count) URLs in tools/urls_before.txt"

# 2. Frozen Category Names (NAMES_LOCK)
$lockedNames = @(
    "Wall Surfaces",
    "Exterior Elevation",
    "Temples & Statues",
    "Home Interior & Decor",
    "CNC Jali Work",
    "Stone Carving",
    "Double Height Wall",
    "Staircase Wall",
    "Sofa Wall",
    "Statement Wall",
    "Living Room Wall",
    "Featured Wall",
    "Stone Art & Murals",
    "Radhe Krishna Stone Art & Mural",
    "Buddha Stone Art & Mural",
    "Hanuman Ji Stone Art & Mural",
    "Durga Mata Ji Stone Art & Mural",
    "Ganesh Ji Stone Art & Mural",
    "Laxmi Ji Stone Art & Mural",
    "Ram Darbar Stone Art & Mural",
    "Shiv Ji Stone Art & Mural",
    "Swaminarayan Ji Stone Art & Mural",
    "Shreenath Ji Stone Art & Mural",
    "Village Stone Art & Mural",
    "Floral Stone Art",
    "Stone Wall Panels",
    "Fluted Stone Panels",
    "Textured Stone Panels",
    "Wave Stone Panels",
    "Geometrical Stone Panels",
    "MDF HDMR Work",
    "MDF HDMR Wall Panels",
    "Fluted MDF Panels",
    "Textured MDF Panels",
    "Wave MDF Panels",
    "Geometrical MDF Panels",
    "Elevation Facade",
    "Customised Name Plates",
    "Wall Cladding",
    "Garden Articles",
    "Marble Temples",
    "Stone Temple",
    "Pooja Rooms",
    "Marble Inlay",
    "Statues",
    "Gazebos",
    "Arches & Mehrabs",
    "Pillars",
    "Handicrafts",
    "Marble Table Tops",
    "Water Fountains",
    "Stone Jali",
    "MDF / HDMR Jali",
    "Partition Jali",
    "PVC / WPC Jali"
)
$lockedNames | Out-File -FilePath "$root/tools/NAMES_LOCK.txt" -Encoding utf8
Write-Host "NAMES_LOCK recorded: $($lockedNames.Count) frozen names in tools/NAMES_LOCK.txt"
