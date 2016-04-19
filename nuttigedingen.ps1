Set-ExecutionPolicy RemoteSigned

Set-Location -Path $home\Downloads
wget https://github.com/mattiewae/test/raw/master/nuttige.zip -OutFile .\nuttige.zip

Write-Host "Download allerlei nuttige dingen succes"
Expand-Archive -Path nuttige.zip -DestinationPath ND -Force
Write-Host "files unzipped"

Copy-Item '.\ND\Allerlei nuttige dingen'  "$home\Desktop\" -Recurse


Remove-Item $home\Downloads\ND -Recurse
Write-Host "Remove ND"
Remove-Item $home\Downloads\nuttige.zip 
Write-Host "Remove ZIP"