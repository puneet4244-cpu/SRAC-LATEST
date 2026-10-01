$backupDir = "assets/originals-unwatermarked"
if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    Write-Host "Created $backupDir"
}

$sourceFiles = Get-ChildItem -Path "assets/images" -File
foreach ($f in $sourceFiles) {
    $dest = Join-Path $backupDir $f.Name
    if (-not (Test-Path $dest)) {
        Copy-Item -Path $f.FullName -Destination $dest -Force
    }
}

Write-Host "Backed up $($sourceFiles.Count) files into $backupDir"
