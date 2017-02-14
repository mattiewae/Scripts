#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------


# variabelen
$Temp = 'C:\Temp';
$checkLocation = Test-Path 'E:\AdobeExport';
$script:checkTemp = Test-Path 'C:\Temp';
$script:ffmpeg = "C:\encoder\ffmpeg\bin\ffmpeg.exe";
$script:mp4box = "C:\encoder\mp4box\MP4box.exe";
$script:qtaacenc = "C:\encoder\qtaacenc\qtaacenc.exe";


function BrowseBtn ()
{
	if ($script:checkTemp -eq $true) {
		
		Load-ListBox -ListBox $listbox1 -Items "C:\temp dir: OK" -DisplayMember 'DisplayMember' -Append
	}
	else {
		
		New-Item 'C:\Temp' -Type Directory -Force
		Load-ListBox -ListBox $listbox1 -Items "C:\Temp dir: created" -DisplayMember 'DisplayMember' -Append
	}
	$openFiledialog1.InitialDirectory = "C:\Temp";
	$openfiledialog1.ShowDialog()
	$textbox1.Text = $openfiledialog1.FileName
}

function check_rdnButtons ()
{
	if ($radiobuttonHigh.Checked)
	{
		$script:crf = 23;
	}
	elseif ($radiobuttonMedium.Checked)
	{
		$script:crf = 26;
	}
	elseif ($radiobuttonLow.Checked)
	{
		$script:crf = 29;
	}
	else
	{
		#[System.Windows.Forms.MessageBox]::Show("Selecteer videokwaliteit!", "FFMPEG MP4 Converter")
	}
}

function Convert ()
{
	if ($textbox1.text)
	{
		TrimFileName
		CheckLocation
		MxfExtractAudio
		Start-Sleep -Seconds '1' 
		Mono2Stereo2
		Wave2aacConverter
		Mxf2mp4
		Mp4Mix
		#MoveItems
	}
	else
	{
		[System.Windows.Forms.MessageBox]::Show("Er is iets foutgelopen, selecteer MXF")
	}
	
}

function TrimFileName()
{
	#remove space from filename
	$script:mxfInputFile = $textbox1.Text -replace ' ';
	Load-ListBox -ListBox $listbox1 -Items $mxfInputFile -DisplayMember 'DisplayMember' -Append
	Rename-Item $textbox1.Text $script:mxfInputFile
}

# Functie CheckLocation
function CheckLocation()
{
	if ($checkLocation -eq 'true')
	{
		$script:location = 'E:\AdobeExport'
		Set-Location C:\Temp;
		Write-Host "Item wordt ge-exporteerd naar $script:location"
		Load-ListBox -ListBox $listbox1 -Items "Item wordt ge-exporteerd naar $location" -DisplayMember 'DisplayMember' -Append
	}
	else
	{
		$script:location = 'C:\AdobeExport'
		Set-Location C:\Temp;
		New-Item $script:location -Type Directory -Force
		write-host "`n"
		Write-Host "Item wordt ge-exporteerd naar $script:location"
		Load-ListBox -ListBox $listbox1 -Items "Item wordt ge-exporteerd naar $location" -DisplayMember 'DisplayMember' -Append
	}
	# Premiere export naar C:\Temp
	Set-Location $Temp;
}

# # Haal de 8 channels uit MXF -> TODO: Check op aantal kanalen. 
# Do while ipv foreach
function MxfExtractor()
{
	$mxf = Get-ChildItem *.mxf
	for ($i = 1
		$i -le 8
		$i++)
	{
		&$script:ffmpeg -i $mxf -map 0:$i -acodec: copy -vn mono$i.wav -y 
	}
}

function MxfExtractAudio()
{
	Set-Location C:\Temp
	$mxfArguments = "-i $script:mxfInputFile -map 0:$i -acodec: copy -vn mono$i.wav -y"
	for ($i = 1
		$i -le 8
		$i++)
	{
		Start-Process $script:ffmpeg -ArgumentList "-i $script:mxfInputFile -map 0:$i -acodec: copy -vn mono$i.wav -y -report" -Wait -WindowStyle Hidden
		Load-ListBox -ListBox $listbox1 -Items "Audio: OK" -DisplayMember 'DisplayMember' -Append
	}
}

# Check of er een MXF in C:\Temp is.
function MxfTester()
{
	$Mxftester = Test-Path *.mxf
	if ($Mxftester -eq 'true')
	{
		MxfExtractor
	}
	else
	{
		Write-Warning "Geen MXF in C:\Temp gevonden"
		Load-ListBox -ListBox $listbox1 -Items "Geen MXF in C:\Temp" -DisplayMember 'DisplayMember' -Append
	}
}

# # 2xmono > stereo
function Mono2Stereo()
{
	&$script:ffmpeg -i mono1.wav -i mono2.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo1.wav -y
	&$script:ffmpeg -i mono3.wav -i mono4.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo2.wav -y
	&$script:ffmpeg -i mono5.wav -i mono6.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo3.wav -y
	&$script:ffmpeg -i mono7.wav -i mono8.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo4.wav -y
}

