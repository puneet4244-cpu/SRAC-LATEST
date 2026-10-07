$files = Get-ChildItem -Path "mdf-hdmr-work" -Recurse -Filter "index.html"
foreach ($f in $files) {
    $c = Get-Content $f.FullName -Raw -Encoding UTF8
    if ($c -match 'noindex,\s*nofollow') {
        $c = $c -replace 'noindex,\s*nofollow', 'noindex, follow'
        [System.IO.File]::WriteAllText($f.FullName, $c, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($f.FullName) to noindex, follow"
    }
}
