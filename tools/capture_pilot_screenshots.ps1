$httpPort = 8088
$cdpPort = 9225
$rootDir = (Get-Location).Path
$artifactDir = "C:\Users\shree\.gemini\antigravity-ide\brain\0517bc7e-63eb-4c37-9edd-e6af7e976187"
if (-not (Test-Path $artifactDir)) { New-Item -ItemType Directory -Path $artifactDir -Force | Out-Null }

$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

# 1. Start HTTP Server
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$httpPort/")
$listener.Start()
Write-Output "HTTP server started on port $httpPort"

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".webp" = "image/webp"
    ".svg"  = "image/svg+xml"
}

$runspace = [runspacefactory]::CreateRunspace()
$runspace.Open()
$powershell = [powershell]::Create()
$powershell.Runspace = $runspace

$powershell.AddScript({
    param($listener, $rootDir, $mimeTypes)
    while ($listener.IsListening) {
        try {
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response

            $urlPath = $request.Url.LocalPath.TrimStart('/')
            if ([string]::IsNullOrWhiteSpace($urlPath)) {
                $urlPath = "index.html"
            }

            $localPath = Join-Path $rootDir $urlPath
            if (Test-Path -Path $localPath -PathType Container) {
                $localPath = Join-Path $localPath "index.html"
            }

            if (Test-Path -Path $localPath -PathType Leaf) {
                $ext = [System.IO.Path]::GetExtension($localPath).ToLower()
                $mime = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
                $response.ContentType = $mime
                $response.StatusCode = 200
                $bytes = [System.IO.File]::ReadAllBytes($localPath)
                $response.ContentLength64 = $bytes.Length
                $response.OutputStream.Write($bytes, 0, $bytes.Length)
            } else {
                $response.StatusCode = 404
                $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
                $response.OutputStream.Write($msg, 0, $msg.Length)
            }
            $response.OutputStream.Close()
        } catch {
            break
        }
    }
}).AddArgument($listener).AddArgument($rootDir).AddArgument($mimeTypes) | Out-Null

$asyncHandle = $powershell.BeginInvoke()
Start-Sleep -Milliseconds 500

# 2. Launch Edge
$tempDir = Join-Path $env:TEMP "edge_pilot_shots"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue }
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new", "--remote-debugging-port=$cdpPort", "--user-data-dir=$tempDir", "--disable-gpu", "about:blank" -PassThru
Start-Sleep -Seconds 2

try {
    $tabs = Invoke-RestMethod -Uri "http://localhost:$cdpPort/json"
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

        $buffer = New-Object byte[] 2097152 # 2MB buffer
        $ms = New-Object System.IO.MemoryStream
        do {
            $recvSegment = New-Object System.ArraySegment[byte] -ArgumentList @(,$buffer)
            $res = $ws.ReceiveAsync($recvSegment, $cts.Token).Result
            $ms.Write($buffer, 0, $res.Count)
        } while (-not $res.EndOfMessage)

        return [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
    }

    $pagesToTest = @(
        @{ Name = "pilot1_home"; Path = "/" },
        @{ Name = "pilot2_staircase"; Path = "/stone-carving/staircase-wall/" },
        @{ Name = "pilot3_radhe_krishna"; Path = "/stone-art-murals/radhe-krishna-stone-art-mural/" },
        @{ Name = "pilot4_fluted_panels"; Path = "/stone-wall-panels/fluted-stone-panels/" },
        @{ Name = "pilot5_cnc_jali_hub"; Path = "/cnc-jali-work/" },
        @{ Name = "pilot5b_stone_jali"; Path = "/stone-jali/" }
    )

    $viewports = @(
        @{ Label = "desktop_1280"; Width = 1280; Height = 800; Mobile = $false },
        @{ Label = "mobile_375"; Width = 375; Height = 812; Mobile = $true }
    )

    Write-Output "`n=== CAPTURING SCREENSHOTS & TESTING OVERFLOW ==="

    foreach ($page in $pagesToTest) {
        $pageUrl = "http://localhost:$httpPort" + $page.Path
        Write-Output "`nTesting Page: $($page.Name) ($($page.Path))"

        foreach ($vp in $viewports) {
            # Set viewport
            $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{
                width = $vp.Width
                height = $vp.Height
                deviceScaleFactor = 1
                mobile = $vp.Mobile
            }

            # Navigate
            $null = Send-CDP "Page.navigate" @{ url = $pageUrl }
            Start-Sleep -Milliseconds 1200

            # Check overflow
            $evalResp = Send-CDP "Runtime.evaluate" @{
                expression = @"
(() => {
    return JSON.stringify({
        winW: window.innerWidth,
        docW: document.documentElement.scrollWidth,
        bodyW: document.body.scrollWidth,
        hasHScroll: document.documentElement.scrollWidth > window.innerWidth
    });
})()
"@
                returnByValue = $true
            }
            $evalData = (($evalResp | ConvertFrom-Json).result.result.value) | ConvertFrom-Json
            
            $statusStr = if ($evalData.hasHScroll) { "FAIL: Horizontal Overflow!" } else { "PASS (No overflow)" }
            Write-Output "  [$($vp.Label)] $statusStr (winW=$($evalData.winW), docW=$($evalData.docW))"

            # Capture screenshot
            $shotResp = Send-CDP "Page.captureScreenshot" @{
                format = "png"
            }
            $base64 = ($shotResp | ConvertFrom-Json).result.data
            if ($base64) {
                $outName = "$($page.Name)_$($vp.Label).png"
                $outPath = Join-Path $artifactDir $outName
                [System.IO.File]::WriteAllBytes($outPath, [System.Convert]::FromBase64String($base64))
                Write-Output "    -> Saved screenshot: $outName"
            }
        }
    }

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", $cts.Token).Wait()

} finally {
    if ($proc -and -not $proc.HasExited) { $proc.Kill() }
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
    $listener.Stop()
    $listener.Close()
    $powershell.Dispose()
    $runspace.Dispose()
}

Write-Output "`nAll screenshots captured successfully!"
