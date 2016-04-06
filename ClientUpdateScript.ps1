Set-ExecutionPolicy RemoteSigned

Set-Location -Path $home\Downloads

wget https://raw.githubusercontent.com/mattiewae/test/master/winupdate.ps1 -OutFile winupdate.ps1

$ChkFile = "$home\Downloads\winupdate.ps1" 
$FileExists = Test-Path $ChkFile 
If ($FileExists -eq $True) {
Write-Host "File download success"
<<<<<<< HEAD
Invoke-Expression $home\Downloads\winupdate.ps1
=======
Invoke-Expression C:\Users\Mathias\Downloads\winupdate.ps1 | out-null
>>>>>>> origin/master
}

Remove-Item $home\Downloads\winupdate.ps1





