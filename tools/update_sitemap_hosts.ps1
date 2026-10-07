$root = (Get-Location).Path
$sitemapPath = Join-Path $root "sitemap.xml"
$sitemapContent = [System.IO.File]::ReadAllText($sitemapPath)

# 1. Drop /murals-wall-art/ and /temple/ blocks
# Standard regex to remove <url> block containing murals-wall-art or temple
$pattern1 = '(?s)\s*<url>\s*<loc>https?://[^<]*/murals-wall-art/?</loc>.*?</url>'
$pattern2 = '(?s)\s*<url>\s*<loc>https?://[^<]*/temple/?</loc>.*?</url>'

$sitemapContent = [regex]::Replace($sitemapContent, $pattern1, '')
$sitemapContent = [regex]::Replace($sitemapContent, $pattern2, '')

# 2. Standardize all non-www to www
$sitemapContent = $sitemapContent.Replace("https://shreeramandcompany.com", "https://www.shreeramandcompany.com")

[System.IO.File]::WriteAllText($sitemapPath, $sitemapContent, [System.Text.Encoding]::UTF8)

# Check count
$locMatches = [regex]::Matches($sitemapContent, '<loc>(.*?)</loc>')
Write-Host "Updated sitemap.xml! Total URLs: $($locMatches.Count)"
$hasMurals = $sitemapContent -match '/murals-wall-art'
$hasTemple = $sitemapContent -match '/temple/'
Write-Host "Contains /murals-wall-art: $hasMurals"
Write-Host "Contains /temple: $hasTemple"
