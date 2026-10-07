# Find shared sentences between CNC Jali Work and Radhe Krishna Stone Art & Mural
function Get-Sentences($filePath) {
    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    # Strip scripts, styles, header, footer
    $text = [regex]::Replace($raw, '(?is)<script.*?</script>', ' ')
    $text = [regex]::Replace($text, '(?is)<style.*?</style>', ' ')
    $text = [regex]::Replace($text, '(?is)<header.*?</header>', ' ')
    $text = [regex]::Replace($text, '(?is)<footer.*?</footer>', ' ')
    $text = [regex]::Replace($text, '(?is)<svg.*?</svg>', ' ')
    
    # Strip HTML tags
    $plain = [regex]::Replace($text, '<[^>]+>', ' ')
    $plain = [regex]::Replace($plain, '\s+', ' ')
    
    # Split into sentences
    $sentences = $plain -split '(?<=[.!?])\s+' | ForEach-Object { $_.Trim() } | Where-Object { $_.Length -gt 25 }
    return $sentences
}

$cncSentences = Get-Sentences "cnc-jali-work/index.html"
$rkSentences = Get-Sentences "stone-art-murals/radhe-krishna-stone-art-mural/index.html"

Write-Output "CNC Total Sentences: $($cncSentences.Count)"
Write-Output "Radhe Krishna Total Sentences: $($rkSentences.Count)"

$shared = @()
foreach ($s1 in $cncSentences) {
    foreach ($s2 in $rkSentences) {
        if ($s1.ToLower() -eq $s2.ToLower()) {
            if (-not ($shared -contains $s1)) {
                $shared += $s1
            }
        }
    }
}

Write-Output "`nExact Shared Sentences Count: $($shared.Count)"
foreach ($s in $shared) {
    Write-Output "  - $s"
}
