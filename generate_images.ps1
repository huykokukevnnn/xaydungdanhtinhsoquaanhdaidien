$prompts = @{
    "boy_pos_1" = "3D Pixar style, clean cartoon portrait of a joyful young boy, neat, smiling, looking directly at camera, upper body only, perfect anatomy, high quality"
    "boy_pos_2" = "3D Pixar style, clean cartoon portrait of a smart young boy wearing glasses, studying, looking directly at camera, upper body only, perfect anatomy, high quality"
    "boy_pos_3" = "3D Pixar style, clean cartoon portrait of a confident young boy with arms crossed, smiling, looking directly at camera, upper body only, perfect anatomy, high quality"
    "boy_pos_4" = "3D Pixar style, clean cartoon portrait of an energetic young boy laughing, looking directly at camera, upper body only, perfect anatomy, high quality"
    "boy_pos_5" = "3D Pixar style, clean cartoon portrait of a friendly young boy waving hand, looking directly at camera, upper body only, perfect anatomy, high quality"

    "boy_neg_1" = "3D Pixar style, clean cartoon portrait of a joyful young boy playing football on a field, looking at camera, full body visible, perfect anatomy, realistic proportions, high quality"
    "boy_neg_2" = "3D Pixar style, clean cartoon portrait of a young boy playing basketball, holding ball, looking at camera, perfect anatomy, realistic proportions, high quality"
    "boy_neg_3" = "3D Pixar style, clean cartoon portrait of a smart young boy playing chess, sitting at a table, looking at camera, perfect anatomy, realistic proportions, high quality"
    "boy_neg_4" = "3D Pixar style, clean cartoon portrait of a joyful young boy playing table tennis, holding paddle, perfect anatomy, realistic proportions, high quality"
    "boy_neg_5" = "3D Pixar style, clean cartoon portrait of a young boy swimming in a pool, smiling, perfect anatomy, realistic proportions, high quality"
    
    "girl_pos_1" = "3D Pixar style, clean cartoon portrait of a joyful young girl, neat, smiling, looking directly at camera, upper body only, perfect anatomy, high quality"
    "girl_pos_2" = "3D Pixar style, clean cartoon portrait of a smart young girl reading, looking directly at camera, upper body only, perfect anatomy, high quality"
    "girl_pos_3" = "3D Pixar style, clean cartoon portrait of a confident young girl with hands on hips, looking directly at camera, upper body only, perfect anatomy, high quality"
    "girl_pos_4" = "3D Pixar style, clean cartoon portrait of an energetic young girl laughing, looking directly at camera, upper body only, perfect anatomy, high quality"
    "girl_pos_5" = "3D Pixar style, clean cartoon portrait of a friendly young girl waving hand, looking directly at camera, upper body only, perfect anatomy, high quality"

    "girl_neg_1" = "3D Pixar style, clean cartoon portrait of a graceful young girl dancing ballet, full body visible, looking at camera, perfect anatomy, high quality"
    "girl_neg_2" = "3D Pixar style, clean cartoon portrait of an energetic young girl doing modern dance, looking at camera, perfect anatomy, high quality"
    "girl_neg_3" = "3D Pixar style, clean cartoon portrait of a young girl singing with a microphone, looking at camera, perfect anatomy, high quality"
    "girl_neg_4" = "3D Pixar style, clean cartoon portrait of a creative young girl painting on a canvas, holding brush, perfect anatomy, high quality"
    "girl_neg_5" = "3D Pixar style, clean cartoon portrait of a calm young girl playing violin, looking at camera, perfect anatomy, high quality"
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
    while (-not $success -and $retries -lt 3) {
        try {
            Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing -TimeoutSec 45
            Write-Host "Success: $name"
            $success = $true
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
