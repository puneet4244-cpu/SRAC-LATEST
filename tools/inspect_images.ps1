Add-Type -AssemblyName System.Drawing

$files = Get-ChildItem "assets/originals-unwatermarked/*.jpg"
$results = foreach ($f in $files) {
    try {
        $img = [System.Drawing.Image]::FromFile($f.FullName)
        $w = $img.Width
        $h = $img.Height
        $img.Dispose()
        [PSCustomObject]@{
            Name = $f.Name
            Width = $w
            Height = $h
            SizeKB = [math]::Round($f.Length / 1KB, 1)
        }
    } catch {
        [PSCustomObject]@{
            Name = $f.Name
            Width = -1
            Height = -1
            SizeKB = [math]::Round($f.Length / 1KB, 1)
        }
    }
}
$results | Format-Table -AutoSize
