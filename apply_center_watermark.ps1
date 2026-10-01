# Center Watermark Refinement for Double Height Wall
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

$bmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# 1. Color Grading & Studio Light Correction
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

# Background neutralization on side margins
$leftRect = New-Object System.Drawing.Rectangle(0, 480, 200, 420)
$leftBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $leftRect,
    [System.Drawing.Color]::FromArgb(55, 10, 10, 10),
    [System.Drawing.Color]::FromArgb(0, 10, 10, 10),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($leftBrush, $leftRect)

$rightRect = New-Object System.Drawing.Rectangle(800, 380, 100, 620)
$rightBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $rightRect,
    [System.Drawing.Color]::FromArgb(0, 20, 20, 20),
    [System.Drawing.Color]::FromArgb(45, 20, 20, 20),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($rightBrush, $rightRect)

# --- 2. WATERMARK IN CENTRE ---
# "SHREE RAM & COMPANY"
#        "VIJETA STONE"
$centerY = 575.0  # Placed right across the focal center of the 3D relief wall

$mainFontSize = 38.0
$subFontSize = 18.0

$mainFont = New-Object System.Drawing.Font("Georgia", [float]$mainFontSize, [System.Drawing.FontStyle]::Regular)
$subFont = New-Object System.Drawing.Font("Arial", [float]$subFontSize, [System.Drawing.FontStyle]::Bold)

# Rich semi-transparent golden palette with soft drop shadow
# Opacity: ~70% (175/255) for elegant luxury look that protects the photo while showing stone relief
$alphaGold = 185
$alphaShadow = 135

$goldMain = [System.Drawing.Color]::FromArgb($alphaGold, 232, 175, 88)
$shadowDark = [System.Drawing.Color]::FromArgb($alphaShadow, 15, 15, 15)
$shadowSoft = [System.Drawing.Color]::FromArgb([int]($alphaShadow * 0.6), 10, 10, 10)

$goldBrush = New-Object System.Drawing.SolidBrush($goldMain)
$shadowBrush = New-Object System.Drawing.SolidBrush($shadowDark)
$shadowSoftBrush = New-Object System.Drawing.SolidBrush($shadowSoft)

$sfCenter = New-Object System.Drawing.StringFormat
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$sfRight = New-Object System.Drawing.StringFormat
$sfRight.Alignment = [System.Drawing.StringAlignment]::Far
$sfRight.LineAlignment = [System.Drawing.StringAlignment]::Center

$offsetShadow = 2.0

# 1. Main Title: "SHREE RAM & COMPANY"
$rectMainY = $centerY - ($mainFontSize * 0.9)
$rectMain = New-Object System.Drawing.RectangleF ([float]0, [float]$rectMainY, [float]$targetW, [float]($mainFontSize * 1.8))
$rectMainShadow = New-Object System.Drawing.RectangleF ([float]$offsetShadow, [float]($rectMainY + $offsetShadow), [float]$targetW, [float]($mainFontSize * 1.8))
$rectMainShadowSoft = New-Object System.Drawing.RectangleF ([float]($offsetShadow * 1.8), [float]($rectMainY + ($offsetShadow * 1.8)), [float]$targetW, [float]($mainFontSize * 1.8))

$g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowSoftBrush, $rectMainShadowSoft, $sfCenter)
$g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowBrush, $rectMainShadow, $sfCenter)
$g.DrawString("SHREE RAM & COMPANY", $mainFont, $goldBrush, $rectMain, $sfCenter)

# 2. Subtitle: "VIJETA STONE" positioned under the right wing of COMPANY
$rectSubY = $centerY + ($mainFontSize * 0.5)
$subRightMargin = $targetW * 0.16
$rectSub = New-Object System.Drawing.RectangleF ([float]0, [float]$rectSubY, [float]($targetW - $subRightMargin), [float]($subFontSize * 1.8))
$rectSubShadow = New-Object System.Drawing.RectangleF ([float]$offsetShadow, [float]($rectSubY + $offsetShadow), [float]($targetW - $subRightMargin), [float]($subFontSize * 1.8))

$g.DrawString("VIJETA STONE", $subFont, $shadowBrush, $rectSubShadow, $sfRight)
$g.DrawString("VIJETA STONE", $subFont, $goldBrush, $rectSub, $sfRight)

# Save intermediate high-quality image
$finalJpg = "$previewDir\double-height-wall-01.jpg"
$finalWebp = "$previewDir\double-height-wall-01.webp"

$bmp.Save($finalJpg, [System.Drawing.Imaging.ImageFormat]::Jpeg)

$g.Dispose()
$ia.Dispose()
$bmp.Dispose()
$src.Dispose()
$leftBrush.Dispose()
$rightBrush.Dispose()
$mainFont.Dispose()
$subFont.Dispose()
$goldBrush.Dispose()
$shadowBrush.Dispose()
$shadowSoftBrush.Dispose()

# Convert to WebP
& $cwebpExe -q 86 -m 6 "$finalJpg" -o "$finalWebp"

$info = Get-Item $finalWebp
$kb = [Math]::Round($info.Length / 1024, 2)
Write-Host "Generated WebP with center watermark: $finalWebp ($kb KB)"
