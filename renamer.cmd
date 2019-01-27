@echo off
chcp 65001>nul

net session>nul 2>nul
if %errorLevel% GEQ 1 goto :startAsAdmin

%~d0
cd %~dp0

if not exist files md files
cd files





:start
call :logo

set /p prefix=^(^>^) Enter Prefix ^> 
set /p suffix=^(^>^) Enter Suffix ^> 

echo.
echo.^(^i^) New Files Names: %prefix% FileName %suffix%
set answer=null
set /p answer=^(?^) All is OK? ^(y/n^) ^> 
if "%answer%" NEQ "y" goto start

for %%i in (*) do rename "%%i" "%prefix% %%i %suffix%"
exit





:logo
mode con:cols=46 lines=18
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





:startAsAdmin
echo.^(^!^) Please, run as Admin^!
timeout /nobreak /t 3 >nul
exit