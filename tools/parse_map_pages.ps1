$lines = Get-Content "SEO_KEYWORD_MAP.md"
$mapSections = @()
$currentSection = ""

foreach ($line in $lines) {
    if ($line -match '^###\s+(.*)') {
        $currentSection = $matches[1].Trim()
    }
    elseif ($line -match '^####\s+(.*)') {
        $pageName = $matches[1].Trim()
        $mapSections += [PSCustomObject]@{
            Pillar = $currentSection
            PageName = $pageName
        }
    }
}

Write-Host "Total Mapped Pages in Section 1: $($mapSections.Count)"
$mapSections | Format-Table -AutoSize
