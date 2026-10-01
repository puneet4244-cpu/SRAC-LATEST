$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$cwebp = "$baseDir\tools\libwebp-1.4.0-windows-x64\bin\cwebp.exe"
$csFile = "$baseDir\tools\LuxuryColorGrader.cs"

Add-Type -Path $csFile -ReferencedAssemblies System.Drawing

$photosDir = "$baseDir\photos\WALL SURFACES\STONE CARVING\Double Height Wall"
$assetsDir = "$baseDir\assets\images"
$tempDir = "$baseDir\tools\temp_graded"

if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
}

$images = @(
    @{
        Src = "$photosDir\NEW DOUBLE HEIGHTED 1.png";
        TargetWebp = "double-height-wall-01.webp";
        Contrast = 0.35;
        Vibrance = 0.30;
        WarmR = 1.04;
        WarmG = 1.01;
        WarmB = 0.95;
        Sharpness = 0.35;
    },
    @{
        Src = "$photosDir\NEW DOUBLE HEIGHTED 2.png";
        TargetWebp = "double-height-wall-02.webp";
        Contrast = 0.38;
        Vibrance = 0.35;
        WarmR = 1.05;
        WarmG = 1.01;
        WarmB = 0.94;
        Sharpness = 0.35;
    },
    @{
        Src = "$photosDir\NEW DOUBLE HEIGHTED 3.png";
        TargetWebp = "double-height-wall-03.webp";
        Contrast = 0.32;
        Vibrance = 0.28;
        WarmR = 1.03;
        WarmG = 1.01;
        WarmB = 0.96;
        Sharpness = 0.32;
    },
    @{
        Src = "$photosDir\NEW DOUBLE HEIGHTED 4.png";
        TargetWebp = "double-height-wall-04.webp";
        Contrast = 0.35;
        Vibrance = 0.32;
        WarmR = 1.04;
        WarmG = 1.01;
        WarmB = 0.95;
        Sharpness = 0.35;
    },
    @{
        Src = "$photosDir\NEW DOUBLE HEIGHTED 5.png";
        TargetWebp = "double-height-wall-05.webp";
        Contrast = 0.42;
        Vibrance = 0.38;
        WarmR = 1.06;
        WarmG = 1.02;
        WarmB = 0.93;
        Sharpness = 0.38;
    },
    @{
        Src = "$photosDir\NEW DOUBLE HEIGHTED 6.png";
        TargetWebp = "double-height-wall-06.webp";
        Contrast = 0.35;
        Vibrance = 0.32;
        WarmR = 1.05;
        WarmG = 1.01;
        WarmB = 0.94;
        Sharpness = 0.35;
    }
)

$idx = 1
foreach ($img in $images) {
    $tempPng = "$tempDir\graded_$idx.png"
    Write-Host "Color grading $($img.TargetWebp)..."
    
    [LuxuryColorGrader]::ProcessImage(
        $img.Src,
        $tempPng,
        [float]$img.Contrast,
        [float]$img.Vibrance,
        [float]$img.WarmR,
        [float]$img.WarmG,
        [float]$img.WarmB,
        [float]$img.Sharpness
    )
    
    # Encode with high-fidelity WebP
    $destAssetWebp = "$assetsDir\$($img.TargetWebp)"
    $destPhotosWebp = "$photosDir\DOUBLE HEIGHTED $idx.webp"
    $destPhotosNewWebp = "$photosDir\NEW DOUBLE HEIGHTED $idx.webp"
    
    & $cwebp -q 92 -m 6 -sharp_yuv "$tempPng" -o "$destAssetWebp" | Out-Null
    Copy-Item -Path "$destAssetWebp" -Destination "$destPhotosWebp" -Force
    Copy-Item -Path "$destAssetWebp" -Destination "$destPhotosNewWebp" -Force
    
    Write-Host "Successfully enhanced & color-graded: $($img.TargetWebp)"
    $idx++
}

Write-Host "All 6 Double Height images color graded, made vibrant, crisp, and alive!"
