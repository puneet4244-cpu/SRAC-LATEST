# Script to run all missing QA audits for Item 5
$pilotFiles = @(
    "index.html",
    "stone-carving/staircase-wall/index.html",
    "stone-art-murals/radhe-krishna-stone-art-mural/index.html",
    "stone-wall-panels/fluted-stone-panels/index.html",
    "cnc-jali-work/index.html",
    "stone-jali/index.html"
)

Write-Output "=== 1. PLACEHOLDER & LOREM SCAN ==="
$badTerms = @("TODO", "todo", "[ ]", "owner to confirm", "lorem", "Lorem ipsum")
$placeholderFound = $false
foreach ($f in $pilotFiles) {
    $c = Get-Content $f -Raw
    foreach ($term in $badTerms) {
        if ($c.Contains($term)) {
            Write-Output "FAIL: Found '$term' in $f"
            $placeholderFound = $true
        }
    }
}
if (-not $placeholderFound) {
    Write-Output "PASS: Zero occurrences of 'TODO', '[ ]', 'owner to confirm', or 'lorem' found across all pilot pages."
}

Write-Output "`n=== 2. BANNED PHRASES SCAN (Rule 4) ==="
$bannedPhrases = @("Makrana", "Pietra Dura", "generational", "pure white marble", "our factory", "Vedic architecture", "Akshardham style", "Ayodhya style")
$bannedFound = $false
foreach ($f in $pilotFiles) {
    $c = Get-Content $f -Raw
    foreach ($phrase in $bannedPhrases) {
        if ($c -match [regex]::Escape($phrase)) {
            Write-Output "ALERT: Found '$phrase' in $f"
            $bannedFound = $true
        }
    }
}
if (-not $bannedFound) {
    Write-Output "PASS: Zero banned phrases found across all pilot pages."
}

Write-Output "`n=== 3. 'WRITE AS' SPELLING SCAN ==="
# Map's write as list: "cncwall art" -> "CNC wall art", "CNC Jali  design for doors" -> "CNC jali design for doors"
$writeAsTypos = @("cncwall art", "CNC Jali  design for doors", "Khadappa", "Macrana")
$typoFound = $false
foreach ($f in $pilotFiles) {
    $c = Get-Content $f -Raw
    foreach ($typo in $writeAsTypos) {
        if ($c -match [regex]::Escape($typo)) {
            Write-Output "FAIL: Found typo '$typo' in $f"
            $typoFound = $true
        }
    }
}
if (-not $typoFound) {
    Write-Output "PASS: Zero spelling violations against 'write as' guidelines found."
}

Write-Output "`n=== 4. INTERNAL LINK RESOLUTION AUDIT ==="
$brokenLinks = 0
$totalLinks = 0
foreach ($f in $pilotFiles) {
    $c = Get-Content $f -Raw
    $links = [regex]::Matches($c, 'href="(/[^"#?]+)"') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
    foreach ($l in $links) {
        $totalLinks++
        # Resolve path
        $cleanRel = $l.TrimStart('/')
        if ($cleanRel -eq "") {
            $diskPath = "index.html"
        } else {
            $diskPath = "$cleanRel"
            if (-not (Test-Path $diskPath)) {
                $diskPath = "$cleanRel/index.html"
            }
        }
        if (-not (Test-Path $diskPath)) {
            Write-Output "BROKEN LINK: In $f -> $l (Resolved to: $diskPath)"
            $brokenLinks++
        }
    }
}
Write-Output "Checked $totalLinks unique internal links across pilot pages. Broken: $brokenLinks"

Write-Output "`n=== 5. WHATSAPP PREFILLED LINK AUDIT ==="
foreach ($f in $pilotFiles) {
    $c = Get-Content $f -Raw
    $waMatches = [regex]::Matches($c, 'href="(https://api\.whatsapp\.com/send\?[^"]+|https://wa\.me/[^"]+)"')
    Write-Output "Page: $f"
    if ($waMatches.Count -eq 0) {
        # Check tel or generic wa
        $waOther = [regex]::Matches($c, 'href="([^"]*whatsapp[^"]*)"')
        if ($waOther.Count -gt 0) {
            foreach ($m in $waOther) { Write-Output "  WA Link: $($m.Groups[1].Value)" }
        } else {
            Write-Output "  No WhatsApp links."
        }
    } else {
        foreach ($m in $waMatches) {
            Write-Output "  WA Link: $($m.Groups[1].Value)"
        }
    }
}
