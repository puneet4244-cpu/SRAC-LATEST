$before = git show b67e905:index.html
$before[550..630] | Set-Content "tools/hero_before.txt" -Encoding utf8
Write-Output "Written hero before lines 550..630"
