$src = "c:\test\xaydungdanhtinhsoquaanhdaidien\images\girl_1.jpg"
5..10 | ForEach-Object {
    $dest = "c:\test\xaydungdanhtinhsoquaanhdaidien\images\girl_$_.jpg"
    Copy-Item -Path $src -Destination $dest -Force
}
