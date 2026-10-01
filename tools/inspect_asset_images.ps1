# Inspect all images in assets/images with dimensions and file size
Add-Type -AssemblyName System.Drawing

$imgFiles = Get-ChildItem -Path "assets/images" -File | Where-Object { 
    $_.Extension -match '\.(jpg|jpeg|png|webp)$' -and 
    $_.Name -notmatch 'logo' -and 
    $_.Name -notmatch 'favicon'
}

$report = @()

foreach ($f in $imgFiles) {
    $dim = "Unknown"
    try {
        $img = [System.Drawing.Image]::FromFile($f.FullName)
        $dim = "$($img.Width)x$($img.Height)"
        $img.Dispose()
    } catch {
        $dim = "Error loading"
    }
    
    $report += [PSCustomObject]@{
        Name = $f.Name
        Dimensions = $dim
        SizeKB = [Math]::Round($f.Length / 1024, 1)
        LastWrite = $f.LastWriteTime
    }
}

$report | Sort-Object Name | Format-Table -AutoSize
