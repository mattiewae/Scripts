Set-ExecutionPolicy RemoteSigned

#Set-Location -Path C:\Users\ENG\Downloads
Set-Location -Path C:\Users\Mathias\Downloads

wget https://raw.githubusercontent.com/mattiewae/test/master/winupdate.ps1 -OutFile winupdate.ps1

$ChkFile = "C:\Users\Mathias\Downloads\winupdate.ps1" 
$FileExists = Test-Path $ChkFile 
If ($FileExists -eq $True) {
Write-Host "File download success"
Invoke-Expression C:\Users\Mathias\Downloads\winupdate.ps1
}

Remove-Item C:\Users\ENG\Downloads\winupdate.ps1





