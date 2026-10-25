# WirelessPhoneDev 📶📱

> **One-click Smart Wireless ADB Development Toolkit for Mobile Engineers.** Debug, test, and hot-reload your Flutter, React Native, and Android apps wirelessly over Wi-Fi without cables or terminal commands.

---

## 🌟 Why WirelessPhoneDev?

Developing mobile applications with a physically connected USB cable often leads to:
* Wobbly, worn-out USB ports and disconnected debug sessions upon moving the device.
* Cluttered desks and awkward testing of sensors, camera, or orientation.
* Tedious manual terminal commands (`adb tcpip 5555`, finding the IP in Android settings, `adb connect <ip>:5555`).

**WirelessPhoneDev** automates everything into **ONE SINGLE BUTTON / CLICK**. It auto-detects your state:
- If your phone was previously paired, it connects wirelessly in seconds without any cables.
- If it's your first time or your IP changed, plugging the cable once auto-detects the Wi-Fi IP, opens port 5555, connects wirelessly, and tells you to unplug the cable!

---

## 🚀 Key Features

* **⚡ Smart 1-Button Execution (`Connect_Wireless.bat`)**: Intelligent auto-detection handles both first-time pairing and instant daily cable-free reconnection.
* **🔄 Zero Cable Needed on Daily Use**: Double-click `Connect_Wireless.bat` and start coding.
* **🎯 Full IDE Compatibility**:
  * **Flutter**: Run `flutter run`, Hot Reload (`r`), Hot Restart (`R`) wirelessly.
  * **Android Studio**: Device appears automatically in the Target Devices dropdown.
  * **VS Code**: Detected immediately by Flutter & Dart extensions.
  * **React Native**: Supports `npx react-native run-android`.
* **🔒 Privacy & Security**:
  * Zero personal data, no hardcoded IPs or serials.
  * Local IP settings (`phone_ip.txt`) are excluded from Git via `.gitignore`.
* **📦 Fully Portable & Standalone**: Contains embedded ADB binaries; zero external servers, background daemons, or python installations required.

---

## 📋 Prerequisites

1. **Windows 10 or Windows 11**.
2. **Android Smartphone** (Android 8.0 through Android 16+).
3. **Wi-Fi Connection**: PC and Phone must be connected to the same local Wi-Fi network.
4. **USB Debugging Enabled**:
   * `Settings` → `About phone` → Tap `Build number` 7 times.
   * `Settings` → `Developer options` → Enable **USB Debugging**.

---

## 🛠️ Step-by-Step Usage

### 🖱️ One Single Click: `Connect_Wireless.bat`
1. Double-click **`Connect_Wireless.bat`**.
2. **First Time Setup**:
   - Plug the phone via USB cable once.
   - The script detects the phone, extracts its Wi-Fi IP, enables wireless ADB (Port 5555), and connects wirelessly.
   - **Unplug the cable immediately!**
3. **Daily Reconnect**:
   - Make sure your PC and phone are on the same Wi-Fi.
   - Double-click **`Connect_Wireless.bat`** (no cable needed).
   - You're connected in under 2 seconds!

### 🛑 Disconnect: `Disconnect_Wireless.bat`
* Double-click **`Disconnect_Wireless.bat`** whenever you want to terminate the wireless ADB session cleanly.

---

## 📂 Project Structure

```
WirelessPhoneDev/
├── Connect_Wireless.bat     # Smart 1-Click launcher (Auto-pairs / Auto-reconnects)
├── Disconnect_Wireless.bat  # Cleanly disconnects wireless ADB sessions
├── connect_wireless.ps1     # Core auto-discovery and wireless engine
├── adb.exe & DLLs           # Embedded portable ADB runtime
└── README.md                # Documentation
```
