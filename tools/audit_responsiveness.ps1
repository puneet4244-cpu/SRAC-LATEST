$files = Get-ChildItem -Path "." -Filter "*.html" -Recurse
Write-Host "Total HTML files found: $($files.Count)"

$missingViewport = @()
$hasViewport = @()
$missingRootOverflow = @()

foreach ($file in $files) {
    $relPath = $file.FullName.Substring((Get-Location).Path.Length + 1).Replace("\", "/")
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    if ($content -notmatch 'meta\s+name=["'']viewport["'']') {
        $missingViewport += $relPath
    } else {
        $hasViewport += $relPath
    }

    if ($content -notmatch 'html\s*,\s*body\s*\{[^}]*overflow-x\s*:\s*hidden' -and $content -notmatch 'html\s*\{[^}]*overflow-x\s*:\s*hidden') {
        $missingRootOverflow += $relPath
    }
}

Write-Host "Files WITH viewport tag: $($hasViewport.Count)"
Write-Host "Files MISSING viewport tag: $($missingViewport.Count)"
Write-Host "`n--- Sample Missing Viewport Files ---"
$missingViewport | Select-Object -First 25 | ForEach-Object { Write-Host " - $_" }

Write-Host "`nFiles Missing html overflow-x:hidden: $($missingRootOverflow.Count)"
$missingRootOverflow | Select-Object -First 15 | ForEach-Object { Write-Host " - $_" }
