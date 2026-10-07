$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$htmlFiles = Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\\.git\\' -and 
    $_.FullName -notmatch '\\node_modules\\' -and
    $_.FullName -notmatch '\\\.gemini\\'
}

$rupee = [char]0x20B9
$patterns = @(
    $rupee,
    '\bRs\.?\s*\d+',
    '\bINR\b',
    '(?i)per\s+sq\.?\s*ft',
    '(?i)/sq\.?\s*ft',
    '(?i)starting\s+at',
    '(?i)starts\s+at',
    '(?i)starts\s+from',
    '(?i)\bfrom\s+' + $rupee + '?\d+',
    '(?i)\b\d+\s*mm\b',
    '(?i)\b\d+\s*inch(es)?\b',
    '(?i)\b\d+x\d+\b',
    '(?i)\b\d+\s*feet\b'
)

$combinedPattern = ($patterns -join '|')

$results = @()

foreach ($file in $htmlFiles) {
    $lines = Get-Content $file.FullName -Encoding utf8
    $lineNum = 1
    $rel = $file.FullName.Substring($rootDir.Length).Replace('\', '/')

    foreach ($line in $lines) {
        if ($line -match $combinedPattern) {
            $matchesFound = [regex]::Matches($line, $combinedPattern)
            $matchedTokens = ($matchesFound | ForEach-Object { $_.Value }) -join ', '
            
            $snippet = $line.Trim()
            if ($snippet.Length -gt 140) {
                $snippet = $snippet.Substring(0, 140) + "..."
            }

            $results += [PSCustomObject]@{
                File = $rel
                LineNumber = $lineNum
                MatchedTokens = $matchedTokens
                Snippet = $snippet
            }
        }
        $lineNum++
    }
}

Write-Output "=== PRICE AND SIZE CLAIMS AUDIT REPORT ==="
Write-Output "Total Hits Found across repository: $($results.Count)"

$csvPath = Join-Path $rootDir "tools\price_size_claims_audit.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding utf8

$mdPath = Join-Path $rootDir "tools\price_size_claims_audit.md"
$md = @()
$md += "# Price and Size Claims Audit Report"
$md += "Scan Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$md += "Total Hits: $($results.Count)`n"
$md += "| File | Line | Matched Tokens | Snippet |"
$md += "| :--- | :--- | :--- | :--- |"
foreach ($r in $results) {
    $cleanSnippet = $r.Snippet.Replace('|', '\|')
    $md += "| `$($r.File)` | $($r.LineNumber) | `$($r.MatchedTokens)` | $cleanSnippet |"
}
[System.IO.File]::WriteAllLines($mdPath, $md, [System.Text.Encoding]::UTF8)

Write-Output "Saved report to tools/price_size_claims_audit.md and .csv"

# Show summary of rupee/price hits specifically
$priceHits = $results | Where-Object { $_.MatchedTokens -match "$rupee|\bRs|INR|per sq|starting at|starts at" }
Write-Output "`nPrice / Currency Hits specifically: $($priceHits.Count)"
foreach ($p in $priceHits | Select-Object -First 15) {
    Write-Output "  $($p.File):$($p.LineNumber) -> $($p.Snippet)"
}
