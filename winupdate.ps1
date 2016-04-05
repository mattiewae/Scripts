Set-ExecutionPolicy RemoteSigned
######################################################
# Install apps using Chocolatey
######################################################
Write-Host "Installing Chocolatey"
iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))
Write-Host

Write-Host "Installing applications from Chocolatey"
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
cinst boxstarter -y

Write-Host

#update all apps
cup all

#Install windowd updates
Install-WindowsUpdate -acceptEula -SuppressReboots  -criteria IsHidden=0 and IsInstalled=0 and Type='Software'

