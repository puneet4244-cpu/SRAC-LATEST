$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"

# 1. Update llms.txt
$llmsPath = Join-Path $rootDir "llms.txt"
$llmsContent = [System.IO.File]::ReadAllText($llmsPath, [System.Text.Encoding]::UTF8)

$llmsContent = $llmsContent.Replace("https://shreeramandcompany.com", "https://www.shreeramandcompany.com")
$llmsContent = $llmsContent.Replace("Factory-direct", "Workshop-direct")
$llmsContent = $llmsContent.Replace("Pietra Dura ", "")
$llmsContent = $llmsContent.Replace("Makrana Pure White Marble", "Rajasthan White Marble")
$llmsContent = $llmsContent.Replace("Pure Makrana white marble", "Rajasthan white marble")
$llmsContent = $llmsContent.Replace("Makrana marble", "white marble")
$llmsContent = $llmsContent.Replace("generational hand-chiseling", "master hand-chiseling")

# Add CNC Jali Hub link
if ($llmsContent -notmatch '/cnc-jali-work/') {
    $llmsContent = $llmsContent.Replace("URL: https://www.shreeramandcompany.com/stone-jali/", "URL: https://www.shreeramandcompany.com/cnc-jali-work/ (Pillar Hub)`n   - URL: https://www.shreeramandcompany.com/stone-jali/")
}
[System.IO.File]::WriteAllText($llmsPath, $llmsContent, [System.Text.Encoding]::UTF8)

# 2. Update llms-full.txt
$llmsFullPath = Join-Path $rootDir "llms-full.txt"
if (Test-Path $llmsFullPath) {
    $fullContent = [System.IO.File]::ReadAllText($llmsFullPath, [System.Text.Encoding]::UTF8)
    $fullContent = $fullContent.Replace("https://shreeramandcompany.com (HTTPS, non-www only)", "https://www.shreeramandcompany.com (HTTPS, www primary)")
    $fullContent = $fullContent.Replace("https://shreeramandcompany.com", "https://www.shreeramandcompany.com")
    $fullContent = $fullContent.Replace("Factory-direct", "Workshop-direct")
    $fullContent = $fullContent.Replace("factory-direct", "workshop-direct")
    $fullContent = $fullContent.Replace("Pietra Dura ", "")
    $fullContent = $fullContent.Replace("Pietra Dura", "Handcrafted Semi-Precious Inlay")
    [System.IO.File]::WriteAllText($llmsFullPath, $fullContent, [System.Text.Encoding]::UTF8)
}

Write-Output "Successfully updated llms.txt and llms-full.txt to locked https://www.shreeramandcompany.com host!"
