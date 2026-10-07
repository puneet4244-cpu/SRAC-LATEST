$mapPath = "c:\Users\shree\OneDrive\Desktop\NTRY\SEO_KEYWORD_MAP.md"
$lines = Get-Content $mapPath -Encoding utf8

$pagePrimaries = @{}
$blogPrimaries = @{}

$currentPage = ""
$inSection1 = $false
$inSection4 = $false

foreach ($line in $lines) {
    if ($line -match '^## 1\. PAGE') { $inSection1 = $true; $inSection4 = $false; continue }
    if ($line -match '^## 2\. FLAGGED') { $inSection1 = $false; continue }
    if ($line -match '^## 4\. BLOG PLAN') { $inSection4 = $true; continue }
    if ($line -match '^## 5\. KEYWORD COVERAGE') { $inSection4 = $false; continue }

    if ($inSection1) {
        if ($line -match '^####\s+(.*)') {
            $currentPage = $matches[1].Trim()
        } elseif ($line -match '-\s+\*\*Primary:\*\*\s+([^—–\(]+)') {
            $kw = $matches[1].Trim().ToLower()
            if ($kw -notmatch 'none in the research') {
                $pagePrimaries[$currentPage] = $kw
            }
        }
    }

    if ($inSection4) {
        if ($line -match '^\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*([^\|]+)\|\s*([^\|\(]+)') {
            $blogNum = $matches[1].Trim()
            $blogTitle = $matches[3].Trim()
            $blogKw = $matches[4].Trim().ToLower()
            $blogPrimaries["Blog #${blogNum}: $blogTitle"] = $blogKw
        }
    }
}

Write-Output "=== PRIMARY KEYWORD UNIQUENESS & COLLISION AUDIT ==="
Write-Output "Total Page Primaries Found: $($pagePrimaries.Count)"
Write-Output "Total Blog Primaries Found: $($blogPrimaries.Count)"

$allPrimaries = @{}
$collisions = @()

foreach ($kv in $pagePrimaries.GetEnumerator()) {
    $kw = $kv.Value
    if ($allPrimaries.ContainsKey($kw)) {
        $collisions += [PSCustomObject]@{
            Keyword = $kw
            FirstMappedTo = $allPrimaries[$kw]
            SecondMappedTo = "Page: $($kv.Key)"
        }
    } else {
        $allPrimaries[$kw] = "Page: $($kv.Key)"
    }
}

foreach ($kv in $blogPrimaries.GetEnumerator()) {
    $kw = $kv.Value
    if ($allPrimaries.ContainsKey($kw)) {
        $collisions += [PSCustomObject]@{
            Keyword = $kw
            FirstMappedTo = $allPrimaries[$kw]
            SecondMappedTo = "$($kv.Key)"
        }
    } else {
        $allPrimaries[$kw] = "$($kv.Key)"
    }
}

Write-Output "`nPrimaries for CNC & Stone Jali Pages and Blogs:"
Write-Output "  Page [/cnc-jali-work/]: $($pagePrimaries['CNC JALI WORK (pillar page)'] )"
Write-Output "  Page [/stone-jali/]:     $($pagePrimaries['Stone Jali'])"
$b4Key = ($blogPrimaries.Keys | Where-Object { $_ -like "Blog #4:*" })[0]
$b17Key = ($blogPrimaries.Keys | Where-Object { $_ -like "Blog #17:*" })[0]
Write-Output "  $b4Key -> Primary: '$($blogPrimaries[$b4Key])'"
Write-Output "  $b17Key -> Primary: '$($blogPrimaries[$b17Key])'"

Write-Output "`nCollisions Detected: $($collisions.Count)"
if ($collisions.Count -eq 0) {
    Write-Output "PERFECT PASS: Zero primary keyword collisions across all pages and blogs!"
} else {
    $collisions | Format-Table -AutoSize
}
