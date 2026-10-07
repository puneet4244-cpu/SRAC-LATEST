Get-ChildItem -Path "assets/images" | ForEach-Object {
    $n = $_.Name
    if ($n -like "*mural*" -or $n -like "*krishna*" -or $n -like "*fluted*" -or $n -like "*jali*" -or $n -like "*radha*") {
        Write-Output $n
    }
}
