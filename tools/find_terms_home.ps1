$lines = Get-Content index.html
$terms = @("Makrana", "Pietra Dura", "generational", "pure white marble")
for ($i = 0; $i -lt $lines.Count; $i++) {
    foreach ($t in $terms) {
        if ($lines[$i] -match $t) {
            Write-Output "Line $($i+1): [$t] $($lines[$i].Trim())"
        }
    }
}
