# Parse execute_all_category_generation.ps1 to see all defined categories and products
$script = Get-Content "execute_all_category_generation.ps1" -Raw

# Find all blocks where products array is defined
$matches = [regex]::Matches($script, '\$([a-zA-Z0-9]+Products)\s*=\s*@\(([\s\S]*?)\r?\n\)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

Write-Host "Found $($matches.Count) product arrays:"
foreach ($m in $matches) {
    $varName = $m.Groups[1].Value
    $body = $m.Groups[2].Value
    
    # Extract each product inside
    $prodMatches = [regex]::Matches($body, '@\{\s*Name\s*=\s*"([^"]+)"([\s\S]*?)\}', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    Write-Host "`nArray: $varName ($($prodMatches.Count) products)"
    foreach ($pm in $prodMatches) {
        $pName = $pm.Groups[1].Value
        $pBody = $pm.Groups[2].Value
        
        # Extract images
        $imgMatches = [regex]::Matches($pBody, '"(/assets/images/[^"]+)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        $imgs = @()
        foreach ($im in $imgMatches) { $imgs += $im.Groups[1].Value }
        
        Write-Host "  * Product: '$pName' - Images count: $($imgs.Count)"
        for ($i=0; $i -lt $imgs.Count; $i++) {
            Write-Host "      [$i] $($imgs[$i])"
        }
    }
}
