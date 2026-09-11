# Script to map all authentic generated & real product photos cleanly to assets/images
$brainDir = "C:\Users\shree\.gemini\antigravity-ide\brain\059785c7-1675-4ae9-a295-9f53674d862f"
$userUpDir = "$brainDir\.user_uploaded"
$assetsDir = "c:\Users\shree\OneDrive\Desktop\NTRY\assets\images"

$mapping = @{
    # 1. Stone Carving & Artisan Chiseling Work
    "jaipur-artisan.jpg"       = "$brainDir\artisan_stone_carving_1788696689738.jpg"
    "stone-carving.jpg"        = "$brainDir\artisan_stone_carving_1788696689738.jpg"

    # 2. Temple & Marble Mandir
    "marble-temple.jpg"        = "$brainDir\marble_mandir_temple_1788696788325.jpg"
    "temple.jpg"               = "$brainDir\marble_mandir_temple_1788696788325.jpg"
    "pooja-room.jpg"           = "$brainDir\marble_mandir_temple_1788696788325.jpg"

    # 3. Water Fountain
    "water-fountain.jpg"       = "$brainDir\water_fountain_carved_1788694449824.jpg"
    "garden-article.jpg"       = "$brainDir\water_fountain_carved_1788694449824.jpg"

    # 4. Stone & CNC Jali Screen
    "stone-jali.jpg"           = "$brainDir\stone_jali_screen_1788696985639.jpg"
    "mdf-jali.jpg"             = "$brainDir\stone_jali_screen_1788696985639.jpg"
    "wpc-jali.jpg"             = "$brainDir\stone_jali_screen_1788696985639.jpg"

    # 5. Marble Inlay & Table Tops
    "marble-inlay.jpg"         = "$brainDir\marble_inlay_table_1788697090502.jpg"
    "marble-table-tops.jpg"    = "$brainDir\marble_inlay_table_1788697090502.jpg"
    "handicrafts.jpg"          = "$brainDir\marble_inlay_table_1788697090502.jpg"

    # 6. Stone Art & 3D Murals
    "murals-wall-art.jpg"      = "$brainDir\radha_krishna_stone_mural_1788697175780.jpg"
    "mural-art.jpg"            = "$brainDir\radha_krishna_stone_mural_1788697175780.jpg"

    # 7. Real Backlit Elevation & Wall Panels (From User Reference Photo)
    "elevation-facade.jpg"     = "$userUpDir\media_1788694510827.jpg"
    "wall-cladding.jpg"        = "$userUpDir\media_1788694510827.jpg"
    "stone-wall-panels.jpg"    = "$userUpDir\media_1788694510827.jpg"
    "stone-wall-panel.jpg"     = "$userUpDir\media_1788694510827.jpg"
    "mdf-hdmr-work.jpg"        = "$userUpDir\media_1788694510827.jpg"
    "mdf-work.jpg"             = "$userUpDir\media_1788694510827.jpg"
    "customised-name-plate.jpg"= "$userUpDir\media_1788694510827.jpg"
    "pillar.jpg"               = "$brainDir\marble_mandir_temple_1788696788325.jpg"
    "arch-mehrab.jpg"          = "$brainDir\stone_jali_screen_1788696985639.jpg"
    "gazebo.jpg"               = "$brainDir\water_fountain_carved_1788694449824.jpg"
    "statue.jpg"               = "$brainDir\radha_krishna_stone_mural_1788697175780.jpg"
    "marble-statue.jpg"        = "$brainDir\marble_mandir_temple_1788696788325.jpg"
}

foreach ($item in $mapping.GetEnumerator()) {
    $targetName = $item.Key
    $sourcePath = $item.Value
    $destPath = Join-Path $assetsDir $targetName

    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        Write-Host "Mapped realistic photo to: $targetName"
    } else {
        Write-Host "Warning: Source not found for $targetName at $sourcePath"
    }
}

Write-Host "All product category cards successfully updated with realistic matching photos!"
