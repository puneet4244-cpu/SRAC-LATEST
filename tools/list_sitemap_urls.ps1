$sitemapPath = "c:\Users\shree\OneDrive\Desktop\NTRY\sitemap.xml"
$sitemapContent = [System.IO.File]::ReadAllText($sitemapPath, [System.Text.Encoding]::UTF8)
$locMatches = [regex]::Matches($sitemapContent, '<loc>(.*?)</loc>')
Write-Output "Total URLs in sitemap: $($locMatches.Count)"
foreach ($m in $locMatches) {
    Write-Output $m.Groups[1].Value
}
