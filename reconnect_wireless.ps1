# PowerShell Wireless ADB Reconnector
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Wireless ADB Reconnect"

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "       📶 إعادة الاتصال بالموبايل وايرلس (بدون وصلة USB)" -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$adb = Join-Path $scriptDir "adb.exe"
if (-not (Test-Path $adb)) { $adb = "adb" }

$ipFile = Join-Path $scriptDir "phone_ip.txt"
if (-not (Test-Path $ipFile)) {
    Write-Host "❌ لم يتم العثور على IP محفوظ مسبقاً!" -ForegroundColor Red
    Write-Host "من فضلك شغل الملف رقم (1_تفعيل_الوايرلس_لأول_مرة_بالوصلة.bat) أولاً وأنت موصل الكابل لمرة واحدة."
    Write-Host ""
    Read-Host "اضغط Enter للخروج..."
    exit
}

$phoneIp = (Get-Content -Path $ipFile).Trim()
Write-Host "🔄 جاري الاتصال بالموبايل على العنوان: ${phoneIp}:5555 ..." -ForegroundColor Yellow

$connectResult = & $adb connect "${phoneIp}:5555"
Write-Host $connectResult -ForegroundColor Gray
Write-Host ""

$devicesOutput = & $adb devices
Write-Host $devicesOutput -ForegroundColor White

Write-Host ""
Write-Host "========================================================================" -ForegroundColor Green
Write-Host "  ✅ إذا رأيت جهازك أعلاه وبجانبه كلمة 'device':" -ForegroundColor Green
Write-Host "     فالموبايل متصل الآن بالـ Antigravity IDE وتقدر تعمل Run وايرلس فوراً!" -ForegroundColor White
Write-Host "========================================================================" -ForegroundColor Green
Write-Host ""
Start-Sleep -Seconds 3
