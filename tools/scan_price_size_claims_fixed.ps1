$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$htmlFiles = Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\\.git\\' -and 
    $_.FullName -notmatch '\\node_modules\\' -and
    $_.FullName -notmatch '\\\.gemini\\'
}

$results = @()
$rupeeChar = [char]0x20B9

foreach ($file in $htmlFiles) {
    $lines = Get-Content $file.FullName -Encoding utf8
    $lineNum = 1
    $rel = $file.FullName.Substring($rootDir.Length).Replace('\', '/')

    foreach ($line in $lines) {
        $matched = @()
        
        # 1. Currency & Pricing
        if ($line.Contains($rupeeChar)) { $matched += "RupeeSymbol($rupeeChar)" }
        if ($line -match '\bRs\.?\s*\d+') { $matched += "Rs" }
        if ($line -match '\bINR\b') { $matched += "INR" }
        if ($line -match '(?i)per\s+sq\.?\s*ft|/sq\.?\s*ft') { $matched += "per sq ft" }
        if ($line -match '(?i)starting\s+at|starts\s+at|starts\s+from') { $matched += "starting at" }
        if ($line -match '(?i)\bfrom\s+\d+') { $matched += "from [number]" }

        # 2. Dimensions & Sizes
        if ($line -match '(?i)\b\d+\s*mm\b') { $matched += "mm thickness/size" }
        if ($line -match '(?i)\b\d+\s*inch(es)?\b') { $matched += "inches" }
        if ($line -match '(?i)\b\d+x\d+\b') { $matched += "dimension (NxN)" }
        if ($line -match '(?i)\b\d+\s*feet\b|\b\d+\s*ft\b') { $matched += "feet/ft" }

        if ($matched.Count -gt 0) {
            $snippet = $line.Trim()
            if ($snippet.Length -gt 150) {
                $snippet = $snippet.Substring(0, 150) + "..."
            }
            $results += [PSCustomObject]@{
                File = $rel
                LineNumber = $lineNum
                Categories = ($matched | Select-Object -Unique) -join '; '
                Snippet = $snippet
            }
        }
        $lineNum++
    }
}

Write-Output "=== PRICE AND SIZE CLAIMS AUDIT REPORT ==="
Write-Output "Total Hits Found across 82 HTML files: $($results.Count)"

$csvPath = Join-Path $rootDir "tools\price_size_claims_audit.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding utf8

$mdPath = Join-Path $rootDir "tools\price_size_claims_audit.md"
$md = @()
$md += "# Price and Size Claims Audit Report"
$md += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$md += "Total Hits: $($results.Count)`n"
$md += "| File | Line | Claim Types | Snippet |"
$md += "| :--- | :--- | :--- | :--- |"
foreach ($r in $results) {
    $cleanSnippet = $r.Snippet.Replace('|', '\|')
    $md += "| `$($r.File)` | $($r.LineNumber) | $($r.Categories) | $cleanSnippet |"
}
[System.IO.File]::WriteAllLines($mdPath, $md, [System.Text.Encoding]::UTF8)

Write-Output "Saved to tools/price_size_claims_audit.csv and tools/price_size_claims_audit.md"

# Categorized counts
$currencyHits = $results | Where-Object { $_.Categories -match 'Rupee|Rs|INR|per sq|starting' }
$dimensionHits = $results | Where-Object { $_.Categories -match 'mm|inches|dimension|feet' }

Write-Output "`nSummary:"
Write-Output "  Currency / Price Hits: $($currencyHits.Count)"
Write-Output "  Dimension / Size Hits: $($dimensionHits.Count)"

Write-Output "`nTop 10 Currency Hits:"
foreach ($c in $currencyHits | Select-Object -First 10) {
    Write-Output "  $($c.File):$($c.LineNumber) -> $($c.Snippet)"
}
