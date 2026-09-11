# Fix missing images and watermark them cleanly
Add-Type -AssemblyName System.Drawing

$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$assetsDir = "$baseDir\assets\images"
. "$baseDir\refresh_clean_watermarks.ps1"

$fallbackSources = @{
    "murals-wall-art.jpg" = "https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?auto=format&fit=crop&w=1200&q=80"
    "mural-art.jpg" = "https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?auto=format&fit=crop&w=1200&q=80"
    "handicrafts.jpg" = "https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=1200&q=80"
}

foreach ($item in $fallbackSources.GetEnumerator()) {
    $fileName = $item.Key
    $url = $item.Value
    $targetFile = Join-Path $assetsDir $fileName

    try {
        Invoke-WebRequest -Uri $url -OutFile $targetFile -UseBasicParsing -TimeoutSec 15
        Apply-ExactReferenceWatermark -filePath $targetFile
        Write-Host "Fixed and applied reference watermark to: $fileName"
    } catch {
        Write-Host "Failed for $fileName : $($_.Exception.Message)"
    }
}
