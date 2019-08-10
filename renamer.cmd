@echo off
chcp 65001>nul

%~d0
cd %~dp0

set app_name=Renamer

set getFileNames=call :getFileNames



setlocal EnableDelayedExpansion

:main
set fileName_prefix=
set fileName_suffix=
set fileName_find=
set fileName_replace=



call :logo
echo.^(^?^) Select option:
echo.    ^(1^) Add
echo.    ^(2^) Find and Replace
echo.
echo.
echo.
choice /c 12 /n /m " > "



if "%errorLevel%" == "1" (
  set /p fileName_prefix=^(^>^) Enter addition prefix ^> 
  set /p fileName_suffix=^(^>^) Enter addition suffix ^> 
  set change=add
)
if "%errorLevel%" == "2" (
  set /p fileName_find=^(^>^) Enter search keyworld ^> 
  set /p fileName_replace=^(^>^) Enter replacement ^> 
  set change=replace
)



%getFileNames%



call :logo
echo.^(i^) Changes:
echo.
echo.

set counter=0
for /f "tokens=1,2,* delims=;" %%i in (temp\fileNames) do (
  set /a counter+=1
  if !counter! LEQ 5 echo.     %%i   ==^>   %%j
)

echo.
echo.
echo.
choice /c yn /n /m "(?) Are all OK? (Y/N) > "



if "%errorLevel%" == "2" goto :main

for /f "tokens=1,2,* delims=;" %%i in (temp\fileNames) do rename "files\%%i" "%%j"
goto :main









:logo
title [MikronT] Renamer
mode con:cols=110 lines=30
color 0b
cls
echo.
echo.
echo.    [MikronT] ==^> %app_name%
echo.   ━━━━━━━━━━━━━━━━━━━━━━━━━
echo.     See other here:
echo.         github.com/MikronT
echo.
echo.
echo.
exit /b









:getFileNames
if not exist files md files
if not exist temp md temp
for %%i in (temp\fileNames_old temp\fileNames_new temp\fileNames) do if exist "%%i" del /q "%%i"

for /f "delims=" %%i in ('dir /a:-d /b files') do echo.%%i>>temp\fileNames_old

for /f "delims=" %%i in (temp\fileNames_old) do (
  if "%change%" == "add" echo.%fileName_prefix%%%i%fileName_suffix%>>temp\fileNames_new
  if "%change%" == "replace" (
    set fileName_new=%%i
    set "fileName_new=!fileName_new:%fileName_find%=%fileName_replace%!"
    echo.!fileName_new!>>temp\fileNames_new
  )
)

set counter=0
for /f "delims=" %%i in (temp\fileNames_old) do (
  set /a counter+=1
  set fileNames_old[!counter!]=%%i
)
set counter=0
for /f "delims=" %%i in (temp\fileNames_new) do (
  set /a counter+=1
  set fileNames_new[!counter!]=%%i
)
for /l %%i in (1,1,%counter%) do call echo.!fileNames_old[%%i]!;!fileNames_new[%%i]!>>temp\fileNames
exit /b