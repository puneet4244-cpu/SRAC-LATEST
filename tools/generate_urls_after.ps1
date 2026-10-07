$rootDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$htmlFiles = Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\\.git\\' -and 
    $_.FullName -notmatch '\\node_modules\\' -and
    $_.FullName -notmatch '\\\.gemini\\'
}

$urls = @()
foreach ($file in $htmlFiles) {
    $rel = $file.FullName.Substring($rootDir.Length).Replace("\", "/")
    if ($rel -eq "/index.html") {
        $url = "/"
    } elseif ($rel.EndsWith("/index.html")) {
        $url = $rel.Substring(0, $rel.Length - 10) # keeps trailing slash
    } else {
        $url = $rel
    }
    $urls += $url
}

$urls = $urls | Sort-Object -Unique
$urls | Out-File -FilePath "$rootDir\tools\urls_after.txt" -Encoding utf8

$before = Get-Content "$rootDir\tools\urls_before.txt" | Where-Object { $_.Trim() -ne "" }
$after = Get-Content "$rootDir\tools\urls_after.txt" | Where-Object { $_.Trim() -ne "" }

Write-Output "=== URL INVENTORY REPORT ==="
Write-Output "Total URLs Before: $($before.Count)"
Write-Output "Total URLs After:  $($after.Count)"

$added = $after | Where-Object { $before -notcontains $_ }
$removed = $before | Where-Object { $after -notcontains $_ }

Write-Output "`nAdded URLs ($($added.Count)):"
foreach ($u in $added) { Write-Output "  + $u" }

Write-Output "`nRemoved URLs ($($removed.Count)):"
foreach ($u in $removed) { Write-Output "  - $u" }

if ($removed.Count -eq 0 -and $added.Count -eq 1 -and $added[0] -eq "/cnc-jali-work/") {
    Write-Output "`nPERFECT PASS: Zero frozen URLs lost. Exactly 1 intended pillar hub (/cnc-jali-work/) added."
} else {
    Write-Output "`nReview URL changes above."
}
