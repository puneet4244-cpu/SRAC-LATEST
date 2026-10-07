$pages = @(
    @{ Name="Homepage"; Path="index.html" },
    @{ Name="Staircase Wall"; Path="stone-carving/staircase-wall/index.html" },
    @{ Name="Radhe Krishna Stone Art & Mural"; Path="stone-art-murals/radhe-krishna-stone-art-mural/index.html" },
    @{ Name="Fluted Stone Panels"; Path="stone-wall-panels/fluted-stone-panels/index.html" },
    @{ Name="CNC Jali Work"; Path="cnc-jali-work/index.html" },
    @{ Name="Stone Jali"; Path="stone-jali/index.html" }
)

foreach ($p in $pages) {
    $c = Get-Content $p.Path -Raw
    Write-Output "=================================================="
    Write-Output "PAGE: $($p.Name) ($($p.Path))"

    # In these files, FAQs are structured with <h3 ...> ... <span ...>Q.</span> ... <span>(Question text)</span> ... </h3> <p ...>(Answer text)</p>
    # Let's extract between "Frequently Asked Questions" and the next </section>
    if ($c -match '(?s)Frequently Asked Questions(.*?</section>)') {
        $section = $matches[1]
        
        # Match questions and answers
        $items = [regex]::Matches($section, '(?s)<h3[^>]*>.*?<span>(.*?)</span>\s*</h3>\s*<p[^>]*>(.*?)</p>')
        Write-Output "Found $($items.Count) FAQ items:"
        $idx = 1
        foreach ($item in $items) {
            $q = ($item.Groups[1].Value -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
            $a = ($item.Groups[2].Value -replace '<[^>]+>', ' ').Trim() -replace '\s+', ' '
            Write-Output "  [$idx] Q: $q"
            Write-Output "      A: $a"
            $idx++
        }
    }
}
