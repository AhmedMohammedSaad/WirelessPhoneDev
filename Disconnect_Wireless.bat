@echo off
title Disconnect Wireless Phone
echo ===================================================
echo        Disconnecting Wireless ADB Devices
echo ===================================================
"%~dp0bin\adb.exe" disconnect
echo.
echo Current ADB Devices:
"%~dp0bin\adb.exe" devices
echo.
echo Done.
pause
