# Clean Base Image Downloader and Exact Reference Watermark Applier
Add-Type -AssemblyName System.Drawing

$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$assetsDir = "$baseDir\assets\images"

$imageSources = @{
    "water-fountain.jpg" = "https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?auto=format&fit=crop&w=1200&q=80"
    "marble-temple.jpg" = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "jaipur-artisan.jpg" = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "stone-jali.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "elevation-facade.jpg" = "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80"
    "murals-wall-art.jpg" = "https://images.unsplash.com/photo-1579783902614-a3fb3927b675?auto=format&fit=crop&w=1200&q=80"
    "marble-inlay.jpg" = "https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=1200&q=80"
    "gazebo.jpg" = "https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?auto=format&fit=crop&w=1200&q=80"
    "stone-wall-panels.jpg" = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "customised-name-plate.jpg" = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "garden-article.jpg" = "https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?auto=format&fit=crop&w=1200&q=80"
    "wall-cladding.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "arch-mehrab.jpg" = "https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?auto=format&fit=crop&w=1200&q=80"
    "pillar.jpg" = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "pooja-room.jpg" = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "statue.jpg" = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "marble-statue.jpg" = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "handicrafts.jpg" = "https://images.unsplash.com/photo-1579783902614-a3fb3927b675?auto=format&fit=crop&w=1200&q=80"
    "marble-table-tops.jpg" = "https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=1200&q=80"
    "mdf-hdmr-work.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "mdf-jali.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "wpc-jali.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "temple.jpg" = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "mural-art.jpg" = "https://images.unsplash.com/photo-1579783902614-a3fb3927b675?auto=format&fit=crop&w=1200&q=80"
    "mdf-work.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "stone-carving.jpg" = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "stone-wall-panel.jpg" = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
}

function Apply-ExactReferenceWatermark {
    param([string]$filePath)

    $img = [System.Drawing.Image]::FromFile($filePath)
    $w = $img.Width
    $h = $img.Height

    $bmp = New-Object System.Drawing.Bitmap ($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $g.DrawImage($img, 0, 0, $w, $h)
    $img.Dispose()

    # Dynamic scale based on width
    $mainFontSize = [Math]::Max(26.0, ($w * 0.052))
    $subFontSize = [Math]::Max(12.0, ($w * 0.022))
    $phoneFontSize = [Math]::Max(20.0, ($w * 0.040))

    $mainFont = New-Object System.Drawing.Font ("Georgia", [float]$mainFontSize, [System.Drawing.FontStyle]::Regular)
    $subFont = New-Object System.Drawing.Font ("Arial", [float]$subFontSize, [System.Drawing.FontStyle]::Bold)
    $phoneFont = New-Object System.Drawing.Font ("Georgia", [float]$phoneFontSize, [System.Drawing.FontStyle]::Bold)

    # Exact Gold tone from reference image
    $goldMain = [System.Drawing.Color]::FromArgb(250, 232, 172, 85)       # Rich warm gold
    $shadowDark = [System.Drawing.Color]::FromArgb(235, 0, 0, 0)           # Deep black shadow
    $shadowSoft = [System.Drawing.Color]::FromArgb(130, 0, 0, 0)

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
    $rectMainY = $centerY - ($mainFontSize * 1.5)
    $rectMain = New-Object System.Drawing.RectangleF ([float]0, [float]$rectMainY, [float]$w, [float]($mainFontSize * 1.8))
    $rectMainShadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rectMainY + $offset), [float]$w, [float]($mainFontSize * 1.8))
    $rectMainShadowSoft = New-Object System.Drawing.RectangleF ([float]($offset * 1.8), [float]($rectMainY + ($offset * 1.8)), [float]$w, [float]($mainFontSize * 1.8))

    $g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowSoftBrush, $rectMainShadowSoft, $sfCenter)
    $g.DrawString("SHREE RAM & COMPANY", $mainFont, $shadowBrush, $rectMainShadow, $sfCenter)
    $g.DrawString("SHREE RAM & COMPANY", $mainFont, $goldBrush, $rectMain, $sfCenter)

    # 2. VIJETA STONE (Right positioned)
    $rectSubY = $centerY - ($mainFontSize * 0.05)
    $subRightMargin = $w * 0.12
    $rectSub = New-Object System.Drawing.RectangleF ([float]0, [float]$rectSubY, [float]($w - $subRightMargin), [float]($subFontSize * 1.8))
    $rectSubShadow = New-Object System.Drawing.RectangleF ([float]$offset, [float]($rectSubY + $offset), [float]($w - $subRightMargin), [float]($subFontSize * 1.8))

    $g.DrawString("VIJETA STONE", $subFont, $shadowBrush, $rectSubShadow, $sfRight)
    $g.DrawString("VIJETA STONE", $subFont, $goldBrush, $rectSub, $sfRight)

    # 3. 6367607459 (Centered)
    $rectPhoneY = $centerY + ($mainFontSize * 0.85)
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
}

foreach ($item in $imageSources.GetEnumerator()) {
    $fileName = $item.Key
    $url = $item.Value
    $targetFile = Join-Path $assetsDir $fileName

    try {
        Invoke-WebRequest -Uri $url -OutFile $targetFile -UseBasicParsing -TimeoutSec 15
        Apply-ExactReferenceWatermark -filePath $targetFile
        Write-Host "Cleaned and applied reference watermark to: $fileName"
    } catch {
        Write-Host "Failed for $fileName : $($_.Exception.Message)"
    }
}

Write-Host "All catalog images freshly rendered with exact reference watermark!"
