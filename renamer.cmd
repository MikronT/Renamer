@echo off
chcp 65001>nul

%~d0
cd %~dp0





:start
if not exist filesToRename md filesToRename
cd filesToRename

for /f "delims=" %%i in ('dir /a:-d /b') do set fileName_before_withExtension=%%i
set fileName_before=%fileName_before_withExtension%





call :logo
set /p filename_prefix=^(^>^) Enter prefix ^> 
set /p filename_suffix=^(^>^) Enter suffix ^> 



call :logo
echo.^(i^) Changes:
echo.    - before: %fileName_before%
echo.    - after:  %filename_prefix%%fileName_before%%filename_suffix%
echo.
choice /c yn /n /m "(?) Is all are OK? (Y/N) > "
if "%errorLevel%" == "2" goto :start

for /f "delims=" %%i in ('dir /a:-d /b') do rename "%%i" "%filename_prefix%%%i%filename_suffix%"
exit





:logo
mode con:cols=66 lines=26
title [MikronT] Renamer
color 0b
cls
echo.
echo.
echo.    [MikronT] ==^> Renamer
echo.   =========================
echo.     See other here:
echo.         github.com/MikronT
echo.
echo.
echo.
exit /b