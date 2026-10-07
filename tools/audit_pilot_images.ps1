$files = @(
  'index.html',
  'stone-jali/index.html',
  'cnc-jali-work/index.html',
  'stone-wall-panels/fluted-stone-panels/index.html',
  'stone-art-murals/radhe-krishna-stone-art-mural/index.html',
  'stone-carving/staircase-wall/index.html'
)

$report = @()

foreach ($f in $files) {
    $content = Get-Content $f -Raw
    $imgMatches = [regex]::Matches($content, '<img[^>]+>')
    $count = 0
    foreach ($m in $imgMatches) {
        $imgTag = $m.Value
        $src = ''
        $alt = ''
        if ($imgTag -match 'src=["'']([^"'']+)["'']') { $src = $matches[1] }
        if ($imgTag -match 'alt=["'']([^"'']+)["'']') { $alt = $matches[1] }
        
        $isStock = if ($src -match 'unsplash|pexels|pixabay') { 'Stock' } else { 'Own Photo / Local Asset' }
        $count++
        $report += [PSCustomObject]@{
            Page = $f
            Index = $count
            Src = $src
            Alt = $alt
            Type = $isStock
        }
    }
}

$report | Export-Csv -Path tools\pilot_images_audit.csv -NoTypeInformation
Write-Host "Total images in 6 pilot pages: $($report.Count)"
$report | Group-Object Page | ForEach-Object {
    Write-Host "`nPage: $($_.Name) ($($_.Count) images)"
    $_.Group | ForEach-Object {
        Write-Host "  [$($_.Type)] $($_.Src) -> $($_.Alt)"
    }
}
