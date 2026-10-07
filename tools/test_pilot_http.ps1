$port = 8085
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Output "HTTP Test Listener started on port $port"

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".webp" = "image/webp"
}

$pilotUrls = @(
    "/",
    "/stone-carving/staircase-wall/",
    "/stone-art-murals/radhe-krishna-stone-art-mural/",
    "/stone-wall-panels/fluted-stone-panels/",
    "/cnc-jali-work/",
    "/stone-jali/"
)

$rootDir = (Get-Location).Path
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
                $mime = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "text/html; charset=utf-8" }
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

Write-Output "`n=== TESTING PILOT PAGES HTTP RESPONSES ==="
$results = @()
foreach ($relUrl in $pilotUrls) {
    $testUrl = "http://localhost:$port$relUrl"
    try {
        $resp = Invoke-WebRequest -Uri $testUrl -UseBasicParsing -TimeoutSec 5
        $status = $resp.StatusCode
        $html = $resp.Content
        
        $titleMatch = [regex]::Match($html, '(?is)<title>(.*?)</title>')
        $title = if ($titleMatch.Success) { $titleMatch.Groups[1].Value.Trim() } else { "MISSING" }
        
        $h1Match = [regex]::Match($html, '(?is)<h1[^>]*>(.*?)</h1>')
        $h1 = if ($h1Match.Success) { 
            [regex]::Replace($h1Match.Groups[1].Value, '\s+', ' ').Trim() 
        } else { "MISSING" }
        $h1Clean = [regex]::Replace($h1, '<[^>]+>', '').Trim()

        $canonMatch = [regex]::Match($html, '(?is)<link[^>]*rel=["'']canonical["''][^>]*href=["''](.*?)["'']')
        $canon = if ($canonMatch.Success) { $canonMatch.Groups[1].Value.Trim() } else { "MISSING" }

        $results += [PSCustomObject]@{
            URL = $relUrl
            HTTP = $status
            H1 = $h1Clean
            Canonical = $canon
            Title = $title
        }
    } catch {
        $results += [PSCustomObject]@{
            URL = $relUrl
            HTTP = "ERROR: $_"
            H1 = "N/A"
            Canonical = "N/A"
            Title = "N/A"
        }
    }
}

$listener.Stop()
$listener.Close()
$powershell.Dispose()
$runspace.Dispose()

$results | Format-Table -AutoSize
