# Extract all visible FAQs from HTML for each pilot page
$pages = @(
    @{ Name="Homepage"; Path="index.html" },
    @{ Name="Staircase Wall"; Path="stone-carving/staircase-wall/index.html" },
    @{ Name="Radhe Krishna"; Path="stone-art-murals/radhe-krishna-stone-art-mural/index.html" },
    @{ Name="Fluted Stone Panels"; Path="stone-wall-panels/fluted-stone-panels/index.html" },
    @{ Name="CNC Jali Work"; Path="cnc-jali-work/index.html" },
    @{ Name="Stone Jali"; Path="stone-jali/index.html" }
)

foreach ($p in $pages) {
    $c = Get-Content $p.Path -Raw
    Write-Output "=================================================="
    Write-Output "PAGE: $($p.Name) ($($p.Path))"
    
    # Try finding FAQ section
    if ($c -match '(?s)(?:id="faq"|<section[^>]*id="faq"[^>]*>)(.*?)</section>') {
        $faqHtml = $matches[1]
        # Match questions and answers
        # Typical format: <h3>...Q...<span>(Question)</span></h3> ... <p...>(Answer)</p>
        # Or details/summary
        $faqMatches = [regex]::Matches($faqHtml, '(?s)<(?:h3|button|div)[^>]*class="[^"]*(?:faq-question|font-serif text-lg|cursor-pointer)[^"]*"[^>]*>.*?<span>(.*?)</span>.*?</(?:h3|button|div)>\s*<(?:div|p)[^>]*class="[^"]*(?:faq-answer|text-gray|leading-relaxed)[^"]*"[^>]*>(.*?)</(?:div|p)>')
        Write-Output "Regex 1 found: $($faqMatches.Count)"
        if ($faqMatches.Count -eq 0) {
            # Let's inspect raw headers in faq section
            $faqQuestions = [regex]::Matches($faqHtml, '(?s)<h3[^>]*>(.*?)</h3>') | ForEach-Object { ($_.Groups[1].Value -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' ' }
            Write-Output "H3 in FAQ: $($faqQuestions.Count)"
            foreach ($q in $faqQuestions) { Write-Output "  Q: $q" }
        } else {
            foreach ($m in $faqMatches) {
                $q = ($m.Groups[1].Value -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
                $a = ($m.Groups[2].Value -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
                Write-Output "  Q: $q"
                Write-Output "  A: $a"
            }
        }
    } else {
        Write-Output "No explicit #faq section found."
    }
}
