# Helper script to inspect lead lines and sections of pilot pages
$pilotPages = @(
    "index.html",
    "stone-carving/staircase-wall/index.html",
    "stone-art-murals/radhe-krishna-stone-art-mural/index.html",
    "stone-wall-panels/fluted-stone-panels/index.html",
    "cnc-jali-work/index.html",
    "stone-jali/index.html"
)

foreach ($path in $pilotPages) {
    $c = Get-Content $path -Raw
    Write-Output "=================================================="
    Write-Output "PAGE: $path"
    
    # H1
    if ($c -match '(?s)<h1[^>]*>(.*?)</h1>') {
        $cleanH1 = ($matches[1] -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
        Write-Output "H1: $cleanH1"
    }

    # Lead line (usually first p in hero or first p after h1)
    if ($c -match '(?s)<h1.*?</h1>\s*(?:<div.*?</div>\s*)?(?:<p[^>]*class="[^"]*(?:tracking|lead|text-lg|text-gray|text-luxury)[^"]*"[^>]*>(.*?)</p>)') {
        $lead = ($matches[1] -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
        Write-Output "LEAD: $lead"
    } elseif ($c -match '(?s)<h1.*?</h1>.*?<p[^>]*>(.*?)</p>') {
        $lead = ($matches[1] -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
        Write-Output "LEAD (fallback): $lead"
    }

    # Headings summary
    $headings = [regex]::Matches($c, '<h[234][^>]*>(.*?)</h[234]>') | ForEach-Object {
        ($_.Groups[1].Value -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
    }
    Write-Output "Headings count: $($headings.Count)"
}
