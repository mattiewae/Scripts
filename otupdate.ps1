Set-ExecutionPolicy RemoteSigned

Set-Location -Path $home\Downloads
wget https://github.com/mattiewae/test/raw/master/ot.zip -OutFile .\test.zip

Write-Host "Download succes"
Expand-Archive -Path test.zip -DestinationPath OT -Force
Write-Host "Unzip succes"


$OTcheck = "$home\Desktop\*.stp"
$STPrem = Remove-Item "$home\Desktop\*.stp"
$SDnew = "$home\Downloads\OT\Setting_SD_11feb2016.stp"
$HDnew = "$home\Downloads\OT\Setting_HD_11feb2016.stp"

$OTchecker = Test-Path $OTcheck
Write-Host $OTchecker

if ($OTchecker -eq $true){
    $STPrem    
    Copy-Item $SDnew $home\Desktop
    Copy-Item $HDnew $home\Desktop
    Write-Host "Kopieer nieuwe settings en verwijder oude settings"
    }
else {
    Write-Host "Kopieer nieuwe settings"
    Copy-Item $SDnew $home\Desktop
    Copy-Item $HDnew $home\Desktop
    }

Remove-Item $home\Downloads\OT -Recurse
Write-Host "Remove OT"
Remove-Item $home\Downloads\test.zip 
Write-Host "Remove ZIP"

