# -------------------------------------------------------------
# Uncomment 'Set-ExecutionPolicy RemoteSigned' en voer uit (F5) 
# -------------------------------------------------------------
Set-ExecutionPolicy Unrestricted

# Check of E-schijf bestaat, indien niet, maak folder aan op C-schijf.
# Premiere project wordt altijd ge-exporteerd naar C:\Temp, daar worden alle bewerkingen gedaan. 
# De uiteindelijk mp4 file wordt gekopieerd naar E/C:\AdobeExport.

# variabelen
$Temp = 'C:\Temp'
$location = 'E:\AdobeExport' 
$checkLocation = Test-Path $location
$mp4box = "C:\Program Files\GPAC\mp4box.exe"
$ffmpeg = "C:\ProgramData\chocolatey\lib\ffmpeg\tools\ffmpeg-3.2-win64-static\bin\ffmpeg.exe"

if($checkLocation -eq 'true'){
    Write-Host "Item wordt ge-exporteerd naar E:\AdobeExport "
    $location = 'E:\AdobeExport'
}
else{
    $location = 'C:\AdobeExport'
    New-Item $location -Type Directory -Force
    write-host "`n"
    Write-Host "Write-Host "Item wordt ge-exporteerd naar $location ""}

# Premiere export naar C:\Temp
Set-Location $Temp;

$mxf = Get-ChildItem *.mxf
# Haal de 8 channels uit MXF -> TODO: Check op aantal kanalen. 
for($i=1
     $i -le 8
     $i++){
       ffmpeg.exe -i $mxf -map 0:$i -acodec: copy -vn mono$i.wav -y}

# $CountWaves = (dir $Temp | measure).Count;
$CountWaves = (dir 'Y:\beeldmateriaal\export uit premiere\temp\*.wav' | measure).Count;
if ($CountWaves == 8){
    Write-Host = 'Je montage heeft 8 kanalen';}
# Todo: maak vergelijking 8-$CountWaves=x, maak x aantal lege streams.
#Elseif ($x = [int]"8"-$CountWaves){
    # FFmpeg x aantal lege streams
#}

# MXF to MP4 no audio
$ffmpeg = "C:\ProgramData\chocolatey\lib\ffmpeg\tools\ffmpeg-3.2-win64-static\bin\ffmpeg.exe"
$oldvids = Get-ChildItem *.mxf #-Recurse
foreach ($oldvid in $oldvids) {
    $newvid = [io.path]::ChangeExtension($oldvid.FullName, '.mp4') 
    &$ffmpeg -i $oldvid.FullName -an -pix_fmt yuv420p -c:v libx264 -profile:v high -level 4.1 -aspect 16:9 -flags +ildct+ilme -x264opts weightp=0:tff=1 output.mp4 -y;
    # Remove-Item $oldvid
}


# 2xmono > stereo
ffmpeg -i mono1.wav -i mono2.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo1.wav  -y
ffmpeg -i mono3.wav -i mono4.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo2.wav -y
ffmpeg -i mono5.wav -i mono6.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo3.wav -y
ffmpeg -i mono7.wav -i mono8.wav -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" stereo4.wav -y

# WAVE > MP3

ffmpeg -i .\stereo1.wav -codec:a libmp3lame -q:a 3 stereo1.mp3 -y
ffmpeg -i .\stereo2.wav -codec:a libmp3lame -q:a 3 stereo2.mp3 -y
ffmpeg -i .\stereo3.wav -codec:a libmp3lame -q:a 3 stereo3.mp3 -y
ffmpeg -i .\stereo4.wav -codec:a libmp3lame -q:a 3 stereo4.mp3 -y

# MP4 mixen met 4 mp3

ffmpeg -i output.mp4 -i .\stereo1.mp3 -i .\stereo2.mp3 -i .\stereo3.mp3 -i .\stereo4.mp3 -map 0:v -map 1:a -map 2:a -map 3:a -map 4:a -c copy -shortest $newvid -y

# Move item naar Export map
Move $newvid $location

# Verwijder alle rommel
Remove-Item ('*.mp3','*.wav', 'output.mp4','*.xmp')
# Remove-Item ('*.mxf')

Invoke-Item $location

