Add-Type -AssemblyName System.Drawing

$inputPath = "c:\Users\shree\OneDrive\Desktop\NTRY\assets\images\malabar-gold-logo.png"
$outputPath = "c:\Users\shree\OneDrive\Desktop\NTRY\assets\images\malabar-gold-logo-transparent.png"

$bmp = New-Object System.Drawing.Bitmap($inputPath)

# Create 32-bit ARGB bitmap
$newBmp = New-Object System.Drawing.Bitmap($bmp.Width, $bmp.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $pixel = $bmp.GetPixel($x, $y)
        $r = $pixel.R
        $g = $pixel.G
        $b = $pixel.B
        
        # Gold emblem color is brownish gold (r ~ 140-190, g ~ 125-170, b ~ 70-130)
        # Background is white/light-grey checkered pattern (r > 190, g > 190, b > 190 or r,g,b very close and light)
        
        $isLightBackground = ($r -gt 195 -and $g -gt 195 -and $b -gt 195) -or `
                             ($r -gt 170 -and $g -gt 170 -and $b -gt 170 -and [Math]::Abs($r - $g) -lt 15 -and [Math]::Abs($g - $b) -lt 15)
                             
        if ($isLightBackground) {
            $newBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 255, 255, 255))
        } else {
            $newBmp.SetPixel($x, $y, $pixel)
        }
    }
}

$newBmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$newBmp.Dispose()

Write-Host "Saved transparent logo to $outputPath"
