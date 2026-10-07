$logPath = "C:\Users\shree\.gemini\antigravity-ide\brain\0517bc7e-63eb-4c37-9edd-e6af7e976187\.system_generated\logs\transcript_full.jsonl"
$lines = Get-Content $logPath
foreach ($line in $lines) {
    if ($line.Contains('"USER_INPUT"') -and $line.Contains('STOP GATE 2: NOT YET APPROVED')) {
        $json = $line | ConvertFrom-Json
        $json.content | Set-Content -Path "tools/user_stop_gate_2_full.txt" -Encoding utf8
        Write-Output "Extracted full prompt to tools/user_stop_gate_2_full.txt"
        break
    }
}
