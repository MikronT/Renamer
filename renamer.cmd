@echo off
chcp 65001>nul

%~d0
cd %~dp0

if not exist files md files
cd files





:start
call :logo

set /p prefix=(^>) Enter Prefix: 
set /p suffix=(^>) Enter Suffix: 

echo.

echo.^(^!^) New Files Names: %prefix% FileName %suffix%
set answer=null
set /p answer=(?) All is OK? (y/n) ^> 
if "%answer%" NEQ "y" goto start

for %%i in (*) do rename "%%i" "%prefix% %%i %suffix%"
exit





:logo
mode con:cols=46 lines=18
title [MikronT] Renamer
color 0b
cls
echo.
echo.    [MikronT] ==^> Renamer
echo.
exit /b