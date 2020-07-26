<# : ytdl.bat
@echo off
@chcp 65001 >nul
title module : ytdl
set dl=1
cls
echo url to video (it will temporarily be saved on your computer)
set /p u=""
set $u="%u%"
youtube-dl -q -i --no-playlist --no-warnings --console-title -f "bestvideo[height<=1080]/best" --merge-output-format mkv -o "source" %$u% 
set src="source"
for %%I IN (%src%) do set src=%%~fI
goto :eof
cls
#>