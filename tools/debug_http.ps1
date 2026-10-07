$req = [System.Net.HttpWebRequest]::Create('https://shreeramandcompany.com')
$req.AllowAutoRedirect = $false
try {
    $resp = $req.GetResponse()
} catch [System.Net.WebException] {
    $resp = $_.Exception.Response
}
Write-Host "Status: $([int]$resp.StatusCode)"
Write-Host "Headers:"
foreach ($k in $resp.Headers.AllKeys) {
    Write-Host "  $k : $($resp.Headers[$k])"
}
$stream = $resp.GetResponseStream()
$reader = New-Object System.IO.StreamReader($stream)
Write-Host "Body: $($reader.ReadToEnd())"
