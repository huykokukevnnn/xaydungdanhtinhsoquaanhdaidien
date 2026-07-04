for ($i=1; $i -le 5; $i++) {
    Copy-Item -Path "images\boy_pos_$i.jpg" -Destination "images\boy_neg_$i.jpg" -Force
    Copy-Item -Path "images\girl_pos_$i.jpg" -Destination "images\girl_neg_$i.jpg" -Force
}
