$url = "https://www.shreeramandcompany.com/"
$req = [System.Net.HttpWebRequest]::Create($url)
$req.AllowAutoRedirect = $true
$req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

$resp = $req.GetResponse()
$stream = $resp.GetResponseStream()
$reader = New-Object System.IO.StreamReader($stream)
$content = $reader.ReadToEnd()

Write-Host "Live Status: $([int]$resp.StatusCode)"
Write-Host "Response URI: $($resp.ResponseUri)"
Write-Host "HTML Length: $($content.Length) bytes"

Write-Host "`n--- LIVE HEAD CHECKS (https://www.shreeramandcompany.com/) ---"

# 1. Canonical
if ($content -match '<link\s+rel=["'']canonical["'']\s+href=["''](.*?)["'']') {
    Write-Host "Live Canonical: $($matches[1])"
} else {
    Write-Host "No Canonical tag on live!"
}

# 2. OG:URL
if ($content -match '<meta\s+property=["'']og:url["'']\s+content=["''](.*?)["'']') {
    Write-Host "Live OG:URL: $($matches[1])"
} else {
    Write-Host "No OG:URL tag on live!"
}

# 3. vijetastone.com matches
$hasVijeta = $content -match "vijetastone\.com"
Write-Host "Contains 'vijetastone.com' on live: $hasVijeta"
if ($hasVijeta) {
    $vMatches = [regex]::Matches($content, 'https?://[^\s"'']*vijetastone\.com[^\s"'']*')
    foreach ($vm in $vMatches) {
        Write-Host "   -> Live vijetastone reference: $($vm.Value)"
    }
} else {
    Write-Host "   -> 0 occurrences of vijetastone.com on live site!"
}

# 4. JSON-LD Schema extract
$schemaMatches = [regex]::Matches($content, '<script\s+type=["'']application/ld\+json["'']>(.*?)</script>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
Write-Host "Total JSON-LD blocks on live: $($schemaMatches.Count)"
foreach ($sm in $schemaMatches) {
    $schemaText = $sm.Groups[1].Value
    if ($schemaText -match "vijetastone\.com") {
        Write-Host "   -> WARNING: Live JSON-LD contains vijetastone.com!"
        $lines = $schemaText -split "`n" | Where-Object { $_ -match "vijetastone\.com" }
        foreach ($l in $lines) { Write-Host "      $($l.Trim())" }
    } else {
        Write-Host "   -> Live JSON-LD is 100% CLEAN (does not contain vijetastone.com)."
    }
}

# 5. Local index.html Comparison
$localContent = [System.IO.File]::ReadAllText("index.html")
Write-Host "`n--- LOCAL FILE (index.html) ---"
if ($localContent -match '<link\s+rel=["'']canonical["'']\s+href=["''](.*?)["'']') {
    Write-Host "Local Canonical: $($matches[1])"
}
if ($localContent -match '<meta\s+property=["'']og:url["'']\s+content=["''](.*?)["'']') {
    Write-Host "Local OG:URL: $($matches[1])"
}
Write-Host "Local contains 'vijetastone.com': $($localContent -match 'vijetastone\.com')"
