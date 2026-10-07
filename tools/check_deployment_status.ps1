$statuses = Invoke-RestMethod -Uri "https://api.github.com/repos/puneet4244-cpu/SRAC-LATEST/deployments/6904334149/statuses" -Headers @{ "User-Agent" = "PowerShell" }
$statuses | Format-List *
