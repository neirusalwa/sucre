<# : profiles.bat
@echo off
@chcp 65001 >nul
title module : profiles
cls
set "mode=0"
echo select the profile you want to use, default is discord
set /p mode=""
goto %mode%%axis%

::discord horizontal
:0h
set h=-1
if %w% geq 400 set w=400
goto :eof

::discord horizontal
:0v
if %h% geq 300 set h=300
set w=-1
goto :eof

::discord horizontal (with target)
:1h
set h=-1
if %w% geq 400 set w=400
set target=8000000
goto :eof

::discord horizontal (with target)
:1v
if %h% geq 300 set h=300
set w=-1
set target=8000000
goto :eof

::twitter horizontal
:2h
if %h% geq 600 set h=600
set w=-1
set target=15000000
goto :eof

::twitter vertical
:2v
set h=-1
if %w% geq 600 set w=600
set target=15000000
goto :eof

::raw
:3h
:3v
set h=-1
set w=-1
goto :eof

cls
goto :eof
#>