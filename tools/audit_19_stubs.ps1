$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

$all21 = @(
    "stone-art-murals\buddha-stone-art-mural\index.html",
    "stone-art-murals\durga-mata-ji-stone-art-mural\index.html",
    "stone-art-murals\floral-stone-art\index.html",
    "stone-art-murals\ganesh-ji-stone-art-mural\index.html",
    "stone-art-murals\hanuman-ji-stone-art-mural\index.html",
    "stone-art-murals\laxmi-ji-stone-art-mural\index.html",
    "stone-art-murals\radhe-krishna-stone-art-mural\index.html",
    "stone-art-murals\ram-darbar-stone-art-mural\index.html",
    "stone-art-murals\shiv-ji-stone-art-mural\index.html",
    "stone-art-murals\shreenath-ji-stone-art-mural\index.html",
    "stone-art-murals\swaminarayan-ji-stone-art-mural\index.html",
    "stone-art-murals\village-stone-art-mural\index.html",
    "stone-wall-panels\fluted-stone-panels\index.html",
    "stone-wall-panels\geometrical-stone-panels\index.html",
    "stone-wall-panels\textured-stone-panels\index.html",
    "stone-wall-panels\wave-stone-panels\index.html",
    "mdf-hdmr-work\fluted-mdf-panels\index.html",
    "mdf-hdmr-work\geometrical-mdf-panels\index.html",
    "mdf-hdmr-work\mdf-hdmr-wall-panels\index.html",
    "mdf-hdmr-work\textured-mdf-panels\index.html",
    "mdf-hdmr-work\wave-mdf-panels\index.html"
)

Write-Output "=== 21 CONVERTED STUBS CONTENT AUDIT ==="

foreach ($rel in $all21) {
    $full = Join-Path $rootDir $rel
    if (-not (Test-Path $full)) {
        Write-Output "Missing: $rel"
        continue
    }
    $text = [System.IO.File]::ReadAllText($full, [System.Text.Encoding]::UTF8)
    $lines = $text.Split("`n").Count
    $bytes = (Get-Item $full).Length
    
    $hasMetaRefresh = $text -match 'http-equiv=["'']refresh["'']'
    $hasNoindex = $text -match 'content=["''][^"'']*noindex[^"'']*["'']'
    $hasRedirectingText = $text -match 'Redirecting\.\.\.'
    
    # Check title and h1
    $title = if ($text -match '(?i)<title>(.*?)</title>') { $matches[1] } else { "NONE" }
    $h1 = if ($text -match '(?i)<h1[^>]*>(.*?)</h1>') { $matches[1] } else { "NONE" }

    Write-Output "`n$rel"
    Write-Output "  Size: $bytes bytes ($lines lines)"
    Write-Output "  Title: $title"
    Write-Output "  H1: $h1"
    Write-Output "  MetaRefresh: $hasMetaRefresh | Noindex: $hasNoindex | RedirectingText: $hasRedirectingText"
}
