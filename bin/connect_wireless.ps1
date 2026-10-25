# PowerShell Smart Wireless ADB Connector
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Wireless Phone ADB Connector"

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "             Wireless ADB Auto-Connect (One-Click Tool)" -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$adb = Join-Path $scriptDir "adb.exe"
if (-not (Test-Path $adb)) { $adb = "adb" }

$ipFile = Join-Path $scriptDir "phone_ip.txt"

# 1. Check if a device is already connected wirelessly
Write-Host "[1/3] Checking current ADB connection status..." -ForegroundColor Yellow
$devicesOutput = & $adb devices
$alreadyWireless = $false

foreach ($line in ($devicesOutput -split "`r?`n")) {
    $line = $line.Trim()
    if ($line -match ':\d+\s+device$') {
        $alreadyWireless = $true
        $wirelessDevice = ($line -split '\s+')[0]
        break
    }
}

if ($alreadyWireless) {
    Write-Host "[OK] Phone is already connected wirelessly: $wirelessDevice" -ForegroundColor Green
    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host "  Success! Your phone is active and ready for Flutter/IDE debugging." -ForegroundColor Green
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host ""
    Read-Host "Press Enter to exit..."
    exit
}

# 2. Try connecting via saved IP (Wireless without cable)
$phoneIp = $null
if (Test-Path $ipFile) {
    $savedIp = (Get-Content -Path $ipFile).Trim()
    if ($savedIp -match '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$') {
        Write-Host "[2/3] Trying to connect to saved IP ($savedIp)..." -ForegroundColor Yellow
        $res = & $adb connect "${savedIp}:5555"
        if ($res -match "connected to") {
            $phoneIp = $savedIp
            Write-Host "[OK] Connected wirelessly to $phoneIp:5555" -ForegroundColor Green
        }
    }
}

# 3. If wireless connect didn't work, check for USB device to setup/refresh
if (-not $phoneIp) {
    Write-Host "[2/3] Checking for phone connected via USB cable..." -ForegroundColor Yellow
    $usbDevice = $null
    $devicesOutput = & $adb devices

    foreach ($line in ($devicesOutput -split "`r?`n")) {
        $line = $line.Trim()
        if ($line -and -not ($line.StartsWith("List")) -and ($line -match '\s+device$')) {
            $serial = ($line -split '\s+')[0]
            if (-not ($serial.Contains(":")) -and -not ($serial.StartsWith("emulator-"))) {
                $usbDevice = $serial
                break
            }
        }
    }

    if ($usbDevice) {
        Write-Host "[OK] Found USB phone: $usbDevice" -ForegroundColor Green
        Write-Host "[3/3] Retrieving phone Wi-Fi IP address..." -ForegroundColor Yellow

        $ipRoute = & $adb -s $usbDevice shell "ip route"
        foreach ($line in ($ipRoute -split "`r?`n")) {
            if ($line -match 'wlan0.*src\s+([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)') {
                $phoneIp = $matches[1]
                break
            }
        }

        if (-not $phoneIp) {
            $ipAddr = & $adb -s $usbDevice shell "ip -f inet addr show wlan0"
            if ($ipAddr -match 'inet\s+([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)') {
                $phoneIp = $matches[1]
            }
        }

        if ($phoneIp) {
            Write-Host "[OK] Detected phone IP: $phoneIp" -ForegroundColor Green
            Set-Content -Path $ipFile -Value $phoneIp -Encoding UTF8

            Write-Host "Enabling TCP/IP Mode (Port 5555)..." -ForegroundColor Yellow
            & $adb -s $usbDevice tcpip 5555
            Start-Sleep -Seconds 2

            Write-Host "Connecting wirelessly to ${phoneIp}:5555 ..." -ForegroundColor Yellow
            $res = & $adb connect "${phoneIp}:5555"
            Write-Host $res -ForegroundColor Gray
        }
    }
}

# 4. If still not connected, prompt manual IP
if (-not $phoneIp) {
    Write-Host ""
    Write-Host "[!] Phone not connected via USB and saved wireless IP unreachable." -ForegroundColor Yellow
    $userInput = Read-Host "Enter your phone Wi-Fi IP manually (or plug USB cable and press Enter to retry)"
    if ($userInput -match '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$') {
        $phoneIp = $userInput.Trim()
        Set-Content -Path $ipFile -Value $phoneIp -Encoding UTF8
        Write-Host "Connecting to ${phoneIp}:5555 ..." -ForegroundColor Yellow
        $res = & $adb connect "${phoneIp}:5555"
        Write-Host $res -ForegroundColor Gray
    }
}

# Final Verification
Write-Host ""
$finalDevices = & $adb devices
$isConnected = $false
foreach ($line in ($finalDevices -split "`r?`n")) {
    if ($line -match ':\d+\s+device$') {
        $isConnected = $true
        break
    }
}

if ($isConnected) {
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host "  [OK] WIRELESS CONNECTION SUCCESSFUL!" -ForegroundColor Green
    Write-Host ""
    Write-Host "  * You can UNPLUG the USB cable now completely." -ForegroundColor White
    Write-Host "  * Your device is visible in Flutter / Antigravity IDE / VS Code." -ForegroundColor White
    Write-Host "  * Next time, just click Connect_Wireless.bat without any cables!" -ForegroundColor White
    Write-Host "========================================================================" -ForegroundColor Green
} else {
    Write-Host "========================================================================" -ForegroundColor Red
    Write-Host "  [X] Connection could not be established." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Make sure:" -ForegroundColor Yellow
    Write-Host "  1. Phone and PC are connected to the SAME Wi-Fi network." -ForegroundColor White
    Write-Host "  2. USB debugging is enabled on your phone." -ForegroundColor White
    Write-Host "  3. Connect USB cable once to initialize wireless mode." -ForegroundColor White
    Write-Host "========================================================================" -ForegroundColor Red
}

Write-Host ""
Read-Host "Press Enter to exit..."
