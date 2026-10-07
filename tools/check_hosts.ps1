# Check vijetastone.com and primary host

Write-Host "=== 1. Checking vijetastone.com ==="
try {
    $dns = [System.Net.Dns]::GetHostAddresses("vijetastone.com")
    Write-Host "DNS resolved for vijetastone.com: $($dns.IPAddressToString -join ', ')"
    
    $req = [System.Net.HttpWebRequest]::Create("http://vijetastone.com")
    $req.AllowAutoRedirect = $false
    $req.Timeout = 5000
    $resp = $req.GetResponse()
    Write-Host "HTTP Status: $([int]$resp.StatusCode)"
    Write-Host "Location: $($resp.Headers['Location'])"
    $resp.Close()
} catch {
    Write-Host "vijetastone.com check error / does not resolve: $_"
}

Write-Host "`n=== 2. Checking www vs non-www redirection on shreeramandcompany.com ==="
$domains = @("https://shreeramandcompany.com", "https://www.shreeramandcompany.com")
foreach ($d in $domains) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($d)
        $req.AllowAutoRedirect = $false
        $resp = $req.GetResponse()
        Write-Host "$d -> Status $([int]$resp.StatusCode), Location: $($resp.Headers['Location'])"
        $resp.Close()
    } catch [System.Net.WebException] {
        $resp = $_.Exception.Response
        Write-Host "$d -> Catch Status $([int]$resp.StatusCode), Location: $($resp.Headers['Location'])"
    }
}
