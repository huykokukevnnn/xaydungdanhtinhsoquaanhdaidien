Add-Type -AssemblyName System.Drawing

$images = @{
    "boy_neg_1" = "Bong da"
    "boy_neg_2" = "Bong ro"
    "boy_neg_3" = "Co vua"
    "boy_neg_4" = "Bong ban"
    "boy_neg_5" = "Boi loi"
    "girl_neg_1" = "Mua bale"
    "girl_neg_2" = "Nhay"
    "girl_neg_3" = "Hat"
    "girl_neg_4" = "Ve"
    "girl_neg_5" = "Doc sach"
}

foreach ($key in $images.Keys) {
    $bmp = New-Object System.Drawing.Bitmap(512, 512)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::LightBlue)
    
    $font = New-Object System.Drawing.Font("Arial", 48)
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
    $format = New-Object System.Drawing.StringFormat
    $format.Alignment = [System.Drawing.StringAlignment]::Center
    $format.LineAlignment = [System.Drawing.StringAlignment]::Center
    
    $rect = New-Object System.Drawing.RectangleF(0, 0, 512, 512)
    $g.DrawString($images[$key], $font, $brush, $rect, $format)
    
    $path = Join-Path (Get-Location) "images\$key.jpg"
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    
    $g.Dispose
    $bmp.Dispose
}
