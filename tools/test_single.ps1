$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$port = 9223
$tempDir = Join-Path $env:TEMP "edge_test_single"
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

    $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{ width = 768; height = 1024; deviceScaleFactor = 2; mobile = $true }
    $null = Send-CDP "Page.navigate" @{ url = "http://localhost:8080/" }
    Start-Sleep -Seconds 1

    $resp = Send-CDP "Runtime.evaluate" @{
        expression = @"
(() => {
    const elList = [];
    document.querySelectorAll('*').forEach(el => {
        const r = el.getBoundingClientRect();
        if (r.right > 768 || el.offsetWidth > 768) {
            elList.push({
                tag: el.tagName,
                id: el.id,
                className: (el.className || '').toString().slice(0, 100),
                rectRight: Math.round(r.right),
                rectLeft: Math.round(r.left),
                offsetWidth: el.offsetWidth,
                textSnippet: (el.innerText || '').slice(0, 40).replace(/\n/g, ' ')
            });
        }
    });
    return JSON.stringify({
        winW: window.innerWidth,
        docW: document.documentElement.scrollWidth,
        culprits: elList.slice(0, 15)
    });
})()
"@
        returnByValue = $true
    }
    Write-Host "Raw CDP Response: $resp"

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", $cts.Token).Wait()
} finally {
    if ($proc -and -not $proc.HasExited) { $proc.Kill() }
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}
