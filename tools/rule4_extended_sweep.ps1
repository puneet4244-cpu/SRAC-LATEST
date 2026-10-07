$terms = @(
    'Dholpur',
    'Bansi Paharpur',
    'Gwalior',
    'Red Agra',
    'multi-axis',
    '\bISPM\b',
    '\bMPa\b',
    '\bweeks\b',
    'pan-India',
    'export',
    'silane',
    'decades',
    'atelier',
    'Malabar'
)

$htmlFiles = Get-ChildItem -Recurse -Filter *.html | Where-Object { $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\node_modules\\' }

$allHits = @()

foreach ($file in $htmlFiles) {
    $rel = $file.FullName.Replace('c:\Users\shree\OneDrive\Desktop\NTRY\', '')
    $lines = Get-Content $file.FullName
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $l = $lines[$i]
        foreach ($t in $terms) {
            if ($l -match $t) {
                $allHits += [PSCustomObject]@{
                    File = $rel
                    Line = $i + 1
                    Term = $t
                    Snippet = $l.Trim().Substring(0, [math]::Min(120, $l.Trim().Length))
                }
            }
        }
    }
}

Write-Host "Total Rule 4 Extended Hits: $($allHits.Count)"
$allHits | Group-Object Term | ForEach-Object {
    Write-Host "Term: $($_.Name) -> $($_.Count) hits"
}

$allHits | Export-Csv -Path tools\rule4_extended_sweep.csv -NoTypeInformation
