$htmlFiles = Get-ChildItem -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch "node_modules|\.git|tools" }

$results = foreach ($f in $htmlFiles) {
    $content = Get-Content $f.FullName -Raw
    $matches = [regex]::Matches($content, '<img[^>]+src=["'']([^"'']+)["''][^>]*>')
    foreach ($m in $matches) {
        $tag = $m.Value
        $src = $m.Groups[1].Value
        $altMatch = [regex]::Match($tag, 'alt=["'']([^"'']*)["'']')
        $alt = if ($altMatch.Success) { $altMatch.Groups[1].Value } else { "" }
        [PSCustomObject]@{
            File = $f.FullName.Replace((Get-Location).Path + "\", "")
            Src = $src
            Alt = $alt
        }
    }
}

Write-Host "Total img tags found: $($results.Count)"
$results | Group-Object File | Select-Object Name, Count | Format-Table -AutoSize
