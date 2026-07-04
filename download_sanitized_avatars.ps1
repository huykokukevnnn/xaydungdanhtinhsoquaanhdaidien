$prompts = @{
    "girl_pos_4" = "A 3D cartoon style portrait of a joyful, energetic female teenager laughing happily. Vibrant colors, confetti background, expressive and fun, Pixar style."
    "girl_neg_3" = "A 3D cartoon style portrait of a tough female teenager with a grumpy expression, crossing her arms. Dark and dramatic lighting, Pixar style."
    "girl_neg_4" = "A 3D cartoon style portrait of a boastful female teenager wearing a flashy sports jacket, proudly pointing to herself with a smug smirk. Confident and showy pose, Pixar style."
    "girl_neg_5" = "A 3D cartoon style portrait of a very annoyed female teenager with a red face and steam coming from her ears. Intense dynamic lighting, Pixar style."
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
            Start-Sleep -Seconds 4
        } catch {
            Write-Host "Failed to download $key : $_.Exception.Message"
            $retries++
            Write-Host "Waiting 15 seconds before retry..."
            Start-Sleep -Seconds 15
        }
    }
}
Write-Host "ALL MISSING DOWNLOADS FINISHED"
