# Deploy Reference Photo & Match Watermark Pipeline 1:1
Add-Type -AssemblyName System.Drawing

$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$assetsDir = "$baseDir\assets\images"
$userUploadedImg = "C:\Users\shree\.gemini\antigravity-ide\brain\059785c7-1675-4ae9-a295-9f53674d862f\.user_uploaded\media_1788694510827.jpg"

# 1. Deploy the real uploaded project photo to relevant wall & facade categories
$targetFiles = @(
    "elevation-facade.jpg",
    "stone-wall-panels.jpg",
    "stone-wall-panel.jpg",
    "wall-cladding.jpg"
)

foreach ($target in $targetFiles) {
    $dest = Join-Path $assetsDir $target
    Copy-Item $userUploadedImg $dest -Force
    Write-Host "Deployed real reference project photo to: $target"
}

# 2. Perfected Watermark Function matching the exact photo
function Apply-MatchedReferenceWatermark {
    param([string]$filePath)

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

        # Draw base
        $g.DrawImage($img, 0, 0, $w, $h)
        $img.Dispose()

        # Dynamic scale based on width & height (calibrated from reference image)
        $mainFontSize = [Math]::Max(24.0, ($w * 0.050))
        $subFontSize = [Math]::Max(11.0, ($w * 0.021))
        $phoneFontSize = [Math]::Max(18.0, ($w * 0.038))

        # Fonts: Classic Roman Serif & Clean Subtitle
        $mainFont = New-Object System.Drawing.Font ("Georgia", [float]$mainFontSize, [System.Drawing.FontStyle]::Regular)
        $subFont = New-Object System.Drawing.Font ("Arial", [float]$subFontSize, [System.Drawing.FontStyle]::Bold)
        $phoneFont = New-Object System.Drawing.Font ("Georgia", [float]$phoneFontSize, [System.Drawing.FontStyle]::Bold)

        # Exact Golden Palette sampled from user reference photo
        $goldMain = [System.Drawing.Color]::FromArgb(250, 230, 175, 92)       # Warm lustrous gold (#E6AF5C)
        $shadowDark = [System.Drawing.Color]::FromArgb(240, 15, 12, 10)       # Crisp 3D drop shadow
        $shadowSoft = [System.Drawing.Color]::FromArgb(120, 0, 0, 0)

        $goldBrush = New-Object System.Drawing.SolidBrush ($goldMain)
        $shadowBrush = New-Object System.Drawing.SolidBrush ($shadowDark)
        $shadowSoftBrush = New-Object System.Drawing.SolidBrush ($shadowSoft)

        $sfCenter = New-Object System.Drawing.StringFormat
        $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
        $sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

        $sfRight = New-Object System.Drawing.StringFormat
        $sfRight.Alignment = [System.Drawing.StringAlignment]::Far
        $sfRight.LineAlignment = [System.Drawing.StringAlignment]::Center

        $centerY = $h / 2.0
        $offset = [Math]::Max(2.5, ($w * 0.003))

        # 1. SHREE RAM & COMPANY
        $rectMainY = $centerY - ($mainFontSize * 1.4)
        $rectMain = New-Object System.Drawing.RectangleF ([float]0, [float]$rectMainY, [float]$w, [float]($mainFontSize * 1.8))
        $rectMainShadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rectMainY + $offset), [float]$w, [float]($mainFontSize * 1.8))
        $rectMainShadowSoft = New-Object System.Drawing.RectangleF ([float]($offset * 1.8), [float]($rectMainY + ($offset * 1.8)), [float]$w, [float]($mainFontSize * 1.8))

        $g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowSoftBrush, $rectMainShadowSoft, $sfCenter)
        $g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowBrush, $rectMainShadow, $sfCenter)
        $g.DrawString("SHREE RAM & COMPANY", $mainFont, $goldBrush, $rectMain, $sfCenter)

        # 2. VIJETA STONE (Right positioned below COMPANY)
        $rectSubY = $centerY - ($mainFontSize * 0.02)
        $subRightMargin = $w * 0.14
        $rectSub = New-Object System.Drawing.RectangleF ([float]0, [float]$rectSubY, [float]($w - $subRightMargin), [float]($subFontSize * 1.8))
        $rectSubShadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rectSubY + $offset), [float]($w - $subRightMargin), [float]($subFontSize * 1.8))

        $g.DrawString("VIJETA STONE", $subFont, $shadowBrush, $rectSubShadow, $sfRight)
        $g.DrawString("VIJETA STONE", $subFont, $goldBrush, $rectSub, $sfRight)

        # 3. 6367607459 (Centered below)
        $rectPhoneY = $centerY + ($mainFontSize * 0.88)
        $rectPhone = New-Object System.Drawing.RectangleF ([float]0, [float]$rectPhoneY, [float]$w, [float]($phoneFontSize * 1.8))
        $rectPhoneShadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rectPhoneY + $offset), [float]$w, [float]($phoneFontSize * 1.8))
        $rectPhoneShadowSoft = New-Object System.Drawing.RectangleF ([float]($offset * 1.8), [float]($rectPhoneY + ($offset * 1.8)), [float]$w, [float]($phoneFontSize * 1.8))

        $g.DrawString("6367607459", $phoneFont, $shadowSoftBrush, $rectPhoneShadowSoft, $sfCenter)
        $g.DrawString("6367607459", $phoneFont, $shadowBrush, $rectPhoneShadow, $sfCenter)
        $g.DrawString("6367607459", $phoneFont, $goldBrush, $rectPhone, $sfCenter)

        $tempPath = "$filePath.tmp.jpg"
        $bmp.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

        $g.Dispose()
        $bmp.Dispose()
        $mainFont.Dispose()
        $subFont.Dispose()
        $phoneFont.Dispose()
        $goldBrush.Dispose()
        $shadowBrush.Dispose()
        $shadowSoftBrush.Dispose()

        Move-Item -Path $tempPath -Destination $filePath -Force
        Write-Host "Applied 1:1 Matched Watermark to: $(Split-Path $filePath -Leaf)"
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

Write-Host "Pipeline updated with exact reference design!"
