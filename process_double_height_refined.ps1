# Refined Studio Retoucher for Double Height Wall
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

# Crop setup:
# Full width 682 -> 3:4 height is 909.
# Setting cropY = 30 gives the perfect balance:
# Chandelier top is preserved with breathing room,
# while the dining table and chairs are neatly grounded at the bottom.
$cropX = 0
$cropY = 30
$cropW = $sw
$cropH = [int][Math]::Round($sw / $targetAspect)

$bmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# 1. Studio Color Grading:
# Contrast 1.11, slight brightness lift 0.015, warm sandstone tone (Gwalior Mint / Bansi warm cream)
$c = 1.11
$b = 0.015
$t = (1.0 - $c) / 2.0 + $b
$warmth = 0.035

$rScale = [single]($c * 1.035)
$gScale = [single]($c * 1.012)
$bScale = [single]($c * 0.955)
$tx = [single]($t + $warmth)
$ty = [single]($t + ($warmth * 0.45))
$tz = [single]($t - ($warmth * 0.35))

$pts = @(
    [single[]]@($rScale, 0.0,     0.0,     0.0, 0.0),
    [single[]]@(0.0,     $gScale, 0.0,     0.0, 0.0),
    [single[]]@(0.0,     0.0,     $bScale, 0.0, 0.0),
    [single[]]@(0.0,     0.0,     0.0,     1.0, 0.0),
    [single[]]@($tx,     $ty,     $tz,     0.0, 1.0)
)

$cm = New-Object System.Drawing.Imaging.ColorMatrix(,$pts)
$ia = New-Object System.Drawing.Imaging.ImageAttributes
$ia.SetColorMatrix($cm, [System.Drawing.Imaging.ColorMatrixFlag]::Default, [System.Drawing.Imaging.ColorAdjustType]::Bitmap)

$destRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
$g.DrawImage($src, $destRect, $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel, $ia)

# 2. Subtle Background Neutralization:
# Per Rule 8: Subtly neutralize extraneous background clutter (left doorway opening & right exterior window AC)
# We apply a very subtle, transparent gradient burn/soften on the far left doorway interior (x: 0 to 180, y: 500 to 900)
# and far right terrace window (x: 820 to 900, y: 400 to 1000) so attention naturally locks onto the stone wall.

# Far left doorway interior tint: smooth darkening brush
$leftRect = New-Object System.Drawing.Rectangle(0, 480, 200, 420)
$leftBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $leftRect,
    [System.Drawing.Color]::FromArgb(55, 10, 10, 10),
    [System.Drawing.Color]::FromArgb(0, 10, 10, 10),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($leftBrush, $leftRect)

# Far right terrace exterior window tint: smooth subtle neutralizing brush
$rightRect = New-Object System.Drawing.Rectangle(800, 380, 100, 620)
$rightBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $rightRect,
    [System.Drawing.Color]::FromArgb(0, 20, 20, 20),
    [System.Drawing.Color]::FromArgb(45, 20, 20, 20),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($rightBrush, $rightRect)

# 3. Watermark: "Vijeta Stone"
# Consistent placement, subtle opacity, bottom-right corner
$wmText = "Vijeta Stone"
$wmFont = New-Object System.Drawing.Font("Georgia", [float]18.5, [System.Drawing.FontStyle]::Bold)
$textSize = $g.MeasureString($wmText, $wmFont)
$wmMarginX = 30.0
$wmMarginY = 26.0
$wmX = $targetW - $textSize.Width - $wmMarginX
$wmY = $targetH - $textSize.Height - $wmMarginY

$shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 0, 0, 0))
$wmBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(155, 255, 252, 245))

$g.DrawString($wmText, $wmFont, $shadowBrush, ($wmX + 1.5), ($wmY + 1.5))
$g.DrawString($wmText, $wmFont, $wmBrush, $wmX, $wmY)

$finalJpg = "$previewDir\double-height-wall-01.jpg"
$finalWebp = "$previewDir\double-height-wall-01.webp"

$bmp.Save($finalJpg, [System.Drawing.Imaging.ImageFormat]::Jpeg)

# Clean up GDI objects
$g.Dispose()
$ia.Dispose()
$bmp.Dispose()
$src.Dispose()
$leftBrush.Dispose()
$rightBrush.Dispose()
$wmFont.Dispose()
$shadowBrush.Dispose()
$wmBrush.Dispose()

# Convert to WebP using Google libwebp cwebp with optimal quality 86
& $cwebpExe -q 86 -m 6 "$finalJpg" -o "$finalWebp"

$info = Get-Item $finalWebp
$kb = [Math]::Round($info.Length / 1024, 2)
Write-Host "SUCCESS: $finalWebp generated ($kb KB)"
