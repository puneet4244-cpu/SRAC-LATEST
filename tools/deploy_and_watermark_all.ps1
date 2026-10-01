Add-Type -AssemblyName System.Drawing

$cwebp = "tools/libwebp-1.4.0-windows-x64/bin/cwebp.exe"
$unwatermarkedDir = "assets/originals-unwatermarked"
$imagesDir = "assets/images"

if (-not (Test-Path $unwatermarkedDir)) {
    New-Item -ItemType Directory -Path $unwatermarkedDir -Force | Out-Null
}
if (-not (Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
}

function Apply-VietaWatermark {
    param(
        [string]$inputPath,
        [string]$outputPath
    )

    if (-not (Test-Path $inputPath)) {
        Write-Error "File not found: $inputPath"
        return $false
    }

    $imgBytes = [System.IO.File]::ReadAllBytes($inputPath)
    $ms = New-Object System.IO.MemoryStream(,$imgBytes)
    $img = [System.Drawing.Image]::FromStream($ms)
    
    $w = $img.Width
    $h = $img.Height

    $bmp = New-Object System.Drawing.Bitmap ($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $g.DrawImage($img, 0, 0, $w, $h)

    # Watermark specification:
    # Text: "Shree Ram & Company Vieta Stone"
    # Position: bottom-right corner (~3% margin from edges)
    # Style: clean elegant serif font, white text at ~55-65% opacity (60% = alpha 153), subtle soft shadow
    # Size: font size proportional (~2.5% of image width, e.g. 22pt for 900w)
    $watermarkText = "Shree Ram & Company Vieta Stone"
    
    $fontSize = [Math]::Max(14.0, ($w * 0.025))
    $font = New-Object System.Drawing.Font ("Georgia", [float]$fontSize, [System.Drawing.FontStyle]::Regular)

    $marginRight = $w * 0.035
    $marginBottom = $h * 0.03

    $stringSize = $g.MeasureString($watermarkText, $font)
    $x = $w - $stringSize.Width - $marginRight
    $y = $h - $stringSize.Height - $marginBottom

    # 60% opacity white text
    $textBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(153, 255, 255, 255))
    # Subtle soft drop shadow (30% black)
    $shadowBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(70, 0, 0, 0))

    $shadowOffset = [Math]::Max(1.0, ($w * 0.0016))

    $g.DrawString($watermarkText, $font, $shadowBrush, [float]($x + $shadowOffset), [float]($y + $shadowOffset))
    $g.DrawString($watermarkText, $font, $textBrush, [float]$x, [float]$y)

    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]92)
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    
    if ($outputPath.EndsWith(".png", [System.StringComparison]::OrdinalIgnoreCase)) {
        $bmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    } else {
        $bmp.Save($outputPath, $codec, $encoderParams)
    }

    $g.Dispose()
    $bmp.Dispose()
    $img.Dispose()
    $ms.Dispose()
    $font.Dispose()
    $textBrush.Dispose()
    $shadowBrush.Dispose()

    # Create WebP counterpart if cwebp is available
    if (Test-Path $cwebp) {
        $webpPath = [System.IO.Path]::ChangeExtension($outputPath, ".webp")
        & $cwebp -q 85 $outputPath -o $webpPath | Out-Null
    }

    return $true
}

# 1. Double Height Wall slides (1 to 6)
Write-Host "Processing Double Height Wall slides..."
1..6 | ForEach-Object {
    $slideNum = $_
    $pad = $slideNum.ToString("00")
    $cleanSrc = "photos/WALL SURFACES/STONE CARVING/Double Height Wall/NEW DOUBLE HEIGHTED $slideNum.png"
    if (Test-Path $cleanSrc) {
        $unwatermarkedJpg = "$unwatermarkedDir/double-height-wall-$pad.jpg"
        # Convert clean PNG to high-res unwatermarked JPG backup
        $img = [System.Drawing.Image]::FromFile((Resolve-Path $cleanSrc))
        $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]95)
        $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
        $img.Save($unwatermarkedJpg, $codec, $encoderParams)
        $img.Dispose()

        # Watermark into assets/images/
        $destJpg = "$imagesDir/double-height-wall-$pad.jpg"
        Apply-VietaWatermark -inputPath $unwatermarkedJpg -outputPath $destJpg
        Write-Host "  Double height wall slide $pad done."
    }
}

