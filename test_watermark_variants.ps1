Add-Type -AssemblyName System.Drawing

$rawPath = "c:\Users\shree\OneDrive\Desktop\NTRY\raw-originals\double-height-wall-raw-01.jpg"
$previewDir = "c:\Users\shree\OneDrive\Desktop\NTRY\preview"
$cwebpExe = "c:\Users\shree\OneDrive\Desktop\NTRY\tools\libwebp-1.4.0-windows-x64\bin\cwebp.exe"

$src = [System.Drawing.Image]::FromFile($rawPath)
$sw = $src.Width
$sh = $src.Height
$targetW = 900
$targetH = 1200
$targetAspect = 3.0 / 4.0

$cropX = 0
$cropY = 30
$cropW = $sw
$cropH = [int][Math]::Round($sw / $targetAspect)

function Render-WatermarkVariant {
    param(
        [string]$Name,
        [string]$Line1,
        [string]$Line2,
        [float]$Line1Size,
        [float]$Line2Size,
        [float]$CenterY,
        [float]$Line2RightOffsetPercent = 0.20
    )

    $bmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Color grade
    $c = 1.11; $b = 0.015; $t = (1.0 - $c)/2.0 + $b; $warmth = 0.035
    $rScale = [single]($c * 1.035); $gScale = [single]($c * 1.012); $bScale = [single]($c * 0.955)
    $tx = [single]($t + $warmth); $ty = [single]($t + ($warmth * 0.45)); $tz = [single]($t - ($warmth * 0.35))
    $pts = @(
        [single[]]@($rScale, 0.0, 0.0, 0.0, 0.0),
        [single[]]@(0.0, $gScale, 0.0, 0.0, 0.0),
        [single[]]@(0.0, 0.0, $bScale, 0.0, 0.0),
        [single[]]@(0.0, 0.0, 0.0, 1.0, 0.0),
        [single[]]@($tx, $ty, $tz, 0.0, 1.0)
    )
    $cm = New-Object System.Drawing.Imaging.ColorMatrix(,$pts)
    $ia = New-Object System.Drawing.Imaging.ImageAttributes
    $ia.SetColorMatrix($cm, [System.Drawing.Imaging.ColorMatrixFlag]::Default, [System.Drawing.Imaging.ColorAdjustType]::Bitmap)

    $destRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
    $g.DrawImage($src, $destRect, $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel, $ia)

    # Edge neutralization
    $leftRect = New-Object System.Drawing.Rectangle(0, 480, 200, 420)
    $leftBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($leftRect, [System.Drawing.Color]::FromArgb(55, 10, 10, 10), [System.Drawing.Color]::FromArgb(0, 10, 10, 10), [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal)
    $g.FillRectangle($leftBrush, $leftRect)

    $rightRect = New-Object System.Drawing.Rectangle(800, 380, 100, 620)
    $rightBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rightRect, [System.Drawing.Color]::FromArgb(0, 20, 20, 20), [System.Drawing.Color]::FromArgb(45, 20, 20, 20), [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal)
    $g.FillRectangle($rightBrush, $rightRect)

    # Fonts
    $mainFont = New-Object System.Drawing.Font("Georgia", [float]$Line1Size, [System.Drawing.FontStyle]::Bold)
    $subFont = New-Object System.Drawing.Font("Arial", [float]$Line2Size, [System.Drawing.FontStyle]::Bold)

    $alphaGold = 190
    $alphaShadow = 140
    $goldBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($alphaGold, 235, 178, 90))
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($alphaShadow, 10, 10, 10))
    $shadowSoftBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb([int]($alphaShadow * 0.5), 10, 10, 10))

    $sfCenter = New-Object System.Drawing.StringFormat
    $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
    $sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

    $sfRight = New-Object System.Drawing.StringFormat
    $sfRight.Alignment = [System.Drawing.StringAlignment]::Far
    $sfRight.LineAlignment = [System.Drawing.StringAlignment]::Center

    $offset = 2.0

    # Line 1: Main Title
    $rect1Y = $CenterY - ($Line1Size * 0.9)
    $rect1 = New-Object System.Drawing.RectangleF ([float]0, [float]$rect1Y, [float]$targetW, [float]($Line1Size * 1.8))
    $rect1Shadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rect1Y + $offset), [float]$targetW, [float]($Line1Size * 1.8))
    $rect1ShadowSoft = New-Object System.Drawing.RectangleF ([float]($offset * 1.8), [float]($rect1Y + ($offset * 1.8)), [float]$targetW, [float]($Line1Size * 1.8))

    $g.DrawString($Line1, $mainFont, $shadowSoftBrush, $rect1ShadowSoft, $sfCenter)
    $g.DrawString($Line1, $mainFont, $shadowBrush, $rect1Shadow, $sfCenter)
    $g.DrawString($Line1, $mainFont, $goldBrush, $rect1, $sfCenter)

    # Line 2: Subtitle
    $rect2Y = $CenterY + ($Line1Size * 0.45)
    $marginRight = $targetW * $Line2RightOffsetPercent
    $rect2 = New-Object System.Drawing.RectangleF ([float]0, [float]$rect2Y, [float]($targetW - $marginRight), [float]($Line2Size * 1.8))
    $rect2Shadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rect2Y + $offset), [float]($targetW - $marginRight), [float]($Line2Size * 1.8))

    $g.DrawString($Line2, $subFont, $shadowBrush, $rect2Shadow, $sfRight)
    $g.DrawString($Line2, $subFont, $goldBrush, $rect2, $sfRight)

    $outJpg = "$previewDir\$Name.jpg"
    $outWebp = "$previewDir\$Name.webp"
    $bmp.Save($outJpg, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    $g.Dispose()
    $ia.Dispose()
    $bmp.Dispose()
    $leftBrush.Dispose()
    $rightBrush.Dispose()
    $mainFont.Dispose()
    $subFont.Dispose()
    $goldBrush.Dispose()
    $shadowBrush.Dispose()
    $shadowSoftBrush.Dispose()

    & $cwebpExe -q 86 -m 6 "$outJpg" -o "$outWebp"
    Write-Host "Generated $Name"
}

