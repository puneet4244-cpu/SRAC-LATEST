$folders = @('raw-originals', 'product_uploads', 'photos', 'assets/images')
foreach ($f in $folders) {
    if (Test-Path $f) {
        Write-Host "=== FOLDER: $f ==="
        Get-ChildItem -Path $f -Recurse -File | ForEach-Object {
            $rel = $_.FullName.Substring((Get-Location).Path.Length + 1)
            Write-Host "$rel ($($_.Length) bytes)"
        }
    }
}
