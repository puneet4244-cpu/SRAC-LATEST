$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

$pilotFiles = @(
    "index.html",
    "stone-carving\staircase-wall\index.html",
    "stone-art-murals\radhe-krishna-stone-art-mural\index.html",
    "stone-wall-panels\fluted-stone-panels\index.html",
    "cnc-jali-work\index.html",
    "stone-jali\index.html"
)

Write-Output "=== PILOT SCHEMA VALIDATION REPORT ==="
$allPassed = $true

foreach ($file in $pilotFiles) {
    $fullPath = Join-Path $rootDir $file
    Write-Output "`n------------------------------------------------------------"
    Write-Output "Checking: $file"

    if (-not (Test-Path $fullPath)) {
        Write-Output "  FAIL: File not found!"
        $allPassed = $false
        continue
    }

    $content = [System.IO.File]::ReadAllText($fullPath, [System.Text.Encoding]::UTF8)
    
    # Extract all <script type="application/ld+json"> blocks
    $pattern = '(?is)<script\s+type=["'']application/ld\+json["'']\s*>(.*?)</script>'
    $matches = [regex]::Matches($content, $pattern)

    if ($matches.Count -eq 0) {
        Write-Output "  FAIL: No JSON-LD script tags found!"
        $allPassed = $false
        continue
    }

    Write-Output "  Found $($matches.Count) JSON-LD block(s)."

    $blockIndex = 1
    foreach ($m in $matches) {
        $jsonStr = $m.Groups[1].Value.Trim()
        try {
            $parsed = $jsonStr | ConvertFrom-Json
            Write-Output "  Block ${blockIndex}: VALID JSON syntax."

            # Inspect graph or array or object
            $types = @()
            if ($parsed -is [System.Array]) {
                foreach ($item in $parsed) { $types += $item.'@type' }
            } elseif ($parsed.'@graph') {
                foreach ($item in $parsed.'@graph') { $types += $item.'@type' }
            } else {
                $types += $parsed.'@type'
            }

            Write-Output "  Detected Schema Types: $($types -join ', ')"

            # Check for non-www domain
            if ($jsonStr -match 'https://shreeramandcompany\.com[^\w]') {
                Write-Output "  WARNING: Found non-www domain in JSON-LD!"
                $allPassed = $false
            } else {
                Write-Output "  Host Check: All URLs use locked https://www.shreeramandcompany.com/"
            }

            # Check for banned words in schema
            if ($jsonStr -match '(?i)Makrana|Pietra Dura|generational|factory|Akshardham|Ayodhya') {
                Write-Output "  FAIL: Found banned word in JSON-LD schema: $matches"
                $allPassed = $false
            } else {
                Write-Output "  Banned Word Check: 0 banned words found in schema."
            }

        } catch {
            Write-Output "  FAIL: Block $blockIndex has INVALID JSON: $_"
            $allPassed = $false
        }
        $blockIndex++
    }
}

Write-Output "`n============================================================"
if ($allPassed) {
    Write-Output "OVERALL SCHEMA VALIDATION: PASS (100% Valid JSON, No Banned Words, Correct Host)"
} else {
    Write-Output "OVERALL SCHEMA VALIDATION: FAILED (Review errors above)"
}
