# Scan all HTML pages in the website for image tags, card contexts, and image counts
$htmlFiles = Get-ChildItem -Path . -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch '\\\.git\\' }

$results = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $relPath = $file.FullName.Substring((Get-Location).Path.Length + 1)
    
    # Match img tags: <img ... src="..." ...>
    $matches = [regex]::Matches($content, '<img\s+[^>]*src=["'']([^"'']+)["''][^>]*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    foreach ($m in $matches) {
        $tag = $m.Value
        $src = $m.Groups[1].Value
        
        # Extract alt if present
        $alt = ""
        if ($tag -match 'alt=["'']([^"'']*)["'']') {
            $alt = $matches[0].Groups[1].Value
            $alt = $Matches[1]
        }
        
        # Check context around img (e.g. 200 chars before and after)
        $startPos = [Math]::Max(0, $m.Index - 200)
        $len = [Math]::Min($content.Length - $startPos, 400)
        $context = $content.Substring($startPos, $len)
        
        $results += [PSCustomObject]@{
            HtmlFile = $relPath
            Src      = $src
            Alt      = $alt
            Tag      = $tag
        }
    }
}

Write-Host "Total images found across all HTML files: $($results.Count)"
$results | Group-Object Src | Select-Object Name, Count | Sort-Object -Descending Count | Format-Table -AutoSize
