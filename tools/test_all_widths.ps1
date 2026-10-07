$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$port = 9224
$tempDir = Join-Path $env:TEMP "edge_test_multi"
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

    $testWidths = @(320, 360, 375, 390, 414, 480, 600, 768, 800, 900, 1024, 1100, 1280, 1440, 1920)
    
    foreach ($w in $testWidths) {
        $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{ width = $w; height = 900; deviceScaleFactor = 2; mobile = ($w -lt 1024) }
        $null = Send-CDP "Page.navigate" @{ url = "http://localhost:8080/" }
        Start-Sleep -Milliseconds 800

        $resp = Send-CDP "Runtime.evaluate" @{
            expression = @"
(() => {
    const elList = [];
    const targetW = $w;
    document.querySelectorAll('*').forEach(el => {
        const r = el.getBoundingClientRect();
        if (r.right > targetW + 1.5) {
            elList.push({
                tag: el.tagName,
                id: el.id,
                className: (el.className || '').toString().slice(0, 80),
                rectRight: Math.round(r.right),
                offsetWidth: el.offsetWidth
            });
        }
    });
    return JSON.stringify({
        targetW: targetW,
        winW: window.innerWidth,
        docW: document.documentElement.scrollWidth,
        bodyW: document.body.scrollWidth,
        culprits: elList.slice(0, 10)
    });
})()
"@
            returnByValue = $true
        }
        
        $jsonStr = ($resp | ConvertFrom-Json).result.result.value
        $data = $jsonStr | ConvertFrom-Json
        if ($data.culprits.Count -gt 0 -or $data.docW -gt $w -or $data.winW -ne $w) {
            Write-Host "⚠️ OVERFLOW at ${w}px! docW=$($data.docW) winW=$($data.winW) culprits=$($data.culprits.Count)" -ForegroundColor Red
            foreach ($c in $data.culprits) {
                Write-Host "   Tag: $($c.tag) id='$($c.id)' class='$($c.className)' right=$($c.rectRight) width=$($c.offsetWidth)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "✅ Perfect at ${w}px (docW=$($data.docW), winW=$($data.winW))" -ForegroundColor Green
        }
    }

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", $cts.Token).Wait()
} finally {
    if ($proc -and -not $proc.HasExited) { $proc.Kill() }
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}
