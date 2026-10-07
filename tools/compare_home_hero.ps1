$before = git show b67e905:index.html
$after = Get-Content index.html

# Find H1 before and after
Write-Output "=== BEFORE (Commit b67e905) ==="
$before | Select-String -Pattern '<h1' -Context 0,5

Write-Output "`n=== AFTER (Current) ==="
$after | Select-String -Pattern '<h1' -Context 0,5

Write-Output "`n=== HERO HEADING / SUBTITLE BEFORE ==="
$before | Select-String -Pattern 'Artisans of Architectural Elegance' -Context 2,5

Write-Output "`n=== ABOUT / INTRO BEFORE ==="
$before | Select-String -Pattern 'ABOUT\s*US' -Context 1,12

Write-Output "`n=== ABOUT / INTRO AFTER ==="
$after | Select-String -Pattern 'ABOUT\s*US' -Context 1,12
