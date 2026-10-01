Add-Type -AssemblyName System.Drawing

function Apply-VietaWatermark {
    param(
        [string]$inputPath,
        [string]$outputPath
    )

    if (-not (Test-Path $inputPath)) {
        Write-Error "File not found: $inputPath"
        return
    }

    # Load original image
    $imgBytes = [System.IO.File]::ReadAllBytes($inputPath)
    $ms = New-Object System.IO.MemoryStream(,$imgBytes)
    $img = [System.Drawing.Image]::FromStream($ms)
    
    $w = $img.Width
    $h = $img.Height

    $bmp = New-Object System.Drawing.Bitmap ($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Draw image
    $g.DrawImage($img, 0, 0, $w, $h)

    # Watermark specification:
    # Text: "Shree Ram & Company Vieta Stone"
    # Position: bottom-right corner (~3% margin from edges)
    # Style: clean elegant serif font, white text at ~55-65% opacity (60% = alpha 153), subtle soft shadow
    # Size: font size proportional (~2.4% - 2.8% of image width, e.g. 22pt for 900w)
    $watermarkText = "Shree Ram & Company Vieta Stone"
    
    $fontSize = [Math]::Max(14.0, ($w * 0.026))
    $font = New-Object System.Drawing.Font ("Georgia", [float]$fontSize, [System.Drawing.FontStyle]::Regular)

    $marginRight = $w * 0.035
    $marginBottom = $h * 0.03

    # Measure string
    $stringSize = $g.MeasureString($watermarkText, $font)
    $x = $w - $stringSize.Width - $marginRight
    $y = $h - $stringSize.Height - $marginBottom

    # 60% opacity white text
    $textBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(150, 255, 255, 255))
    # Subtle soft drop shadow (30% black)
    $shadowBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(65, 0, 0, 0))

    $shadowOffset = [Math]::Max(1.0, ($w * 0.0015))

    # Draw shadow then text
    $g.DrawString($watermarkText, $font, $shadowBrush, [float]($x + $shadowOffset), [float]($y + $shadowOffset))
    $g.DrawString($watermarkText, $font, $textBrush, [float]$x, [float]$y)

    # Save to output path
    # If jpeg:
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]92)
    
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    
    if ($outputPath.EndsWith(".png")) {
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
}

# Test on a sample image
$testOut = "tools/test_vieta_watermark.jpg"
Apply-VietaWatermark -inputPath "assets/images/sofa-wall.jpg" -outputPath $testOut
Write-Host "Test watermark created at $testOut"
