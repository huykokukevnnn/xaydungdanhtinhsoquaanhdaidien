$basePrompt = "Modern 3D Animated Film Style, Pixar Disney DreamWorks style, highest quality, masterpiece. Chest-up bust portrait, stylized proportions, slightly larger head, large expressive round eyes, soft smooth features. Smooth natural skin with subsurface scattering, detailed hair strands, high-quality fabric textures, cinematic studio lighting."

$prompts = @{
    "boy_pos_1" = "$basePrompt joyful male teenager, smiling brightly, warm bright lighting, vibrant colors."
    "boy_pos_2" = "$basePrompt smart male teenager wearing neat glasses, confident smile, warm bright lighting, vibrant colors."
    "boy_pos_3" = "$basePrompt gentle male teenager, kind soft smile, warm bright lighting, vibrant colors."
    "boy_pos_4" = "$basePrompt cheerful male teenager, laughing happily, energetic expression, warm bright lighting, vibrant colors."
    "boy_pos_5" = "$basePrompt confident male teenager, self-assured smile, warm bright lighting, vibrant colors."

    "boy_neg_1" = "$basePrompt joyful male teenager wearing a soccer jersey, holding a football, energetic expression, warm bright lighting."
    "boy_neg_2" = "$basePrompt joyful male teenager wearing a basketball jersey, holding a basketball, energetic expression, warm bright lighting."
    "boy_neg_3" = "$basePrompt smart male teenager holding a chess piece, focused expression, cinematic studio lighting."
    "boy_neg_4" = "$basePrompt joyful male teenager holding a table tennis paddle, energetic expression, warm bright lighting."
    "boy_neg_5" = "$basePrompt joyful male teenager wearing swimming goggles and swimsuit, energetic expression, warm bright lighting."
    
    "girl_pos_1" = "$basePrompt joyful female teenager, smiling brightly, warm bright lighting, vibrant colors."
    "girl_pos_2" = "$basePrompt smart female teenager wearing neat glasses, confident smile, warm bright lighting, vibrant colors."
    "girl_pos_3" = "$basePrompt gentle female teenager, kind soft smile, warm bright lighting, vibrant colors."
    "girl_pos_4" = "$basePrompt cheerful female teenager, laughing happily, energetic expression, warm bright lighting, vibrant colors."
    "girl_pos_5" = "$basePrompt confident female teenager, self-assured smile, warm bright lighting, vibrant colors."

    "girl_neg_1" = "$basePrompt graceful female teenager wearing a ballet outfit, elegant expression, warm soft lighting."
    "girl_neg_2" = "$basePrompt energetic female teenager wearing modern dance clothes, confident expression, vibrant colors."
    "girl_neg_3" = "$basePrompt joyful female teenager holding a microphone, singing passionately, stage lighting, vibrant colors."
    "girl_neg_4" = "$basePrompt creative female teenager holding a paintbrush and palette, colorful paint splatters on apron, bright lighting."
    "girl_neg_5" = "$basePrompt calm female teenager holding a book, focused and peaceful expression, warm soft lighting."
}

param (
    [string]$target = "all"
)

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

if ($target -eq "all") {
    foreach ($key in $prompts.Keys) {
        DownloadImage -name $key -prompt $prompts[$key]
    }
} else {
    DownloadImage -name $target -prompt $prompts[$target]
}
