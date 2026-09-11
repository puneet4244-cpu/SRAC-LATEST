# Exact Reference Watermark Processor for Shree Ram & Company (Vijeta Stone)
Add-Type -AssemblyName System.Drawing

$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$assetsDir = "$baseDir\assets\images"

function Apply-ExactWatermark {
    param(
        [string]$filePath
    )

    if (-not (Test-Path $filePath)) { return }

    try {
        $img = [System.Drawing.Image]::FromFile($filePath)
        $w = $img.Width
        $h = $img.Height

        $bmp = New-Object System.Drawing.Bitmap ($w, $h)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

        # Draw base image
        $g.DrawImage($img, 0, 0, $w, $h)
        $img.Dispose()

        # Dynamic scale based on width
        $mainFontSize = [Math]::Max(24.0, ($w * 0.046))
        $subFontSize = [Math]::Max(11.0, ($w * 0.020))
        $phoneFontSize = [Math]::Max(18.0, ($w * 0.034))

        # Fonts
        $mainFont = New-Object System.Drawing.Font ("Georgia", [float]$mainFontSize, [System.Drawing.FontStyle]::Regular)
        $subFont = New-Object System.Drawing.Font ("Arial", [float]$subFontSize, [System.Drawing.FontStyle]::Bold)
        $phoneFont = New-Object System.Drawing.Font ("Georgia", [float]$phoneFontSize, [System.Drawing.FontStyle]::Bold)

        # Exact Golden Palette from Reference Photo
        $goldMain = [System.Drawing.Color]::FromArgb(245, 229, 169, 83)      # Rich warm metallic gold
        $goldHighlight = [System.Drawing.Color]::FromArgb(255, 248, 205, 130) # Top bevel highlight
        $shadowDark = [System.Drawing.Color]::FromArgb(220, 0, 0, 0)          # Crisp drop shadow
        $shadowSoft = [System.Drawing.Color]::FromArgb(110, 0, 0, 0)          # Ambient shadow

        $goldBrush = New-Object System.Drawing.SolidBrush ($goldMain)
        $goldHighlightBrush = New-Object System.Drawing.SolidBrush ($goldHighlight)
        $shadowBrush = New-Object System.Drawing.SolidBrush ($shadowDark)
        $shadowSoftBrush = New-Object System.Drawing.SolidBrush ($shadowSoft)

        $sfCenter = New-Object System.Drawing.StringFormat
        $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
        $sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

        $sfRight = New-Object System.Drawing.StringFormat
        $sfRight.Alignment = [System.Drawing.StringAlignment]::Far
        $sfRight.LineAlignment = [System.Drawing.StringAlignment]::Center

        $centerY = $h / 2.0
        $offsetShadow = [Math]::Max(2.0, ($w * 0.0025))

        # 1. Main Title: "SHREE RAM & COMPANY"
        $rectMainY = $centerY - ($mainFontSize * 1.5)
        $rectMain = New-Object System.Drawing.RectangleF ([float]0, [float]$rectMainY, [float]$w, [float]($mainFontSize * 1.8))
        $rectMainShadow = New-Object System.Drawing.RectangleF ([float]$offsetShadow, [float]($rectMainY + $offsetShadow), [float]$w, [float]($mainFontSize * 1.8))
        $rectMainShadowSoft = New-Object System.Drawing.RectangleF ([float]($offsetShadow * 1.8), [float]($rectMainY + ($offsetShadow * 1.8)), [float]$w, [float]($mainFontSize * 1.8))

        $g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowSoftBrush, $rectMainShadowSoft, $sfCenter)
        $g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowBrush, $rectMainShadow, $sfCenter)
        $g.DrawString("SHREE RAM & COMPANY", $mainFont, $goldBrush, $rectMain, $sfCenter)

        # 2. Subtitle: "VIJETA STONE" (Positioned under right wing of "COMPANY")
        $rectSubY = $centerY - ($mainFontSize * 0.05)
        $subRightMargin = $w * 0.15
        $rectSub = New-Object System.Drawing.RectangleF ([float]0, [float]$rectSubY, [float]($w - $subRightMargin), [float]($subFontSize * 1.8))
        $rectSubShadow = New-Object System.Drawing.RectangleF ([float]$offsetShadow, [float]($rectSubY + $offsetShadow), [float]($w - $subRightMargin), [float]($subFontSize * 1.8))

        $g.DrawString("VIJETA STONE", $subFont, $shadowBrush, $rectSubShadow, $sfRight)
        $g.DrawString("VIJETA STONE", $subFont, $goldBrush, $rectSub, $sfRight)

        # 3. Phone Number: "6367607459" (Centered below)
        $rectPhoneY = $centerY + ($mainFontSize * 0.85)
        $rectPhone = New-Object System.Drawing.RectangleF ([float]0, [float]$rectPhoneY, [float]$w, [float]($phoneFontSize * 1.8))
        $rectPhoneShadow = New-Object System.Drawing.RectangleF ([float]$offsetShadow, [float]($rectPhoneY + $offsetShadow), [float]$w, [float]($phoneFontSize * 1.8))
        $rectPhoneShadowSoft = New-Object System.Drawing.RectangleF ([float]($offsetShadow * 1.8), [float]($rectPhoneY + ($offsetShadow * 1.8)), [float]$w, [float]($phoneFontSize * 1.8))

        $g.DrawString("6367607459", $phoneFont, $shadowSoftBrush, $rectPhoneShadowSoft, $sfCenter)
        $g.DrawString("6367607459", $phoneFont, $shadowBrush, $rectPhoneShadow, $sfCenter)
        $g.DrawString("6367607459", $phoneFont, $goldBrush, $rectPhone, $sfCenter)

        # Save back cleanly
        $tempPath = "$filePath.tmp.jpg"
        $bmp.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

        $g.Dispose()
        $bmp.Dispose()
        $mainFont.Dispose()
        $subFont.Dispose()
        $phoneFont.Dispose()
        $goldBrush.Dispose()
        $goldHighlightBrush.Dispose()
        $shadowBrush.Dispose()
        $shadowSoftBrush.Dispose()

        Move-Item -Path $tempPath -Destination $filePath -Force
        Write-Host "Applied Reference Watermark to: $(Split-Path $filePath -Leaf)"
    } catch {
        Write-Host "Error processing $filePath : $($_.Exception.Message)"
    }
}

# Apply to all catalog files
$files = Get-ChildItem -Path $assetsDir -Filter "*.jpg"
foreach ($f in $files) {
    Apply-ExactWatermark -filePath $f.FullName
}

Write-Host "All product catalog images updated with exact reference watermark!"