# Variant A: Exact Title Case matching user input, beautifully proportioned inside the stone wall
Render-WatermarkVariant -Name "variant-titlecase" -Line1 "Shree Ram & Company" -Line2 "Vijeta Stone" -Line1Size 33.0 -Line2Size 17.0 -CenterY 560.0 -Line2RightOffsetPercent 0.22

# Variant B: All Caps, slightly more compact so it stays firmly on the stone wall
Render-WatermarkVariant -Name "variant-allcaps" -Line1 "SHREE RAM & COMPANY" -Line2 "VIJETA STONE" -Line1Size 32.0 -Line2Size 16.0 -CenterY 560.0 -Line2RightOffsetPercent 0.22

# Variant C: Both lines centered
function Render-BothCentered {
    param([string]$Name, [string]$Line1, [string]$Line2, [float]$Line1Size, [float]$Line2Size, [float]$CenterY)
    $bmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $c = 1.11; $b = 0.015; $t = (1.0 - $c)/2.0 + $b; $warmth = 0.035
    $rScale = [single]($c * 1.035); $gScale = [single]($c * 1.012); $bScale = [single]($c * 0.955)
    $tx = [single]($t + $warmth); $ty = [single]($t + ($warmth * 0.45)); $tz = [single]($t - ($warmth * 0.35))
    $pts = @(
        [single[]]@($rScale, 0.0, 0.0, 0.0, 0.0),
        [single[]]@(0.0, $gScale, 0.0, 0.0, 0.0),
        [single[]]@(0.0, 0.0, $bScale, 0.0, 0.0),
        [single[]]@(0.0, 0.0, 0.0, 1.0, 0.0),
        [single[]]@($tx, $ty, $tz, 0.0, 1.0)
    )
    $cm = New-Object System.Drawing.Imaging.ColorMatrix(,$pts)
    $ia = New-Object System.Drawing.Imaging.ImageAttributes
    $ia.SetColorMatrix($cm, [System.Drawing.Imaging.ColorMatrixFlag]::Default, [System.Drawing.Imaging.ColorAdjustType]::Bitmap)
    $destRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
    $g.DrawImage($src, $destRect, $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel, $ia)

    $leftRect = New-Object System.Drawing.Rectangle(0, 480, 200, 420)
    $leftBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($leftRect, [System.Drawing.Color]::FromArgb(55, 10, 10, 10), [System.Drawing.Color]::FromArgb(0, 10, 10, 10), [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal)
    $g.FillRectangle($leftBrush, $leftRect)

    $rightRect = New-Object System.Drawing.Rectangle(800, 380, 100, 620)
    $rightBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rightRect, [System.Drawing.Color]::FromArgb(0, 20, 20, 20), [System.Drawing.Color]::FromArgb(45, 20, 20, 20), [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal)
    $g.FillRectangle($rightBrush, $rightRect)

    $mainFont = New-Object System.Drawing.Font("Georgia", [float]$Line1Size, [System.Drawing.FontStyle]::Bold)
    $subFont = New-Object System.Drawing.Font("Arial", [float]$Line2Size, [System.Drawing.FontStyle]::Bold)

    $alphaGold = 190
    $alphaShadow = 140
    $goldBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($alphaGold, 235, 178, 90))
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($alphaShadow, 10, 10, 10))
    $shadowSoftBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb([int]($alphaShadow * 0.5), 10, 10, 10))

    $sfCenter = New-Object System.Drawing.StringFormat
    $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
    $sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center
    $offset = 2.0

    # Line 1
    $rect1Y = $CenterY - ($Line1Size * 0.8)
    $rect1 = New-Object System.Drawing.RectangleF ([float]0, [float]$rect1Y, [float]$targetW, [float]($Line1Size * 1.8))
    $rect1Shadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rect1Y + $offset), [float]$targetW, [float]($Line1Size * 1.8))
    $g.DrawString($Line1, $mainFont, $shadowBrush, $rect1Shadow, $sfCenter)
    $g.DrawString($Line1, $mainFont, $goldBrush, $rect1, $sfCenter)

    # Line 2: centered directly below
    $rect2Y = $CenterY + ($Line1Size * 0.45)
    $rect2 = New-Object System.Drawing.RectangleF ([float]0, [float]$rect2Y, [float]$targetW, [float]($Line2Size * 1.8))
    $rect2Shadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rect2Y + $offset), [float]$targetW, [float]($Line2Size * 1.8))
    $g.DrawString($Line2, $subFont, $shadowBrush, $rect2Shadow, $sfCenter)
    $g.DrawString($Line2, $subFont, $goldBrush, $rect2, $sfCenter)

    $outJpg = "$previewDir\$Name.jpg"
    $outWebp = "$previewDir\$Name.webp"
    $bmp.Save($outJpg, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    $g.Dispose(); $ia.Dispose(); $bmp.Dispose(); $leftBrush.Dispose(); $rightBrush.Dispose()
    $mainFont.Dispose(); $subFont.Dispose(); $goldBrush.Dispose(); $shadowBrush.Dispose(); $shadowSoftBrush.Dispose()

    & $cwebpExe -q 86 -m 6 "$outJpg" -o "$outWebp"
    Write-Host "Generated $Name"
}

Render-BothCentered -Name "variant-centered-both" -Line1 "Shree Ram & Company" -Line2 "Vijeta Stone" -Line1Size 33.0 -Line2Size 17.0 -CenterY 560.0

$src.Dispose()
