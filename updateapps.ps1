#$ChkFile = "C:\ProgramData\chocolatey\choco.exe" 
#$FileExists = Test-Path $ChkFile 
#    If ($FileExists -eq $True) {
#        Write-Host "Choco already installed"
#    }
#    else {
#        ######################################################
#        # Install apps using Chocolatey
#        ######################################################
#        Write-Host "Installing Chocolatey"
#        iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))
#        Write-Host
#    }
#
Write-Host "Installing applications from Chocolatey"

cinst wget -y
cinst flashplayerplugin -y
cinst googlechrome -y 
cinst firefox -y 
cinst notepadplusplus.install -y
cinst jre8 -y 
cinst jdk8 -y
cinst vlc -y
cinst ccleaner -y
cinst adobeair -y
cinst windirstat -y
cinst quicktime -y 
cinst irfanview -y
cinst libreoffice -y
cinst winff -y
cinst mediainfo -y
cinst teamviewer11 -y
cinst 7zip -y
cinst dotnet4.6 -y
cinst win-youtube-dl -y

Write-Host "update all apps"
cup all -y