function Mono2Stereo2()
{
	Set-Location C:\Temp
	Load-ListBox -ListBox $listbox1 -Items "Mono > stereo converteren" -DisplayMember 'DisplayMember' -Append
	
	$1 = '-i mono1.wav -i mono2.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo1.wav -y -report'
	$2 = '-i mono3.wav -i mono4.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo2.wav  -y -report'
	$3 = '-i mono5.wav -i mono6.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo3.wav  -y -report'
	$4 = '-i mono7.wav -i mono8.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo4.wav -y -report'
	
	Start-Process $script:ffmpeg -ArgumentList $1  -Wait -WindowStyle Hidden 
	Start-Process $script:ffmpeg -ArgumentList $2 -Wait -WindowStyle Hidden
	Start-Process $script:ffmpeg -ArgumentList $3 -Wait -WindowStyle Hidden
	Start-Process $script:ffmpeg -ArgumentList $4 -Wait -WindowStyle Hidden
	
	Load-ListBox -ListBox $listbox1 -Items "Mono > Stereo: OK" -DisplayMember 'DisplayMember' -Append
}

function Wave2aac()
{
	&$script:qtaacenc .\stereo1.wav stereo1.m4a 
	&$script:qtaacenc .\stereo2.wav stereo2.m4a
	&$script:qtaacenc .\stereo3.wav stereo3.m4a
	&$script:qtaacenc .\stereo4.wav stereo4.m4a
}

function Wave2aacConverter ()
{
	Set-Location C:\Temp
	Load-ListBox -ListBox $listbox1 -Items "Wave > AAC converteren" -DisplayMember 'DisplayMember' -Append
	
	$1 = ".\stereo1.wav stereo1.m4a"
	$2 = ".\stereo2.wav stereo2.m4a"
	$3 = " .\stereo3.wav stereo3.m4a"
	$4 = ".\stereo4.wav stereo4.m4a"
	
	Start-Process $script:qtaacenc -ArgumentList $1 -Wait -WindowStyle Hidden
	Start-Process $script:qtaacenc -ArgumentList $2 -Wait -WindowStyle Hidden
	Start-Process $script:qtaacenc -ArgumentList $3 -Wait -WindowStyle Hidden
	Start-Process $script:qtaacenc -ArgumentList $4 -Wait -WindowStyle Hidden
	
	
	
	Load-ListBox -ListBox $listbox1 -Items "Wave > AAC: OK" -DisplayMember 'DisplayMember' -Append
}

# # MXF to MP4 no audio
# CRF: 0 is lossless, 23 is default, and 51 is worst possible
function MxfToMp4()
{
	Load-ListBox -ListBox $listbox1 -Items "Item wordt geconverteerd" -DisplayMember 'DisplayMember' -Append
	$oldvids = Get-ChildItem *.mxf #-Recurse
	foreach ($oldvid in $oldvids)
	{
		$Script:newvid = [io.path]::ChangeExtension($oldvid.FullName, '.mp4')
		&$script:ffmpeg -i $oldvid.FullName -an -pix_fmt yuv420p -c:v libx264 -crf $script:crf -profile:v high -level 4.1 -aspect 16:9 -flags +ildct+ilme -x264opts weightp=0:tff=1 $Script:newvid -y;
		
		Load-ListBox -ListBox $listbox1 -Items "MXF > MP4: OK" -DisplayMember 'DisplayMember' -Append
	}
}


function Mxf2mp4()
{
	$script:convertedVideoPath = $textbox1.Text.Substring(0, $textbox1.Text.LastIndexOf('.')) + "_CONVERTED_" + $(get-date -f yyyy-MM-dd-mm-ss-ms) + ".mp4"
	$lblStatus.Text = "Status: Converteren..."
	$argument = "-i $($textbox1.Text) -an -pix_fmt yuv420p -c:v libx264 -crf $script:crf -profile:v high -level 4.1 -aspect 16:9 -flags +ildct+ilme -x264opts weightp=0:tff=1 $script:convertedVideoPath"
	Start-Process $script:ffmpeg -ArgumentList $argument -Wait
	
	
}

function Mp4Mix()
{
	Load-ListBox -ListBox $listbox1 -Items "Mix MP4 > Audio" -DisplayMember 'DisplayMember' -Append
	Set-Location $Temp;
	$Mp4boxArg = "-add stereo1.m4a -add stereo2.m4a -add stereo3.m4a -add stereo4.m4a $($script:convertedVideoPath)"
	#&$script:mp4box -add stereo1.m4a -add stereo2.m4a -add stereo3.m4a -add stereo4.m4a $Script:newvid
	Start-Process $script:mp4box -ArgumentList $Mp4boxArg
	
	Load-ListBox -ListBox $listbox1 -Items "MP4 > Audio: OK" -DisplayMember 'DisplayMember' -Append
	$lblStatus.Text = "Ready!"
}

# Move item naar Export map en open Exportmap
function MoveItems()
{
	Copy-Item $script:convertedVideoPath $script:location -Force 
	Start-Sleep -Seconds '3'	
	# Verwijder alle rommel
	Remove-Item ('*.mp3', '*.wav', '*.xmp', '*.m4a', '*.mp4')
	Remove-Item ('*.mxf')
	Invoke-Item $script:location
	
	
}

# Wachten op input voor af te sluiten
function Wait-KeyPress($prompt = 'Druk op een toets ...!')
{
	Write-Host $prompt
	do
	{
		Start-Sleep -milliseconds 100
	}
	until ($Host.UI.RawUI.KeyAvailable)
	
	$Host.UI.RawUI.FlushInputBuffer()
}
