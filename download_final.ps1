$prompts = @{
    "girl_pos_4" = "A 3D cartoon portrait of a smiling female person, Pixar style"
    "girl_neg_3" = "A 3D cartoon portrait of a frowning female person, Pixar style"
    "girl_neg_4" = "A 3D cartoon portrait of a female person wearing a jacket, Pixar style"
    "girl_neg_5" = "A 3D cartoon portrait of a mad female person, Pixar style"
}

$baseUrl = "https://image.pollinations.ai/prompt/"
$outDir = "C:\test\khamphaanhdaidien\images"

foreach ($key in $prompts.Keys) {
    $prompt = $prompts[$key]
    $encodedPrompt = [uri]::EscapeDataString($prompt)
    $seed = Get-Random -Minimum 1000 -Maximum 999999
    $url = "$baseUrl$encodedPrompt?seed=$seed&width=512&height=512&nologo=true"
    $outFile = "$outDir\$key.jpg"
    
    $success = $false
    $retries = 0
    while (-not $success -and $retries -lt 3) {
        try {
            Write-Host "Downloading $key..."
            Invoke-WebRequest -Uri $url -OutFile $outFile -UseBasicParsing -TimeoutSec 30
            Write-Host "Success: $key"
            $success = $true
            Start-Sleep -Seconds 2
        } catch {
            Write-Host "Failed to download $key : $_.Exception.Message"
            $retries++
            Write-Host "Waiting 5 seconds before retry..."
            Start-Sleep -Seconds 5
        }
    }
}
Write-Host "ALL FINAL DOWNLOADS FINISHED"
