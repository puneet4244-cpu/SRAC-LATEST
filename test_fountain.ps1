$res = Invoke-WebRequest -Uri 'http://localhost:8080/water-fountain/' -UseBasicParsing
Write-Host "HTTP Status: $($res.StatusCode)"
Write-Host "Indoor: $($res.Content.Contains('Indoor Water Fountain'))"
Write-Host "Small: $($res.Content.Contains('Small Water Fountain'))"
Write-Host "Large: $($res.Content.Contains('Large Water Fountain'))"
Write-Host "Outdoor: $($res.Content.Contains('Outdoor Water Fountain'))"
Write-Host "Sandstone: $($res.Content.Contains('Sandstone Water Fountain'))"
Write-Host "Marble: $($res.Content.Contains('Marble Water Fountain'))"
