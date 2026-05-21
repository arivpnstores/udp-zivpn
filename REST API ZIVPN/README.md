# Dokumentasi REST API ZIVPN

Dokumentasi ini menjelaskan cara menggunakan REST API untuk mengelola akun ZIVPN secara terprogram.

## URL Dasar

Semua endpoint API diakses melalui URL dasar berikut:

```
http://<IP_ATAU_DOMAIN_SERVER_ANDA>:5888
```

## Otentikasi

Setiap permintaan ke API harus menyertakan kunci otentikasi yang valid. Kunci ini dikirim melalui query parameter bernama `auth`.

```
?auth=KUNCI_ANDA
```

Anda dapat membuat atau mengganti kunci otentikasi melalui menu utama skrip ZIVPN dengan memilih opsi **"Generate API Auth Key"**. Kunci baru akan dikirimkan ke bot Telegram Anda jika sudah dikonfigurasi.

---

## Endpoints

Semua endpoint mendukung metode request `GET` dan `POST`.

### 1. Buat Akun Baru

Endpoint ini digunakan untuk membuat akun ZIVPN baru dengan kata sandi dan masa aktif tertentu.

- **Endpoint:** `/create/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `password` (string, wajib): Kata sandi unik untuk akun baru.
  - `exp` (integer, wajib): Masa aktif akun dalam **hari**.
  - `auth` (string, wajib): Kunci otentikasi API Anda.

#### Contoh Request (`curl`)

```bash
curl "http://123.45.67.89:5888/create/zivpn?password=userbaru&exp=30&auth=a1b2c3"
```

#### Contoh Respons

- **Sukses (200 OK):**
  ```json
  {
    "status": "success",
    "message": "Success: Account 'userbaru' created, expires in 30 days.\nRestarting ZIVPN service...\nService restarted."
  }
  ```

- **Gagal (400 Bad Request - Kata Sandi Sudah Ada):**
  ```json
  {
    "status": "error",
    "message": "Error: Password 'userbaru' already exists."
  }
  ```

---

### 2. Hapus Akun

Endpoint ini digunakan untuk menghapus akun ZIVPN berdasarkan kata sandinya.

- **Endpoint:** `/delete/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `password` (string, wajib): Kata sandi akun yang akan dihapus.
  - `auth` (string, wajib): Kunci otentikasi API Anda.

#### Contoh Request (`curl`)

```bash
curl "http://123.45.67.89:5888/delete/zivpn?password=userlama&auth=a1b2c3"
```

#### Contoh Respons

- **Sukses (200 OK):**
  ```json
  {
    "status": "success",
    "message": "Success: Account 'userlama' deleted.\nRestarting ZIVPN service...\nService restarted."
  }
  ```

- **Gagal (400 Bad Request - Akun Tidak Ditemukan):**
  ```json
  {
    "status": "error",
    "message": "Error: Password 'userlama' not found."
  }
  ```

---

### 3. Perpanjang Akun

Endpoint ini digunakan untuk memperpanjang masa aktif akun yang sudah ada.

- **Endpoint:** `/renew/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `password` (string, wajib): Kata sandi akun yang akan diperpanjang.
  - `exp` (integer, wajib): Jumlah **hari** tambahan untuk masa aktif.
  - `auth` (string, wajib): Kunci otentikasi API Anda.

#### Contoh Request (`curl`)

```bash
curl "http://123.45.67.89:5888/renew/zivpn?password=useraktif&exp=15&auth=a1b2c3"
```

#### Contoh Respons

- **Sukses (200 OK):**
  ```json
  {
    "status": "success",
    "message": "Success: Account 'useraktif' has been renewed for 15 days."
  }
  ```

- **Gagal (400 Bad Request - Akun Tidak Ditemukan):**
  ```json
  {
    "status": "error",
    "message": "Error: Account 'useraktif' not found."
  }
  ```

---

### 4. Buat Akun Trial

Endpoint ini digunakan untuk membuat akun trial dengan masa aktif dalam hitungan menit. Kata sandi akan dibuat secara otomatis.

- **Endpoint:** `/trial/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `exp` (integer, wajib): Masa aktif akun dalam **menit**.
  - `auth` (string, wajib): Kunci otentikasi API Anda.

#### Contoh Request (`curl`)

```bash
curl "http://123.45.67.89:5888/trial/zivpn?exp=60&auth=a1b2c3"
```

#### Contoh Respons

- **Sukses (200 OK):**
  ```json
  {
    "status": "success",
    "message": "Success: Trial account 'trial12345' created, expires in 60 minutes.\nRestarting ZIVPN service...\nService restarted."
  }
  ```

- **Gagal (400 Bad Request - Nilai `exp` Tidak Valid):**
  ```json
  {
    "status": "error",
    "message": "Error: Invalid number of minutes."
  }
  ```

---

### 5. Total Akun

Melihat jumlah total akun ZIVPN yang terdaftar.

- **Endpoint:** `/total/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `auth` (string, wajib): Kunci otentikasi API Anda.

Contoh request:
```bash
curl "http://IP:5888/total/zivpn?auth=KEY"
```
Contoh respons:
```json
{
  "status": "success",
  "message": "Success: Total accounts: 15"
}
```

---

### 6. Check Akun

Melihat detail sebuah akun ZIVPN.

- **Endpoint:** `/check/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `password` (string, wajib): Kata sandi akun.
  - `auth` (string, wajib): Kunci otentikasi API Anda.

Contoh request:
```bash
curl "http://IP:5888/check/zivpn?password=userku&auth=KEY"
```
Contoh respons sukses:
```json
{
  "status": "success",
  "message": "Success:\nPassword    : userku\nHost        : 103.25.58.109\nISP         : PT. Nexin\nExpiry Date : 2026-06-17 14:30:00\nRemaining   : 30 days\nStatus      : Active"
}
```
Contoh respons gagal:
```json
{
  "status": "error",
  "message": "Error: Account 'userku' not found."
}
```

---

### 7. Lock Akun

Endpoint ini digunakan untuk mengunci (menonaktifkan sementara) akun ZIVPN. Akun tetap ada di database tetapi tidak bisa digunakan untuk koneksi.

- **Endpoint:** `/lock/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `password` (string, wajib): Kata sandi akun yang akan dikunci.
  - `auth` (string, wajib): Kunci otentikasi API Anda.

Contoh request:
```bash
curl "http://IP:5888/lock/zivpn?password=userku&auth=KEY"
```

Contoh respons sukses:
```json
{
  "status": "success",
  "message": "Success: Account 'userku' has been locked."
}
```

Contoh respons gagal (sudah dikunci):
```json
{
  "status": "error",
  "message": "Error: Account 'userku' is already locked."
}
```

---

### 8. Unlock Akun

Endpoint ini digunakan untuk mengaktifkan kembali akun ZIVPN yang sebelumnya dikunci.

- **Endpoint:** `/unlock/zivpn`
- **Metode:** `GET`, `POST`
- **Parameter:**
  - `password` (string, wajib): Kata sandi akun yang akan dibuka.
  - `auth` (string, wajib): Kunci otentikasi API Anda.

Contoh request:
```bash
curl "http://IP:5888/unlock/zivpn?password=userku&auth=KEY"
```

Contoh respons sukses:
```json
{
  "status": "success",
  "message": "Success: Account 'userku' has been unlocked."
}
```

Contoh respons gagal (tidak dikunci):
```json
{
  "status": "error",
  "message": "Error: Account 'userku' is not locked."
}
```
