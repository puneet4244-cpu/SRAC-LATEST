. ./tools/image_processor.ps1

$testUrls = @{
    "mdf_jali_1.jpg" = "https://images.unsplash.com/photo-1541123437800-1bb1317badc2?w=1200&q=85"
    "mdf_jali_2.jpg" = "https://images.unsplash.com/photo-1513694203232-719a280e022f?w=1200&q=85"
    "wpc_jali_1.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1200&q=85"
}

foreach ($k in $testUrls.Keys) {
    $out = "tools/staged/$k"
    Save-CroppedImage -inputSource $testUrls[$k] -outputPath $out -targetWidth 900 -targetHeight 1200
    if (Test-Path $out) {
        Write-Host "Downloaded $k : $((Get-Item $out).Length) bytes"
    }
}
