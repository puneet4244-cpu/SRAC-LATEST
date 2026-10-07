$url = "https://shreeramandcompany.com/"
$maxRedirects = 5

for ($i = 0; $i -lt $maxRedirects; $i++) {
    $req = [System.Net.HttpWebRequest]::Create($url)
    $req.AllowAutoRedirect = $false
    $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
    
    try {
        $resp = $req.GetResponse()
        $statusCode = [int]$resp.StatusCode
        Write-Host "Hop $($i): $url returned $statusCode"
        $stream = $resp.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $content = $reader.ReadToEnd()
        $reader.Close()
        $resp.Close()
        break
    } catch [System.Net.WebException] {
        $resp = $_.Exception.Response
        $statusCode = [int]$resp.StatusCode
        $loc = $resp.Headers["Location"]
        Write-Host "Hop $($i): $url returned $statusCode -> Redirect to: $loc"
        $resp.Close()
        if ($loc) {
            if (-not $loc.StartsWith("http")) {
                $uri = New-Object System.Uri([System.Uri]$url, $loc)
                $url = $uri.AbsoluteUri
            } else {
                $url = $loc
            }
        } else {
            break
        }
    }
}

if ($content) {
    Write-Host "`nSuccessfully fetched destination content ($($content.Length) bytes) from: $url"
    
    if ($content -match '<link\s+rel=["'']canonical["'']\s+href=["''](.*?)["'']') {
        Write-Host "Live Canonical: $($matches[1])"
    } else {
        Write-Host "No Canonical tag on live!"
    }
    
    if ($content -match '<meta\s+property=["'']og:url["'']\s+content=["''](.*?)["'']') {
        Write-Host "Live OG:URL: $($matches[1])"
    } else {
        Write-Host "No OG:URL tag on live!"
    }
    
    $hasVijeta = $content -match "vijetastone\.com"
    Write-Host "Contains 'vijetastone.com' on live: $hasVijeta"
    if ($hasVijeta) {
        $vMatches = [regex]::Matches($content, 'https?://[^\s"'']*vijetastone\.com[^\s"'']*')
        foreach ($vm in $vMatches) {
            Write-Host "   -> Match: $($vm.Value)"
        }
    }

    $schemaMatches = [regex]::Matches($content, '<script\s+type=["'']application/ld\+json["'']>(.*?)</script>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    Write-Host "Total JSON-LD blocks on live: $($schemaMatches.Count)"
    foreach ($sm in $schemaMatches) {
        $schemaText = $sm.Groups[1].Value
        if ($schemaText -match "vijetastone\.com") {
            Write-Host "   -> WARNING: Live JSON-LD contains vijetastone.com!"
            $lines = $schemaText -split "`n" | Where-Object { $_ -match "vijetastone\.com" }
            foreach ($l in $lines) { Write-Host "      $($l.Trim())" }
        } else {
            Write-Host "   -> Live JSON-LD does NOT contain vijetastone.com."
        }
    }
}
