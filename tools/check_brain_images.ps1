$dirs = Get-ChildItem "C:\Users\shree\.gemini\antigravity-ide\brain" -Directory
foreach ($d in $dirs) {
    $imgs = Get-ChildItem $d.FullName -Recurse -File -Include *.jpg,*.png,*.webp | Where-Object { 
        $_.FullName -notmatch '\\\.system_generated\\' -and 
        $_.FullName -notmatch '\\\.tempmediaStorage\\'
    }
    if ($imgs.Count -gt 0) {
        Write-Host "Brain: $($d.Name) Count: $($imgs.Count)"
        $imgs | ForEach-Object { Write-Host "   $($_.FullName)" }
    }
}
