$root = (Get-Location).Path
$vPath = Join-Path $root "vercel.json"
$v = Get-Content $vPath -Raw | ConvertFrom-Json

$convertedSlugs = @(
    "/mdf-hdmr-work/fluted-mdf-panels",
    "/mdf-hdmr-work/geometrical-mdf-panels",
    "/mdf-hdmr-work/mdf-hdmr-wall-panels",
    "/mdf-hdmr-work/textured-mdf-panels",
    "/mdf-hdmr-work/wave-mdf-panels",
    "/stone-art-murals/buddha-stone-art-mural",
    "/stone-art-murals/durga-mata-ji-stone-art-mural",
    "/stone-art-murals/floral-stone-art",
    "/stone-art-murals/ganesh-ji-stone-art-mural",
    "/stone-art-murals/hanuman-ji-stone-art-mural",
    "/stone-art-murals/laxmi-ji-stone-art-mural",
    "/stone-art-murals/radhe-krishna-stone-art-mural",
    "/stone-art-murals/ram-darbar-stone-art-mural",
    "/stone-art-murals/shiv-ji-stone-art-mural",
    "/stone-art-murals/shreenath-ji-stone-art-mural",
    "/stone-art-murals/swaminarayan-ji-stone-art-mural",
    "/stone-art-murals/village-stone-art-mural",
    "/stone-wall-panels/fluted-stone-panels",
    "/stone-wall-panels/geometrical-stone-panels",
    "/stone-wall-panels/textured-stone-panels",
    "/stone-wall-panels/wave-stone-panels"
)

# Map short alias sources to their converted canonical page destinations
$aliasMap = @{
    "/mdf-hdmr-work/fluted" = "/mdf-hdmr-work/fluted-mdf-panels/"
    "/mdf-hdmr-work/geometrical" = "/mdf-hdmr-work/geometrical-mdf-panels/"
    "/mdf-hdmr-work/wall-panels" = "/mdf-hdmr-work/mdf-hdmr-wall-panels/"
    "/mdf-hdmr-work/textured" = "/mdf-hdmr-work/textured-mdf-panels/"
    "/mdf-hdmr-work/wave" = "/mdf-hdmr-work/wave-mdf-panels/"
    "/stone-art-murals/buddha" = "/stone-art-murals/buddha-stone-art-mural/"
    "/stone-art-murals/durga-mata-ji" = "/stone-art-murals/durga-mata-ji-stone-art-mural/"
    "/stone-art-murals/ganesh-ji" = "/stone-art-murals/ganesh-ji-stone-art-mural/"
    "/stone-art-murals/hanuman-ji" = "/stone-art-murals/hanuman-ji-stone-art-mural/"
    "/stone-art-murals/laxmi-ji" = "/stone-art-murals/laxmi-ji-stone-art-mural/"
    "/stone-art-murals/radhe-krishna" = "/stone-art-murals/radhe-krishna-stone-art-mural/"
    "/stone-art-murals/ram-darbar" = "/stone-art-murals/ram-darbar-stone-art-mural/"
    "/stone-art-murals/shiv-ji" = "/stone-art-murals/shiv-ji-stone-art-mural/"
    "/stone-art-murals/shreenath-ji" = "/stone-art-murals/shreenath-ji-stone-art-mural/"
    "/stone-art-murals/swaminarayan-ji" = "/stone-art-murals/swaminarayan-ji-stone-art-mural/"
    "/stone-art-murals/village-stone-art" = "/stone-art-murals/village-stone-art-mural/"
    "/stone-wall-panels/fluted" = "/stone-wall-panels/fluted-stone-panels/"
    "/stone-wall-panels/geometrical" = "/stone-wall-panels/geometrical-stone-panels/"
    "/stone-wall-panels/textured" = "/stone-wall-panels/textured-stone-panels/"
    "/stone-wall-panels/wave" = "/stone-wall-panels/wave-stone-panels/"
}

$newRedirects = @()

foreach ($r in $v.redirects) {
    $src = $r.source.TrimEnd('/')
    
    # 1. Skip if this rule is for one of the 21 converted pages
    if ($convertedSlugs -contains $src) {
        Write-Host "Removing 301 rule for converted page: $src"
        continue
    }

    # 2. Update aliases to point to converted canonical page
    if ($aliasMap.ContainsKey($src)) {
        $dest = $aliasMap[$src]
        Write-Host "Updating alias: $src -> $dest"
        $r.destination = $dest
    }

    $newRedirects += $r
}

$v.redirects = $newRedirects
$v | ConvertTo-Json -Depth 10 | Set-Content $vPath -Encoding UTF8
Write-Host "vercel.json updated! Remaining redirects: $($v.redirects.Count)"

# 3. Remove meta-refresh from all 21 stub files
$removedRefreshCount = 0
foreach ($slug in $convertedSlugs) {
    $relPath = $slug.TrimStart('/') + "/index.html"
    $fullPath = Join-Path $root ($relPath.Replace('/', [System.IO.Path]::DirectorySeparatorChar))
    if (Test-Path $fullPath) {
        $content = Get-Content $fullPath -Raw
        if ($content -match '<meta\s+http-equiv=["'']refresh["''][^>]*>') {
            $updated = $content -replace '(?m)^\s*<meta\s+http-equiv=["'']refresh["''][^>]*>\r?\n?', ''
            Set-Content -Path $fullPath -Value $updated -Encoding UTF8
            $removedRefreshCount++
            Write-Host "Removed meta-refresh from $relPath"
        }
    }
}
Write-Host "Meta-refresh removed from $removedRefreshCount stub files."
