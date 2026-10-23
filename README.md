# WirelessPhoneDev 📶📱

> **One-click Wireless ADB Development Toolkit for Mobile Engineers.** Debug, test, and hot-reload your Flutter, React Native, and Android apps wirelessly over Wi-Fi without cables or terminal commands.

---

## 🌟 Why WirelessPhoneDev?

Developing mobile applications with a physically connected USB cable often leads to:
* Wobbly, worn-out USB ports and disconnected debug sessions upon moving the device.
* Cluttered desks and awkward testing of sensors, camera, or orientation.
* Tedious manual terminal commands (`adb tcpip 5555`, finding the IP in Android settings, `adb connect <ip>:5555`).

**WirelessPhoneDev** automates the entire process into **one single click**. It automatically detects your phone, fetches its Wi-Fi IP, opens the wireless ADB port, and pairs it with your computer. Once paired, you can unplug the cable and develop completely wirelessly!

---

## 🚀 Key Features

* **⚡ 1-Click Initial Pairing**: Connect your cable once, double-click `1_تفعيل_الوايرلس_لأول_مرة_بالوصلة.bat`, and unplug your cable immediately.
* **🔄 1-Click Cable-Free Reconnect**: Returning the next day? Double-click `2_إعادة_الاتصال_الوايرلس_بدون_وصلة.bat` to reconnect instantly without touching any cables.
* **🎯 Full IDE Compatibility**:
  * **Flutter**: Run `flutter run`, Hot Reload (`r`), Hot Restart (`R`) wirelessly.
  * **Android Studio**: Device appears automatically in the Target Devices dropdown.
  * **VS Code**: Detected immediately by Flutter & Dart extensions.
  * **React Native**: Supports `npx react-native run-android`.
* **🔒 Privacy & Security**:
  * Zero personal data, no hardcoded IPs or serials.
  * Network settings (`phone_ip.txt`) are excluded from Git via `.gitignore`.
* **📦 Fully Portable**: Includes embedded, pre-configured ADB binaries and runtimes.

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

### Step 1: Initial Setup (Only done once with cable)
1. Plug your phone into your PC via USB cable.
2. Accept the **"Allow USB Debugging"** dialog on your phone screen.
3. Double-click **`1_تفعيل_الوايرلس_لأول_مرة_بالوصلة.bat`**.
4. The script will find your phone, grab its local IP, configure port 5555, and connect wirelessly.
5. **Unplug your USB cable!** Your phone is now fully wireless.

### Step 2: Develop Wirelessly
* Open **Android Studio**, **VS Code**, or **Antigravity IDE**.
* Your phone will show up in your device list (e.g., `192.168.x.x:5555`).
* Press **Run** or **Debug** — it works just as fast as a cable!

### Step 3: Reconnecting Later (No cables ever needed)
* Whenever you turn on your PC or want to re-establish the connection:
* Make sure phone and PC are on the same Wi-Fi.
* Double-click **`2_إعادة_الاتصال_الوايرلس_بدون_وصلة.bat`**.
* Connected in under 2 seconds!

---

## 📂 Project Structure

```
WirelessPhoneDev/
├── 1_تفعيل_الوايرلس_لأول_مرة_بالوصلة.bat    # Batch launcher for initial wireless pairing
├── 2_إعادة_الاتصال_الوايرلس_بدون_وصلة.bat   # Batch launcher for cable-free reconnect
├── setup_wireless.ps1                     # PowerShell core setup & auto-IP discovery
├── reconnect_wireless.ps1                 # PowerShell reconnect script
├── إيقاف_الخدمة.bat                       # Disconnects wireless ADB cleanly
├── طريقة_الاستخدام.txt                    # Arabic quick guide
├── adb.exe & DLLs                         # Embedded ADB runtime
└── README.md                              # Documentation
```

---

## 🇪🇬 ملخص سريع بالعربية (Arabic Summary)

**أداة المطورين للربط اللاسلكي بالأندرويد (WirelessPhoneDev):**
* حل مشكلة قطع الأسلاك والتوصيل أثناء تطوير التطبيقات وعمل Debug.
* تفعيل الاتصال اللاسلكي بضغطة زر واحدة لأول مرة: الموبايل يلقط الآي بي ويفتح بورت 5555 ويفصل الكابل فوراً.
* إعادة الاتصال في أي وقت بدون كابل نهائياً بضغطة واحدة.
* متوافق 100% مع Flutter, Android Studio, VS Code مع دعم كامل للـ Hot Reload اللاسلكي.


