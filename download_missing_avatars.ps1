$prompts = @{
    "girl_pos_4" = "A 3D cartoon style portrait of a joyful, energetic female character laughing happily, from the chest up. Vibrant colors, confetti background, expressive and fun, Pixar style."
    "girl_neg_3" = "A 3D cartoon style portrait of a large, intimidating female character with an angry, scowling face, cracking her knuckles, from the chest up. Dark and dramatic lighting, Pixar style."
    "girl_neg_4" = "A 3D cartoon style portrait of a boastful female character wearing an open jacket, proudly pointing to her stomach with a smug smirk, from the chest up. Confident and showy pose, Pixar style."
    "girl_neg_5" = "A 3D cartoon style portrait of a furious female character, clenching her fists with a red, angry facial expression and steam metaphorically coming from her ears, from the chest up. Intense dynamic lighting, Pixar style."
}

$baseUrl = "https://image.pollinations.ai/prompt/"
$outDir = "images"

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
