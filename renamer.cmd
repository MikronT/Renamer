@echo off
chcp 65001
cd Files



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
title [ADSI] Renamer
color 0b
cls
echo.
echo.    [ADSI] ==^> Renamer
echo.
exit /b