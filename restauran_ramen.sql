-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2026 at 10:00 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restauran_ramen`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `id_detail` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_pesanan`
--

INSERT INTO `detail_pesanan` (`id_detail`, `id_pesanan`, `id_menu`, `jumlah`) VALUES
(1, 1, 1, 1),
(2, 1, 4, 1),
(3, 2, 1, 1),
(4, 3, 2, 1),
(5, 3, 4, 1),
(6, 4, 1, 1),
(7, 5, 2, 1),
(8, 6, 1, 1),
(9, 6, 3, 1),
(10, 1, 1, 2),
(11, 2, 4, 2);

--
-- Triggers `detail_pesanan`
--
DELIMITER $$
CREATE TRIGGER `trg_kurangi_stok` AFTER INSERT ON `detail_pesanan` FOR EACH ROW BEGIN
    UPDATE stock_menu
    SET stok = stok - NEW.jumlah
    WHERE id_menu = NEW.id_menu;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `id_karyawan` int(11) NOT NULL,
  `nama_karyawan` varchar(100) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `tanggal_bergabung` date DEFAULT NULL,
  `status_aktif` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`id_karyawan`, `nama_karyawan`, `jabatan`, `tanggal_bergabung`, `status_aktif`) VALUES
(1, 'Akilla', 'Kasir Senior', '2023-01-10', 1),
(2, 'Maya', 'Chef Ramen', '2022-11-20', 1),
(3, 'Bambang', 'Pelayan', '2024-03-01', 0),
(4, 'Salsa Putri', 'Kasir', '2024-07-15', 1),
(5, 'Doni Prakoso', 'Pelayan', '2024-09-01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `kategori_menu`
--

CREATE TABLE `kategori_menu` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori_menu`
--

INSERT INTO `kategori_menu` (`id_kategori`, `nama_kategori`) VALUES
(2, 'Minuman'),
(1, 'Ramen'),
(3, 'Side Dish');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL,
  `nama_menu` varchar(100) NOT NULL,
  `harga` int(11) NOT NULL,
  `id_kategori` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id_menu`, `nama_menu`, `harga`, `id_kategori`) VALUES
(1, 'Shoyu Ramen', 40000, 1),
(2, 'Tonkotsu Ramen', 44000, 1),
(3, 'Ocha', 8000, 2),
(4, 'Gyoza', 15000, 3);

--
-- Triggers `menu`
--
DELIMITER $$
CREATE TRIGGER `trg_log_harga` AFTER UPDATE ON `menu` FOR EACH ROW BEGIN
    
    IF OLD.harga <> NEW.harga THEN
        INSERT INTO riwayat_harga (id_menu, nama_menu, harga_lama, harga_baru)
        VALUES (OLD.id_menu, OLD.nama_menu, OLD.harga, NEW.harga);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`, `alamat`, `no_telp`) VALUES
(1, 'Mayang Wulandari', 'Wonosobo', '081234567890'),
(2, 'Andi Saputra', 'Purwokerto', '085612345678'),
(3, 'Rina Maharani', 'Semarang', '081223344556'),
(4, 'Dewi Anggraini', 'Yogyakarta', '089512345678'),
(5, 'Fajar Nugraha', 'Magelang', '082134567890'),
(6, 'Siti Rahmawati', 'Solo', '081345678901'),
(7, 'Budi Santoso', 'Klaten', '082256789012'),
(8, 'Nina Oktaviani', 'Salatiga', '085734567890'),
(9, 'Rizky Pratama', 'Kebumen', '089876543210');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan_aktif`
--

CREATE TABLE `pelanggan_aktif` (
  `id` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan_aktif`
--

INSERT INTO `pelanggan_aktif` (`id`, `id_pelanggan`, `nama`) VALUES
(1, 1, 'Mayang Wulandari'),
(2, 1, 'Mayang Wulandari'),
(3, 2, 'Andi Saputra'),
(4, 3, 'Rina Maharani'),
(5, 4, 'Dewi Anggraini'),
(6, 5, 'Fajar Nugraha');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `jenis_pembayaran` varchar(50) NOT NULL,
  `jumlah_bayar` int(11) NOT NULL,
  `tanggal_pembayaran` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pesanan`, `jenis_pembayaran`, `jumlah_bayar`, `tanggal_pembayaran`) VALUES
