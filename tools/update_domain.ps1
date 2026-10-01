# tools/update_domain.ps1
# Replaces all instances of shreeramandcompany.com with shreeramandcompany.com

$root = $PSScriptRoot | Split-Path -Parent
$extensions = @("*.html", "*.xml", "*.txt", "*.json", "*.md", "*.csv", "*.ps1")

$files = Get-ChildItem -Path $root -Recurse -File -Include $extensions | Where-Object {
    $_.FullName -notmatch "\\.git\\" -and $_.FullName -notmatch "\\node_modules\\"
}

$count = 0

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    if ($content.Contains("shreeramandcompany.com")) {
        $newContent = $content.Replace("https://www.shreeramandcompany.com", "https://www.shreeramandcompany.com")
        $newContent = $newContent.Replace("https://www.shreeramandcompany.com", "https://www.shreeramandcompany.com")
        $newContent = $newContent.Replace("www.shreeramandcompany.com", "www.shreeramandcompany.com")
        $newContent = $newContent.Replace("shreeramandcompany.com", "shreeramandcompany.com")
        
        [System.IO.File]::WriteAllText($f.FullName, $newContent, [System.Text.Encoding]::UTF8)
        $count++
        Write-Host "Updated: $($f.FullName.Substring($root.Length + 1))"
    }
}

Write-Host "`nDomain update complete! Updated $count files to https://www.shreeramandcompany.com"
