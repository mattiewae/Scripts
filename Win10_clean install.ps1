Set-ExecutionPolicy RemoteSigned

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
cinst flashplayerplugin -y
cinst flashplayeractivex -y
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
cinst 7zip.install -y
cinst javaruntime -y
cinst skype -y
cinst putty -y
cinst libreoffice -y
cinst windirstat -y
cinst googledrive -y
cinst irfanview -y
cinst avgantivirusfree -y
cinst clover -y
cinst jdownloader -y




Write-Host "update all apps"
cup all

Write-Host "Install windows updates - critical only"
Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Restart-Computer
