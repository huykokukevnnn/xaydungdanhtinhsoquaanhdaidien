Get-ChildItem -Path c:\test\xaydungdanhtinhsoquaanhdaidien\images\girl_*.png | ForEach-Object {
    $newName = $_.Name -replace '\.png$','.jpg'
    Rename-Item -Path $_.FullName -NewName $newName -Force
}
