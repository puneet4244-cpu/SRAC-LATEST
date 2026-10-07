$cr = Invoke-RestMethod -Uri "https://api.github.com/repos/puneet4244-cpu/SRAC-LATEST/commits/13e62dc/check-runs" -Headers @{ "User-Agent" = "PowerShell" }
$cr.check_runs | Format-List *
