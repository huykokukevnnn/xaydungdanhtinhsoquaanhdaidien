$basePrompt = "3D modern animated film style, Disney Pixar aesthetic, high-end 3D render. Stylized character proportions with expressive facial features, large expressive eyes. Smooth skin with subsurface scattering, highly detailed clothing textures (cloth, leather, silk). Cinematic studio lighting, vibrant and appealing colors, sharp focus, 8k resolution, Octane Render, Unreal Engine 5 masterpiece."

$prompts = @{
    "girl_5" = "$basePrompt A 3D Pixar style energetic female teenager jumping high to spike a volleyball. Wearing a sporty uniform. Sunny beach or indoor court background."
    "girl_6" = "$basePrompt A 3D Pixar style peaceful female teenager sitting in a lotus yoga pose with her eyes closed, breathing deeply. Wearing comfortable activewear. Morning sunlight coming from a window."
    "girl_7" = "$basePrompt A 3D Pixar style cheerful female teenager holding a badminton racket, ready to hit the shuttlecock. Playful expression, vibrant outdoor lighting."
    "girl_8" = "$basePrompt A 3D Pixar style adventurous female teenager riding a surfboard on a big blue wave, wind blowing through her hair. Tropical sunny weather."
    "girl_9" = "$basePrompt A 3D Pixar style fun female teenager roller skating with retro 4-wheel skates. Wearing a colorful 80s style outfit and helmet. Neon sunset lighting."
    "girl_10" = "$basePrompt A 3D Pixar style expressive female teenager in a mid-air contemporary dance pose, conveying emotion and joy. Flowing clothes, dramatic studio lighting."
}

function DownloadImage {
    param([string]$name, [string]$prompt)
    $encodedPrompt = [uri]::EscapeDataString($prompt)
    $seed = Get-Random -Minimum 1000 -Maximum 999999
    $url = "https://image.pollinations.ai/prompt/$encodedPrompt?width=512&height=512&nologo=true&seed=$seed&model=flux"
    $dest = "images\$name.jpg"
    
    Write-Host "Downloading $name..."
    $success = $false
    $retries = 0
    while (-not $success -and $retries -lt 5) {
        try {
            Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing -TimeoutSec 45
            
            # The red hair girl error image is ~90-100KB. Real images are usually 30-70KB.
            $file = Get-Item $dest
            if ($file.Length -gt 85000) {
                Write-Host "Warning: Downloaded image might be an error fallback (Size: $($file.Length)). Retrying..."
                $retries++
                Start-Sleep -Seconds 3
                continue
            }
            
            Write-Host "Success: $name (Size: $($file.Length))"
            $success = $true
            Start-Sleep -Seconds 2
        } catch {
            Write-Host "Failed: $_"
            $retries++
            Start-Sleep -Seconds 3
        }
    }
}

foreach ($key in $prompts.Keys) {
    DownloadImage -name $key -prompt $prompts[$key]
}
