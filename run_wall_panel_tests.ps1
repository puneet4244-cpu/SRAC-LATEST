. "c:\Users\shree\OneDrive\Desktop\NTRY\WallPanelEngine.ps1"

$rawPath = "c:\Users\shree\OneDrive\Desktop\NTRY\raw-originals\double-height-wall-raw-01.jpg"
$previewDir = "c:\Users\shree\OneDrive\Desktop\NTRY\preview"
$cwebpExe = "c:\Users\shree\OneDrive\Desktop\NTRY\tools\libwebp-1.4.0-windows-x64\bin\cwebp.exe"

function Export-Test {
    param([string]$Name, [int]$X, [int]$Y, [int]$W, [int]$H, [float]$Sharpen = 1.3)
    
    $bmp = [WallPanelEngine]::Process($rawPath, $X, $Y, $W, $H, 1.12, 0.02, 0.038, $Sharpen)
    $jpgPath = "$previewDir\$Name.jpg"
    $webpPath = "$previewDir\$Name.webp"
    
    $bmp.Save($jpgPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    
    & $cwebpExe -q 88 -m 6 "$jpgPath" -o "$webpPath"
    $info = Get-Item $webpPath
    $kb = [Math]::Round($info.Length / 1024, 2)
    Write-Host "$Name -> $kb KB"
}

# 1. Hero Wall Panel: Wall fills ~85% of frame, cutting out left kitchen door & right terrace AC, table top at bottom
Export-Test -Name "focus-hero-panel" -X 110 -Y 20 -W 540 -H 720 -Sharpen 1.4

# 2. Ultra Wall Panel: 100% stone wall focus from edge to edge
Export-Test -Name "focus-ultra-panel" -X 145 -Y 35 -W 475 -H 633 -Sharpen 1.5

# 3. Balanced Focus: Wall panel dominant with subtle dining ambiance
Export-Test -Name "focus-balanced-panel" -X 80 -Y 15 -W 580 -H 773 -Sharpen 1.35
