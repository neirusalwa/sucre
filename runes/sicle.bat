<# : sicle.bat
@echo off
@chcp 65001 >nul
title module : sicle
cls
set "try=1"
set "loss=25"
set $file="%file%"
for %%I IN (%$file%) do set size=%%~zI
if %size% leq %target% (
    echo the gif doesnt require compression
    goto :eof
)
for %%I IN (%$file%) do set $1=%%~dpI
for %%I IN (%$file%) do set $2=%%~nI
set fileout=%$1%%$2%.0.gif
echo attempt number %try%, compression %loss%
echo output will have the .0.gif extension

:loop
if %try% gtr 5 call :retry
gifsicle -O3 --lossy=%loss% "%file%" -o "%fileout%"
set /a "try+=1"
if %try% gtr 8 (
    set "errn=3"
    if %try% gtr 8 call :err_%errn%
)
set /a "loss+=25"
for %%I IN ("%fileout%") do set sizeout=%%~zI
if %sizeout% gtr %target% (
    cls
    goto loop
) else (
    cls
    echo the compressed gif has successfully been made
    goto :eof
)
cls
#>