$SDold = "$home\Desktop\SD VRT.stp"
$HDold = "$home\Desktop\HD VRT.stp"
$SDnew = "$home\Downloads\OT\Setting_SD_11feb2016.stp"
$HDnew = "$home\Downloads\OT\Setting_HD_11feb2016.stp"
 
$SDtest = Test-Path $SDold
$HDtest = Test-Path $HDold


#OT SD settings
if ($SDtest -eq $false){
    Write-Host "Oude OT's gevonden"
    Write-Host $SDold
}
else{
    Write-Host "Kopieer nieuwe settings en verwijder oude settings"
    Copy-Item $SDnew $home\Desktop
    Remove-Item $SDold
}


#OT HD settings
if ($HDtest -eq $false){
    Write-Host "Oude OT's gevonden"
    Write-Host $HDold
    Remove-Item $HDold
}
else{
    Write-Host "Kopieer nieuwe settings en verwijder oude settings"
    Copy-Item $HDnew $home\Desktop
    Remove-Item $HDold
}






#OT SD settings
#if ($SDtest -eq $True){
#    Write-Host "SD verwijderen en nieuwe kopieren"
#    Remove-Item $SDold
#    Copy-Item $SDnew "$home\Desktop"
#}
#Else{
#    Write-Host "SD settings UptoDate"
#}

#OT HD settings
#if ($HDtest -eq $True){
#    Write-Host "SD verwijderen en nieuwe kopieren"
#    Remove-Item $HDold
#    Copy-Item $HDnew "$home\Desktop"
#}
#Else{
#    Write-Host "HD settings UptoDate"
#}



