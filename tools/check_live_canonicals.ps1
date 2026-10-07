$pages = @(
    "https://www.shreeramandcompany.com/",
    "https://www.shreeramandcompany.com/stone-carving/",
    "https://www.shreeramandcompany.com/stone-jali/",
    "https://www.shreeramandcompany.com/marble-temple/"
)

Write-Output "=== LIVE SITE CANONICAL, OG:URL & SCHEMA AUDIT ==="

foreach ($url in $pages) {
    Write-Output "`n-----------------------------------------"
    Write-Output "Fetching LIVE: $url"
    try {
        $resp = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10 -Headers @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" }
        $html = $resp.Content

        $canon = if ($html -match '(?i)<link[^>]*rel=["'']canonical["''][^>]*href=["''](.*?)["'']') { $matches[1] } else { "NONE" }
        $ogUrl = if ($html -match '(?i)<meta[^>]*property=["'']og:url["''][^>]*content=["''](.*?)["'']') { $matches[1] } else { "NONE" }
        
        # Check domain in json-ld
        $jsonMatches = [regex]::Matches($html, '(?is)<script[^>]*type=["'']application/ld\+json["''][^>]*>(.*?)</script>')
        $schemaUrls = @()
        foreach ($jm in $jsonMatches) {
            $uMatches = [regex]::Matches($jm.Groups[1].Value, 'https?://[^\s",]+')
            foreach ($um in $uMatches) {
                if ($um.Value -notlike "*schema.org*") {
                    $schemaUrls += $um.Value
                }
            }
        }
        $schemaUrls = $schemaUrls | Select-Object -Unique

        Write-Output "  Status Code: $($resp.StatusCode)"
        Write-Output "  Live Canonical: $canon"
        Write-Output "  Live og:url:    $ogUrl"
        Write-Output "  Live Schema Sample URLs: $($schemaUrls[0..3] -join ' | ')"

    } catch {
        Write-Output "  Error fetching $url : $_"
    }
}
