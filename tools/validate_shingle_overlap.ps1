param(
    [string[]]$Pages = @(
        'index.html',
        'stone-jali/index.html',
        'cnc-jali-work/index.html',
        'stone-wall-panels/fluted-stone-panels/index.html',
        'stone-art-murals/radhe-krishna-stone-art-mural/index.html',
        'stone-carving/staircase-wall/index.html'
    ),
    [double]$Threshold = 0.30
)

function Get-CleanBodyText([string]$filePath) {
    if (-not (Test-Path $filePath)) { return "" }
    $raw = Get-Content $filePath -Raw

    # Remove script, style, head, header, nav, footer, and shared contact blocks
    $clean = $raw -replace '(?s)<head>.*?</head>', ' '
    $clean = $clean -replace '(?s)<script.*?</script>', ' '
    $clean = $clean -replace '(?s)<style.*?</style>', ' '
    $clean = $clean -replace '(?s)<header.*?</header>', ' '
    $clean = $clean -replace '(?s)<nav.*?</nav>', ' '
    $clean = $clean -replace '(?s)<footer.*?</footer>', ' '
    $clean = $clean -replace '(?s)<section id="contact".*?</section>', ' '
    $clean = $clean -replace '(?s)<section id="quick-enquiry".*?</section>', ' '
    $clean = $clean -replace '(?s)<form.*?</form>', ' '
    
    # Strip remaining HTML tags
    $clean = $clean -replace '<[^>]+>', ' '
    # Decode common HTML entities
    $clean = $clean -replace '&nbsp;', ' ' -replace '&amp;', '&' -replace '&quot;', '"' -replace '&#39;', "'"
    # Normalize whitespace
    $clean = [regex]::Replace($clean, '\s+', ' ').Trim()
    return $clean
}

function Get-Sentences([string]$text) {
    $sentences = [regex]::Split($text, '(?<=[.!?])\s+')
    $cleanSentences = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($s in $sentences) {
        $st = $s.Trim().ToLower()
        if ($st.Length -gt 25) { # Only meaningful sentences
            [void]$cleanSentences.Add($st)
        }
    }
    return $cleanSentences
}

function Get-5WordShingles([string]$text) {
    $words = [regex]::Replace($text.ToLower(), '[^\w\s]', ' ').Split([char[]]@(' ', "`t", "`r", "`n"), [System.StringSplitOptions]::RemoveEmptyEntries)
    $shingles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    
    if ($words.Count -ge 5) {
        for ($i = 0; $i -le ($words.Count - 5); $i++) {
            $shingle = "$($words[$i]) $($words[$i+1]) $($words[$i+2]) $($words[$i+3]) $($words[$i+4])"
            [void]$shingles.Add($shingle)
        }
    }
    return $shingles
}

$pageData = @{}
foreach ($p in $Pages) {
    $body = Get-CleanBodyText $p
    $sents = Get-Sentences $body
    $shingles = Get-5WordShingles $body
    $pageData[$p] = @{
        Body = $body
        Sentences = $sents
        Shingles = $shingles
    }
    Write-Host "Processed $($p): $($sents.Count) unique sentences, $($shingles.Count) unique 5-word shingles."
}

Write-Host "`n=== PAIRWISE OVERLAP ANALYSIS (Threshold: $([math]::Round($Threshold * 100))%) ==="
$violations = 0
$results = @()

for ($i = 0; $i -lt $Pages.Count; $i++) {
    for ($j = $i + 1; $j -lt $Pages.Count; $j++) {
        $p1 = $Pages[$i]
        $p2 = $Pages[$j]

        $s1 = $pageData[$p1].Sentences
        $s2 = $pageData[$p2].Sentences

        # Sentence overlap (Jaccard)
        $sentIntersect = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
        foreach ($item in $s1) { if ($s2.Contains($item)) { [void]$sentIntersect.Add($item) } }
        
        $sentUnionCount = $s1.Count + $s2.Count - $sentIntersect.Count
        $sentOverlap = if ($sentUnionCount -gt 0) { $sentIntersect.Count / $sentUnionCount } else { 0 }

        # Shingle overlap (Jaccard)
        $sh1 = $pageData[$p1].Shingles
        $sh2 = $pageData[$p2].Shingles

        $shIntersect = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
        foreach ($item in $sh1) { if ($sh2.Contains($item)) { [void]$shIntersect.Add($item) } }

        $shUnionCount = $sh1.Count + $sh2.Count - $shIntersect.Count
        $shingleOverlap = if ($shUnionCount -gt 0) { $shIntersect.Count / $shUnionCount } else { 0 }

        $status = if ($sentOverlap -ge $Threshold -or $shingleOverlap -ge $Threshold) { "FAIL" } else { "PASS" }
        if ($status -eq "FAIL") { $violations++ }

        $results += [PSCustomObject]@{
            Pair = "$p1 vs $p2"
            SentenceOverlap = [math]::Round($sentOverlap * 100, 2)
            SentenceCommon = $sentIntersect.Count
            ShingleOverlap = [math]::Round($shingleOverlap * 100, 2)
            ShingleCommon = $shIntersect.Count
            Status = $status
        }

        Write-Host "$p1 vs $p2 -> Sentence: $([math]::Round($sentOverlap * 100, 2))% ($($sentIntersect.Count) shared), Shingle: $([math]::Round($shingleOverlap * 100, 2))% ($($shIntersect.Count) shared) [$status]"
    }
}

$results | Export-Csv -Path tools\shingle_overlap_report.csv -NoTypeInformation

if ($violations -gt 0) {
    Write-Host "`nFAILED: $violations pair(s) exceed the $($Threshold * 100)% threshold!" -ForegroundColor Red
    exit 1
} else {
    Write-Host "`nSUCCESS: All $($results.Count) page pairs are below the $($Threshold * 100)% threshold." -ForegroundColor Green
    exit 0
}
