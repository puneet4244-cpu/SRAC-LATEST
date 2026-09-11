Add-Type -AssemblyName System.Drawing

$testPath = Join-Path $PSScriptRoot "test_exact_watermark.png"
$bmp = New-Object System.Drawing.Bitmap (1200, 400)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::FromArgb(40, 35, 30))

# Colors from reference image: Rich golden tone with warm gradient feel
$goldColor = [System.Drawing.Color]::FromArgb(250, 228, 169, 84)     # #E4A954
$goldLight = [System.Drawing.Color]::FromArgb(255, 245, 195, 120)    # #F5C378
$shadowColor = [System.Drawing.Color]::FromArgb(210, 0, 0, 0)        # Deep shadow
$shadowSoft = [System.Drawing.Color]::FromArgb(120, 0, 0, 0)

$goldBrush = New-Object System.Drawing.SolidBrush ($goldColor)
$goldLightBrush = New-Object System.Drawing.SolidBrush ($goldLight)
$shadowBrush = New-Object System.Drawing.SolidBrush ($shadowColor)
$shadowSoftBrush = New-Object System.Drawing.SolidBrush ($shadowSoft)

# Fonts matching reference
$mainFont = New-Object System.Drawing.Font ("Georgia", [float]46, [System.Drawing.FontStyle]::Regular)
$subFont = New-Object System.Drawing.Font ("Arial", [float]20, [System.Drawing.FontStyle]::Bold)
$phoneFont = New-Object System.Drawing.Font ("Georgia", [float]34, [System.Drawing.FontStyle]::Bold)

$sfLeft = New-Object System.Drawing.StringFormat
$sfLeft.Alignment = [System.Drawing.StringAlignment]::Near

$sfRight = New-Object System.Drawing.StringFormat
$sfRight.Alignment = [System.Drawing.StringAlignment]::Far

$sfCenter = New-Object System.Drawing.StringFormat
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center

# Draw 1. SHREE RAM & COMPANY
$rectMain = New-Object System.Drawing.RectangleF ([float]100, [float]80, [float]1000, [float]70)
$rectMainShadow = New-Object System.Drawing.RectangleF ([float]103, [float]83, [float]1000, [float]70)
$rectMainShadowSoft = New-Object System.Drawing.RectangleF ([float]105, [float]85, [float]1000, [float]70)

$g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowSoftBrush, $rectMainShadowSoft, $sfCenter)
$g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowBrush, $rectMainShadow, $sfCenter)
$g.DrawString("SHREE RAM & COMPANY", $mainFont, $goldBrush, $rectMain, $sfCenter)

# Draw 2. VIJETA STONE (Right aligned under COMPANY)
$rectSub = New-Object System.Drawing.RectangleF ([float]100, [float]160, [float]950, [float]40)
$rectSubShadow = New-Object System.Drawing.RectangleF ([float]102, [float]162, [float]950, [float]40)

$g.DrawString("VIJETA STONE", $subFont, $shadowBrush, $rectSubShadow, $sfRight)
$g.DrawString("VIJETA STONE", $subFont, $goldBrush, $rectSub, $sfRight)

# Draw 3. 6367607459 (Centered below)
$rectPhone = New-Object System.Drawing.RectangleF ([float]100, [float]230, [float]1000, [float]50)
$rectPhoneShadow = New-Object System.Drawing.RectangleF ([float]103, [float]233, [float]1000, [float]50)

$g.DrawString("6367607459", $phoneFont, $shadowBrush, $rectPhoneShadow, $sfCenter)
$g.DrawString("6367607459", $phoneFont, $goldBrush, $rectPhone, $sfCenter)

$bmp.Save($testPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
Write-Host "Exact watermark reference rendered to: $testPath"
