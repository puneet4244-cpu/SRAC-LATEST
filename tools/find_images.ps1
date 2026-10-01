$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
}

function Search-Commons {
    param([string]$query, [int]$limit = 5)
    $encoded = [Uri]::EscapeDataString($query)
    $url = "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrnamespace=6&gsrsearch=$encoded&gsrlimit=$limit&prop=imageinfo&iiprop=url|size|extmetadata&format=json"
    $res = Invoke-RestMethod -Uri $url -Headers $headers
    $list = @()
    if ($res.query -and $res.query.pages) {
        foreach ($p in $res.query.pages.PSObject.Properties) {
            $page = $p.Value
            if ($page.imageinfo) {
                $info = $page.imageinfo[0]
                $list += [PSCustomObject]@{
                    Title = $page.title
                    Width = $info.width
                    Height = $info.height
                    Url = $info.url
                    Desc = if ($info.extmetadata -and $info.extmetadata.ObjectName) { $info.extmetadata.ObjectName.value } else { "" }
                }
            }
        }
    }
    return $list
}

# Test queries for our items
$queries = @{
    "gazebo" = "Bada Bagh Cenotaphs Jaisalmer OR chhatri sandstone"
    "stone_temple" = "sandstone temple shikhara Rajasthan OR Khajuraho temple sandstone"
    "pillars" = "carved stone pillars temple OR pillared hall sandstone"
    "statues" = "marble statue hindu OR marble murti"
    "marble_table_tops" = "pietra dura table top OR Agra marble inlay table"
    "handicrafts" = "marble elephant jali OR stone carving handicraft India"
    "garden_articles" = "stone garden urn OR carved stone planter"
    "wall_cladding" = "sandstone wall texture OR split face stone wall"
}

foreach ($k in $queries.Keys) {
    $name = $k
    $q = $queries[$k]
    Write-Host "=== Query for $name : $q ==="
    $results = Search-Commons -query $queries[$k] -limit 4
    $results | Select-Object Title, Width, Height, Url | Format-Table -AutoSize
}
