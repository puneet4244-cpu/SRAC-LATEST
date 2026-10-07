$ErrorActionPreference = "Stop"
$httpPort = 8080
$cdpPort = 9227
$rootDir = (Get-Location).Path
$artifactDir = "C:\Users\shree\.gemini\antigravity-ide\brain\0517bc7e-63eb-4c37-9edd-e6af7e976187"
if (-not (Test-Path $artifactDir)) { New-Item -ItemType Directory -Path $artifactDir -Force | Out-Null }

$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

Write-Host "Edge Path: $edgePath"
Write-Host "Testing against local server on port $httpPort (serving branch content-seo)"

# Verify server is answering
$testHead = curl.exe -s -I "http://localhost:$httpPort/"
if (-not $testHead) {
    Write-Error "Local server is not running on port $httpPort!"
}

# Launch Edge headless with CDP
$tempDir = Join-Path $env:TEMP "edge_preview_test"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue }
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new", "--remote-debugging-port=$cdpPort", "--user-data-dir=$tempDir", "--disable-gpu", "about:blank" -PassThru
Start-Sleep -Seconds 2

$script:cmdId = 1
$script:capturedConsoleLogs = @()

try {
    $tabs = Invoke-RestMethod -Uri "http://localhost:$cdpPort/json"
    $wsUrl = $tabs[0].webSocketDebuggerUrl
    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    $cts = New-Object System.Threading.CancellationTokenSource
    $ws.ConnectAsync([System.Uri]$wsUrl, $cts.Token).Wait()

    function Send-CDP ($method, $params = @{}) {
        $id = [System.Threading.Interlocked]::Increment([ref]$script:cmdId)
        $payload = @{ id = $id; method = $method; params = $params } | ConvertTo-Json -Depth 10 -Compress
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
        $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$bytes)
        $ws.SendAsync($segment, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, $cts.Token).Wait()

        while ($true) {
            $buffer = New-Object byte[] 4194304 # 4MB buffer
            $ms = New-Object System.IO.MemoryStream
            do {
                $recvSegment = New-Object System.ArraySegment[byte] -ArgumentList @(,$buffer)
                $res = $ws.ReceiveAsync($recvSegment, $cts.Token).Result
                $ms.Write($buffer, 0, $res.Count)
            } while (-not $res.EndOfMessage)

            $rawStr = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
            $parsed = $rawStr | ConvertFrom-Json
            if ($parsed.id -eq $id) {
                return $rawStr
            }
            if ($parsed.method -match 'Log|Runtime\.console|Security') {
                $script:capturedConsoleLogs += $rawStr
            }
        }
    }

    # Enable console / runtime events
    $null = Send-CDP "Log.enable"
    $null = Send-CDP "Runtime.enable"

    $samplePages = @(
        @{ Name = "sample1_home"; Path = "/" },
        @{ Name = "sample2_staircase_wall"; Path = "/stone-carving/staircase-wall/" },
        @{ Name = "sample3_fluted_panels"; Path = "/stone-wall-panels/fluted-stone-panels/" },
        @{ Name = "sample4_cnc_jali"; Path = "/cnc-jali-work/" },
        @{ Name = "sample5_ram_darbar"; Path = "/stone-art-murals/ram-darbar-stone-art-mural/" },
        @{ Name = "sample6_buddha_mural"; Path = "/stone-art-murals/buddha-stone-art-mural/" }
    )

    $viewports = @(
        @{ Label = "desktop_1280"; Width = 1280; Height = 800; Mobile = $false },
        @{ Label = "mobile_375"; Width = 375; Height = 812; Mobile = $true }
    )

    $summaryResults = @()

    foreach ($pg in $samplePages) {
        $pageUrl = "http://localhost:$httpPort" + $pg.Path
        Write-Host "`n=================================================="
        Write-Host "TESTING PAGE: $($pg.Name) ($($pg.Path))"
        Write-Host "=================================================="

        # Load page on desktop first for DOM inspections
        $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{
            width = 1280
            height = 800
            deviceScaleFactor = 1
            mobile = $false
        }
        $null = Send-CDP "Page.navigate" @{ url = $pageUrl }
        Start-Sleep -Milliseconds 1800

        # Test A: DOM Elements (Forms, Buttons, Maps, Fonts, Images)
        $domEval = Send-CDP "Runtime.evaluate" @{
            expression = @"
(() => {
    // 1. Forms & Quote CTAs
    const forms = Array.from(document.querySelectorAll('form')).map(f => ({
        id: f.id || '',
        action: f.action || '',
        inputsCount: f.querySelectorAll('input, select, textarea').length
    }));
    const quoteLinks = Array.from(document.querySelectorAll('a[href*="get-a-quote"]')).map(a => a.href);

    // 2. WhatsApp & Phone Buttons
    const waLinks = Array.from(document.querySelectorAll('a[href*="wa.me"], a[href*="whatsapp"]')).map(a => a.href);
    const callLinks = Array.from(document.querySelectorAll('a[href^="tel:"]')).map(a => a.href);

    // 3. Maps
    const maps = Array.from(document.querySelectorAll('iframe[src*="google.com/maps"], iframe[src*="maps.google"], a[href*="maps.app.goo.gl"], a[href*="google.com/maps"]')).map(m => m.src || m.href);

    // 4. Fonts
    const computedBody = window.getComputedStyle(document.body);
    const bodyFont = computedBody.fontFamily;
    const h1Elem = document.querySelector('h1');
    const h1Font = h1Elem ? window.getComputedStyle(h1Elem).fontFamily : '';

    // 5. Image Aspect Ratios & Dimensions
    const images = Array.from(document.querySelectorAll('img')).map(img => {
        const nw = img.naturalWidth;
        const nh = img.naturalHeight;
        const cw = img.clientWidth;
        const ch = img.clientHeight;
        const attrW = img.getAttribute('width');
        const attrH = img.getAttribute('height');
        const alt = img.alt || '';
        const src = img.src || '';
        
        const hasZeroNatural = (nw === 0 || nh === 0);
        let isDistorted = false;
        if (nw > 0 && nh > 0 && cw > 100 && ch > 100) {
            const naturalRatio = nw / nh;
            const displayRatio = cw / ch;
            const diff = Math.abs(naturalRatio - displayRatio) / naturalRatio;
            if (diff > 0.40) {
                isDistorted = true;
            }
        }
        return {
            src: src.replace(/^http:\/\/[^/]+/, ''),
            alt: alt.substring(0, 50),
            hasZeroNatural: hasZeroNatural,
            isDistorted: isDistorted,
            nw: nw,
            nh: nh,
            cw: cw,
            ch: ch
        };
    });

    return JSON.stringify({
        formsCount: forms.length,
        quoteLinksCount: quoteLinks.length,
        waLinksCount: waLinks.length,
        sampleWa: waLinks.length > 0 ? waLinks[0] : '',
        callLinksCount: callLinks.length,
        sampleCall: callLinks.length > 0 ? callLinks[0] : '',
        mapsCount: maps.length,
        bodyFont: bodyFont,
        h1Font: h1Font,
        imagesTotal: images.length,
        zeroDimImages: images.filter(i => i.hasZeroNatural).length,
        distortedImages: images.filter(i => i.isDistorted).length
    });
})()
"@
            returnByValue = $true
        }

        $resObj = (($domEval | ConvertFrom-Json).result.result.value) | ConvertFrom-Json

        Write-Host "  [DOM] Forms: $($resObj.formsCount) | Quote CTAs: $($resObj.quoteLinksCount)"
        Write-Host "  [DOM] WhatsApp: $($resObj.waLinksCount) links ($($resObj.sampleWa))"
        Write-Host "  [DOM] Call (tel:): $($resObj.callLinksCount) links ($($resObj.sampleCall))"
        Write-Host "  [DOM] Maps Elements: $($resObj.mapsCount)"
        Write-Host "  [DOM] Fonts: Body='$($resObj.bodyFont)', H1='$($resObj.h1Font)'"
        Write-Host "  [DOM] Images: Total=$($resObj.imagesTotal), 0-Dim=$($resObj.zeroDimImages), Distorted=$($resObj.distortedImages)"

        # Viewport screenshots and horizontal overflow test
        foreach ($vp in $viewports) {
            $null = Send-CDP "Emulation.setDeviceMetricsOverride" @{
                width = $vp.Width
                height = $vp.Height
                deviceScaleFactor = 1
                mobile = $vp.Mobile
            }
            Start-Sleep -Milliseconds 600

            $overflowEval = Send-CDP "Runtime.evaluate" @{
                expression = @"
(() => {
    return JSON.stringify({
        winW: window.innerWidth,
        docW: document.documentElement.scrollWidth,
        hasHScroll: document.documentElement.scrollWidth > window.innerWidth
    });
})()
"@
                returnByValue = $true
            }
            $ovData = (($overflowEval | ConvertFrom-Json).result.result.value) | ConvertFrom-Json
            $ovStatus = if ($ovData.hasHScroll) { "FAIL (Overflow)" } else { "PASS (No overflow)" }
            Write-Host "  [$($vp.Label)] $ovStatus (viewport: $($ovData.winW)px, scrollW: $($ovData.docW)px)"

            # Capture screenshot
            $shot = Send-CDP "Page.captureScreenshot" @{
                format = "png"
            }
            $base64Data = ($shot | ConvertFrom-Json).result.data
            if ($base64Data) {
                $fileName = "$($pg.Name)_$($vp.Label).png"
                $savePath = Join-Path $artifactDir $fileName
                [System.IO.File]::WriteAllBytes($savePath, [System.Convert]::FromBase64String($base64Data))
                Write-Host "    -> Screenshot saved: $fileName"
            }
        }

        $summaryResults += [PSCustomObject]@{
            Page = $pg.Name
            Path = $pg.Path
            Forms = $resObj.formsCount
            QuoteCTAs = $resObj.quoteLinksCount
            WhatsApp = $resObj.waLinksCount
            Call = $resObj.callLinksCount
            Maps = $resObj.mapsCount
            ImagesTotal = $resObj.imagesTotal
            ZeroDimImages = $resObj.zeroDimImages
            DistortedImages = $resObj.distortedImages
        }
    }

    Write-Host "`n=================================================="
    Write-Host "CHECKING CONSOLE LOGS FOR CSP / JAVASCRIPT ERRORS"
    Write-Host "=================================================="
    $cspErrors = $script:capturedConsoleLogs | Where-Object { $_ -match 'Content Security Policy|CSP|violation' }
    Write-Host "Total Captured Console Events: $($script:capturedConsoleLogs.Count)"
    Write-Host "CSP Errors / Violations: $($cspErrors.Count)"
    if ($cspErrors.Count -gt 0) {
        $cspErrors | ForEach-Object { Write-Host "  -> $_" }
    } else {
        Write-Host "Zero CSP violations detected across all sample pages!"
    }

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", $cts.Token).Wait()
} finally {
    if ($proc -and -not $proc.HasExited) { $proc.Kill() }
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}

Write-Host "`n=================================================="
Write-Host "SUMMARY RESULTS TABLE"
Write-Host "=================================================="
$summaryResults | Format-Table -AutoSize
