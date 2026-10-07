$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$port = 9225
$tempDir = Join-Path $env:TEMP "edge_test_span"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue }
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new", "--remote-debugging-port=$port", "--user-data-dir=$tempDir", "--disable-gpu", "about:blank" -PassThru
Start-Sleep -Seconds 2

try {
    $tabs = Invoke-RestMethod -Uri "http://localhost:$port/json"
    $wsUrl = $tabs[0].webSocketDebuggerUrl
    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    $cts = New-Object System.Threading.CancellationTokenSource
    $ws.ConnectAsync([System.Uri]$wsUrl, $cts.Token).Wait()

    function Send-CDP ($method, $params = @{}) {
        $id = [System.Threading.Interlocked]::Increment([ref]1)
        $payload = @{ id = $id; method = $method; params = $params } | ConvertTo-Json -Depth 10 -Compress
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
        $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$bytes)
        $ws.SendAsync($segment, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, $cts.Token).Wait()

        $buffer = New-Object byte[] 65536
        $ms = New-Object System.IO.MemoryStream
        do {
            $recvSegment = New-Object System.ArraySegment[byte] -ArgumentList @(,$buffer)
            $res = $ws.ReceiveAsync($recvSegment, $cts.Token).Result
            $ms.Write($buffer, 0, $res.Count)
        } while (-not $res.EndOfMessage)

        return [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
    }

    $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{ width = 1280; height = 900; deviceScaleFactor = 2; mobile = $false }
    $null = Send-CDP "Page.navigate" @{ url = "http://localhost:8080/" }
    Start-Sleep -Seconds 1

    $resp = Send-CDP "Runtime.evaluate" @{
        expression = @"
(() => {
    const bigEls = [];
    document.querySelectorAll('*').forEach(el => {
        if (el.offsetWidth > 2000) {
            bigEls.push({
                tag: el.tagName,
                className: el.className,
                outerHTML: el.outerHTML.slice(0, 300),
                parentTag: el.parentElement ? el.parentElement.tagName : null,
                parentClass: el.parentElement ? el.parentElement.className : null,
                parentParentClass: el.parentElement && el.parentElement.parentElement ? el.parentElement.parentElement.className : null
            });
        }
    });
    return JSON.stringify(bigEls);
})()
"@
        returnByValue = $true
    }
    
    $jsonVal = ($resp | ConvertFrom-Json).result.result.value
    Write-Host "Big Elements (>2000px):"
    Write-Host $jsonVal

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", $cts.Token).Wait()
} finally {
    if ($proc -and -not $proc.HasExited) { $proc.Kill() }
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}
