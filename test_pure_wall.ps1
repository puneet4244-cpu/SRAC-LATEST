. "c:\Users\shree\OneDrive\Desktop\NTRY\WallPanelEngine.ps1"

$rawPath = "c:\Users\shree\OneDrive\Desktop\NTRY\raw-originals\double-height-wall-raw-01.jpg"
$previewDir = "c:\Users\shree\OneDrive\Desktop\NTRY\preview"
$cwebpExe = "c:\Users\shree\OneDrive\Desktop\NTRY\tools\libwebp-1.4.0-windows-x64\bin\cwebp.exe"

function Export-Test {
    param([string]$Name, [int]$X, [int]$Y, [int]$W, [int]$H, [float]$Sharpen = 1.4, [float]$Contrast = 1.14)
    
    $bmp = [WallPanelEngine]::Process($rawPath, $X, $Y, $W, $H, $Contrast, 0.02, 0.038, $Sharpen)
    $jpgPath = "$previewDir\$Name.jpg"
    $webpPath = "$previewDir\$Name.webp"
    
    $bmp.Save($jpgPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    
    & $cwebpExe -q 88 -m 6 "$jpgPath" -o "$webpPath"
    $info = Get-Item $webpPath
    $kb = [Math]::Round($info.Length / 1024, 2)
    Write-Host "$Name -> $kb KB"
}

# Pure Wall Panel Close-Up (Zero room distraction, 100% stone wall panel & chandelier)
# X: 165 to 585 (W=420), Y: 25 to 585 (H=560) -> 420/560 = 0.75 (exact 3:4)
Export-Test -Name "focus-pure-wall" -X 165 -Y 25 -W 420 -H 560 -Sharpen 1.6 -Contrast 1.15

# Wall Panel Hero with Subtle Table Grounding (W=470, H=626)
Export-Test -Name "focus-wall-table-ground" -X 152 -Y 28 -W 470 -H 626 -Sharpen 1.5 -Contrast 1.14
