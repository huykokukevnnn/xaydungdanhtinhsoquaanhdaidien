$sportsPrompts = @{
    "boy_neg_1" = "3D animation style, Pixar style cartoon portrait of a joyful young boy playing football on a green field, colorful, energetic"
    "boy_neg_2" = "3D animation style, Pixar style cartoon portrait of a joyful young boy playing basketball, colorful, energetic"
    "boy_neg_3" = "3D animation style, Pixar style cartoon portrait of a smart young boy playing chess on a board, colorful, focused"
    "boy_neg_4" = "3D animation style, Pixar style cartoon portrait of a joyful young boy playing table tennis, colorful, energetic"
    "boy_neg_5" = "3D animation style, Pixar style cartoon portrait of a joyful young boy swimming in a blue pool, colorful, energetic"
    
    "girl_neg_1" = "3D animation style, Pixar style cartoon portrait of a joyful young girl dancing ballet in a studio, colorful, elegant"
    "girl_neg_2" = "3D animation style, Pixar style cartoon portrait of a joyful young girl doing modern dance, colorful, energetic"
    "girl_neg_3" = "3D animation style, Pixar style cartoon portrait of a joyful young girl singing with a microphone on stage, colorful"
    "girl_neg_4" = "3D animation style, Pixar style cartoon portrait of a creative young girl painting on a canvas, colorful"
    "girl_neg_5" = "3D animation style, Pixar style cartoon portrait of a joyful young girl reading a book in a library, colorful, calm"
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

foreach ($key in $sportsPrompts.Keys) {
    DownloadImage -name $key -prompt $sportsPrompts[$key]
}
