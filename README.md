<p align="center">
  <img src="https://github.com/powermx/dl/blob/master/zivpn.png" width="420">
</p>

<h1 align="center">🚀 ZiVPN UDP Server</h1>

UDP server installation for **ZiVPN Tunnel (SSH / DNS / UDP)** VPN application.

Server binary available for **Linux amd64**, **arm**, and **arm64** with automatic architecture detection.

---

## 🧠 Features
- Auto detect VPS architecture (amd64 / arm / arm64)
- Auto download & install latest UDP binary
- Auto setup Systemd service
- Auto configure UFW firewall
- Auto apply default \"zi\" config
- Support for Debian / Ubuntu (minimal OS)

---

## 📦 Installation Menu

```
apt --fix-broken install && apt update -y && apt install screen ufw ruby figlet lolcat curl wget python3-pip -y && wget -q https://raw.githubusercontent.com/arivpnstores/udp-zivpn/main/install.sh -O /usr/local/bin/zivpn-manager && chmod +x /usr/local/bin/zivpn-manager && /usr/local/bin/zivpn-manager
```

---

## 🧼 Uninstall Menu

```
apt update -y && wget -q https://raw.githubusercontent.com/arivpnstores/udp-zivpn/main/uninstall.sh -O /usr/local/bin/uninstall-zivpn && chmod +x /usr/local/bin/uninstall-zivpn && /usr/local/bin/uninstall-zivpn
```

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

---

## 📱 Client Application

| Platform | Link |
|----------|------|
| Android | https://play.google.com/store/apps/details?id=com.zi.zivpn |

> App: **ZiVPN Tunnel**

---

## 📞 Support
For custom build, business inquiry, reseller system, panel, or telegram bot please contact support.

---

### 🎉 Thank you for using **ZiVPN UDP Server**
