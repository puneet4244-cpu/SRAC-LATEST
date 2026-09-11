Add-Type -AssemblyName System.Drawing

$testPath = Join-Path $PSScriptRoot "test_watermark.png"
$bmp = New-Object System.Drawing.Bitmap (1200, 900)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::FromArgb(250, 248, 244))

$font1 = New-Object System.Drawing.Font ("Georgia", [float]32, [System.Drawing.FontStyle]::Bold)
$brush1 = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(140, 34, 34, 34))

$font2 = New-Object System.Drawing.Font ("Arial", [float]14, [System.Drawing.FontStyle]::Bold)
$brush2 = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(200, 198, 161, 110))

$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$sf.LineAlignment = [System.Drawing.StringAlignment]::Center

$rect1 = New-Object System.Drawing.RectangleF ([float]0, [float]400, [float]1200, [float]50)
$rect2 = New-Object System.Drawing.RectangleF ([float]0, [float]455, [float]1200, [float]30)

$g.DrawString("SHREE RAM & COMPANY", $font1, $brush1, $rect1, $sf)
$g.DrawString("V I J E T A   S T O N E", $font2, $brush2, $rect2, $sf)

$bmp.Save($testPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
Write-Host "Watermark test successfully rendered to: $testPath"
