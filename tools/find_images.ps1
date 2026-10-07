Get-ChildItem -Path "assets/images" -File | Where-Object { 
    $_.Name -match "krishna|radhe|mural|stone-art|fluted|panel|jali|cnc" 
} | Select-Object Name, Length | Format-Table -AutoSize
