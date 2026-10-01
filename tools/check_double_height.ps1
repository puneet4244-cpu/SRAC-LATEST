Add-Type -AssemblyName System.Drawing

1..6 | ForEach-Object {
    $p = "photos/WALL SURFACES/STONE CARVING/Double Height Wall/NEW DOUBLE HEIGHTED $_.png"
    if (Test-Path $p) {
        $b = New-Object System.Drawing.Bitmap($p)
        [PSCustomObject]@{
            Slide = $_
            Width = $b.Width
            Height = $b.Height
            SizeKB = [math]::Round((Get-Item $p).Length / 1KB, 1)
        }
        $b.Dispose()
    }
} | Format-Table -AutoSize
