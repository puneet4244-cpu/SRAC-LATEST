Add-Type -AssemblyName System.Drawing

Write-Host "=== Generated Images in Brain Folder ==="
$brainDir = "C:\Users\shree\.gemini\antigravity-ide\brain\79fcbaac-0c11-444c-9d84-2fd90e796db2"
$genFiles = Get-ChildItem "$brainDir\*_179075*.jpg"
foreach ($f in $genFiles) {
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
