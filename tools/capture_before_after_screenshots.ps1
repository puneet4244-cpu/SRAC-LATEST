$httpPort = 8089
$cdpPort = 9226
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
$tempDir = Join-Path $env:TEMP "edge_compare_shots"
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

    $targets = @(
        @{ Label = "live_home"; Url = "https://www.shreeramandcompany.com/" },
        @{ Label = "preview_home"; Url = "http://localhost:$httpPort/" },
        @{ Label = "live_stone_jali"; Url = "https://www.shreeramandcompany.com/stone-jali/" },
        @{ Label = "preview_stone_jali"; Url = "http://localhost:$httpPort/stone-jali/" }
    )

    $viewports = @(
        @{ Label = "1280"; Width = 1280; Height = 800; Mobile = $false },
        @{ Label = "375"; Width = 375; Height = 812; Mobile = $true }
    )

    Write-Output "`n=== CAPTURING LIVE VS PREVIEW SCREENSHOTS ==="

    foreach ($t in $targets) {
        foreach ($vp in $viewports) {
            $shotName = "$($t.Label)_$($vp.Label).png"
            $outPath = Join-Path $artifactDir $shotName
            Write-Output "Capturing $shotName from $($t.Url)..."

            # Set viewport
            $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{
                width = $vp.Width
                height = $vp.Height
                deviceScaleFactor = 1
                mobile = $vp.Mobile
            }

            # Navigate
            $null = Send-CDP "Page.navigate" @{ url = $t.Url }
            Start-Sleep -Seconds 3

            # Take screenshot of viewport
            $shotResp = Send-CDP "Page.captureScreenshot" @{
                format = "png"
            }

            $shotJson = $shotResp | ConvertFrom-Json
            if ($shotJson.result -and $shotJson.result.data) {
                $imgBytes = [System.Convert]::FromBase64String($shotJson.result.data)
                [System.IO.File]::WriteAllBytes($outPath, $imgBytes)
                Write-Output "  Saved: $shotName ($($imgBytes.Length) bytes)"
            } else {
                Write-Output "  Failed to capture screenshot for $shotName"
            }
        }
    }

} finally {
    if ($ws -and $ws.State -eq [System.Net.WebSockets.WebSocketState]::Open) {
        $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", $cts.Token).Wait()
    }
    if ($proc -and -not $proc.HasExited) {
        Stop-Process -Id $proc.Id -Force
    }
    if ($listener.IsListening) {
        $listener.Stop()
    }
    $runspace.Close()
    Write-Output "`nCleaned up browser and HTTP server."
}
