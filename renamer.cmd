@echo off
chcp 65001>nul

%~d0
cd %~dp0

set app_name=Renamer
set app_version=v1.0

set getFileNames=call :getFileNames

setlocal EnableDelayedExpansion





:main
set command=

set fileName_prefix=
set fileName_suffix=
set fileName_find=
set fileName_replace=

if not exist files md files



call :logo
echo.^(^?^) Select option:
echo.    ^(1^) Add
echo.    ^(2^) Find and Replace
echo.    ^(3^) Open files directory
echo.
echo.
echo.
set /p command=^> 



if "%command%" == "1" (
  set /p fileName_prefix=^(^>^) Enter addition prefix ^> 
  set /p fileName_suffix=^(^>^) Enter addition suffix ^> 
  set change=add
)
if "%command%" == "2" (
  set /p fileName_find=^(^>^) Enter search keyworld ^> 
  set /p fileName_replace=^(^>^) Enter replacement ^> 
  set change=replace
)
if "%command%" == "3" ( start "" explorer "%~dp0files"
) else (
  %getFileNames%
  goto :changes
)
goto :main









:changes
set command=

call :logo
echo.^(i^) Changes:
echo.

set counter=0
if exist temp\fileNames (
  for /f "tokens=1,2,* delims=;" %%i in (temp\fileNames) do (
    set /a counter+=1
    if !counter! LEQ 5 echo.     %%i   ==^>   %%j
  )
) else echo.    ^(^^!^) No files found^^! Move them into the files directory

echo.
echo.
echo.    ^(1^) Run renaming
echo.    ^(2^) Cancel/Change properties
echo.    ^(3^) Open files directory
echo.
echo.
echo.
set /p command=^> 



if "%command%" == "1" (
  if exist temp\fileNames for /f "tokens=1,2,* delims=;" %%i in (temp\fileNames) do rename "files\%%i" "%%j"
  goto :main
)
if "%command%" == "2" goto :main
if "%command%" == "3" start "" explorer "%~dp0files"
goto :changes









:logo
mode con:cols=110 lines=30
title [MikronT] %app_name% %app_version%
color 0b
cls
echo.
echo.
echo.    [MikronT] ==^> %app_name%
echo.                  %app_version%
echo.   ━━━━━━━━━━━━━━━━━━━━━━━━━
echo.     See other here:
echo.         github.com/MikronT
echo.
echo.
echo.
exit /b









:getFileNames
if not exist temp md temp
for %%i in (temp\fileNames_old temp\fileNames_new temp\fileNames) do if exist "%%i" del /q "%%i"

for /f "delims=" %%i in ('dir /a:-d /b /s files') do (
  set fileName_old=%%i
  set "fileName_old=!fileName_old:%~dp0files\=!"
  echo.!fileName_old!>>temp\fileNames_old
)

if not exist temp\fileNames_old exit /b

for /f "delims=" %%i in (temp\fileNames_old) do (
  set fileName_new=%%i
  set "fileName_new=!fileName_new: =:!"
  set "fileName_new=!fileName_new:\= !"
  for %%z in (!fileName_new!) do set fileName=%%z

  if "%change%" == "add" echo.%fileName_prefix%!fileName!%fileName_suffix%>>temp\fileNames_new
  if "%change%" == "replace" (
    set fileName_new=!fileName!
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