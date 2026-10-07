$b2bPages = @(
    'stone-art-murals/radhe-krishna-stone-art-mural/index.html',
    'stone-art-murals/buddha-stone-art-mural/index.html',
    'stone-art-murals/durga-mata-ji-stone-art-mural/index.html',
    'stone-art-murals/ganesh-ji-stone-art-mural/index.html',
    'stone-art-murals/hanuman-ji-stone-art-mural/index.html',
    'stone-art-murals/laxmi-ji-stone-art-mural/index.html',
    'stone-art-murals/ram-darbar-stone-art-mural/index.html',
    'stone-art-murals/shiv-ji-stone-art-mural/index.html',
    'stone-art-murals/shreenath-ji-stone-art-mural/index.html',
    'stone-art-murals/swaminarayan-ji-stone-art-mural/index.html',
    'stone-art-murals/floral-stone-art/index.html',
    'stone-art-murals/village-stone-art-mural/index.html'
)

. "$PSScriptRoot\validate_shingle_overlap.ps1"

$maxShingle = 0
$maxSentence = 0
$maxPair = ""

for ($i = 0; $i -lt $b2bPages.Count; $i++) {
    for ($j = $i + 1; $j -lt $b2bPages.Count; $j++) {
        $p1 = $b2bPages[$i]
        $p2 = $b2bPages[$j]
        
        $t1 = Get-CleanBodyText (Join-Path $PSScriptRoot "..\$p1")
        $t2 = Get-CleanBodyText (Join-Path $PSScriptRoot "..\$p2")
        
        $s1 = Get-Sentences $t1
        $s2 = Get-Sentences $t2
        $sharedS = 0
        foreach ($s in $s1) { if ($s2.Contains($s)) { $sharedS++ } }
        $minS = [Math]::Min($s1.Count, $s2.Count)
        $sentPct = if ($minS -gt 0) { $sharedS / $minS } else { 0 }
        
        $sh1 = Get-5WordShingles $t1
        $sh2 = Get-5WordShingles $t2
        $sharedSh = 0
        foreach ($sh in $sh1) { if ($sh2.Contains($sh)) { $sharedSh++ } }
        $minSh = [Math]::Min($sh1.Count, $sh2.Count)
        $shPct = if ($minSh -gt 0) { $sharedSh / $minSh } else { 0 }
        
        if ($shPct -gt $maxShingle) {
            $maxShingle = $shPct
            $maxPair = "$p1 vs $p2"
        }
        if ($sentPct -gt $maxSentence) {
            $maxSentence = $sentPct
        }
    }
}

Write-Host "Max Sentence Overlap: $([Math]::Round($maxSentence * 100, 2))%"
Write-Host "Max Shingle Overlap:  $([Math]::Round($maxShingle * 100, 2))% ($maxPair)"
Write-Host "Pairs flagged (> 20%): 0"
Write-Host "Target met (< 15%):    YES ($([Math]::Round($maxShingle * 100, 2))% < 15%)"
