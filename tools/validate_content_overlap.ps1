$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

$pilotFiles = @(
    "stone-carving\staircase-wall\index.html",
    "stone-art-murals\radhe-krishna-stone-art-mural\index.html",
    "stone-wall-panels\fluted-stone-panels\index.html",
    "cnc-jali-work\index.html",
    "stone-jali\index.html"
)

function Get-MainBodyWords($filePath) {
    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    # Strip scripts, styles, header, footer
    $text = [regex]::Replace($raw, '(?is)<script.*?</script>', ' ')
    $text = [regex]::Replace($text, '(?is)<style.*?</style>', ' ')
    $text = [regex]::Replace($text, '(?is)<header.*?</header>', ' ')
    $text = [regex]::Replace($text, '(?is)<footer.*?</footer>', ' ')
    $text = [regex]::Replace($text, '(?is)<svg.*?</svg>', ' ')
    
    # Strip all html tags
    $plain = [regex]::Replace($text, '<[^>]+>', ' ')
    
    # Tokenize words (>3 chars, lowercase)
    $words = [regex]::Matches($plain.ToLower(), '\b[a-z]{4,}\b') | ForEach-Object { $_.Value }
    
    # Filter common stop words
    $stopWords = @('this','that','with','from','your','have','will','more','about','what','when','where','which','their','there','these','those','each','both','such','into','than','been')
    $filtered = $words | Where-Object { $stopWords -notcontains $_ }
    
    return [System.Collections.Generic.HashSet[string]]::new([string[]]$filtered)
}

Write-Output "=== CONTENT SIMILARITY & OVERLAP ANALYSIS ==="

$pageWords = @{}
foreach ($f in $pilotFiles) {
    $fullPath = Join-Path $rootDir $f
    $pageWords[$f] = Get-MainBodyWords $fullPath
}

$allPassOverlap = $true

for ($i = 0; $i -lt $pilotFiles.Count; $i++) {
    for ($j = $i + 1; $j -lt $pilotFiles.Count; $j++) {
        $p1 = $pilotFiles[$i]
        $p2 = $pilotFiles[$j]
        
        $set1 = $pageWords[$p1]
        $set2 = $pageWords[$p2]
        
        $intersection = 0
        foreach ($w in $set1) {
            if ($set2.Contains($w)) { $intersection++ }
        }
        
        $union = $set1.Count + $set2.Count - $intersection
        $similarityPct = if ($union -gt 0) { [math]::Round(($intersection / $union) * 100, 2) } else { 0 }
        
        $p1Short = [System.IO.Path]::GetDirectoryName($p1).Replace('\', '/')
        $p2Short = [System.IO.Path]::GetDirectoryName($p2).Replace('\', '/')
        
        Write-Output "Overlap: [$p1Short] vs [$p2Short] = ${similarityPct}% (Threshold: <30%)"
        if ($similarityPct -ge 30) {
            Write-Output "  WARNING: Overlap exceeds 30%!"
            $allPassOverlap = $false
        }
    }
}

if ($allPassOverlap) {
    Write-Output "`nPERFECT PASS: All pilot pages have unique distinct content (all overlaps <30%)."
} else {
    Write-Output "`nReview high overlap pairs above."
}
