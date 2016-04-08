Set-ExecutionPolicy RemoteSigned
    
    ######################################################
    Write-Host Install PS V5.0
    Write-Host Reboot and run script again.
    ######################################################
    Write-Host "Installing Chocolatey"
    iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))
    Write-Host
    choco install dotnet4.6 -y -force
    #choco upgrade dotnet4.6 -y 
    cinst boxstarter -y
    cinst powershell -pre -y
    cinst upgrade powershell -pre -y
    Restart-Computer