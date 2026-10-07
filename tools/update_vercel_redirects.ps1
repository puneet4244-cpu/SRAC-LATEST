$root = (Get-Location).Path
$vPath = Join-Path $root "vercel.json"
$v = Get-Content $vPath -Raw | ConvertFrom-Json

# Filter out the 2 converted pilot subcategories
$newRedirects = @()

foreach ($r in $v.redirects) {
    $src = $r.source.TrimEnd('/')
    
    # 1. Remove rules for the converted standalone URLs
    if ($src -eq "/stone-art-murals/radhe-krishna-stone-art-mural" -or $src -eq "/stone-wall-panels/fluted-stone-panels") {
        Write-Host "Removing 301 redirect rule for converted standalone page: $src"
        continue
    }

    # 2. Point short aliases to the canonical standalone page
    if ($src -eq "/stone-art-murals/radhe-krishna") {
        $r.destination = "/stone-art-murals/radhe-krishna-stone-art-mural/"
        Write-Host "Updated alias $src -> $($r.destination)"
    }
    elseif ($src -eq "/stone-wall-panels/fluted") {
        $r.destination = "/stone-wall-panels/fluted-stone-panels/"
        Write-Host "Updated alias $src -> $($r.destination)"
    }

    $newRedirects += $r
}

# 3. Add duplicates redirects for /murals-wall-art and /temple if not present
$hasMurals = ($newRedirects | Where-Object { $_.source.TrimEnd('/') -eq "/murals-wall-art" })
if (-not $hasMurals) {
    $newRedirects += [PSCustomObject]@{
        source = "/murals-wall-art"
        destination = "/stone-art-murals/"
        permanent = $true
    }
    Write-Host "Added 301 redirect: /murals-wall-art -> /stone-art-murals/"
}

$hasTemple = ($newRedirects | Where-Object { $_.source.TrimEnd('/') -eq "/temple" })
if (-not $hasTemple) {
    $newRedirects += [PSCustomObject]@{
        source = "/temple"
        destination = "/marble-temple/"
        permanent = $true
    }
    Write-Host "Added 301 redirect: /temple -> /marble-temple/"
}

$v.redirects = $newRedirects
$v | ConvertTo-Json -Depth 10 | Set-Content $vPath -Encoding UTF8
Write-Host "vercel.json successfully updated! Total redirects: $($v.redirects.Count)"
