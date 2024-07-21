-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 21 Jul 2024 pada 17.09
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_transaksi_toko_uas_pbd`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListProducts` ()   BEGIN SELECT * FROM Produk; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrderStatusWithValidation` (IN `order_id` VARCHAR(10), IN `new_status` VARCHAR(255))   BEGIN  IF EXISTS (SELECT 1 FROM Pesanan_Pelanggan WHERE ID_PESANAN = order_id) THEN 
UPDATE Pesanan_Pelanggan SET STATUS_PESANAN = new_status WHERE ID_PESANAN = order_id; 
SELECT * FROM Pesanan_Pelanggan WHERE ID_PESANAN = order_id; ELSE 
SELECT 'Order ID does not exist' AS message; END IF; END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetDiscountedProductPrice` (`product_id` VARCHAR(10), `discount_percent` DECIMAL(5,2)) RETURNS DECIMAL(10,2)  BEGIN DECLARE product_price DECIMAL(10, 2); 
DECLARE discounted_price DECIMAL(10, 2); 
SELECT HARGA INTO product_price FROM Produk WHERE ID_PRODUK = product_id; 
SET discounted_price = product_price - (product_price * discount_percent / 100); 
RETURN discounted_price; 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalProducts` () RETURNS INT(11)  BEGIN DECLARE total INT; 
SELECT COUNT(*) INTO total FROM Produk; 
RETURN total; END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `ID_DETAIL` varchar(10) NOT NULL,
  `ID_PESANAN` varchar(10) DEFAULT NULL,
  `ID_PRODUK` varchar(10) DEFAULT NULL,
  `JUMLAH` int(11) DEFAULT NULL,
  `HARGA_SATUAN` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `detail_pesanan`
--

INSERT INTO `detail_pesanan` (`ID_DETAIL`, `ID_PESANAN`, `ID_PRODUK`, `JUMLAH`, `HARGA_SATUAN`) VALUES
('D01', 'PS01', 'P01', 2, 200000.00),
('D02', 'PS02', 'P02', 1, 700000.00),
('D03', 'PS03', 'P03', 3, 22000.00),
('D04', 'PS04', 'P04', 50, 9000.00),
('D05', 'PS05', 'P05', 5, 4500.00);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `horizontalview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `horizontalview` (
`ID_PRODUK` varchar(10)
,`NAMA_PRODUK` varchar(255)
,`HARGA` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `innerview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `innerview` (
`ID_PRODUK` varchar(10)
,`NAMA_PRODUK` varchar(255)
,`HARGA` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori_produk`
--

CREATE TABLE `kategori_produk` (
  `ID_KATEGORI` varchar(15) NOT NULL,
  `NAMA_KATEGORI` varchar(255) NOT NULL,
  `TANGGAL_PEMBUATAN` date DEFAULT NULL,
  `KUALITAS_PRODUK` varchar(255) DEFAULT NULL,
  `UKURAN_PRODUK` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori_produk`
--

INSERT INTO `kategori_produk` (`ID_KATEGORI`, `NAMA_KATEGORI`, `TANGGAL_PEMBUATAN`, `KUALITAS_PRODUK`, `UKURAN_PRODUK`) VALUES
('K01', 'Elektronik', '2023-12-10', 'Baik', 'Sedang'),
('K02', 'Mebel', '2024-02-05', 'Cukup Baik', 'Besar'),
('K03', 'Makanan', '2024-03-20', 'Baik', 'Kecil'),
('K04', 'Minuman', '2024-04-15', 'Baik', 'Kecil'),
('K05', 'Kosmetik', '2023-11-12', 'Baik', 'Kecil');

-- --------------------------------------------------------

--
-- Struktur dari tabel `logtable`
--

CREATE TABLE `logtable` (
  `LogID` int(11) NOT NULL,
  `Operation` varchar(10) DEFAULT NULL,
  `TableName` varchar(50) DEFAULT NULL,
  `OldData` text DEFAULT NULL,
  `NewData` text DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `logtable`
--

INSERT INTO `logtable` (`LogID`, `Operation`, `TableName`, `OldData`, `NewData`, `Timestamp`) VALUES
(1, 'INSERT', 'Produk', NULL, 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', '2024-07-15 03:07:17'),
(2, 'INSERT', 'Produk', NULL, 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', '2024-07-15 03:07:17'),
(3, 'UPDATE', 'Produk', 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', '2024-07-15 03:09:36'),
(4, 'UPDATE', 'Produk', 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', '2024-07-15 03:09:36'),
(5, 'DELETE', 'Produk', 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', NULL, '2024-07-15 03:12:17'),
(6, 'DELETE', 'Produk', 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', NULL, '2024-07-15 03:12:17'),
(7, 'INSERT', 'Produk', NULL, 'ID_PRODUK=P07, NAMA_PRODUK=Es Krim Maklum', '2024-07-15 04:03:38'),
(8, 'INSERT', 'Produk', NULL, 'ID_PRODUK=P07, NAMA_PRODUK=Es Krim Maklum', '2024-07-15 04:03:38'),
(9, 'UPDATE', 'Produk', 'ID_PRODUK=P03, NAMA_PRODUK=DiamondKing 95gr', 'ID_PRODUK=P03, NAMA_PRODUK=DiamondKing 95gr', '2024-07-15 04:03:38'),
(10, 'UPDATE', 'Produk', 'ID_PRODUK=P03, NAMA_PRODUK=DiamondKing 95gr', 'ID_PRODUK=P03, NAMA_PRODUK=DiamondKing 95gr', '2024-07-15 04:03:38'),
(11, 'INSERT', 'Produk', NULL, 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', '2024-07-21 22:07:58'),
(12, 'INSERT', 'Produk', NULL, 'ID_PRODUK=P06, NAMA_PRODUK=Laptop Gimang snsv Rock ', '2024-07-21 22:07:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `member`
--

CREATE TABLE `member` (
  `ID_MEMBER` varchar(10) NOT NULL,
  `ID_PELANGGAN` varchar(10) DEFAULT NULL,
  `JENIS_KELAMIN` varchar(10) DEFAULT NULL,
  `TANGGAL_LAHIR` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `member`
--

INSERT INTO `member` (`ID_MEMBER`, `ID_PELANGGAN`, `JENIS_KELAMIN`, `TANGGAL_LAHIR`) VALUES
('M01', 'PL01', 'Laki-laki', '2014-01-15'),
('M02', 'PL02', 'Laki-Laki', '2015-02-24'),
('M03', 'PL03', 'Laki-laki', '2014-03-29'),
('M04', 'PL04', 'Perempuan', '1706-06-06'),
('M05', 'PL05', 'Laki-laki', '2013-05-28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orderdetails`
--

CREATE TABLE `orderdetails` (
  `OrderID` varchar(10) NOT NULL,
  `ProductID` varchar(10) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `outerviewcascaded`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `outerviewcascaded` (
`ID_PRODUK` varchar(10)
,`NAMA_PRODUK` varchar(255)
,`HARGA` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `outerviewlocal`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `outerviewlocal` (
`ID_PRODUK` varchar(10)
,`NAMA_PRODUK` varchar(255)
,`HARGA` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `ID_PELANGGAN` varchar(10) NOT NULL,
  `NAMA_PELANGGAN` varchar(255) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `ALAMAT` text DEFAULT NULL,
  `KONTAK` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`ID_PELANGGAN`, `NAMA_PELANGGAN`, `EMAIL`, `ALAMAT`, `KONTAK`) VALUES
('PL01', 'Mariyadi', 'Mariyadi@gamil.com', 'Jl. Lestari No. 1', '089573829156'),
('PL02', 'Soethopo', 'Thopo@gamil.com', 'Jl. Salak Bosok No. 2', '089645873633'),
('PL03', 'Michael Jawir', 'Jawir@gamil.com', 'Jl. Mundur Tratur No. 3', '089785643342'),
('PL04', 'Emily Paijem', 'Paijem@gamil.com', 'Jl. Penting Selamet No. 4', '08489372931'),
('PL05', 'David Coklat', 'david@gamil.com', 'Jl. Cpt. America No. 5', '089546373282');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pesanan_pelanggan`
--

CREATE TABLE `pesanan_pelanggan` (
  `ID_PESANAN` varchar(10) NOT NULL,
  `ID_PELANGGAN` varchar(10) DEFAULT NULL,
  `TANGGAL_PESANAN` date DEFAULT NULL,
  `STATUS_PESANAN` varchar(255) DEFAULT NULL,
  `TOTAL_HARGA` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pesanan_pelanggan`
--

INSERT INTO `pesanan_pelanggan` (`ID_PESANAN`, `ID_PELANGGAN`, `TANGGAL_PESANAN`, `STATUS_PESANAN`, `TOTAL_HARGA`) VALUES
('PS01', 'PL01', '2024-04-07', 'Dikirim', 400000.00),
('PS02', 'PL02', '2024-08-15', 'Proses', 700000.00),
('PS03', 'PL03', '2024-03-13', 'Selesai', 66000.00),
('PS04', 'PL04', '2024-09-06', 'Proses', 450000.00),
('PS05', 'PL05', '2024-04-17', 'Selesai', 22500.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `produk`
--

CREATE TABLE `produk` (
  `ID_PRODUK` varchar(10) NOT NULL,
  `NAMA_PRODUK` varchar(255) NOT NULL,
  `HARGA` decimal(10,2) DEFAULT NULL,
  `STOK` int(11) DEFAULT NULL,
  `ID_KATEGORI` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `produk`
--

INSERT INTO `produk` (`ID_PRODUK`, `NAMA_PRODUK`, `HARGA`, `STOK`, `ID_KATEGORI`) VALUES
('P01', 'Magic Jar Ademsonic', 200000.00, 30, 'K01'),
('P02', 'Lemari', 700000.00, 10, 'K02'),
('P03', 'DiamondKing 95gr', 30000.00, 200, 'K03'),
('P04', 'Kopi Botol Sosro 350ml', 9000.00, 150, 'K04'),
('P05', 'Sabun Lifegirl 80gr', 4500.00, 100, 'K05'),
('P06', 'Laptop Gimang snsv Rock ', 25000000.00, 15, 'K01'),
('P07', 'Es Krim Maklum', 18000.00, NULL, NULL);

--
-- Trigger `produk`
--
DELIMITER $$
CREATE TRIGGER `AfterDeleteProduct` AFTER DELETE ON `produk` FOR EACH ROW BEGIN INSERT INTO LogTable 
(Operation, TableName, OldData, Timestamp) 
VALUES ('DELETE', 'Produk', 
        CONCAT('ID_PRODUK=', OLD.ID_PRODUK, ', NAMA_PRODUK=', OLD.NAMA_PRODUK),
        NOW()); 
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterInsertProduct` AFTER INSERT ON `produk` FOR EACH ROW BEGIN INSERT INTO LogTable 
(Operation, TableName, NewData, Timestamp) VALUES
('INSERT', 'Produk', 
 CONCAT('ID_PRODUK=', NEW.ID_PRODUK, ', NAMA_PRODUK=', NEW.NAMA_PRODUK), NOW()); 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterUpdateProduct` AFTER UPDATE ON `produk` FOR EACH ROW BEGIN INSERT INTO LogTable 
(Operation, TableName, OldData, NewData, Timestamp) 
VALUES ('UPDATE', 'Produk', 
        CONCAT('ID_PRODUK=', OLD.ID_PRODUK, ', NAMA_PRODUK=', OLD.NAMA_PRODUK), 
        CONCAT('ID_PRODUK=', NEW.ID_PRODUK, ', NAMA_PRODUK=', NEW.NAMA_PRODUK),
        NOW()); 
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeDeleteProduct` BEFORE DELETE ON `produk` FOR EACH ROW BEGIN INSERT INTO LogTable 
(Operation, TableName, OldData, Timestamp) 
VALUES 
('DELETE', 'Produk', CONCAT('ID_PRODUK=', OLD.ID_PRODUK, ', NAMA_PRODUK=', OLD.NAMA_PRODUK), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeInsertProduct` BEFORE INSERT ON `produk` FOR EACH ROW BEGIN INSERT INTO LogTable (Operation, TableName, NewData, Timestamp) 
VALUES ('INSERT', 'Produk', CONCAT('ID_PRODUK=', NEW.ID_PRODUK, ', NAMA_PRODUK=', NEW.NAMA_PRODUK), NOW()); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeUpdateProduct` BEFORE UPDATE ON `produk` FOR EACH ROW BEGIN INSERT INTO LogTable 
(Operation, TableName, OldData, NewData, Timestamp) VALUES 
('UPDATE', 'Produk', CONCAT('ID_PRODUK=', OLD.ID_PRODUK, ', NAMA_PRODUK=', OLD.NAMA_PRODUK), 
CONCAT('ID_PRODUK=', NEW.ID_PRODUK, ', NAMA_PRODUK=', NEW.NAMA_PRODUK), NOW()); END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `produk_supplier`
--

CREATE TABLE `produk_supplier` (
  `ID_PRODUK` varchar(10) NOT NULL,
  `ID_SUPPLIER` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `produk_supplier`
--

INSERT INTO `produk_supplier` (`ID_PRODUK`, `ID_SUPPLIER`) VALUES
('P01', 'S01'),
('P02', 'S02'),
('P03', 'S03'),
('P04', 'S04'),
('P05', 'S05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `ID_SUPPLIER` varchar(10) NOT NULL,
  `NAMA_SUPPLIER` varchar(255) NOT NULL,
  `KONTAK` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `ALAMAT` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`ID_SUPPLIER`, `NAMA_SUPPLIER`, `KONTAK`, `EMAIL`, `ALAMAT`) VALUES
('S01', 'PT.SIGMART', '082397347987', 'Sigmart@gamil.com', 'Jl. Tembaga No. 09'),
('S02', 'PT.Ambatukam', '08567856781', 'Ambatukam@gamil.com', 'Jl. Kelamaan Jomblo No. 17'),
('S03', 'PT.LIGMART', '08986376982', 'Ligmart@gamil.com', 'Jl. Budiono Siregar No. 14'),
('S04', 'PT.MEWING', '083434354278', 'Mewing@gamil.com', 'Jl. Kapal Laut No. 04'),
('S05', 'PT.KADANG MAKMUR', '08685943784', 'Kadang@gamil.com', 'Jl. Kelengkeng Setengah No. 54');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `verticalview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `verticalview` (
`ID_PRODUK` varchar(10)
,`NAMA_PRODUK` varchar(255)
,`HARGA` decimal(10,2)
,`STOK` int(11)
,`ID_KATEGORI` varchar(10)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `horizontalview`
--
DROP TABLE IF EXISTS `horizontalview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontalview`  AS SELECT `produk`.`ID_PRODUK` AS `ID_PRODUK`, `produk`.`NAMA_PRODUK` AS `NAMA_PRODUK`, `produk`.`HARGA` AS `HARGA` FROM `produk` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `innerview`
--
DROP TABLE IF EXISTS `innerview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `innerview`  AS SELECT `produk`.`ID_PRODUK` AS `ID_PRODUK`, `produk`.`NAMA_PRODUK` AS `NAMA_PRODUK`, `produk`.`HARGA` AS `HARGA` FROM `produk` WHERE `produk`.`HARGA` > 20000 ;

-- --------------------------------------------------------

--
-- Struktur untuk view `outerviewcascaded`
--
DROP TABLE IF EXISTS `outerviewcascaded`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `outerviewcascaded`  AS SELECT `innerview`.`ID_PRODUK` AS `ID_PRODUK`, `innerview`.`NAMA_PRODUK` AS `NAMA_PRODUK`, `innerview`.`HARGA` AS `HARGA` FROM `innerview`WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `outerviewlocal`
--
DROP TABLE IF EXISTS `outerviewlocal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `outerviewlocal`  AS SELECT `innerview`.`ID_PRODUK` AS `ID_PRODUK`, `innerview`.`NAMA_PRODUK` AS `NAMA_PRODUK`, `innerview`.`HARGA` AS `HARGA` FROM `innerview`WITH LOCAL CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `verticalview`
--
DROP TABLE IF EXISTS `verticalview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `verticalview`  AS SELECT `produk`.`ID_PRODUK` AS `ID_PRODUK`, `produk`.`NAMA_PRODUK` AS `NAMA_PRODUK`, `produk`.`HARGA` AS `HARGA`, `produk`.`STOK` AS `STOK`, `produk`.`ID_KATEGORI` AS `ID_KATEGORI` FROM `produk` WHERE `produk`.`STOK` > 100 ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`ID_DETAIL`),
  ADD KEY `ID_PESANAN` (`ID_PESANAN`),
  ADD KEY `ID_PRODUK` (`ID_PRODUK`);

--
-- Indeks untuk tabel `kategori_produk`
--
ALTER TABLE `kategori_produk`
  ADD PRIMARY KEY (`ID_KATEGORI`);

--
-- Indeks untuk tabel `logtable`
--
ALTER TABLE `logtable`
  ADD PRIMARY KEY (`LogID`);

--
-- Indeks untuk tabel `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`ID_MEMBER`),
  ADD KEY `ID_PELANGGAN` (`ID_PELANGGAN`);

--
-- Indeks untuk tabel `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`OrderID`,`ProductID`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`ID_PELANGGAN`);

--
-- Indeks untuk tabel `pesanan_pelanggan`
--
ALTER TABLE `pesanan_pelanggan`
  ADD PRIMARY KEY (`ID_PESANAN`),
  ADD KEY `ID_PELANGGAN` (`ID_PELANGGAN`),
  ADD KEY `idx_pesanan_pelanggan` (`ID_PELANGGAN`,`TANGGAL_PESANAN`);

--
-- Indeks untuk tabel `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`ID_PRODUK`),
  ADD KEY `ID_KATEGORI` (`ID_KATEGORI`),
  ADD KEY `idx_harga_stok` (`HARGA`,`STOK`);

--
-- Indeks untuk tabel `produk_supplier`
--
ALTER TABLE `produk_supplier`
  ADD PRIMARY KEY (`ID_PRODUK`,`ID_SUPPLIER`),
  ADD KEY `ID_SUPPLIER` (`ID_SUPPLIER`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`ID_SUPPLIER`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `logtable`
--
ALTER TABLE `logtable`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`ID_PESANAN`) REFERENCES `pesanan_pelanggan` (`ID_PESANAN`),
  ADD CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`ID_PRODUK`) REFERENCES `produk` (`ID_PRODUK`);

--
-- Ketidakleluasaan untuk tabel `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`ID_PELANGGAN`) REFERENCES `pelanggan` (`ID_PELANGGAN`);

--
-- Ketidakleluasaan untuk tabel `pesanan_pelanggan`
--
ALTER TABLE `pesanan_pelanggan`
  ADD CONSTRAINT `pesanan_pelanggan_ibfk_1` FOREIGN KEY (`ID_PELANGGAN`) REFERENCES `pelanggan` (`ID_PELANGGAN`);

--
-- Ketidakleluasaan untuk tabel `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`ID_KATEGORI`) REFERENCES `kategori_produk` (`ID_KATEGORI`);

--
-- Ketidakleluasaan untuk tabel `produk_supplier`
--
ALTER TABLE `produk_supplier`
  ADD CONSTRAINT `produk_supplier_ibfk_1` FOREIGN KEY (`ID_PRODUK`) REFERENCES `produk` (`ID_PRODUK`),
  ADD CONSTRAINT `produk_supplier_ibfk_2` FOREIGN KEY (`ID_SUPPLIER`) REFERENCES `supplier` (`ID_SUPPLIER`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
