# Flipper Zero: System & Wi-Fi Sniffer Script

A PowerShell-based system and network information gathering script designed for **educational and authorized testing purposes only**. This script collects basic system, network, and Wi-Fi details from a Windows machine.

> ⚠️ **Disclaimer:** This tool is provided for educational and legitimate security assessment purposes only. The author is **not responsible** for any misuse, damage, or illegal activities conducted with this script. Use only on systems you own or have explicit permission to test.

---

## 📁 Script Overview

This repository contains a PowerShell script that runs via a Flipper Zero BadUSB payload (`system_sniffer.txt`). The script gathers:

- **System Info:** Computer name, username, OS, uptime
- **Network Info:** Public IP, local IP, MAC address, gateway
- **Wi-Fi Info:** Current SSID, BSSID (MAC), signal strength
- **Process Info:** Top 5 processes by CPU usage

> ⚠️ **IMPORTANT:** Currently, the script **does NOT output Wi-Fi passwords** as this requires administrator privileges. UAC/admin rights bypass is under development. If you have information on how to implement this safely and legally — please share via Issues or Pull Requests!

---

## 🚀 How to Use

### 1. Prepare the Flipper Zero
- Copy the content of `system_sniffer.txt` to a `.txt` file on your Flipper Zero SD card under the `badusb` folder.
- Rename the file with a `.txt` extension if needed.

### 2. Execute the Payload
- Plug the Flipper Zero into the target Windows computer.
- Navigate to the BadUSB app on your Flipper.
- Select the `system_sniffer.txt` payload.
- The script will automatically open PowerShell and execute.

### 3. View the Output
- The script runs in a visible PowerShell window.
- Information is displayed in colored sections.
- Press any key to exit when done.

---

## 🔧 How It Works

The script is Base64-encoded within the BadUSB payload to avoid command length limits and improve reliability. It decodes and executes a PowerShell script that:
- Uses native Windows commands (`ipconfig`, `netsh`, `Get-WmiObject`)
- Tries multiple regex patterns to extract network info reliably
- **Does NOT extract Wi-Fi passwords without admin rights** (in current version)
- Displays results in a structured, color-coded format

---

## 🔓 Limitations & Development

### Current Limitations:
1. **Wi-Fi passwords are NOT extracted** — requires administrator privileges
2. **No UAC bypass** in current implementation
3. Basic information gathering only, no privilege escalation

### Planned Improvements:
- UAC bypass for extracting saved Wi-Fi passwords
- Additional system information collection
- Results export to file

**Need help!** If you know safe and legal methods for UAC bypass/obtaining Wi-Fi passwords without admin rights — please share in Issues! This is purely an educational project.

---

## ⚠️ Legal & Ethical Warning

- **Use only on systems you own or have written permission to test.**
- Unauthorized use may violate laws and policies.
- This tool does **NOT hide** itself — it runs in a visible window.
- **Extracting passwords without permission is illegal!**
- The author assumes **NO liability** for any damages or legal issues arising from misuse.

---

## 📸 Example Output

```
=== FLIPPER ZERO, WI-FI & SYSTEM SNIFFER ===
Collecting data...

=== SYSTEM INFO ===
  Computer:          DESKTOP-ABC123
  User:              JohnDoe
  OS:                Windows 10 Pro
  Uptime:            12.5 hr

=== NETWORK INFO ===
  Public IP:          93.184.216.34
  Local IP:           192.168.1.105
  MAC Address:        AA:BB:CC:DD:EE:FF
  Gateway:            192.168.1.1

=== WI-FI INFO ===
  Current Wi-Fi:      MyHomeWiFi
  BSSID (MAC):        AA:BB:CC:11:22:33
  Signal Strength:    85%
  Password:           ADMIN RIGHTS REQUIRED

=== PROCESSES ===
  Top 5 processes by CPU Load:
     chrome.exe         : CPU - 12.5%, RAM - 450.2 MB
     ...

============================
    SUMMARY
     > Computer:       DESKTOP-ABC123
     > User:           JohnDoe
     > Public IP:      93.184.216.34
     > Local IP:       192.168.1.105
     > MAC:            AA:BB:CC:DD:EE:FF
     > Wi-Fi SSID:     MyHomeWiFi
     > Wi-Fi Password: ADMIN RIGHTS REQUIRED
============================
```

---

## 🛡️ Security Notes

- The script does **NOT exfiltrate** data — it only displays it locally
- **Does NOT extract passwords** without explicit administrator rights
- Runs entirely in memory (temp file is deleted after execution)
- All operations are transparent and visible to the user

---

## 🤝 Contributing

Contributions are welcome, especially in:
- Legal information gathering methods
- Regex pattern optimization for network data
- Output readability improvements
- **Safe UAC bypass methods for educational purposes**

---

## 📝 License

This project is for **educational purposes only**. No warranty or support provided. Use at your own risk.

---

## 🙌 Credits

Created for the Flipper Zero community.  
Use responsibly. Stay ethical. Hack the planet — with permission.

---

> ⚠️ **Once again:** Project under development. Wi-Fi password extraction is not implemented due to Windows security requirements. Help improve the project with legal methods!
