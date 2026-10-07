$sitemapPath = "c:\Users\shree\OneDrive\Desktop\NTRY\sitemap.xml"
$content = [System.IO.File]::ReadAllText($sitemapPath, [System.Text.Encoding]::UTF8)

$pilotEntries = @'
    <url>
        <loc>https://www.shreeramandcompany.com/cnc-jali-work/</loc>
        <lastmod>2026-10-06</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.85</priority>
        <image:image>
            <image:loc>https://www.shreeramandcompany.com/assets/images/stone-jali.webp</image:loc>
        </image:image>
    </url>
    <url>
        <loc>https://www.shreeramandcompany.com/stone-art-murals/radhe-krishna-stone-art-mural/</loc>
        <lastmod>2026-10-06</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.8</priority>
        <image:image>
            <image:loc>https://www.shreeramandcompany.com/assets/images/radhe-krishna.webp</image:loc>
        </image:image>
    </url>
    <url>
        <loc>https://www.shreeramandcompany.com/stone-wall-panels/fluted-stone-panels/</loc>
        <lastmod>2026-10-06</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.8</priority>
        <image:image>
            <image:loc>https://www.shreeramandcompany.com/assets/images/fluted-panels.webp</image:loc>
        </image:image>
    </url>
</urlset>
'@

if ($content -notmatch 'https://www.shreeramandcompany.com/cnc-jali-work/') {
    $content = $content.Replace('</urlset>', $pilotEntries)
    [System.IO.File]::WriteAllText($sitemapPath, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Successfully added 3 pilot pages to sitemap.xml"
} else {
    Write-Output "Pilot pages already in sitemap.xml"
}
