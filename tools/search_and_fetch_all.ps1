. ./tools/image_processor.ps1

$headers = @{
    "User-Agent" = "VietaStoneImageFetcher/1.0 (contact@shreeramstone.com)"
}

function Find-And-Save {
    param(
        [string]$query,
        [string]$outputName
    )

    $encoded = [Uri]::EscapeDataString($query)
    $url = "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrnamespace=6&gsrsearch=$encoded&gsrlimit=15&prop=imageinfo&iiprop=url|size&format=json"
    
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers
        if ($res.query -and $res.query.pages) {
            foreach ($p in $res.query.pages.PSObject.Properties) {
                $page = $p.Value
                if ($page.imageinfo) {
                    $info = $page.imageinfo[0]
                    # Filter only bitmap images, NO PDF/DJVU/TIF/SVG
                    if ($info.url -match '\.(jpg|jpeg|png|webp)($|\?)') {
                        if ($info.width -ge 800 -and $info.height -ge 800) {
                            Write-Host "Found for '$query': $($page.title) ($($info.width)x$($info.height))"
                            $outPath = "tools/staged/$outputName"
                            $ok = Save-CroppedImage -inputSource $info.url -outputPath $outPath -targetWidth 900 -targetHeight 1200
                            if ($ok) {
                                Write-Host "Successfully saved $outPath"
                                return $page.title
                            }
                        }
                    }
                }
            }
        }
        Write-Warning "No suitable image found for query: $query"
        return $null
    } catch {
        Write-Error "Failed searching $query : $_"
        return $null
    }
}

# Copy existing test images to staged
if (Test-Path "tools/staged/test_gazebo.jpg") {
    Copy-Item "tools/staged/test_gazebo.jpg" "tools/staged/gazebos.jpg" -Force
}
if (Test-Path "tools/staged/test_stone_temple.jpg") {
    Copy-Item "tools/staged/test_stone_temple.jpg" "tools/staged/stone_temple.jpg" -Force
}
if (Test-Path "tools/staged/test_wall_cladding.jpg") {
    Copy-Item "tools/staged/test_wall_cladding.jpg" "tools/staged/wall_cladding.jpg" -Force
}

$remaining = @(
    @{ Query = "stone urn garden OR stone planter garden"; Out = "garden_articles.jpg" },
    @{ Query = "marble elephant carving OR stone handicraft Rajasthan"; Out = "handicrafts.jpg" },
    @{ Query = "Hindu pooja room OR mandir marble interior"; Out = "pooja_rooms.jpg" },
    @{ Query = "carved stone inscription OR carved stone plaque"; Out = "customised_name_plate.jpg" },
    @{ Query = "stone jaali Rajasthan OR marble jaali screen"; Out = "partition_jali.jpg" },
    @{ Query = "wooden jali screen room divider OR lattice partition"; Out = "mdf_jali.jpg" },
    @{ Query = "jali facade building OR decorative balcony screen"; Out = "wpc_jali.jpg" }
)

foreach ($it in $remaining) {
    Write-Host "`nSearching for: $($it.Query)"
    Find-And-Save -query $it.Query -outputName $it.Out
    Start-Sleep -Seconds 1
}
