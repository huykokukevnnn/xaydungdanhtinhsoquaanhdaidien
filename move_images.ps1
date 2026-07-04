$src = "C:\Users\diept\.gemini\antigravity\brain\cced5c9e-1ea3-4486-afaa-6246a333a644"
$dest = "c:\test\xaydungdanhtinhsoquaanhdaidien\images"

# Create images folder if not exists
if (-not (Test-Path $dest)) {
    New-Item -ItemType Directory -Path $dest | Out-Null
}

Get-ChildItem -Path $src -Filter "boy_*.png" | ForEach-Object { 
    $newName = $_.Name -replace '_\d+\.png','.jpg'
    Copy-Item -Path $_.FullName -Destination (Join-Path $dest $newName) -Force
    Write-Host "Copied $_.Name to $newName"
}

Get-ChildItem -Path $src -Filter "girl_*.png" | ForEach-Object { 
    $newName = $_.Name -replace '_\d+\.png','.jpg'
    Copy-Item -Path $_.FullName -Destination (Join-Path $dest $newName) -Force
    Write-Host "Copied $_.Name to $newName"
}
