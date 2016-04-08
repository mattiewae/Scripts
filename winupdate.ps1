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



Write-Host

#update all apps
cup all

#Install windows updates - critical only
Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"


#Update OT's
Set-Location -Path $home\Downloads
#wget https://raw.githubusercontent.com/mattiewae/test/master/otupdate.ps1 -OutFile otupdate.ps1
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/test/master/otupdate.ps1'))


$ChkFileOT = "$home\Downloads\otupdate.ps1" 
$FileExistsOT = Test-Path $ChkFileOT 
If ($FileExistsOT -eq $True) {
Write-Host "File download success"
Invoke-Expression $home\Downloads\otupdate.ps1 | Out-Null
}

