$c = Get-Content index.html -Raw
$c = $c -replace 'text-\[17px\]', 'TEMP_22'
$c = $c -replace 'text-\[16px\]', 'TEMP_20'
$c = $c -replace 'text-\[15px\]', 'TEMP_18'
$c = $c -replace 'text-\[14px\]', 'TEMP_18'
$c = $c -replace 'text-\[13px\]', 'TEMP_16'
$c = $c -replace 'text-\[12px\]', 'TEMP_15'
$c = $c -replace 'TEMP_', 'text-['
$c | Set-Content index.html
