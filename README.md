
<p align="center">
  <img src="zivpn.png" width="420">
</p>

<h1 align="center">🚀 ZiVPN UDP Server</h1>

UDP server installation for **ZiVPN Tunnel (UDP)** VPN application.

Server binary available for **Linux amd64**, **arm**, and **arm64** with automatic architecture detection.

---

## 🧠 Features
- Auto detect VPS architecture (amd64 / arm / arm64)  
- Auto download & install latest UDP binary  
- Auto setup **systemd service** (fix error after reboot)  
- Auto configure **UFW firewall** & NAT  
- Auto apply default "zi" config  
- Support for **Debian / Ubuntu** (minimal OS)  
- Optional Dual SC or ZiVPN Only mode menu  
- Auto alias command `menu` for `/usr/local/bin/zivpn-manager`  

---

## 📦 Installation Menu

```bash
apt update -y && wget -q https://raw.githubusercontent.com/arivpnstores/udp-zivpn/main/install.sh -O /usr/local/bin/zivpn-manager && chmod +x /usr/local/bin/zivpn-manager && /usr/local/bin/zivpn-manager
```

> Installer akan otomatis:
> - Download binary terbaru sesuai arsitektur  
> - Setup systemd service `zivpn.service`  
> - Setup firewall UFW & NAT  
> - Set default password "zi"  
> - Membuat menu otomatis saat login  

---

## 🧼 Uninstall Menu

```bash
apt update -y && wget -q https://raw.githubusercontent.com/arivpnstores/udp-zivpn/main/uninstall.sh -O /usr/local/bin/uninstall-zivpn && chmod +x /usr/local/bin/uninstall-zivpn && /usr/local/bin/uninstall-zivpn
```

> Uninstall akan:
> - Stop dan disable systemd service  
> - Hapus binary `/usr/local/bin/zivpn`  
> - Hapus konfigurasi `/etc/zivpn/`  
> - Hapus NAT / firewall rules  

---

## 🖥 Supported Architecture

| Architecture | Binary |
|-------------|--------|
| **x86_64 (AMD64)** | udp-zivpn-linux-amd64 |
| **ARM 32-bit** | udp-zivpn-linux-arm |
| **ARM 64-bit (ARMv8)** | udp-zivpn-linux-arm64 |

---

## 📡 Default Configuration

| Setting | Value |
|---------|-------|
| Default Password | `zi` |
| Service Name | `zivpn.service` |
| Config File | `/etc/zivpn/config.json` |
| Binary Path | `/usr/local/bin/zivpn` |
| Firewall / NAT | UDP 6000-19999 → 5667 |
| Auto Menu Alias | `menu` → `/usr/local/bin/zivpn-manager` |

---

## 📱 Client Application

| Platform | Link |
|----------|------|
| Android | [ZiVPN Tunnel](https://play.google.com/store/apps/details?id=com.zi.zivpn) |

> App: **ZiVPN Tunnel**

---

## ⚙️ Systemd / Auto Restart

- Service dijalankan dengan:
```bash
systemctl enable zivpn.service
systemctl start zivpn.service
```
- Service akan **restart otomatis** jika mati
- Tunggu **network-online.target** sebelum start service → mencegah error UDP bind  

---

## 📞 Support

For custom build, business inquiry, reseller system, panel, or telegram bot please contact support.

---

### 🎉 Thank you for using **ZiVPN UDP Server**
