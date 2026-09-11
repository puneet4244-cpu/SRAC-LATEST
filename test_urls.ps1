$urls = @(
    'http://localhost:8080/',
    'http://localhost:8080/stone-carving/',
    'http://localhost:8080/stone-carving/double-height-wall/',
    'http://localhost:8080/stone-art-murals/',
    'http://localhost:8080/stone-art-murals/radhe-krishna/',
    'http://localhost:8080/stone-wall-panels/',
    'http://localhost:8080/stone-wall-panels/fluted/',
    'http://localhost:8080/mdf-hdmr-work/',
    'http://localhost:8080/mdf-hdmr-work/wall-panels/',
    'http://localhost:8080/marble-temple/',
    'http://localhost:8080/stone-temple/',
    'http://localhost:8080/partition-jali/'
)

foreach ($u in $urls) {
    try {
        $res = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 3
        Write-Host "$u -> $($res.StatusCode)"
    } catch {
        Write-Host "$u -> FAILED: $($_.Exception.Message)"
    }
}
