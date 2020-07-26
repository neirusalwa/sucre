<# : seek.bat
@echo off
@chcp 65001 >nul
title module : seek
cls
set $s=%s%
set $t=%t%
echo set the start point (-ss), ^format is hh:mm:ss.mmm, -1 will ^set it to default
set /p s=""
echo set the duration of the clip from the start point (-t), ^format is hh:mm:ss.mmm, -1 will ^set it to default
set /p t=""
if "%s%" == "-1" (
    set s=%$s%
) else (
    set "s=-ss %s%"
)
if "%t%" == "-1" (
    set t=
) else (
    set "t=-t %t%"
)
cls
goto :eof
#>