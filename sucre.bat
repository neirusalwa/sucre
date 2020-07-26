<# : sucre.bat
@echo off
@chcp 65001 >nul
title sucre
set "errn=0"
set PATH=%PATH%;%~dp0
where ffmpeg.exe >nul 2>nul
where ffprobe.exe >nul 2>nul
where gifski.exe >nul 2>nul
if not %errorlevel% geq 0 call :err_%errn%
echo requirements met
if exist "runes" set PATH=%PATH%;%~dp0;%~dp0runes >nul 2>nul 
set root=%~dp0runes
set dl=0
set target=8000000
set src=%~1
if exist "%src%" call :probe
call ytdl.bat 2>nul
call :probe

:err_0
cls
echo critical error %errn%
echo no source detected, this script is drag and drop only
pause
exit

:err_1
cls
echo critical error %errn%
echo ffmpeg, ffprobe or gifski is missing
pause
exit

:err_2
cls
echo critical error %errn%
echo something happened during the process please try again
pause
exit

:err_3
cls
echo error %errn%
echo the optimised gif has been made regardless but is over the target size
pause
exit

:probe
cls
set $src="%src%"
for %%I IN (%$src%) do set $1=%%~dpI
for %%I IN (%$src%) do set $2=%%~nI
set file=%$1%%$2%.gif
title sucre - analysing "%src%"
for /F "delims=" %%I in ('ffprobe -v error -select_streams v:0 -show_entries stream^=avg_frame_rate -of default^=noprint_wrappers^=1:nokey^=1 "%src%" 2^>^&1') do set "f=%%I"
for /F "delims=" %%I in ('ffprobe -v error -select_streams v:0 -sexagesimal -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%src%" 2^>^&1') do set "t=%%I"
for /F "delims=" %%I in ('ffprobe -v error -select_streams v:0 -show_entries stream^=height -of default^=noprint_wrappers^=1:nokey^=1 "%src%" 2^>^&1') do set "h=%%I"
for /F "delims=" %%I in ('ffprobe -v error -select_streams v:0 -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1 "%src%" 2^>^&1') do set "w=%%I"
cd %root%
set axis=h
if %h% geq %w% set axis=v
set /a "f=%f%+%f%%%2"
if %f% geq 50 set f=50
set $w=%w%
set $h=%h%
call profiles.bat 2>nul && call :enc 2>nul
call :%axis%

:h
set h=-1
if %w% geq 400 set w=400
call :enc

:v
if %h% geq 300 set h=300
set w=-1
call :enc

:enc
set "s=-ss 0"
set "t=-t %t%"
call seek.bat 2>nul
if "%w%" == "%$w%" set w=-1
if "%h%" == "%$h%" set h=-1
title sucre - exploding "%file%"
call :$enc
if exist "%file%" call :done
set "errn=1"
call :err_%errn% 2>nul

:$enc
md _temp & cls
ffmpeg  %s% -hwaccel auto -i "%src%" %t% -vsync vfr -r %f% -vf "scale=%w%:%h%:flags=lanczos" "_temp\frames%%04d.png"
title sucre - assembling "%file%"
gifski --fps %f% -o "%file%" _temp\frames*.png
goto :eof

:clean
del /q "%src%"
goto:eof

:done
cls
rd /s /q _temp
if %dl% equ 1 call :clean
echo the gif has successfully been made
pause
call sicle.bat 2>nul
pause
exit
#>