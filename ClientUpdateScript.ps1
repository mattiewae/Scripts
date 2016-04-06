Set-ExecutionPolicy RemoteSigned

Set-Location -Path $home\Downloads

iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

wget https://raw.githubusercontent.com/mattiewae/test/master/winupdate.ps1 -OutFile winupdate.ps1


$ChkFile = "$home\Downloads\winupdate.ps1" 
$FileExists = Test-Path $ChkFile 
If ($FileExists -eq $True) {
Write-Host "File download success"
Invoke-Expression $home\Downloads\winupdate.ps1 | Out-Null
}

Remove-Item $home\Downloads\winupdate.ps1
Write-Host "Update file removed"