﻿Set-ExecutionPolicy RemoteSigned


$ChkFile = "C:\ProgramData\chocolatey\choco.exe" 
$FileExists = Test-Path $ChkFile 
    If ($FileExists -eq $True) {
        Write-Host "Choco already installed"
    }
    else {
        ######################################################
        # Install apps using Chocolatey
        ######################################################
        Write-Host "Installing Chocolatey"
        iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))
        Write-Host
    }

Write-Host "Installing applications from Chocolatey"

cinst wget -y
cinst teamviewer8 -y
cinst flashplayerplugin -y
cinst googlechromex64 -y 
cinst firefox -y 
cinst notepadplusplus.install -y
cinst jre8 -y 
cinst vlc -y
cinst ccleaner -y
cinst adobeair -y
cinst windirstat -y
cinst quicktime -y 
cinst irfanview -y


Write-Host "update all apps"
cup all -y

Write-Host "Update OT's"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/otupdate.ps1'))

Write-Host "Update OT's"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/nuttigedingen.ps1'))

Write-Host "Install windows updates - critical only"
#Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Restart-Computer
