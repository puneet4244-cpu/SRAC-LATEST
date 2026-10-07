$pilotFiles = @(
    @{ Url = "/"; Path = "index.html"; Name = "Homepage" },
    @{ Url = "/stone-carving/staircase-wall/"; Path = "stone-carving/staircase-wall/index.html"; Name = "Staircase Wall" },
    @{ Url = "/stone-art-murals/radhe-krishna-stone-art-mural/"; Path = "stone-art-murals/radhe-krishna-stone-art-mural/index.html"; Name = "Radhe Krishna Stone Art & Mural" },
    @{ Url = "/stone-wall-panels/fluted-stone-panels/"; Path = "stone-wall-panels/fluted-stone-panels/index.html"; Name = "Fluted Stone Panels" },
    @{ Url = "/cnc-jali-work/"; Path = "cnc-jali-work/index.html"; Name = "CNC Jali Work (Pillar Hub)" },
    @{ Url = "/stone-jali/"; Path = "stone-jali/index.html"; Name = "Stone Jali (Child Page)" }
)

foreach ($p in $pilotFiles) {
    $content = Get-Content $p.Path -Raw
    
    # Title
    $title = ""
    if ($content -match '<title>(.*?)</title>') { $title = $matches[1].Trim() }
    
    # Meta description
    $meta = ""
    if ($content -match '<meta\s+name="description"\s+content="([^"]*)"' -or $content -match '<meta\s+content="([^"]*)"\s+name="description"') { 
        $meta = $matches[1].Trim() 
    }
    
    # H1
    $h1 = ""
    if ($content -match '<h1[^>]*>(.*?)</h1>') { 
        $h1 = ($matches[1] -replace '<[^>]+>', ' ').Trim() 
    }
    
    # Alt tags (sample 5)
    $alts = [regex]::Matches($content, '<img[^>]+alt="([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Select-Object -First 5
    
    # FAQs from schema or html
    $faqs = @()
    if ($content -match '"@type":\s*"Question"') {
        $qMatches = [regex]::Matches($content, '"@type":\s*"Question",\s*"name":\s*"([^"]+)",\s*"acceptedAnswer":\s*\{\s*"@type":\s*"Answer",\s*"text":\s*"([^"]+)"')
        foreach ($m in $qMatches) {
            $faqs += [PSCustomObject]@{ Q = $m.Groups[1].Value; A = $m.Groups[2].Value }
        }
    }

    Write-Output "=== $($p.Name) ($($p.Url)) ==="
    Write-Output "Title ($($title.Length) chars): $title"
    Write-Output "Meta  ($($meta.Length) chars): $meta"
    Write-Output "H1: $h1"
    Write-Output "Alts found: $($alts.Count)"
    Write-Output "FAQs found: $($faqs.Count)"
    Write-Output ""
}
