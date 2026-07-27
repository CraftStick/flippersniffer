# 🐬 FlipperSniffer V1.0

## 🇬🇧 English

BadUSB payload for Flipper Zero that collects system and network information from a Windows machine and displays it in a styled terminal interface with animations.

> ⚠️ **For educational and authorized testing purposes only.**

### 📋 What it collects

| Section | Details |
|---------|---------|
| 🖥️ **System** | Hostname, username, domain/workgroup, OS, uptime, RAM, CPU |
| 💾 **Disks** | All local drives — total size and free space |
| 🌐 **Network** | Public IP, local IP, MAC, gateway, all active adapters |
| 📶 **Wi-Fi** | Current SSID, BSSID, signal strength |
| 🔑 **Wi-Fi passwords** | All saved profiles with plaintext passwords (where accessible) |
| 📋 **Clipboard** | Current clipboard contents |
| 📁 **Recent files** | Last 3 opened files |
| 🛡️ **Security** | Installed AV products, Windows Defender RTP status |
| ⚙️ **Processes** | Top 7 processes by CPU usage |

### ✨ Features

- ASCII banner with color animation on startup
- Spinner animations between sections
- Styled section headers and summary box at the end
- Base64 payload split into 3 chunks — prevents Flipper from freezing
- Compatible with **Windows PowerShell 5.1**
- No files written to disk

### 🚀 Usage

1. Copy `system_sniffer_v1.0.txt` to `/badusb/` on your Flipper Zero SD card
2. On Flipper: **BadUSB** → select file → plug into target Windows machine
3. Make sure the target machine has **English keyboard layout active**

> **Wi-Fi passwords** are accessible without admin rights if the current user is in the **Administrators** group (common on personal PCs). Otherwise shows `<admin required>`.

### 📦 Requirements

- Flipper Zero with BadUSB support
- Target: Windows 10 / 11, PowerShell 5.1+

### ⚖️ Disclaimer

For **authorized security testing and educational purposes only.**
Using against systems you don't own or have explicit permission to test is illegal.

---

## 🇷🇺 Русский

BadUSB-пейлоад для Flipper Zero, который собирает системную и сетевую информацию с Windows-машины и выводит её в стилизованном терминале с анимацией.

> ⚠️ **Только для образовательных целей и авторизованного тестирования.**

### 📋 Что собирает

| Раздел | Данные |
|--------|--------|
| 🖥️ **Система** | Имя компьютера, пользователь, домен/воркгруп, ОС, аптайм, RAM, CPU |
| 💾 **Диски** | Все локальные диски — объём и свободное место |
| 🌐 **Сеть** | Публичный IP, локальный IP, MAC, шлюз, все активные адаптеры |
| 📶 **Wi-Fi** | Текущий SSID, BSSID, уровень сигнала |
| 🔑 **Пароли Wi-Fi** | Все сохранённые профили с паролями (где доступно) |
| 📋 **Буфер обмена** | Текущее содержимое clipboard |
| 📁 **Недавние файлы** | Последние 3 открытых файла |
| 🛡️ **Безопасность** | Установленные антивирусы, статус Defender RTP |
| ⚙️ **Процессы** | Топ 7 процессов по загрузке CPU |

### ✨ Особенности

- ASCII-баннер с цветной анимацией при запуске
- Спиннеры между разделами
- Стилизованные заголовки секций и итоговый блок
- Base64-пейлоад разбит на 3 части — Flipper не зависает при вводе
- Совместимость с **Windows PowerShell 5.1**
- Ничего не записывается на диск

### 🚀 Использование

1. Скопируй `system_sniffer_v1.0.txt` в папку `/badusb/` на SD-карте Flipper Zero
2. На Flipper: **BadUSB** → выбери файл → подключи к целевой Windows-машине
3. Убедись что на целевой машине **активна английская раскладка**

> **Пароли Wi-Fi** доступны без прав администратора, если текущий пользователь состоит в группе **Administrators** (обычно так на домашних ПК). В противном случае выводится `<admin required>`.

### 📦 Требования

- Flipper Zero с поддержкой BadUSB
- Цель: Windows 10 / 11, PowerShell 5.1+

### ⚖️ Дисклеймер

Только для **авторизованного тестирования безопасности и образовательных целей.**
Использование против систем, которыми вы не владеете или не имеете явного разрешения на тестирование, является незаконным.

---

<div align="center">

Если было полезно — поставь ⭐, это очень помогает!

If you found this useful, consider leaving a ⭐ — it helps a lot!

</div>
