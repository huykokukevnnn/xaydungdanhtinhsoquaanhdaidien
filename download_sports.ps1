$sportsPrompts = @{
    "boy_neg_1" = "3D Pixar cartoon portrait of a joyful young male character playing football, colorful, energetic"
    "boy_neg_2" = "3D Pixar cartoon portrait of a joyful young male character playing basketball, colorful, energetic"
    "boy_neg_3" = "3D Pixar cartoon portrait of a smart young male character playing chess, colorful, focused"
    "boy_neg_4" = "3D Pixar cartoon portrait of a joyful young male character playing table tennis, colorful, energetic"
    "boy_neg_5" = "3D Pixar cartoon portrait of a joyful young male character swimming in a pool, colorful, energetic"
    
    "girl_neg_1" = "3D Pixar cartoon portrait of a joyful young female character dancing ballet, colorful, elegant"
    "girl_neg_2" = "3D Pixar cartoon portrait of a joyful young female character doing modern dance, colorful, energetic"
    "girl_neg_3" = "3D Pixar cartoon portrait of a joyful young female character singing with a microphone, colorful"
    "girl_neg_4" = "3D Pixar cartoon portrait of a creative young female character painting on a canvas, colorful"
    "girl_neg_5" = "3D Pixar cartoon portrait of a joyful young female character reading a book, colorful, calm"
}

function DownloadImage {
    param([string]$name, [string]$prompt)
    $encodedPrompt = [uri]::EscapeDataString($prompt)
    $seed = Get-Random -Maximum 99999
    $url = "https://image.pollinations.ai/prompt/$encodedPrompt?width=512&height=512&nologo=true&seed=$seed"
    $dest = "images\$name.jpg"
    Write-Host "Downloading $name..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing -TimeoutSec 30
        Write-Host "Success: $name"
    } catch {
        Write-Host "Failed to download $name : $_"
    }
    # Important delay to prevent 429 Too Many Requests
    Start-Sleep -Seconds 4
}

foreach ($key in $sportsPrompts.Keys) {
    DownloadImage -name $key -prompt $sportsPrompts[$key]
}
