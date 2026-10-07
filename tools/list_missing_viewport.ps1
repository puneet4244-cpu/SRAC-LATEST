$files = Get-ChildItem -Path "." -Filter "*.html" -Recurse
$missingViewport = @()

foreach ($file in $files) {
    $relPath = $file.FullName.Substring((Get-Location).Path.Length + 1).Replace("\", "/")
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    if ($content -notmatch 'meta\s+name=["'']viewport["'']') {
        $missingViewport += $relPath
    }
}

Write-Host "Missing viewport count: $($missingViewport.Count)"
foreach ($m in $missingViewport) {
    Write-Host $m
}
