@echo off
title Wireless Phone Connect
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0connect_wireless.ps1"
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo An unexpected error occurred.
    pause
)
