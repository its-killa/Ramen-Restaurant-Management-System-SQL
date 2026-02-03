# Ramen Restaurant Database Management System 🍜

Repositori ini berisi rancangan **Database Relasional (RDBMS)** untuk sistem operasional restoran ramen. Proyek ini tidak hanya berfokus pada penyimpanan data, tetapi juga menerapkan **Business Logic Automation** langsung di tingkat database untuk memastikan integritas data, efisiensi stok, dan keamanan audit.

---

## 🚀 Fitur Teknis & Logika Bisnis (Backend Logic)

Database ini dirancang agar "cerdas" dalam menangani transaksi tanpa membebani aplikasi utama, menggunakan fitur **MySQL Triggers** dan **Stored Procedures**.

### 1. Automated Inventory Management (Manajemen Stok Real-time)
Masalah umum di restoran adalah selisih stok antara komputer dan dapur. Sistem ini mengatasinya dengan otomatisasi.
- **Mekanisme:** Menggunakan Trigger `trg_kurangi_stok`.
- **Logika:** Setiap kali item baru masuk ke tabel transaksi (`detail_pesanan`), database secara otomatis mendeteksi item tersebut dan langsung mengurangi jumlah stok di tabel `stock_menu`.
- **Keunggulan:** Mencegah *human error* (kasir lupa update stok) dan memastikan data ketersediaan menu selalu *real-time*.

### 2. Price Change Audit Trail (Sistem Audit Harga)
Untuk mencegah kecurangan atau kesalahan input harga oleh karyawan, sistem ini memiliki fitur "CCTV" data.
- **Mekanisme:** Menggunakan Trigger `trg_log_harga`.
- **Logika:** Sistem membandingkan data `OLD.harga` (harga lama) dengan `NEW.harga` (harga baru) setiap kali ada update di tabel `menu`.
- **Output:** Jika terjadi perubahan, sistem otomatis mencatat data lama, data baru, dan waktu perubahan ke dalam tabel khusus `riwayat_harga`.

### 3. Customer Retention Tracking
Sistem otomatis memisahkan data pelanggan yang "hanya bertanya" dengan pelanggan yang "sudah bertransaksi" untuk keperluan marketing.
- **Mekanisme:** Trigger `trg_pelanggan_aktif`.
- **Logika:** Saat transaksi terjadi, sistem mengecek apakah pelanggan tersebut sudah ada di daftar `pelanggan_aktif`. Jika belum, data akan disalin secara otomatis.

---

## 📂 Struktur & Skema Database

Sistem ini menggunakan prinsip **Normalisasi Database (3NF)** untuk mengurangi redundansi data.

### A. Modul Transaksi (Sales)
- **`pesanan`**: Mencatat *header* transaksi (Tanggal, Tipe Pesanan, Pelanggan).
- **`detail_pesanan`**: Mencatat rincian item yang dibeli (Many-to-Many relationship antara Pesanan dan Menu).
- **`pembayaran`**: Menangani metode pembayaran (Cash/QRIS) terpisah dari data pesanan utama.

### B. Modul Inventaris (Inventory)
- **`menu`**: Master data produk yang dijual.
- **`kategori_menu`**: Normalisasi kategori (Ramen, Minuman, Side Dish) untuk kemudahan reporting.
- **`stock_menu`**: Menyimpan jumlah stok saat ini dan batas *minimum threshold*.

### C. Modul SDM & Pelanggan (CRM & HR)
- **`karyawan`**: Data staf dengan status aktif/non-aktif.
- **`pelanggan` & `pelanggan_aktif`**: Manajemen data konsumen.
- **`riwayat_harga`**: Tabel log khusus audit.

---

## 🛠️ Teknologi yang Digunakan
- **Database Engine:** MySQL / MariaDB (InnoDB Storage Engine)
- **Fitur SQL:** DDL, DML, Triggers, Joins, Constraints (Foreign Key).

---

## 💻 Cara Instalasi & Penggunaan
1. Pastikan Anda memiliki **XAMPP** (MySQL) atau aplikasi database lainnya.
2. Buat database baru dengan nama `restauran_ramen`.
3. Import file `restauran_ramen.sql` yang tersedia di repositori ini.
4. Selesai! Seluruh tabel, relasi, dan trigger akan otomatis terpasang dan siap digunakan.

---
*Proyek ini dikembangkan sebagai bagian dari portofolio Database Development & Backend Engineering.*
