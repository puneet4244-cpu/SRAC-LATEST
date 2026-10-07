$sm = Invoke-WebRequest -Uri 'https://www.shreeramandcompany.com/sitemap.xml' -UseBasicParsing
$rb = Invoke-WebRequest -Uri 'https://www.shreeramandcompany.com/robots.txt' -UseBasicParsing

Write-Output '=== LIVE SITEMAP.XML SAMPLE (First 6 lines) ==='
$smLines = $sm.Content -split "`n"
$smLines[0..5] | ForEach-Object { Write-Output $_ }

Write-Output "`n=== LIVE ROBOTS.TXT ==="
Write-Output $rb.Content
