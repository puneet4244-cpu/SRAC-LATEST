$muralDirs = Get-ChildItem -Path "stone-art-murals" -Directory
$passed = 0
$total = 0

foreach ($d in $muralDirs) {
    $idxFile = Join-Path $d.FullName "index.html"
    if (Test-Path $idxFile) {
        $total++
        $content = Get-Content $idxFile -Raw -Encoding UTF8
        if ($content -match '<script type="application/ld\+json">([\s\S]*?)</script>') {
            $jsonText = $matches[1].Trim()
            try {
                $schemaObj = ConvertFrom-Json $jsonText
                $types = ($schemaObj.'@graph' | ForEach-Object { $_.'@type' }) -join ", "
                Write-Host "PASS: $($d.Name) -> Types: [$types]"
                $passed++
            } catch {
                Write-Host "FAIL: $($d.Name) -> Invalid JSON: $_"
            }
        } else {
            Write-Host "WARN: $($d.Name) has no ld+json"
        }
    }
}

Write-Host "`nTotal Validated: $passed / $total"
