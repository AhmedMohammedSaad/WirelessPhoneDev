@echo off
cd /d "%~dp0bin"
start "" scrcpy.exe --always-on-top --stay-awake --window-title "Phone Mirror"
exit
