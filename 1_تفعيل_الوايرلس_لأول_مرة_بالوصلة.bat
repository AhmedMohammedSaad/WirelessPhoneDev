@echo off
chcp 65001 >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup_wireless.ps1"
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo حدث خطأ أثناء تشغيل الأداة.
    pause
)
