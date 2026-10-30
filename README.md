# FlipperSniffer V1.0

[English](README.md) · [Русский](README.ru.md)

BadUSB payload for Flipper Zero that collects system and network information from a Windows machine and displays it in a styled terminal interface with animations.

> **For educational and authorized testing purposes only.**

## What it collects

| Section | Details |
|---|---|
| System | Hostname, username, domain/workgroup, OS, uptime, RAM, CPU |
| Disks | All local drives — total size and free space |
| Network | Public IP, local IP, MAC, gateway, all active adapters |
| Wi-Fi | Current SSID, BSSID, signal strength |
| Wi-Fi passwords | All saved profiles with plaintext passwords (where accessible) |
| Clipboard | Current clipboard contents |
| Recent files | Last 3 opened files |
| Security | Installed AV products, Windows Defender RTP status |
| Processes | Top 7 processes by CPU usage |

## Features

- ASCII banner with color animation on startup
- Spinner animations between sections
- Styled section headers and summary box at the end
- Base64 payload split into 3 chunks — prevents Flipper from freezing
- Compatible with Windows PowerShell 5.1
- No files written to disk

## Getting Started

1. Copy `system_sniffer_v1.0.txt` to `/badusb/` on your Flipper Zero SD card.
2. On Flipper: **BadUSB** → select file → plug into target Windows machine.
3. Make sure the target machine has an English keyboard layout active.

> Wi-Fi passwords are accessible without admin rights if the current user is in the **Administrators** group (common on personal PCs). Otherwise shows `<admin required>`.

## Requirements

- Flipper Zero with BadUSB support
- Target: Windows 10 / 11, PowerShell 5.1+

## Disclaimer

For authorized security testing and educational purposes only. Using this against systems you don't own or don't have explicit permission to test is illegal.
