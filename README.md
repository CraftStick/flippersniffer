### English

# 🐬 FlipperSniffer v1 (System & Network Sniffer)

**FlipperSniffer** is an advanced BadUSB/DuckyScript payload designed for execution on Flipper Zero. This script enables fast, automated collection of system information, network data, and sensitive credentials from target Windows machines.

To bypass DuckyScript string length limitations, the payload is split into multiple Base64-encoded fragments (~3.5 KB each). These fragments are reassembled and executed entirely in memory via PowerShell — eliminating the need to download any external files.

## 🚀 Capabilities

The script performs a deep system audit and collects the following data:

* **System Information:** OS version, CPU model, RAM size, username, domain/workgroup, and system uptime.
* **Storage:** List of logical drives with total size and available free space.
* **Network & Connections:**  
  * Public and local IP addresses, MAC address, default gateway.  
  * Active TCP connections mapped to their owning processes.  
  * Local ARP table.  
* **Wi-Fi Audit:** Current network, all visible access points, plus **extraction of saved Wi-Fi profiles and their passwords**.  
* **Browsers (Password Stores):** Decryption of local password databases (via DPAPI/Bcrypt) from popular browsers: Google Chrome, Microsoft Edge, Brave.  
* **SSH & Developer Credentials:** Discovery of public and private SSH keys, plus reading `.gitconfig` files (hunting for tokens and emails).  
* **System Credentials:** Retrieval of saved network passwords from Windows Credential Manager (`cmdkey`).  
* **User Activity:** Clipboard contents and a list of the 15 most recently opened files.  
* **Security & Monitoring:** Detection of installed antivirus software, Windows Defender Real-Time Protection status, and the top 7 processes by CPU usage.

## ⚙️ Installation & Usage

1. Save the script file to your PC (e.g., `sniffer_v3.txt`).
2. Open the qFlipper desktop application.
3. Copy the file to your Flipper Zero's SD card, into the `badusb` folder.
4. Connect your Flipper Zero (unlocked) to a target Windows PC.
5. Launch the script from the BadUSB menu.

**How it works:** The script automatically opens the Run dialog (Win+R), spawns a PowerShell session with an execution policy bypass (`-ExecutionPolicy Bypass`), gathers all data, and saves a comprehensive `.txt` report to the `%TEMP%` directory. For convenience, a basic summary is also copied to the target machine's clipboard.

## 🛡️ Requirements
* Flipper Zero (official firmware or any custom variant supporting BadUSB/DuckyScript).
* Target machine running Windows 10 or 11.
* Default US English keyboard layout on the target PC (required for correct DuckyScript keystroke injection).

## ⚠️ Disclaimer

This project and its associated scripts are provided **for educational purposes and authorized security auditing only**.

The author assumes no liability for any direct or indirect damage, data leakage, or legal violations resulting from the use of this software. Unauthorized use of such tools against systems you do not own or have explicit permission to test is illegal.

---

### Русский

# 🐬 FlipperSniffer v1 (Системный и Сетевой Сниффер)

**FlipperSniffer** — это продвинутый BadUSB/DuckyScript пейлоад, созданный для запуска на Flipper Zero. Скрипт предназначен для быстрого автоматизированного сбора системной информации, сетевых данных и конфиденциальных учетных данных с целевых компьютеров под управлением Windows.

Для обхода ограничений DuckyScript на длину строк, пейлоад разбит на несколько фрагментов в кодировке Base64 (~3.5 КБ каждый). Эти фрагменты собираются и выполняются полностью в памяти через PowerShell, что исключает необходимость загрузки каких-либо внешних файлов.

## 🚀 Возможности

Скрипт проводит глубокий аудит системы и собирает следующие данные:

* **Системная информация:** Версия ОС, модель процессора, объем ОЗУ, имя пользователя, домен/рабочая группа и время работы системы.
* **Хранилище:** Список логических дисков с общим объемом и доступным свободным местом.
* **Сеть и подключения:**  
  * Публичный и локальный IP-адреса, MAC-адрес, основной шлюз.  
  * Активные TCP-соединения с привязкой к процессам.  
  * Локальная ARP-таблица.  
* **Wi-Fi аудит:** Текущая сеть, все видимые точки доступа, а также **извлечение сохраненных профилей Wi-Fi и паролей к ним**.  
* **Браузеры (Хранилища паролей):** Расшифровка локальных баз паролей (через DPAPI/Bcrypt) из популярных браузеров: Google Chrome, Microsoft Edge, Brave.  
* **SSH и учетные данные разработчика:** Поиск публичных и приватных SSH-ключей, а также чтение файлов `.gitconfig` (поиск токенов и email-адресов).  
* **Системные учетные данные:** Извлечение сохраненных сетевых паролей из Windows Credential Manager (`cmdkey`).  
* **Активность пользователя:** Содержимое буфера обмена и список 15 последних открытых файлов.  
* **Безопасность и мониторинг:** Определение установленных антивирусов, статус Windows Defender (защита в реальном времени) и топ-7 процессов по загрузке процессора.

## ⚙️ Установка и использование

1. Сохраните файл скрипта на ваш ПК (например, `sniffer_v3.txt`).
2. Откройте приложение qFlipper на компьютере.
3. Скопируйте файл на SD-карту вашего Flipper Zero в папку `badusb`.
4. Подключите Flipper Zero (в разблокированном состоянии) к целевому ПК с Windows.
5. Запустите скрипт через меню BadUSB.

**Как это работает:** Скрипт автоматически открывает окно «Выполнить» (Win+R), запускает сессию PowerShell с обходом политик выполнения (`-ExecutionPolicy Bypass`), собирает все данные и сохраняет подробный отчет в формате `.txt` во временную папку `%TEMP%`. Для удобства краткая сводка также копируется в буфер обмена целевой машины.

## 🛡️ Требования
* Flipper Zero (официальная прошивка или любой кастомный вариант с поддержкой BadUSB/DuckyScript).
* Целевая машина под управлением Windows 10 или 11.
* Английская раскладка клавиатуры (США) по умолчанию на целевом ПК (необходима для корректной эмуляции нажатий клавиш DuckyScript).

## ⚠️ Отказ от ответственности

Этот проект и прилагаемые к нему скрипты предоставляются **исключительно в образовательных целях и для санкционированного аудита безопасности**.

Автор не несет ответственности за любой прямой или косвенный ущерб, утечку данных или нарушения закона, возникшие в результате использования данного программного обеспечения. Несанкционированное использование подобных инструментов против систем, которыми вы не владеете или на тестирование которых у вас нет явного разрешения, является незаконным.
