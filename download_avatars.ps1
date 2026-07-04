$boyPrompts = @{
    "boy_pos_1" = "3D Pixar cartoon portrait of a cheerful young male character smiling brightly outdoors, colorful"
    "boy_pos_2" = "3D Pixar cartoon portrait of a friendly young male character waving hand, warm smile, colorful"
    "boy_pos_3" = "3D Pixar cartoon portrait of an obedient serious young male character wearing a red scarf holding a notebook"
    "boy_pos_4" = "3D Pixar cartoon portrait of a responsible young male character wearing a proper bicycle helmet smiling"
    "boy_pos_5" = "3D Pixar cartoon portrait of a kind young male character gently watering a small green plant sprout"
    "boy_pos_6" = "3D Pixar cartoon portrait of an energetic young male character holding a basketball wearing sports clothes"
    "boy_pos_7" = "3D Pixar cartoon portrait of a creative young male character holding a colorful paint palette"
    "boy_neg_1" = "3D Pixar cartoon portrait of an angry young male character holding a wooden stick aggressively"
    "boy_neg_2" = "3D Pixar cartoon portrait of an arrogant young male character wearing fake gold chains holding money"
    "boy_neg_3" = "3D Pixar cartoon portrait of a young male character wearing inappropriate revealing street clothes"
    "boy_neg_4" = "3D Pixar cartoon portrait of a young male character with excessive ridiculous clown makeup"
    "boy_neg_5" = "3D Pixar cartoon portrait of a young male character standing on a high dangerous ledge doing a peace sign"
    "boy_neg_6" = "3D Pixar cartoon portrait of a mean young male character laughing at a phone screen cyberbullying"
    "boy_neg_7" = "3D Pixar cartoon portrait of a furious young male character yelling at a phone screen"
}

$girlPrompts = @{
    "girl_pos_1" = "3D Pixar cartoon portrait of a cheerful young female character smiling brightly outdoors, colorful"
    "girl_pos_2" = "3D Pixar cartoon portrait of a friendly young female character smiling warmly, hands resting on backpack straps"
    "girl_pos_3" = "3D Pixar cartoon portrait of an obedient serious young female character wearing a red scarf holding a notebook"
    "girl_pos_4" = "3D Pixar cartoon portrait of a responsible young female character wearing a proper bicycle helmet smiling"
    "girl_pos_5" = "3D Pixar cartoon portrait of a kind young female character gently watering a small green plant sprout"
    "girl_pos_6" = "3D Pixar cartoon portrait of an energetic young female character holding a basketball wearing sports clothes"
    "girl_pos_7" = "3D Pixar cartoon portrait of a creative young female character holding a colorful paint palette"
    "girl_neg_1" = "3D Pixar cartoon portrait of an angry young female character holding a wooden stick aggressively"
    "girl_neg_2" = "3D Pixar cartoon portrait of an arrogant young female character wearing fake gold chains holding money"
    "girl_neg_3" = "3D Pixar cartoon portrait of a young female character wearing inappropriate revealing street clothes"
    "girl_neg_4" = "3D Pixar cartoon portrait of a young female character with excessive ridiculous clown makeup"
    "girl_neg_5" = "3D Pixar cartoon portrait of a young female character standing on a high dangerous ledge doing a peace sign"
    "girl_neg_6" = "3D Pixar cartoon portrait of a mean young female character laughing at a phone screen cyberbullying"
    "girl_neg_7" = "3D Pixar cartoon portrait of a furious young female character yelling at a phone screen"
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

foreach ($key in $boyPrompts.Keys) {
    DownloadImage -name $key -prompt $boyPrompts[$key]
}
foreach ($key in $girlPrompts.Keys) {
    DownloadImage -name $key -prompt $girlPrompts[$key]
}
