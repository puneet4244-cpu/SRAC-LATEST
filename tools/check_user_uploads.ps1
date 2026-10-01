$userUp = "C:\Users\shree\.gemini\antigravity-ide\brain\059785c7-1675-4ae9-a295-9f53674d862f\.user_uploaded"
if (Test-Path $userUp) {
    Write-Host "Found .user_uploaded folder:"
    Get-ChildItem -Path $userUp -Recurse -File | ForEach-Object {
        Write-Host "  $($_.Name) ($($_.Length) bytes)"
    }
} else {
    Write-Host ".user_uploaded folder not found"
}

# Also check any other .user_uploaded folders across all brains
Get-ChildItem -Path "C:\Users\shree\.gemini\antigravity-ide\brain" -Recurse -Directory -Filter ".user_uploaded" | ForEach-Object {
    Write-Host "Found user_uploaded at: $($_.FullName)"
    Get-ChildItem -Path $_.FullName -File | ForEach-Object {
        Write-Host "   $($_.Name) ($($_.Length) bytes)"
    }
}
