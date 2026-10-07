$root = (Get-Location).Path
$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\\.git\\'
}

$bannedTerms = @(
    "Pietra Dura",
    "Makrana",
    "generational",
    "pure",
    "factory",
    "Vedic",
    "Akshardham style",
    "Ayodhya style"
)

$results = @()

foreach ($file in $htmlFiles) {
    $rel = $file.FullName.Substring($root.Length).TrimStart('\').Replace('\', '/')
    $lines = [System.IO.File]::ReadAllLines($file.FullName)
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $lineContent = $lines[$i]
        $lineNum = $i + 1
        
        foreach ($term in $bannedTerms) {
            if ($lineContent -match [regex]::Escape($term)) {
                # Determine context tag
                $context = "Body Text"
                if ($lineContent -match '<title>') { $context = "<title>" }
                elseif ($lineContent -match 'name=["'']description["'']' -or $lineContent -match 'name=["'']keywords["'']') { $context = "<meta SEO>" }
                elseif ($lineContent -match 'property=["'']og:') { $context = "Open Graph" }
                elseif ($lineContent -match 'twitter:') { $context = "Twitter Meta" }
                elseif ($lineContent -match 'application/ld\+json' -or $lineContent -match '"@type"' -or $lineContent -match '"name"') { $context = "JSON-LD Schema" }
                elseif ($lineContent -match 'alt=["'']') { $context = "Image alt" }
                elseif ($lineContent -match '<h1') { $context = "H1" }
                elseif ($lineContent -match '<h2|<h3|<h4') { $context = "Heading (H2-H4)" }
                elseif ($lineContent -match 'breadcrumb|ListItem') { $context = "Breadcrumb" }

                # Formulate proposed replacement
                $replacement = ""
                switch ($term) {
                    "Pietra Dura" { $replacement = "Replace with 'handcrafted marble inlay' or 'marble inlay art'" }
                    "Makrana" { $replacement = "Replace with 'natural white marble' or 'quarried marble'" }
                    "generational" { $replacement = "Replace with 'master artisanal' or 'traditional Rajasthan'" }
                    "pure" { $replacement = "Replace with 'natural' or 'high-density' (or remove)" }
                    "factory" { $replacement = "Replace with 'Jaipur stone carving workshop' or 'manufacturing unit'" }
                    "Vedic" { $replacement = "Replace with 'traditional temple' or 'sacred architectural'" }
                    "Akshardham style" { $replacement = "Remove entirely; replace with 'sacred Swaminarayan relief carving'" }
                    "Ayodhya style" { $replacement = "Remove entirely; replace with 'classical Ram Darbar stone carving'" }
                }

                $snippet = $lineContent.Trim()
                if ($snippet.Length -gt 120) {
                    $snippet = $snippet.Substring(0, 117) + "..."
                }

                $results += [PSCustomObject]@{
                    File = $rel
                    Line = $lineNum
                    Term = $term
                    Context = $context
                    Snippet = $snippet
                    ProposedReplacement = $replacement
                }
            }
        }
    }
}

Write-Host "Total Rule 4 Hits: $($results.Count)"
$results | Export-Csv -Path "$root/tools/rule4_sweep_report.csv" -NoTypeInformation -Encoding UTF8

$mdLines = @(
    "# Rule 4 Sweep Report (Audit of Banned / Unverified Claims Across All 81 HTML Files)",
    "",
    "| # | File | Line | Term Found | Context | Snippet | Proposed Replacement |",
    "| :--- | :--- | :--- | :--- | :--- | :--- | :--- |"
)

$idx = 1
foreach ($r in $results) {
    $safeSnippet = $r.Snippet.Replace("|", "-").Replace("`t", " ")
    $mdLines += "| {0} | `{1}` | {2} | **{3}** | {4} | `{5}` | {6} |" -f $idx, $r.File, $r.Line, $r.Term, $r.Context, $safeSnippet, $r.ProposedReplacement
    $idx++
}

$mdLines | Out-File -FilePath "$root/tools/rule4_sweep_report.md" -Encoding UTF8
Write-Host "Rule 4 report saved to tools/rule4_sweep_report.csv and tools/rule4_sweep_report.md"
