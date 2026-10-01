Add-Type -AssemblyName System.Drawing

Write-Host "=== Staged Images in tools/staged ==="
$files = Get-ChildItem "tools/staged/*.jpg"
foreach ($f in $files) {
    try {
        $img = [System.Drawing.Image]::FromFile($f.FullName)
        [PSCustomObject]@{
            Name = $f.Name
            Width = $img.Width
            Height = $img.Height
            SizeKB = [math]::Round($f.Length / 1KB, 1)
        }
        $img.Dispose()
    } catch {
        Write-Warning "Failed loading $($f.Name)"
    }
}
