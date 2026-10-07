$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
}

$widths = @(360, 390, 414, 768, 820, 1024, 1280, 1440)
$pages = @(
    "/",
    "/stone-carving/",
    "/stone-art-murals/",
    "/stone-wall-panels/",
    "/marble-temple/",
    "/about-us/",
    "/articles/",
    "/get-a-quote/"
)

Write-Host "Using Browser: $edgePath"

# We will start Edge with remote debugging to inspect DOM overflow
$port = 9222
$tempDir = Join-Path $env:TEMP "edge_audit_profile"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue }
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new", "--remote-debugging-port=$port", "--user-data-dir=$tempDir", "--disable-gpu", "about:blank" -PassThru
Start-Sleep -Seconds 2

try {
    # Check CDP connectivity
    $tabs = Invoke-RestMethod -Uri "http://localhost:$port/json" -ErrorAction Stop
    $targetTab = $tabs[0]
    $wsUrl = $targetTab.webSocketDebuggerUrl
    Write-Host "Connected to browser CDP: $wsUrl"

    # We can use System.Net.WebSockets.ClientWebSocket to send CDP commands
    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    $cts = New-Object System.Threading.CancellationTokenSource
    $ws.ConnectAsync([System.Uri]$wsUrl, $cts.Token).Wait()

    function Send-CDP ($method, $params = @{}) {
        $id = [System.Threading.Interlocked]::Increment([ref]1)
        $payload = @{
            id = $id
            method = $method
            params = $params
        } | ConvertTo-Json -Depth 10 -Compress

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

        $respJson = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
        return ($respJson | ConvertFrom-Json)
    }

    foreach ($w in $widths) {
        Write-Host "`n=========================================="
        Write-Host "TESTING VIEWPORT WIDTH: $w px"
        Write-Host "=========================================="

        # Set device metrics override
        $h = 900
        $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{
            width = $w
            height = $h
            deviceScaleFactor = 2
            mobile = ($w -lt 1024)
        }

        foreach ($p in $pages) {
            $url = "http://localhost:8080$p"
            $null = Send-CDP "Page.navigate" @{ url = $url }
            Start-Sleep -Milliseconds 600

            # Evaluate overflow check
            $js = @"
(() => {
    const winW = window.innerWidth;
    const docW = document.documentElement.scrollWidth;
    const bodyW = document.body.scrollWidth;
    const isOverflowing = docW > winW || bodyW > winW;
    
    let overflowingElements = [];
    if (isOverflowing) {
        const all = document.querySelectorAll('*');
        for (let el of all) {
            const rect = el.getBoundingClientRect();
            if (rect.right > winW + 1) {
                overflowingElements.push({
                    tag: el.tagName,
                    id: el.id || '',
                    class: (el.className || '').toString().slice(0, 80),
                    right: Math.round(rect.right),
                    width: Math.round(rect.width)
                });
                if (overflowingElements.length >= 5) break;
            }
        }
    }
    
    return {
        winW: winW,
        docW: docW,
        bodyW: bodyW,
        diff: docW - winW,
        isOverflowing: isOverflowing,
        culprits: overflowingElements
    };
})()
"@
            $evalRes = Send-CDP "Runtime.evaluate" @{
                expression = $js
                returnByValue = $true
            }

            $resVal = $evalRes.result.value
            if ($resVal.isOverflowing -or $resVal.diff -gt 0) {
                Write-Host "❌ OVERFLOW on $p at ${w}px! docW: $($resVal.docW), winW: $($resVal.winW), diff: +$($resVal.diff)px" -ForegroundColor Red
                foreach ($c in $resVal.culprits) {
                    Write-Host "   -> Tag: <$($c.tag)> id='$($c.id)' class='$($c.class)' right=$($c.right)px width=$($c.width)px" -ForegroundColor Yellow
                }
            } else {
                Write-Host "✅ PASS: $p at ${w}px (docW: $($resVal.docW) == winW: $($resVal.winW))" -ForegroundColor Green
            }
        }
    }

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", $cts.Token).Wait()
} finally {
    if ($proc -and -not $proc.HasExited) {
        $proc.Kill()
    }
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}
