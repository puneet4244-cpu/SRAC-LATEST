. ./tools/image_processor.ps1

$stagedDir = "tools/staged"
if (-not (Test-Path $stagedDir)) { New-Item -ItemType Directory -Path $stagedDir | Out-Null }

# Test downloading wall_cladding
$testUrl = "https://images.unsplash.com/photo-1590402494682-cd3fb53b1f70?w=1200&q=85"
Save-CroppedImage -inputSource $testUrl -outputPath "$stagedDir/test_wall_cladding.jpg" -targetWidth 900 -targetHeight 1200

# Test Cenotaphs at Bada Bagh (Gazebo)
$gazeboUrl = "https://upload.wikimedia.org/wikipedia/commons/a/a4/Cenotaphs_at_Bada_Bagh%2C_Jaisalmer.jpg"
Save-CroppedImage -inputSource $gazeboUrl -outputPath "$stagedDir/test_gazebo.jpg" -targetWidth 900 -targetHeight 1200

# Test Stone Temple (Khajuraho sandstone)
$templeUrl = "https://upload.wikimedia.org/wikipedia/commons/c/cd/0121821_Parvati_Temple%2C_Khajuraho_Madhya_Pradesh_011.jpg"
Save-CroppedImage -inputSource $templeUrl -outputPath "$stagedDir/test_stone_temple.jpg" -targetWidth 900 -targetHeight 1200

Get-ChildItem $stagedDir | Select-Object Name, Length
