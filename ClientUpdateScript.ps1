Set-ExecutionPolicy RemoteSigned

if ($PSVersionTable.PSVersion.Major -eq 5){
    
    Set-Location -Path $home\Downloads
    iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/winupdate.ps1'))
}
else{
    iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/installPSv5.ps1'))
}


 Restart-Computer