@echo off
chcp 65001 >nul
echo جاري قطع الاتصال اللاسلكي...
adb disconnect >nul 2>&1
taskkill /F /IM scrcpy.exe >nul 2>&1
echo تم إيقاف الاتصال اللاسلكي بنجاح ✅
timeout /t 2 >nul
