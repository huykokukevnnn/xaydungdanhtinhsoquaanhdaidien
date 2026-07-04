$prompts = @{
    "boy_pos_1" = "A 3D cartoon style portrait of a well-behaved, polite boy smiling gently, from the chest up. Clean academic look, neat hair, bright and soft lighting, Pixar style."
    "boy_pos_2" = "A 3D cartoon style portrait of a smart boy wearing glasses, looking confident and intelligent, from the chest up. Creative and bright background, Pixar style."
    "boy_pos_3" = "A 3D cartoon style portrait of a kind and gentle young man with a warm, soft smile, from the chest up. Friendly expression, warm and cozy lighting, Pixar style."
    "boy_pos_4" = "A 3D cartoon style portrait of a joyful, energetic boy laughing happily, from the chest up. Vibrant colors, confetti background, expressive and fun, Pixar style."
    "boy_pos_5" = "A 3D cartoon style portrait of a confident young man with his arms crossed, smiling determinedly, from the chest up. Strong posture, bright and inspiring background, Pixar style."
    "boy_neg_1" = "A 3D cartoon style portrait of a mischievous boy with a sneaky grin, holding a slingshot, from the chest up. Slightly messy hair, playful yet rebellious vibe, Pixar style."
    "boy_neg_2" = "A 3D cartoon style portrait of a cool, tough-looking man wearing a leather vest with visible tattoos on his arms and neck, from the chest up. Edgy and sharp lighting, Pixar style."
    "boy_neg_3" = "A 3D cartoon style portrait of a large, intimidating bully with an angry, scowling face, cracking his knuckles, from the chest up. Dark and dramatic lighting, Pixar style."
    "boy_neg_4" = "A 3D cartoon style portrait of a boastful man with an unzipped jacket, proudly pointing to his defined 6-pack abs with a smug smirk, from the chest up. Confident and showy pose, Pixar style."
    "boy_neg_5" = "A 3D cartoon style portrait of a furious man, clenching his fists with a red, angry facial expression and steam metaphorically coming from his ears, from the chest up. Intense dynamic lighting, Pixar style."
    "girl_pos_1" = "A 3D cartoon style portrait of a well-behaved, polite girl smiling gently, from the chest up. Clean school uniform, neat hair, bright and soft lighting, Pixar style."
    "girl_pos_2" = "A 3D cartoon style portrait of a smart girl wearing glasses, looking confident and intelligent, from the chest up. Holding a book, creative and bright background, Pixar style."
    "girl_pos_3" = "A 3D cartoon style portrait of a kind and gentle young woman with a warm, soft smile, from the chest up. Friendly expression, warm and cozy lighting, Pixar style."
    "girl_pos_4" = "A 3D cartoon style portrait of a joyful, energetic girl laughing happily, from the chest up. Vibrant colors, confetti background, expressive and fun, Pixar style."
    "girl_pos_5" = "A 3D cartoon style portrait of a confident young woman with her arms crossed, smiling determinedly, from the chest up. Strong posture, bright and inspiring background, Pixar style."
    "girl_neg_1" = "A 3D cartoon style portrait of a mischievous girl with a sneaky grin, holding a slingshot or a spray can, from the chest up. Slightly messy hair, playful yet rebellious vibe, Pixar style."
    "girl_neg_2" = "A 3D cartoon style portrait of a cool, tough-looking woman wearing a leather vest with visible tattoos on her arms and neck, from the chest up. Edgy and sharp lighting, Pixar style."
    "girl_neg_3" = "A 3D cartoon style portrait of a large, intimidating female bully with an angry, scowling face, cracking her knuckles, from the chest up. Dark and dramatic lighting, Pixar style."
    "girl_neg_4" = "A 3D cartoon style portrait of a boastful woman wearing an open jacket over a sports top, proudly pointing to her defined abs with a smug smirk, from the chest up. Confident and showy pose, Pixar style."
    "girl_neg_5" = "A 3D cartoon style portrait of a furious woman, clenching her fists with a red, angry facial expression and steam metaphorically coming from her ears, from the chest up. Intense dynamic lighting, Pixar style."
}

$baseUrl = "https://image.pollinations.ai/prompt/"
$outDir = "images"
if (!(Test-Path -Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir
}

# Only delete the tiger images (size 129730) to be safe, or just overwrite all.
Remove-Item -Path "$outDir\*.jpg" -Force -ErrorAction SilentlyContinue

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
Write-Host "ALL DOWNLOADS FINISHED"
