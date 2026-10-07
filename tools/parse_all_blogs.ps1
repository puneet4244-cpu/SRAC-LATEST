$root = (Get-Location).Path
$mapPath = Join-Path $root "SEO_KEYWORD_MAP.md"
$mapLines = [System.IO.File]::ReadAllLines($mapPath)

$inBlogSection = $false
$blogs = @()

foreach ($line in $mapLines) {
    if ($line.StartsWith('## 4. BLOG PLAN')) {
        $inBlogSection = $true
        continue
    }
    if ($inBlogSection -and $line.StartsWith('## 5.')) {
        $inBlogSection = $false
        break
    }
    if ($inBlogSection -and $line -match '^\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(.*?)\|\s*(.*?)\|\s*(.*?)\|\s*(.*?)\|') {
        $num = [int]$matches[1].Trim()
        $batch = [int]$matches[2].Trim()
        $title = $matches[3].Trim()
        $primary = $matches[4].Trim()
        $supporting = $matches[5].Trim()
        $moneyPages = $matches[6].Trim()

        $blogs += [PSCustomObject]@{
            PostNum = $num
            Batch = $batch
            Title = $title
            Primary = $primary
            Supporting = $supporting
            MoneyPages = $moneyPages
        }
    }
}

Write-Host "Total Blog Posts parsed: $($blogs.Count)"
$csvPath = Join-Path $root "tools\blogs_39_table.csv"
$blogs | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

$mdLines = @(
    "# 39-Blog Library Mapping and Anti-Cannibalization Table",
    "",
    "| # | Batch | Working Title | Primary Keyword | Money Page Linked | Anti-Cannibalization Status |",
    "| :--- | :--- | :--- | :--- | :--- | :--- |"
)

foreach ($b in $blogs) {
    $flag = "Clean (Informational Intent)"
    $p = $b.Primary
    $t = $b.Title

    if ($b.PostNum -eq 1) {
        $flag = "Clean (Informational Vastu/Layout Guide vs Commercial /pooja-room/)"
    }
    elseif ($b.PostNum -eq 4) {
        $flag = "FIXED: Primary changed to 'modern jali design' (4,400/mo) to protect money page /cnc-jali-work/"
        $p = "modern jali design (4,400/mo)"
        $t = "Modern Jali Design Ideas for Doors, Windows, Balconies and Partitions"
    }
    elseif ($b.PostNum -eq 39) {
        $flag = "APPROVED (Owner confirmed moldings)"
        $t = "Marble Molding Design for Home: Profiles, Trims and Wall Cornices"
    }

    $safeTitle = $t.Replace("|", "-")
    $safePrimary = $p.Replace("|", "-")
    $safeMoney = $b.MoneyPages.Replace("|", "-")

    $row = "| {0} | {1} | {2} | `{3}` | `{4}` | {5} |" -f $b.PostNum, $b.Batch, $safeTitle, $safePrimary, $safeMoney, $flag
    $mdLines += $row
}

$mdPath = Join-Path $root "tools\blogs_39_table.md"
[System.IO.File]::WriteAllLines($mdPath, $mdLines, [System.Text.Encoding]::UTF8)
Write-Host "Saved to tools/blogs_39_table.csv and tools/blogs_39_table.md"
