Set-ExecutionPolicy RemoteSigned


Write-Host "Update apps"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/updateapps.ps1'))

Write-Host "Update OT's"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/otupdate.ps1'))

Write-Host "Update nuttige dingen"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/nuttigedingen.ps1'))

Write-Host "Install windows updates - critical only"
#Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Restart-Computer
