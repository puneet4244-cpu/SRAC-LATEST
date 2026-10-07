$htmlFiles = Get-ChildItem -Recurse -Filter *.html | Where-Object { $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\node_modules\\' }
$cssFiles = Get-ChildItem -Recurse -Filter *.css | Where-Object { $_.FullName -notmatch '\\tools\\' -and $_.FullName -notmatch '\\node_modules\\' }

$allFiles = @($htmlFiles) + @($cssFiles)

$stockPatterns = @('unsplash\.com', 'pexels\.com', 'pixabay\.com', 'freepik\.com', 'shutterstock\.com', 'istockphoto\.com')

$results = @()

foreach ($f in $allFiles) {
    $content = Get-Content $f.FullName -Raw
    foreach ($pat in $stockPatterns) {
        $matches = [regex]::Matches($content, "https?://[^'""\s)]*$pat[^'""\s)]*")
        foreach ($m in $matches) {
            $results += [PSCustomObject]@{
                File = $f.FullName.Replace('c:\Users\shree\OneDrive\Desktop\NTRY\', '')
                Pattern = $pat
                Url = $m.Value
            }
        }
    }
}

Write-Host "Total stock links found: $($results.Count)"
$results | Group-Object File | ForEach-Object {
    Write-Host "`nFile: $($_.Name) ($($_.Count) matches)"
    $_.Group | Select-Object -Unique Url | ForEach-Object {
        Write-Host "  $($_.Url)"
    }
}

$results | Export-Csv -Path tools\stock_hotlinks.csv -NoTypeInformation
