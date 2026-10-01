. "c:\Users\shree\OneDrive\Desktop\NTRY\WallPanelMasterEnhancer.ps1"

$rawPath = "c:\Users\shree\OneDrive\Desktop\NTRY\raw-originals\double-height-wall-raw-01.jpg"
$previewDir = "c:\Users\shree\OneDrive\Desktop\NTRY\preview"
$artDir = "C:\Users\shree\.gemini\antigravity-ide\brain\0b523f43-34da-46ee-8143-d88f8fb3c027"
$cwebpExe = "c:\Users\shree\OneDrive\Desktop\NTRY\tools\libwebp-1.4.0-windows-x64\bin\cwebp.exe"

function Build-Export {
    param([string]$Key, [int]$X, [int]$Y, [int]$W, [int]$H, [float]$Strength = 0.42, [float]$Contrast = 1.14)
    
    $bmp = [WallPanelMasterEnhancer]::Process($rawPath, $X, $Y, $W, $H, $Contrast, 0.02, 0.036, $Strength, 1.5)
    
    $jpgPath = "$previewDir\$Key.jpg"
    $webpPath = "$previewDir\$Key.webp"
    
    $bmp.Save($jpgPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    
    & $cwebpExe -q 88 -m 6 "$jpgPath" -o "$webpPath"
    
    Copy-Item $jpgPath -Destination "$artDir\$Key.jpg" -Force
    Copy-Item $webpPath -Destination "$artDir\$Key.webp" -Force
    
    $info = Get-Item $webpPath
    $kb = [Math]::Round($info.Length / 1024, 2)
    Write-Host "$Key -> $kb KB"
}

# 1. Primary Recommendation: Hero Wall Panel Focus (Crop directly around wall panel, showing full height, ripples, chandelier, and clean table edge)
Build-Export -Key "double-height-wall-panel-hero" -X 148 -Y 24 -W 480 -H 640 -Strength 0.45 -Contrast 1.14

# 2. Pure Wall Panel Focus (Tighter framing: maximum stone wall panel surface area)
Build-Export -Key "double-height-wall-panel-pure" -X 168 -Y 22 -W 425 -H 567 -Strength 0.48 -Contrast 1.15

# Also copy primary as double-height-wall-01.webp in preview
Copy-Item "$previewDir\double-height-wall-panel-hero.webp" -Destination "$previewDir\double-height-wall-01.webp" -Force
Copy-Item "$previewDir\double-height-wall-panel-hero.jpg" -Destination "$previewDir\double-height-wall-01.jpg" -Force
Copy-Item "$previewDir\double-height-wall-panel-hero.jpg" -Destination "$artDir\double-height-wall-01-preview.jpg" -Force
Copy-Item "$previewDir\double-height-wall-panel-hero.webp" -Destination "$artDir\double-height-wall-01.webp" -Force
