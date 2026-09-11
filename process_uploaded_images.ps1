# Automation script to process, color-grade, center-focus, and resize bulk uploaded images to 900x1200 (3:4 ratio)
Add-Type -AssemblyName System.Drawing

function Optimize-ProductImage {
    param (
        [string]$SourcePath,
        [string]$DestinationPath,
        [int]$TargetWidth = 900,
        [int]$TargetHeight = 1200,
        [float]$Contrast = 1.08,     # Crisp contrast for stone textures
        [float]$Brightness = 0.02,   # Slight lift to bring out carving details
        [float]$Saturation = 1.08    # Rich natural colors for marble & sandstone
    )

    if (-not (Test-Path $SourcePath)) {
        Write-Warning "Source image does not exist: $SourcePath"
        return
    }

    $destDir = [System.IO.Path]::GetDirectoryName($DestinationPath)
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    $srcImg = [System.Drawing.Image]::FromFile($SourcePath)
    $srcW = $srcImg.Width
    $srcH = $srcImg.Height

    # Target Aspect Ratio is 3:4 (0.75)
    $targetAspect = [double]$TargetWidth / [double]$TargetHeight
    $srcAspect = [double]$srcW / [double]$srcH

    $cropX = 0
    $cropY = 0
    $cropW = $srcW
    $cropH = $srcH

    if ($srcAspect -gt $targetAspect) {
        # Image is wider than 3:4 -> Crop left & right to center on product
        $cropW = [int]($srcH * $targetAspect)
        $cropX = [int](($srcW - $cropW) / 2)
    } elseif ($srcAspect -lt $targetAspect) {
        # Image is taller than 3:4 -> Crop top/bottom (slight 40/60 distribution to protect top carving/head)
        $cropH = [int]($srcW / $targetAspect)
        $cropY = [int](($srcH - $cropH) * 0.40)
    }

    $destBitmap = New-Object System.Drawing.Bitmap($TargetWidth, $TargetHeight, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($destBitmap)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

    # Color grading matrix
    $c = $Contrast
    $b = $Brightness
    $t = (1.0 - $c) / 2.0 + $b

    # Lum weights for saturation
    $rw = 0.3086 * (1.0 - $Saturation)
    $gw = 0.6094 * (1.0 - $Saturation)
    $bw = 0.0820 * (1.0 - $Saturation)

    $cm00 = ($rw + $Saturation) * $c
    $cm01 = $rw * $c
    $cm02 = $rw * $c

    $cm10 = $gw * $c
    $cm11 = ($gw + $Saturation) * $c
    $cm12 = $gw * $c

    $cm20 = $bw * $c
    $cm21 = $bw * $c
    $cm22 = ($bw + $Saturation) * $c

    $ptsArray = @(
        [single[]]@($cm00, $cm01, $cm02, 0.0, 0.0),
        [single[]]@($cm10, $cm11, $cm12, 0.0, 0.0),
        [single[]]@($cm20, $cm21, $cm22, 0.0, 0.0),
        [single[]]@(0.0,   0.0,   0.0,   1.0, 0.0),
        [single[]]@($t,    $t,    $t,    0.0, 1.0)
    )

    $colorMatrix = New-Object System.Drawing.Imaging.ColorMatrix(,$ptsArray)
    $imageAttr = New-Object System.Drawing.Imaging.ImageAttributes
    $imageAttr.SetColorMatrix($colorMatrix, [System.Drawing.Imaging.ColorMatrixFlag]::Default, [System.Drawing.Imaging.ColorAdjustType]::Bitmap)

    $destRect = New-Object System.Drawing.Rectangle(0, 0, $TargetWidth, $TargetHeight)
    $graphics.DrawImage($srcImg, $destRect, $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel, $imageAttr)

    # Save as high quality JPEG (quality 95)
    $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatID -eq [System.Drawing.Imaging.ImageFormat]::Jpeg.Guid }
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    $destBitmap.Save($DestinationPath, $jpegCodec, $encoderParams)

    $graphics.Dispose()
    $imageAttr.Dispose()
    $destBitmap.Dispose()
    $srcImg.Dispose()

    Write-Host "Processed & Color-graded: $DestinationPath (900x1200, 3:4, High Quality)"
}

Write-Host "Image processor ready."
