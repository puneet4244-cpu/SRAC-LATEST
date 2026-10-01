$urls = @(
    'http://localhost:8080/',
    'http://localhost:8080/stone-carving/',
    'http://localhost:8080/stone-carving/double-height-wall/',
    'http://localhost:8080/stone-carving/staircase-wall/',
    'http://localhost:8080/stone-carving/sofa-wall/',
    'http://localhost:8080/stone-carving/statement-wall/',
    'http://localhost:8080/stone-carving/living-room-wall/',
    'http://localhost:8080/stone-carving/featured-wall/',
    'http://localhost:8080/stone-art-murals/'
)

$allOk = $true
foreach ($u in $urls) {
    try {
        $res = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 3
        if ($res.StatusCode -eq 200) {
            Write-Host "[200 OK] $u" -ForegroundColor Green
        } else {
            Write-Host "[$($res.StatusCode)] $u" -ForegroundColor Yellow
            $allOk = $false
        }
    } catch {
        Write-Host "[FAILED] $u -> $($_.Exception.Message)" -ForegroundColor Red
        $allOk = $false
    }
}

if ($allOk) {
    Write-Host "`nAll 9 tested URLs returned HTTP 200 OK!" -ForegroundColor Green
} else {
    Write-Host "`nSome URLs failed!" -ForegroundColor Red
}
