Add-Type -AssemblyName System.Drawing

function Save-CroppedImage {
    param(
        [string]$inputSource, # local file path or URL
        [string]$outputPath,
        [int]$targetWidth = 900,
        [int]$targetHeight = 1200
    )

    $tempFile = $null
    try {
        if ($inputSource.StartsWith("http://") -or $inputSource.StartsWith("https://")) {
            $tempFile = [System.IO.Path]::GetTempFileName() + ".jpg"
            $wc = New-Object System.Net.WebClient
            $wc.Headers.Add("User-Agent", "VietaStoneImageFetcher/1.0 (contact@shreeramstone.com)")
            $wc.DownloadFile($inputSource, $tempFile)
            $srcPath = $tempFile
        } else {
            $srcPath = $inputSource
        }

        if (-not (Test-Path $srcPath)) {
            Write-Error "Source file not found: $srcPath"
            return $false
        }

        $imgBytes = [System.IO.File]::ReadAllBytes($srcPath)
        $ms = New-Object System.IO.MemoryStream(,$imgBytes)
        $srcImg = [System.Drawing.Image]::FromStream($ms)

        $srcW = $srcImg.Width
        $srcH = $srcImg.Height

        # Calculate crop rectangle to preserve center and achieve targetWidth:targetHeight
        $targetRatio = [double]$targetWidth / [double]$targetHeight
        $srcRatio = [double]$srcW / [double]$srcH

        if ($srcRatio -gt $targetRatio) {
            # Source is wider than target ratio: crop sides
            $cropH = $srcH
            $cropW = [int]($srcH * $targetRatio)
            $cropX = [int](($srcW - $cropW) / 2)
            $cropY = 0
        } else {
            # Source is taller than target ratio: crop top/bottom
            $cropW = $srcW
            $cropH = [int]($srcW / $targetRatio)
            $cropX = 0
            $cropY = [int](($srcH - $cropH) / 2)
        }

        $destBmp = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
        $g = [System.Drawing.Graphics]::FromImage($destBmp)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

        $srcRect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)
        $destRect = New-Object System.Drawing.Rectangle(0, 0, $targetWidth, $targetHeight)

        $g.DrawImage($srcImg, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

        # Output dir
        $dir = [System.IO.Path]::GetDirectoryName($outputPath)
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }

        $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]92)
        $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }

        $destBmp.Save($outputPath, $codec, $encoderParams)

        $g.Dispose()
        $destBmp.Dispose()
        $srcImg.Dispose()
        $ms.Dispose()

        return $true
    } catch {
        Write-Error "Error processing $inputSource : $_"
        return $false
    } finally {
        if ($tempFile -and (Test-Path $tempFile)) {
            Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
        }
    }
}