(1, 1, 'Cash', 77000, '2025-12-09 08:04:59'),
(2, 2, 'QRIS', 35000, '2025-12-09 08:04:59'),
(3, 3, 'Cash', 52000, '2025-12-16 06:49:53'),
(4, 4, 'QRIS', 44000, '2025-12-16 06:49:53'),
(5, 5, 'Cash', 37000, '2025-12-16 06:49:53'),
(6, 6, 'QRIS', 52000, '2025-12-16 06:49:53');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `tipe_pesanan` varchar(20) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `tanggal_waktu_pesanan` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id_pesanan`, `id_pelanggan`, `tipe_pesanan`, `total_harga`, `tanggal_waktu_pesanan`) VALUES
(1, 1, 'Dine In', 77000, '2025-12-09 08:04:34'),
(2, 1, 'Take Away', 35000, '2025-12-09 08:04:34'),
(3, 2, 'Dine In', 52000, '2025-12-16 06:49:30'),
(4, 3, 'Take Away', 44000, '2025-12-16 06:49:30'),
(5, 4, 'Dine In', 37000, '2025-12-16 06:49:30'),
(6, 5, 'Take Away', 52000, '2025-12-16 06:49:30');

--
-- Triggers `pesanan`
--
DELIMITER $$
CREATE TRIGGER `trg_pelanggan_aktif` AFTER INSERT ON `pesanan` FOR EACH ROW BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pelanggan_aktif 
        WHERE id_pelanggan = NEW.id_pelanggan
    ) THEN
        INSERT INTO pelanggan_aktif (id_pelanggan, nama)
        SELECT id_pelanggan, nama_pelanggan
        FROM pelanggan
        WHERE id_pelanggan = NEW.id_pelanggan;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_harga`
--

CREATE TABLE `riwayat_harga` (
  `id_log` int(11) NOT NULL,
  `id_menu` int(11) DEFAULT NULL,
  `nama_menu` varchar(100) DEFAULT NULL,
  `harga_lama` int(11) DEFAULT NULL,
  `harga_baru` int(11) DEFAULT NULL,
  `waktu_ubah` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riwayat_harga`
--

INSERT INTO `riwayat_harga` (`id_log`, `id_menu`, `nama_menu`, `harga_lama`, `harga_baru`, `waktu_ubah`) VALUES
(1, 1, 'Shoyu Ramen', 37000, 40000, '2025-12-16 08:11:03');

-- --------------------------------------------------------

--
-- Table structure for table `stock_menu`
--

CREATE TABLE `stock_menu` (
  `id_stock` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `batas_minimum` int(11) DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_menu`
--

INSERT INTO `stock_menu` (`id_stock`, `id_menu`, `stok`, `batas_minimum`) VALUES
(1, 1, 8, 3),
(2, 2, 8, 3),
(3, 3, 25, 5),
(4, 4, 13, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_menu` (`id_menu`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id_karyawan`);

--
-- Indexes for table `kategori_menu`
--
ALTER TABLE `kategori_menu`
  ADD PRIMARY KEY (`id_kategori`),
  ADD UNIQUE KEY `nama_kategori` (`nama_kategori`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`),
  ADD UNIQUE KEY `nama_menu` (`nama_menu`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `pelanggan_aktif`
--
ALTER TABLE `pelanggan_aktif`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_pesanan` (`id_pesanan`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`),
  ADD KEY `id_pelanggan` (`id_pelanggan`);

--
-- Indexes for table `riwayat_harga`
--
ALTER TABLE `riwayat_harga`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `stock_menu`
--
ALTER TABLE `stock_menu`
  ADD PRIMARY KEY (`id_stock`),
  ADD KEY `id_menu` (`id_menu`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `id_karyawan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kategori_menu`
--
ALTER TABLE `kategori_menu`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pelanggan_aktif`
--
ALTER TABLE `pelanggan_aktif`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `riwayat_harga`
--
ALTER TABLE `riwayat_harga`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stock_menu`
--
ALTER TABLE `stock_menu`
  MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`),
  ADD CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`);

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_menu` (`id_kategori`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`);

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`);

--
-- Constraints for table `stock_menu`
--
ALTER TABLE `stock_menu`
  ADD CONSTRAINT `stock_menu_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
