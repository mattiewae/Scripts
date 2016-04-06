Set-ExecutionPolicy RemoteSigned

Set-Location -Path $home\Downloads

wget https://github.com/mattiewae/test/raw/master/ot.zip -OutFile .\test.zip 
Write-Host "Download succes"



Expand-Archive -Path test.zip -DestinationPath OT