# tools/verify_pages.ps1
$cats = Get-ChildItem -Directory | Where-Object { 
    (Test-Path (Join-Path $_.FullName "index.html")) -and 
    ($_.Name -notin @(".git", "tools", "node_modules", "dist", "about-us", "contact", "get-a-quote", "privacy-policy", "terms-of-service", "articles", "blog"))
}

$allGood = $true
Write-Host "Found $($cats.Count) category directories to verify..."

foreach ($c in $cats) {
    $filePath = Join-Path $c.FullName "index.html"
    $t = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    $m1 = $t.Contains("<!-- CRAFTSMANSHIP & MATERIAL OVERVIEW SECTION -->")
    $m2 = $t.Contains("<!-- PRODUCT CARDS GRID -->")
    $m3 = $t.Contains("<!-- MATERIAL & PERFORMANCE COMPARISON TABLE -->")
    $m4 = $t.Contains("<!-- FREQUENTLY ASKED QUESTIONS (AEO FAQ BLOCK) -->")
    $m5 = $t.Contains("<!-- INTERNAL LINKING & RELATED CATEGORIES -->")
    $end = $t.Contains("</html>")

    if (-not ($m1 -and $m2 -and $m3 -and $m4 -and $m5 -and $end)) {
        Write-Warning "FAIL: $($c.Name) (m1=$m1, m2=$m2, m3=$m3, m4=$m4, m5=$m5, end=$end)"
        $allGood = $false
    } else {
        Write-Host "PASS: $($c.Name)"
    }
}

if ($allGood) {
    Write-Host "`nSUCCESS: All $($cats.Count) category pages have intact markers, sections, and valid HTML termination!"
} else {
    Write-Error "Some pages failed validation!"
}
