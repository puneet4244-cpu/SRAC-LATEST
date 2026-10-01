# Generate complete product card matrix
$audit = Import-Csv "tools/initial_card_audit.csv"

Write-Host "Total cards: $($audit.Count)"
$byPage = $audit | Group-Object Page

foreach ($group in $byPage) {
    Write-Host "`n========================================================"
    Write-Host "PAGE: $($group.Name) ($($group.Count) cards)"
    foreach ($row in $group.Group) {
        Write-Host "  Product: '$($row.ProductName)' | Images: $($row.ImageCount)"
        $srcs = $row.Srcs -split "; "
        for ($i=0; $i -lt $srcs.Count; $i++) {
            Write-Host "    [$i] $($srcs[$i])"
        }
    }
}
