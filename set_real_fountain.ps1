Add-Type -AssemblyName System.Drawing
. "c:\Users\shree\OneDrive\Desktop\NTRY\apply_brand_watermarks.ps1"

$src = "C:\Users\shree\.gemini\antigravity-ide\brain\059785c7-1675-4ae9-a295-9f53674d862f\water_fountain_carved_1788694449824.jpg"
$dest = "c:\Users\shree\OneDrive\Desktop\NTRY\assets\images\water-fountain.jpg"

Copy-Item -Path $src -Destination $dest -Force
Apply-ExactWatermark -filePath $dest
Write-Host "Water fountain successfully updated with realistic Rajasthani stone fountain in 900x1200 ratio!"
