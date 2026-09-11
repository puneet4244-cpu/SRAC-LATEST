# Script to restore all clean stock images (WITHOUT watermarks)
$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$assetsDir = "$baseDir\assets\images"

$cleanStockSources = @{
    "water-fountain.jpg"       = "https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?auto=format&fit=crop&w=1200&q=80"
    "marble-temple.jpg"        = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "temple.jpg"               = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "jaipur-artisan.jpg"       = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "stone-carving.jpg"        = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "stone-jali.jpg"           = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "mdf-jali.jpg"             = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "wpc-jali.jpg"             = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "mdf-hdmr-work.jpg"        = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "mdf-work.jpg"             = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "elevation-facade.jpg"     = "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80"
    "wall-cladding.jpg"        = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80"
    "stone-wall-panels.jpg"    = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "stone-wall-panel.jpg"     = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "murals-wall-art.jpg"      = "https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?auto=format&fit=crop&w=1200&q=80"
    "mural-art.jpg"            = "https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?auto=format&fit=crop&w=1200&q=80"
    "marble-inlay.jpg"         = "https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=1200&q=80"
    "marble-table-tops.jpg"    = "https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=1200&q=80"
    "handicrafts.jpg"          = "https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=1200&q=80"
    "gazebo.jpg"               = "https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?auto=format&fit=crop&w=1200&q=80"
    "arch-mehrab.jpg"          = "https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?auto=format&fit=crop&w=1200&q=80"
    "pillar.jpg"               = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "pooja-room.jpg"           = "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80"
    "statue.jpg"               = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "marble-statue.jpg"        = "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "customised-name-plate.jpg"= "https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?auto=format&fit=crop&w=1200&q=80"
    "garden-article.jpg"       = "https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?auto=format&fit=crop&w=1200&q=80"
}

foreach ($item in $cleanStockSources.GetEnumerator()) {
    $fileName = $item.Key
    $url = $item.Value
    $targetFile = Join-Path $assetsDir $fileName

    try {
        Invoke-WebRequest -Uri $url -OutFile $targetFile -UseBasicParsing -TimeoutSec 15
        Write-Host "Restored clean stock image (NO watermark): $fileName"
    } catch {
        Write-Host "Failed for $fileName : $($_.Exception.Message)"
    }
}

Write-Host "All photos have been reverted back to original clean stock photos without any watermarks!"
