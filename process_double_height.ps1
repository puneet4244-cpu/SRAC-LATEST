# Retouching and Studio Optimization for Double Height Wall (Vijeta Stone)
Add-Type -AssemblyName System.Drawing

$rawPath = "c:\Users\shree\OneDrive\Desktop\NTRY\raw-originals\double-height-wall-raw-01.jpg"
$previewDir = "c:\Users\shree\OneDrive\Desktop\NTRY\preview"
if (-not (Test-Path $previewDir)) { New-Item -ItemType Directory -Path $previewDir -Force | Out-Null }

$tempJpg = "$previewDir\double-height-wall-01.jpg"
$finalWebp = "$previewDir\double-height-wall-01.webp"
$cwebpExe = "c:\Users\shree\OneDrive\Desktop\NTRY\tools\libwebp-1.4.0-windows-x64\bin\cwebp.exe"

$src = [System.Drawing.Image]::FromFile($rawPath)
$sw = $src.Width
$sh = $src.Height

# Target dimensions: 900 x 1200 (3:4 aspect ratio)
$targetW = 900
$targetH = 1200
$targetAspect = 3.0 / 4.0

# Raw image is 682 x 1024 (aspect ratio ~0.666).
# To get 3:4 ratio (0.75):
# cropW = 682, cropH = 682 / 0.75 = 909.333 -> round to 909
$cropW = $sw
$cropH = [int][Math]::Round($sw / $targetAspect)

# Distribute vertical crop:
# We trim 100px from the bottom (removing cut-off chair back & empty floor)
# and 15px from top (protecting full double-height chandelier & ceiling curvature)
$cropX = 0
$cropY = 15
if (($cropY + $cropH) -gt $sh) {
    $cropY = $sh - $cropH
}

Write-Host "Source: ${sw}x${sh}, Cropping rect: X=$cropX, Y=$cropY, W=$cropW, H=$cropH -> Target: ${targetW}x${targetH}"

$destBmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($destBmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Color grading matrix:
# 1. Boost contrast slightly (1.10) to accentuate the 3D relief contour depth
# 2. Lift midtone brightness (+0.02) to reveal fine stone carving details
# 3. Add subtle warm golden-amber tone to stone (slight red/green boost relative to blue)
#    to eliminate sterile cool camera tints and give authentic Gwalior Mint / warm Indian sandstone glow
$contrast = 1.10
$brightness = 0.02
$t = (1.0 - $contrast) / 2.0 + $brightness

# Warm stone balance: Red * 1.03, Green * 1.01, Blue * 0.96
$rScale = 1.03 * $contrast
$gScale = 1.01 * $contrast
$bScale = 0.96 * $contrast

$pts = @(
    [single[]]@($rScale, 0.0,     0.0,     0.0, 0.0),
    [single[]]@(0.0,     $gScale, 0.0,     0.0, 0.0),
    [single[]]@(0.0,     0.0,     $bScale, 0.0, 0.0),
    [single[]]@(0.0,     0.0,     0.0,     1.0, 0.0),
    [single[]]@($t + 0.015, $t + 0.008, $t - 0.005, 0.0, 1.0)
)

$cm = New-Object System.Drawing.Imaging.ColorMatrix(,$pts)
$ia = New-Object System.Drawing.Imaging.ImageAttributes
$ia.SetColorMatrix($cm, [System.Drawing.Imaging.ColorMatrixFlag]::Default, [System.Drawing.Imaging.ColorAdjustType]::Bitmap)

$destRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
$g.DrawImage($src, $destRect, $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel, $ia)

# --- Watermark: "Vijeta Stone" ---
# Small, subtle, semi-transparent watermark in bottom-right corner
# Matching section 2 spec: "small, subtle, semi-transparent watermark in the bottom-right corner reading 'Vijeta Stone'"
$watermarkText = "Vijeta Stone"
$fontSize = 18.0
$wmFont = New-Object System.Drawing.Font("Georgia", [float]$fontSize, [System.Drawing.FontStyle]::Bold)

# Measure text size
$textSize = $g.MeasureString($watermarkText, $wmFont)
$wmMarginX = 32.0
$wmMarginY = 28.0
$wmX = $targetW - $textSize.Width - $wmMarginX
$wmY = $targetH - $textSize.Height - $wmMarginY

# Draw subtle shadow for contrast against light or dark background (opacity 90 / 255)
$shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 0, 0, 0))
# Warm pearl-white text with 55% opacity (140 / 255)
$wmBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(150, 255, 252, 245))

# Draw subtle drop shadow offset by 1.5px
$g.DrawString($watermarkText, $wmFont, $shadowBrush, ($wmX + 1.5), ($wmY + 1.5))
# Draw watermark text
$g.DrawString($watermarkText, $wmFont, $wmBrush, $wmX, $wmY)

# Save intermediate high-quality image
$destBmp.Save($tempJpg, [System.Drawing.Imaging.ImageFormat]::Jpeg)

$g.Dispose()
$ia.Dispose()
$destBmp.Dispose()
$src.Dispose()
$wmFont.Dispose()
$shadowBrush.Dispose()
$wmBrush.Dispose()

Write-Host "Saved high-res retouched frame to $tempJpg"

# Convert to WebP using cwebp with quality 85 (ensures < 200KB and razor-sharp stone detail)
& $cwebpExe -q 85 "$tempJpg" -o "$finalWebp"

$webpInfo = Get-Item $finalWebp
$sizeKb = [Math]::Round($webpInfo.Length / 1024, 2)
Write-Host "Generated WebP: $finalWebp ($sizeKb KB)"
