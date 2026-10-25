# WirelessPhoneDev 📶📱

> **One-click Smart Wireless ADB & Screen Mirroring Toolkit for Mobile Engineers.** Debug, test, hot-reload, and mirror your Flutter, React Native, and Android apps wirelessly over Wi-Fi without cables or terminal commands.

[![Download Ready-to-Use Release](https://img.shields.io/badge/Download-Ready--to--Use%20v1.0.0-brightgreen?style=for-the-badge&logo=windows)](https://github.com/AhmedMohammedSaad/WirelessPhoneDev/releases/tag/v1.0.0)

---

## 📥 Download & Quick Start (For End-Users)
You don't need to clone or configure any code. Just download the ready-to-run package:
1. **[Download Latest Release (ZIP)](https://github.com/AhmedMohammedSaad/WirelessPhoneDev/releases/tag/v1.0.0)**
2. Extract the ZIP file anywhere on your PC.
3. Double-click `Connect_Wireless.bat` and start coding!

## 🌟 Clean, Zero-Clutter Architecture

The root folder has been organized with a clean, focused user interface containing **only 3 launch icons**:

```
WirelessPhoneDev/
├── 🟢 Connect_Wireless.bat     # Smart 1-Click launcher (Auto-pairs / Auto-reconnects)
├── 🔴 Disconnect_Wireless.bat  # Cleanly disconnects wireless ADB sessions
├── 📱 Mirror_Screen.bat        # Wireless screen mirror (Zero-lag, high FPS via scrcpy)
│
├── bin/                        # Internal binaries, ADB, scrcpy, and helper scripts
└── README.md                   # Documentation
```

All backend DLLs, ADB runtimes, and scripts are neatly contained inside `bin/` so you never have to deal with clutter.

---

## 🚀 Key Features

* **⚡ Smart 1-Button Connect (`Connect_Wireless.bat`)**: 
  - If already connected, confirms status immediately.
  - If previously paired, reconnects wirelessly over Wi-Fi in ~1 second (no cable needed).
  - If first-time or IP changed, connecting the USB cable once automatically extracts the IP, opens port 5555, connects wirelessly, and tells you to unplug the cable!
* **📱 Wireless Screen Mirroring (`Mirror_Screen.bat`)**:
  - Mirrors your phone screen to your PC wirelessly with ultra-low latency.
  - No need for third-party apps like Vysor or paid subscriptions.
  - Mouse clicks and typing on your PC interact with your phone directly!
* **🛑 Clean Disconnect (`Disconnect_Wireless.bat`)**:
  - Disconnects all wireless sessions cleanly when your work is finished.
* **🎯 Full IDE Compatibility**:
  - **Flutter**: Full wireless Hot Reload (`r`) and Hot Restart (`R`).
  - **Android Studio / VS Code**: Detected immediately as a native device.
* **🔒 100% Private**:
  - No personal data or IP addresses tracked or committed to Git.

---

## 📋 Prerequisites

1. **Windows 10 or Windows 11**.
2. **Android Smartphone** (Android 8.0 through Android 16+).
3. **Same Wi-Fi Network**: PC and Phone must be connected to the same Wi-Fi.
4. **USB Debugging Enabled**:
   - `Settings` → `About phone` → Tap `Build number` 7 times.
   - `Settings` → `Developer options` → Enable **USB Debugging**.

---

## 🛠️ How to Use

### 1. Connect Wirelessly
* Double-click **`Connect_Wireless.bat`**.
* Connect via USB once if it's the very first time, then unplug the cable when prompted.

### 2. Mirror Phone on Screen
* Double-click **`Mirror_Screen.bat`**.
* Your phone screen will appear on your desktop with zero latency. You can interact with it using your mouse and keyboard!

### 3. Disconnect
* Double-click **`Disconnect_Wireless.bat`** when you want to end the session.
