$ErrorActionPreference = "Stop"
$deployments = Invoke-RestMethod -Uri "https://api.github.com/repos/puneet4244-cpu/SRAC-LATEST/deployments" -Headers @{ "User-Agent" = "PowerShell" }

Write-Host "Total Deployments found: $($deployments.Count)"
foreach ($d in ($deployments | Select-Object -First 5)) {
    Write-Host "ID: $($d.id) | SHA: $($d.sha) | Ref: $($d.ref) | Env: $($d.environment) | Created: $($d.created_at)"
    try {
        $statuses = Invoke-RestMethod -Uri $d.statuses_url -Headers @{ "User-Agent" = "PowerShell" }
        foreach ($s in $statuses) {
            Write-Host "  -> State: $($s.state) | TargetUrl: $($s.target_url) | EnvironmentUrl: $($s.environment_url)"
        }
    } catch {
        Write-Host "  -> Error fetching statuses: $_"
    }
}
