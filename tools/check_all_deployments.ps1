$deployments = Invoke-RestMethod -Uri "https://api.github.com/repos/puneet4244-cpu/SRAC-LATEST/deployments" -Headers @{ "User-Agent" = "PowerShell" }

foreach ($d in ($deployments | Select-Object -First 10)) {
    $stat = Invoke-RestMethod -Uri $d.statuses_url -Headers @{ "User-Agent" = "PowerShell" }
    Write-Host "SHA: $($d.sha.Substring(0,7)) | State: $($stat[0].state) | Desc: $($stat[0].description) | Target: $($stat[0].target_url)"
}
