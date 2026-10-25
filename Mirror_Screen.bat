@echo off
title Phone Screen Mirror
echo ===================================================
echo             Phone Screen Mirror
echo ===================================================
cd /d "%~dp0bin"
scrcpy.exe --stay-awake --window-title "Phone Mirror"
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [!] Unable to start screen mirror.
    echo Please make sure your phone is connected by running Connect_Wireless.bat first.
    echo.
    pause
)
