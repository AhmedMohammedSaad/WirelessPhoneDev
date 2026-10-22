# PowerShell Wireless ADB Activator
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Wireless ADB Setup"

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "       📶 أداة تفعيل اتصال الموبايل وايرلس (Wireless ADB)" -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$adb = Join-Path $scriptDir "adb.exe"
if (-not (Test-Path $adb)) { $adb = "adb" }

Write-Host "[1/4] جاري البحث عن الهاتف المتصل بكابل USB..." -ForegroundColor Yellow
$devicesOutput = & $adb devices
$usbDevice = $null

foreach ($line in ($devicesOutput -split "`r?`n")) {
    $line = $line.Trim()
    if ($line -and -not ($line.StartsWith("List")) -and ($line -match "\s+device$")) {
        $serial = ($line -split "\s+")[0]
        # تجاهل الأجهزة المتصلة وايرلس مسبقاً والإيموليتور
        if (-not ($serial.Contains(":")) -and -not ($serial.StartsWith("emulator-"))) {
            $usbDevice = $serial
            break
        }
    }
}

if (-not $usbDevice) {
    Write-Host ""
    Write-Host "❌ لم يتم العثور على هاتف متصل بالوصلة!" -ForegroundColor Red
    Write-Host "من فضلك وصل الموبايل بالوصلة وتأكد من تفعيل USB Debugging ثم أعد المحاولة."
    Write-Host ""
    Read-Host "اضغط Enter للخروج..."
    exit
}

Write-Host "✅ تم العثور على الهاتف برقم: $usbDevice" -ForegroundColor Green
Write-Host ""

Write-Host "[2/4] جاري استخراج عنوان IP الموبايل..." -ForegroundColor Yellow
$ipRoute = & $adb -s $usbDevice shell "ip route"
$phoneIp = $null

foreach ($line in ($ipRoute -split "`r?`n")) {
    if ($line -match "wlan0.*src\s+([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)") {
        $phoneIp = $matches[1]
        break
    }
}

if (-not $phoneIp) {
    # طريقة بديلة لجلب الـ IP
    $ipAddr = & $adb -s $usbDevice shell "ip -f inet addr show wlan0"
    if ($ipAddr -match "inet\s+([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)") {
        $phoneIp = $matches[1]
    }
}

if (-not $phoneIp) {
    Write-Host ""
    Write-Host "❌ تعذر معرفة عنوان IP الموبايل تلقائياً!" -ForegroundColor Red
    Write-Host "تأكد أن الموبايل واللابتوب متصلان بنفس شبكة الـ Wi-Fi."
    Write-Host ""
    Read-Host "اضغط Enter للخروج..."
    exit
}

Write-Host "✅ عنوان IP الموبايل هو: $phoneIp" -ForegroundColor Green
Set-Content -Path (Join-Path $scriptDir "phone_ip.txt") -Value $phoneIp -Encoding UTF8

Write-Host ""
Write-Host "[3/4] تفعيل منفذ الاتصال اللاسلكي (TCP/IP Port 5555)..." -ForegroundColor Yellow
& $adb -s $usbDevice tcpip 5555
Start-Sleep -Seconds 2

Write-Host ""
Write-Host "[4/4] جاري الاتصال بالموبايل وايرلس..." -ForegroundColor Yellow
$connectResult = & $adb connect "${phoneIp}:5555"
Write-Host $connectResult -ForegroundColor Gray

Write-Host ""
Write-Host "========================================================================" -ForegroundColor Green
Write-Host "  🎉 مبروك يا هندسة! تم ربط الموبايل وايرلس بنجاح!" -ForegroundColor Green
Write-Host ""
Write-Host "  👉 تقدر تفصل وصلة الـ USB دلوقتي تماماً!" -ForegroundColor White
Write-Host "  👉 افتح Antigravity IDE أو Android Studio أو VS Code هتلاقي جهازك" -ForegroundColor White
Write-Host "     ظاهر في قائمة الـ Devices وتقدر تعمل Run / Debug و Hot Reload عادي جداً!" -ForegroundColor White
Write-Host "========================================================================" -ForegroundColor Green
Write-Host ""
Read-Host "اضغط Enter للخروج..."