# 2. Map of All Products to their Clean Source Images
$brainDir = "C:\Users\shree\.gemini\antigravity-ide\brain\79fcbaac-0c11-444c-9d84-2fd90e796db2"
$stagedDir = "tools/staged"

$masterDeployMap = @(
    # Category 1: WALL SURFACES
    # Stone Carving
    @{ Target = "sofa-wall.jpg"; Source = "$unwatermarkedDir/sofa-wall.jpg" },
    @{ Target = "statement-wall.jpg"; Source = "$unwatermarkedDir/statement-wall.jpg" },
    @{ Target = "living-room-wall.jpg"; Source = "$unwatermarkedDir/living-room-wall.jpg" },
    @{ Target = "featured-wall.jpg"; Source = "$unwatermarkedDir/featured-wall.jpg" },
    @{ Target = "staircase-mandala-radial-carving.jpg"; Source = "$unwatermarkedDir/staircase-mandala-radial-carving.jpg" },
    @{ Target = "staircase-maple-leaf-relief.jpg"; Source = "$unwatermarkedDir/staircase-maple-leaf-relief.jpg" },
    @{ Target = "staircase-ginkgo-backlit-panel.jpg"; Source = "$unwatermarkedDir/staircase-ginkgo-backlit-panel.jpg" },

    # Stone Art & Murals
    @{ Target = "radhe-krishna-mural.jpg"; Source = "$unwatermarkedDir/radhe-krishna-mural.jpg" },
    @{ Target = "statue.jpg"; Source = "$unwatermarkedDir/statue.jpg" }, # Buddha
    @{ Target = "hanuman-ji-mural.jpg"; Source = "$unwatermarkedDir/hanuman-ji-mural.jpg" },
    @{ Target = "durga-mata-mural.jpg"; Source = "$unwatermarkedDir/durga-mata-mural.jpg" },
    @{ Target = "ganesh-ji-mural.jpg"; Source = "$unwatermarkedDir/ganesh-ji-mural.jpg" },
    @{ Target = "laxmi-ji-mural.jpg"; Source = "$brainDir/laxmi_ji_mural_1790753836861.jpg" },
    @{ Target = "ram-darbar-mural.jpg"; Source = "$unwatermarkedDir/ram-darbar-mural.jpg" },
    @{ Target = "shiv-ji-mural.jpg"; Source = "$unwatermarkedDir/shiv-ji-mural.jpg" },
    @{ Target = "swaminarayan-ji-mural.jpg"; Source = "$brainDir/swaminarayan_ji_mural_1790753863127.jpg" },
    @{ Target = "shreenath-ji-mural.jpg"; Source = "$brainDir/shreenath_ji_mural_1790753889381.jpg" },
    @{ Target = "village-stone-art.jpg"; Source = "$brainDir/village_stone_art_1790753920102.jpg" },
    @{ Target = "floral-stone-art.jpg"; Source = "$unwatermarkedDir/floral-stone-art.jpg" },

    # Stone Wall Panels
    @{ Target = "fluted-stone-panels.jpg"; Source = "$brainDir/fluted_stone_panels_1790754348342.jpg" },
    @{ Target = "textured-stone-panels.jpg"; Source = "$brainDir/textured_stone_panels_1790754514514.jpg" },
    @{ Target = "wave-stone-panels.jpg"; Source = "$brainDir/wave_stone_panels_1790754540770.jpg" },
    @{ Target = "geometrical-stone-panels.jpg"; Source = "$brainDir/geometrical_stone_panels_1790754567570.jpg" },
    # Also update generic fallbacks so any page referencing them gets authentic stone panel
    @{ Target = "stone-wall-panel.jpg"; Source = "$brainDir/fluted_stone_panels_1790754348342.jpg" },
    @{ Target = "stone-wall-panels.jpg"; Source = "$brainDir/fluted_stone_panels_1790754348342.jpg" },

    # MDF HDMR Work
    @{ Target = "mdf-hdmr-wall-panels.jpg"; Source = "$brainDir/mdf_hdmr_wall_panels_1790754594008.jpg" },
    @{ Target = "fluted-mdf-panels.jpg"; Source = "$brainDir/fluted_mdf_panels_1790754618398.jpg" },
    @{ Target = "textured-mdf-panels.jpg"; Source = "$brainDir/textured_mdf_panels_1790754774089.jpg" },
    @{ Target = "wave-mdf-panels.jpg"; Source = "$brainDir/wave_mdf_panels_1790754795129.jpg" },
    @{ Target = "geometrical-mdf-panels.jpg"; Source = "$brainDir/geometrical_mdf_panels_1790754822804.jpg" },
    # Update generic fallbacks
    @{ Target = "mdf-work.jpg"; Source = "$brainDir/mdf_hdmr_wall_panels_1790754594008.jpg" },
    @{ Target = "mdf-hdmr-work.jpg"; Source = "$brainDir/mdf_hdmr_wall_panels_1790754594008.jpg" },

    # Category 2: EXTERIOR ELEVATION
    @{ Target = "elevation-facade.jpg"; Source = "$unwatermarkedDir/elevation-facade.jpg" },
    @{ Target = "customised-name-plate.jpg"; Source = "$stagedDir/customised_name_plate.jpg" },
    @{ Target = "wall-cladding.jpg"; Source = "$stagedDir/wall_cladding.jpg" },
    @{ Target = "garden-article.jpg"; Source = "$stagedDir/garden_articles.jpg" },

    # Category 3: TEMPLES & STATUES
    @{ Target = "marble-temple.jpg"; Source = "$unwatermarkedDir/marble-temple.jpg" },
    @{ Target = "temple.jpg"; Source = "$unwatermarkedDir/marble-temple.jpg" },
    @{ Target = "stone-temple.jpg"; Source = "$stagedDir/stone_temple.jpg" },
    @{ Target = "pooja-room.jpg"; Source = "$stagedDir/pooja_rooms.jpg" },
    @{ Target = "marble-inlay.jpg"; Source = "$unwatermarkedDir/marble-inlay.jpg" },
    @{ Target = "marble-statue.jpg"; Source = "$stagedDir/statues.jpg" },
    @{ Target = "gazebo.jpg"; Source = "$stagedDir/gazebos.jpg" },
    @{ Target = "arch-mehrab.jpg"; Source = "$unwatermarkedDir/arch-mehrab.jpg" },
    @{ Target = "pillar.jpg"; Source = "$stagedDir/pillars.jpg" },

    # Category 4: HOME INTERIOR & DECOR
    @{ Target = "handicrafts.jpg"; Source = "$stagedDir/handicrafts.jpg" },
    @{ Target = "marble-table-tops.jpg"; Source = "$stagedDir/marble_table_tops.jpg" },
    @{ Target = "water-fountain.jpg"; Source = "$unwatermarkedDir/water-fountain.jpg" },

    # Category 5: CNC JALI WORK
    @{ Target = "stone-jali.jpg"; Source = "$unwatermarkedDir/stone-jali.jpg" },
    @{ Target = "mdf-jali.jpg"; Source = "$stagedDir/mdf_jali_1.jpg" },
    @{ Target = "partition-jali.jpg"; Source = "$stagedDir/partition_jali.jpg" },
    @{ Target = "wpc-jali.jpg"; Source = "$stagedDir/wpc_jali_1.jpg" }
)

Write-Host "`nDeploying and watermarking all product images..."
$deployedCount = 0

foreach ($item in $masterDeployMap) {
    $src = $item.Source
    $targetName = $item.Target
    $unwatermarkedTarget = "$unwatermarkedDir/$targetName"
    $watermarkedTarget = "$imagesDir/$targetName"

    if (-not (Test-Path $src)) {
        Write-Warning "Source missing: $src (for $targetName)"
        continue
    }

    # Backup to unwatermarked directory if not already there or different
    if ($src -ne $unwatermarkedTarget) {
        Copy-Item -Path $src -Destination $unwatermarkedTarget -Force
    }

    # Apply watermark to assets/images/
    $res = Apply-VietaWatermark -inputPath $unwatermarkedTarget -outputPath $watermarkedTarget
    if ($res) {
        $deployedCount++
        Write-Host "  [OK] $targetName"
    } else {
        Write-Error "  [FAILED] $targetName"
    }
}

Write-Host "`nSuccessfully watermarked and deployed $deployedCount images."
