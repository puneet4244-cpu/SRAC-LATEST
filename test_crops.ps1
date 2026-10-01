# Generate comparison crops for double-height wall
Add-Type -AssemblyName System.Drawing

$rawPath = "c:\Users\shree\OneDrive\Desktop\NTRY\raw-originals\double-height-wall-raw-01.jpg"
$previewDir = "c:\Users\shree\OneDrive\Desktop\NTRY\preview"
$cwebpExe = "c:\Users\shree\OneDrive\Desktop\NTRY\tools\libwebp-1.4.0-windows-x64\bin\cwebp.exe"

$src = [System.Drawing.Image]::FromFile($rawPath)
$sw = $src.Width
$sh = $src.Height

function Create-EditedImage {
    param(
        [string]$Name,
        [int]$CropX,
        [int]$CropY,
        [int]$CropW,
        [int]$CropH,
        [float]$Contrast = 1.12,
        [float]$Brightness = 0.02,
        [float]$Warmth = 0.03
    )

    $targetW = 900
    $targetH = 1200

    $bmp = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $c = $Contrast
    $b = $Brightness
    $t = (1.0 - $c) / 2.0 + $b

    # Matrix: warm stone grade
    $rScale = [single]($c * 1.03)
    $gScale = [single]($c * 1.01)
    $bScale = [single]($c * 0.96)
    $tx = [single]($t + $Warmth)
    $ty = [single]($t + ($Warmth * 0.5))
    $tz = [single]($t - ($Warmth * 0.3))

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
    $g.DrawImage($src, $destRect, $CropX, $CropY, $CropW, $CropH, [System.Drawing.GraphicsUnit]::Pixel, $ia)

    # Watermark: "Vijeta Stone"
    $wmText = "Vijeta Stone"
    $wmFont = New-Object System.Drawing.Font("Georgia", [float]19.0, [System.Drawing.FontStyle]::Bold)
    $textSize = $g.MeasureString($wmText, $wmFont)
    $wmX = $targetW - $textSize.Width - 32.0
    $wmY = $targetH - $textSize.Height - 30.0

    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(100, 0, 0, 0))
    $wmBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(165, 255, 252, 245))

    $g.DrawString($wmText, $wmFont, $shadowBrush, ($wmX + 1.5), ($wmY + 1.5))
    $g.DrawString($wmText, $wmFont, $wmBrush, $wmX, $wmY)

    $outJpg = "$previewDir\$Name.jpg"
    $outWebp = "$previewDir\$Name.webp"
    $bmp.Save($outJpg, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    $g.Dispose()
    $ia.Dispose()
    $bmp.Dispose()
    $wmFont.Dispose()
    $shadowBrush.Dispose()
    $wmBrush.Dispose()

    & $cwebpExe -q 85 "$outJpg" -o "$outWebp"
    $info = Get-Item $outWebp
    $kb = [Math]::Round($info.Length / 1024, 2)
    Write-Host "$Name -> $kb KB"
}

# Option A: Full architectural double-height view (682x909, cropped from bottom floor)
Create-EditedImage -Name "double-height-wall-01-full" -CropX 0 -CropY 20 -CropW 682 -CropH 909

# Option B: Hero Stone Focus (cropped tighter on stone wall: 580x773, eliminating bottom chair back & cutting kitchen clutter)
# Center slightly on stone wall: x from 45 to 625
Create-EditedImage -Name "double-height-wall-01-hero" -CropX 45 -CropY 10 -CropW 580 -CropH 773

# Option C: Balanced Sweet Spot (630x840, starting at x=20, y=15)
Create-EditedImage -Name "double-height-wall-01-balanced" -CropX 20 -CropY 15 -CropW 630 -CropH 840

$src.Dispose()
