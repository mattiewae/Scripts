Set-Location C:\Users\ENG\Documents\settings

$list = Get-ChildItem -Path C:\Users\ENG\Documents\settings | Where-Object {$_.PSIsContainer} | Foreach-Object {$_.Name}

write $list

$user = Read-Host 'Welke settings wil je laden?'


$checkfile = Test-Path $user

if($checkfile -eq 'true'){
    Copy-Item "C:\Users\ENG\Documents\settings\$user\*" "C:\Users\ENG\Documents\Adobe\Premiere Pro\9.0\Profile-ENG" -Recurse -Force -Verbose
    Write-Host "Gelukt! Settings zijn gekopieerd."
}
else{
    write-host "`n"
    Write-Host "Settings niet gevonden, kopieer eerst je settings naar de map 'settings' in mijn documenten"}

Wait-KeyPress

function Wait-KeyPress($prompt='Druk op een toets ...!') {
	Write-Host $prompt 
	
	do {
		Start-Sleep -milliseconds 100
	} until ($Host.UI.RawUI.KeyAvailable)

	$Host.UI.RawUI.FlushInputBuffer()
}







    