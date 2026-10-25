# PowerShell Wireless ADB Reconnector
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Wireless ADB Reconnect"

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "       [+] اعادة الاتصال بالموبايل وايرلس (بدون كابل USB)" -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$adb = Join-Path $scriptDir "adb.exe"
if (-not (Test-Path $adb)) { $adb = "adb" }

$ipFile = Join-Path $scriptDir "phone_ip.txt"
$phoneIp = $null

if (Test-Path $ipFile) {
    $phoneIp = (Get-Content -Path $ipFile).Trim()
}

if (-not $phoneIp) {
    Write-Host "[!] لم يتم العثور على IP محفوظ مسبقا." -ForegroundColor Yellow
    $userInput = Read-Host "ادخل عنوان IP الموبايل (مثال: 192.168.1.50)"
    if ($userInput -match '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$') {
        $phoneIp = $userInput.Trim()
        Set-Content -Path $ipFile -Value $phoneIp -Encoding UTF8
    } else {
        Write-Host "[X] عنوان IP غير صالح!" -ForegroundColor Red
        Read-Host "اضغط Enter للخروج..."
        exit
    }
}

Write-Host "جاري الاتصال بالموبايل على العنوان: ${phoneIp}:5555 ..." -ForegroundColor Yellow
$connectResult = & $adb connect "${phoneIp}:5555"
Write-Host $connectResult -ForegroundColor Gray
Write-Host ""

$devicesOutput = & $adb devices
Write-Host $devicesOutput -ForegroundColor White

Write-Host ""
if ($connectResult -match "connected to") {
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host "  [OK] تم الاتصال بالهاتف وايرلس بنجاح!" -ForegroundColor Green
    Write-Host "  تقدر تعمل Run / Debug للتطبيق مباشرة من الـ IDE." -ForegroundColor White
    Write-Host "========================================================================" -ForegroundColor Green
} else {
    Write-Host "========================================================================" -ForegroundColor Yellow
    Write-Host "  [!] اذا فشل الاتصال، تاكد من:" -ForegroundColor Yellow
    Write-Host "  1. الموبايل والكمبيوتر على نفس شبكة الـ Wi-Fi." -ForegroundColor White
    Write-Host "  2. الموبايل لم يقم بتغيير عنوان الـ IP." -ForegroundColor White
    Write-Host "  3. اذا تم اعادة تشغيل الموبايل، يلزم توصيل الكابل وتشغيل السكربت الاول مرة واحدة." -ForegroundColor White
    Write-Host "========================================================================" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "اضغط Enter للخروج..."
