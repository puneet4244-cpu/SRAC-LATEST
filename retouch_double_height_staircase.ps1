# Retouching & studio optimization script for Double Height and Staircase Wall photos
Add-Type -AssemblyName System.Drawing

function Retouch-StudioImage {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [int]$TargetWidth = 900,
        [int]$TargetHeight = 1200,
        [double]$CropXPercent = 0.5,    # 0 = left, 0.5 = center, 1 = right
        [double]$CropYPercent = 0.5,    # 0 = top, 0.5 = center, 1 = bottom
        [float]$Contrast = 1.10,
        [float]$Brightness = 0.02,
        [float]$Saturation = 1.10
    )

    if (-not (Test-Path $SourcePath)) {
        Write-Error "Source path not found: $SourcePath"
        return
    }

    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $sw = $src.Width
    $sh = $src.Height

    # Desired aspect ratio 3:4 = 0.75
    $targetAspect = [double]$TargetWidth / [double]$TargetHeight
    $srcAspect = [double]$sw / [double]$sh

    if ($srcAspect -gt $targetAspect) {
        # Image is wider than 3:4 -> crop horizontally
        $cropW = [int]($sh * $targetAspect)
        $cropH = $sh
        $cropX = [int](($sw - $cropW) * $CropXPercent)
        $cropY = 0
    } else {
        # Image is taller than 3:4 -> crop vertically
        $cropW = $sw
        $cropH = [int]($sw / $targetAspect)
        $cropX = 0
        $cropY = [int](($sh - $cropH) * $CropYPercent)
    }

    # Bounds check
    if ($cropX -lt 0) { $cropX = 0 }
    if ($cropY -lt 0) { $cropY = 0 }
    if (($cropX + $cropW) -gt $sw) { $cropW = $sw - $cropX }
    if (($cropY + $cropH) -gt $sh) { $cropH = $sh - $cropY }

    $destBmp = New-Object System.Drawing.Bitmap($TargetWidth, $TargetHeight, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $g = [System.Drawing.Graphics]::FromImage($destBmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

    # Color matrix for studio lighting, depth & enhanced stone color grading
    $c = $Contrast
    $b = $Brightness
    $s = $Saturation
    $t = (1.0 - $c) / 2.0 + $b

    $rw = 0.3086 * (1.0 - $s)
    $gw = 0.6094 * (1.0 - $s)
    $bw = 0.0820 * (1.0 - $s)

    $cm00 = ($rw + $s) * $c
    $cm01 = $rw * $c
    $cm02 = $rw * $c

    $cm10 = $gw * $c
    $cm11 = ($gw + $s) * $c
    $cm12 = $gw * $c

    $cm20 = $bw * $c
    $cm21 = $bw * $c
    $cm22 = ($bw + $s) * $c

    $pts = @(
        [single[]]@($cm00, $cm01, $cm02, 0.0, 0.0),
        [single[]]@($cm10, $cm11, $cm12, 0.0, 0.0),
        [single[]]@($cm20, $cm21, $cm22, 0.0, 0.0),
        [single[]]@(0.0,   0.0,   0.0,   1.0, 0.0),
        [single[]]@($t,    $t,    $t,    0.0, 1.0)
    )

    $cm = New-Object System.Drawing.Imaging.ColorMatrix(,$pts)
    $ia = New-Object System.Drawing.Imaging.ImageAttributes
    $ia.SetColorMatrix($cm, [System.Drawing.Imaging.ColorMatrixFlag]::Default, [System.Drawing.Imaging.ColorAdjustType]::Bitmap)

    $destRect = New-Object System.Drawing.Rectangle(0, 0, $TargetWidth, $TargetHeight)
    $g.DrawImage($src, $destRect, $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel, $ia)

    # Save with 95% JPEG quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatID -eq [System.Drawing.Imaging.ImageFormat]::Jpeg.Guid }
    $ep = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    $destBmp.Save($OutputPath, $codec, $ep)

    $g.Dispose()
    $ia.Dispose()
    $destBmp.Dispose()
    $src.Dispose()

    Write-Host "Studio Retouched -> $OutputPath (900x1200, 3:4, Contrast: $Contrast, Saturation: $Saturation)"
}

$userDir = "C:\Users\shree\.gemini\antigravity-ide\brain\059785c7-1675-4ae9-a295-9f53674d862f\.user_uploaded"
$outDir = "c:\Users\shree\OneDrive\Desktop\NTRY\assets\images"

# 1. Mandala / Radial Rosette Staircase Wall (Crop slightly lower to cut off harsh ceiling flare & highlight center medallions)
Retouch-StudioImage `
    -SourcePath "$userDir\media_1788764405717.jpg" `
    -OutputPath "$outDir\staircase-mandala-radial-carving.jpg" `
    -CropXPercent 0.5 `
    -CropYPercent 0.55 `
    -Contrast 1.12 `
    -Brightness 0.02 `
    -Saturation 1.08

# 2. Maple Leaf 3D Sandstone Staircase Wall (Center crop horizontally on leaves cluster)
Retouch-StudioImage `
    -SourcePath "$userDir\media_1788764405777.jpg" `
    -OutputPath "$outDir\staircase-maple-leaf-relief.jpg" `
    -CropXPercent 0.35 `
    -CropYPercent 0.45 `
    -Contrast 1.10 `
    -Brightness 0.03 `
    -Saturation 1.12

# 3. Ginkgo Fan Leaf Backlit Fluted Staircase Wall
Retouch-StudioImage `
    -SourcePath "$userDir\media_1788764405799.jpg" `
    -OutputPath "$outDir\staircase-ginkgo-backlit-panel.jpg" `
    -CropXPercent 0.5 `
    -CropYPercent 0.40 `
    -Contrast 1.14 `
    -Brightness 0.02 `
    -Saturation 1.15

# 4. Lotus Backlit 3D Relief Double Height Wall
Retouch-StudioImage `
    -SourcePath "$userDir\media_1788764405883.jpg" `
    -OutputPath "$outDir\double-height-lotus-backlit.jpg" `
    -CropXPercent 0.5 `
    -CropYPercent 0.35 `
    -Contrast 1.12 `
    -Brightness 0.03 `
    -Saturation 1.12

# 5. Medallion & Fluted Architectural Facade
Retouch-StudioImage `
    -SourcePath "$userDir\media_1788764406211.jpg" `
    -OutputPath "$outDir\double-height-medallion-facade.jpg" `
    -CropXPercent 0.5 `
    -CropYPercent 0.45 `
    -Contrast 1.10 `
    -Brightness 0.02 `
    -Saturation 1.10

Write-Host "All 5 images successfully retouched and saved!"
