Add-Type -AssemblyName System.Drawing
$brainDir = "C:\Users\diept\.gemini\antigravity\brain\7d022805-4f54-4070-8ab5-e263ce925e0a"
$outDir = "C:\test\khamphaanhdaidien\images"

$prefixes = @(
    "boy_pos_1", "boy_pos_2", "boy_pos_3", "boy_pos_4", "boy_pos_5",
    "boy_neg_1", "boy_neg_2", "boy_neg_3", "boy_neg_4", "boy_neg_5",
    "girl_pos_1", "girl_pos_2", "girl_pos_3", "girl_pos_5",
    "girl_neg_1", "girl_neg_2"
)

foreach ($prefix in $prefixes) {
    # Find latest file matching prefix
    $files = Get-ChildItem -Path $brainDir -Filter "${prefix}_*.png" | Sort-Object LastWriteTime -Descending
    if ($files.Count -gt 0) {
        $latestFile = $files[0].FullName
        $outFile = Join-Path $outDir "$prefix.jpg"
        
        Write-Host "Converting $latestFile to $outFile"
        $img = [System.Drawing.Image]::FromFile($latestFile)
        $img.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $img.Dispose()
    } else {
        Write-Host "No file found for $prefix"
    }
}
