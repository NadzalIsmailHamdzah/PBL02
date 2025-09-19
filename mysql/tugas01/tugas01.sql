DROP DATABASE warung; 
CREATE DATABASE IF NOT EXISTS warung;

USE warung;

-- Membuat Tabel Pelanggan
CREATE TABLE IF NOT EXISTS pelanggan( 
	kd_pelanggan 	varchar(6) primary key, 
    nama 			varchar(50),
    kd_kelamin		int,
    alamat 			varchar(100), 
    kd_kota 		int
);

-- Membuat Tabel Kota
CREATE TABLE IF NOT EXISTS kota (
	kd_kota	int primary key,
    nama	varchar(10)
);

-- Membuat Tabel kelamin
CREATE TABLE IF NOT EXISTS kelamin(
	kd_kelamin		int primary key,
    jenis_kelamin 	varchar(10)
);

-- Membuat Tabel Produk
CREATE TABLE IF NOT EXISTS produk(
	kd_produk 	varchar(4) primary key,
    nama 		varchar(50),
    kd_satuan 	int,
    stok 		int,
    harga 		int
);

-- Membuat Tabel Satuan
CREATE TABLE IF NOT EXISTS satuan(
	kd_satuan 	int primary key,
    nama 		varchar(15)
);

-- Membuat Tabel Penjualan
CREATE TABLE IF NOT EXISTS penjualan(
	no_jual			varchar(4) primary key,
    tgl_jual		date,
    kd_pelanggan	varchar(6)
);

-- Membuat Tabel Detail Penjualan
CREATE TABLE IF NOT EXISTS detail_penjualan(
	no_jual		varchar(4),
    kd_produk	varchar(4),
    jumlah		int
);


-- Mengatur Relasi Antar Tabel
ALTER TABLE pelanggan 
	ADD FOREIGN KEY (kd_kelamin) REFERENCES kelamin(kd_kelamin),
    ADD FOREIGN KEY (kd_kota) REFERENCES kota(kd_kota);
    
ALTER TABLE produk
	ADD FOREIGN KEY (kd_satuan) REFERENCES satuan(kd_satuan);
    
ALTER TABLE penjualan
	ADD FOREIGN KEY (kd_pelanggan) REFERENCES pelanggan(kd_pelanggan);
    
ALTER TABLE detail_penjualan
	ADD FOREIGN KEY (no_jual) REFERENCES penjualan(no_jual),
	ADD FOREIGN KEY (kd_produk) REFERENCES produk(kd_produk);


-- Procedure Pada Tabel Kelamin
-- Procedure Insert Pada Tabel Kelamin
DELIMITER //
CREATE PROCEDURE sp_ins_kel (
	sp_kode varchar(1),
    sp_jenis varchar(7)
)
BEGIN
	INSERT kelamin VALUES (sp_kode, sp_jenis);
END //
DELIMITER ;

-- Pemanggilan Procedure Insert
call sp_ins_kel (1, 'Pria');
call sp_ins_kel (2, 'Wanita');


-- Procedure Update Pada Tabel Kelamin
DELIMITER //
CREATE PROCEDURE sp_upd_kel (
    sp_kode INT,
    sp_jenis VARCHAR(10)
)
BEGIN
    UPDATE kelamin
    SET jenis_kelamin = sp_jenis
    WHERE kd_kelamin = sp_kode;
END //
DELIMITER ;

-- Pemanggilan Procedure Update
-- CALL sp_upd_kel(1, 'Laki-laki');


-- Procedure Delete Pada Tabel Kelamin
DELIMITER //
CREATE PROCEDURE sp_del_kel (
    sp_kode INT
)
BEGIN
    DELETE FROM kelamin
    WHERE kd_kelamin = sp_kode;
END //
DELIMITER ;

-- Pemanggilan Procedure Delete
-- CALL sp_del_kel(2);


-- Procedure Tabel Kota
-- Procedure Insert Tabel Kota
DELIMITER //
CREATE PROCEDURE sp_ins_kota (
	sp_kode varchar(1),
    sp_nama varchar(15)
)
BEGIN
	INSERT kota VALUES (sp_kode, sp_nama);
END //
DELIMITER ;

-- Pemanggilan Procedure
call sp_ins_kota (1, 'Jakarta');
call sp_ins_kota (2, 'Bandung');
call sp_ins_kota (3, 'Surabaya');


-- Procedure Update Tabel Kota
DELIMITER //
CREATE PROCEDURE sp_upd_kota (
    sp_kode INT,
    sp_nama VARCHAR(15)
)
BEGIN
    UPDATE kota
    SET nama = sp_nama
    WHERE kd_kota = sp_kode;
END //
DELIMITER ;

-- Pemanggilan Procedure Update
-- CALL sp_upd_kota(2, 'Bandung Barat');


-- Procedure Delete Tabel Kota
DELIMITER //
CREATE PROCEDURE sp_del_kota (
    sp_kode INT
)
BEGIN
    DELETE FROM kota
    WHERE kd_kota = sp_kode;
END //
DELIMITER ;

-- Pemanggilan Procedure Delete
-- CALL sp_del_kota(3);


-- Procedure Tabel Pelanggan
-- Procedure Insert Tabel Pelanggan
DELIMITER //
CREATE PROCEDURE sp_ins_pel (
	sp_kode varchar(6),
    sp_nama varchar(50),
    sp_kd_kel varchar(1),
    sp_alamat varchar(100),
    sp_kd_kota varchar(1)
)
BEGIN
	INSERT pelanggan VALUES (sp_kode, sp_nama, sp_kd_kel, sp_alamat, sp_kd_kota);
END //
DELIMITER ;

-- Pemanggilan Procedure Insert
call sp_ins_pel ('PLG001', 'Mohammad', 1, 'Priok', 1);
call sp_ins_pel ('PLG002', 'Naufal', 1, 'Cilincing', 1);
call sp_ins_pel ('PLG003', 'Atila', 1, 'Bojongsoang', 2);
call sp_ins_pel ('PLG004', 'Tsalsa', 2, 'Buah Batu', 2);
call sp_ins_pel ('PLG005', 'Damay', 2, 'Gubeng', 3);
call sp_ins_pel ('PLG006', 'Tsaniy', 1, 'Darmo', 3);
call sp_ins_pel ('PLG007', 'Nabila', 2, 'Lebak Bulus', 1);


-- Procedure Update Tabel Pelanggan
DELIMITER //
CREATE PROCEDURE sp_upd_pel (
    sp_kode VARCHAR(6),       
    sp_nama VARCHAR(50),
    sp_kd_kel VARCHAR(1),
    sp_alamat VARCHAR(100),
    sp_kd_kota VARCHAR(1)
)
BEGIN
    UPDATE pelanggan
    SET 
        nama = sp_nama,
        kd_kel = sp_kd_kel,
        alamat = sp_alamat,
        kd_kota = sp_kd_kota
    WHERE kode = sp_kode;
END //
DELIMITER ;

-- Pemanggilan Procedure Update
-- CALL sp_upd_pel('PLG001', 'Budi Raharjo', '1', 'Lebak Bulus', '2');


-- Procedure Delete Pada Tabel Pelanggan
DELIMITER //
CREATE PROCEDURE sp_del_pel (
    sp_kode VARCHAR(6)     
)
BEGIN
    DELETE FROM pelanggan
    WHERE kode = sp_kode;
END //
DELIMITER ;

-- Pemanggilan Procedure Delete
-- CALL sp_del_pel('PLG001');

select * from pelanggan;

-- Procedure Tabel Produk
-- Procedure Insert Pada Tabel Produk
DELIMITER //
CREATE PROCEDURE sp_ins_sat_prod (
	sp_kode varchar(1),
    sp_bentuk varchar(10)
)
BEGIN
	INSERT satuan VALUES (sp_kode, sp_bentuk);
END //
DELIMITER ;

call sp_ins_sat_prod ('1', 'Bungkus');
call sp_ins_sat_prod ('2', 'Pak');
call sp_ins_sat_prod ('3', 'Botol');


-- Procedure Update Pada Tabel Satuan
DELIMITER //
CREATE PROCEDURE sp_upd_sat_prod (
    sp_kode VARCHAR(1),
    sp_bentuk VARCHAR(10)
)
BEGIN
    UPDATE satuan
    SET bentuk = sp_bentuk
    WHERE kode = sp_kode;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_upd_sat_prod('1', 'Pak');


-- Procedure Delete Pada Tabel Satuan
DELIMITER //
CREATE PROCEDURE sp_del_sat_prod (
    sp_kode VARCHAR(1)
)
BEGIN
    DELETE FROM satuan
    WHERE kode = sp_kode;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_del_sat_prod('3');

select * from satuan;

-- Procedure Tabel Produk
-- Procedure Insert Pada Tabel Produk
DELIMITER //
CREATE PROCEDURE sp_ins_prod (
	sp_kode varchar(4),
    sp_nama varchar(50),
    sp_kd_sat int,
    sp_stok int,
    sp_harga int
)
BEGIN
	INSERT produk VALUES (sp_kode, sp_nama, sp_kd_sat, sp_stok, sp_harga);
END //
DELIMITER ;

-- Pemanggilan Procedure Insert
call sp_ins_prod ('P001', 'Indomie',	1, 10, 3000);
call sp_ins_prod ('P002', 'Roti', 		2, 3, 18000);
call sp_ins_prod ('P003', 'Kecap', 		3, 8, 4700);
call sp_ins_prod ('P004', 'Saos Tomat', 3, 8, 5800);
call sp_ins_prod ('P005', 'Bihun', 		1, 5, 3500);
call sp_ins_prod ('P006', 'Sikat Gigi', 2, 5, 15000);
call sp_ins_prod ('P007', 'Pasta Gigi', 2, 7, 10000);
call sp_ins_prod ('P008', 'Saos Sambal',3, 5, 7300);


-- Procedure Update Pada Tabel Produk
DELIMITER //
CREATE PROCEDURE sp_upd_prod (
    sp_kode VARCHAR(4),
    sp_nama VARCHAR(50),
    sp_kd_sat INT,
    sp_stok INT,
    sp_harga INT
)
BEGIN
    UPDATE produk
    SET nama   = sp_nama,
        kd_sat = sp_kd_sat,
        stok   = sp_stok,
        harga  = sp_harga
    WHERE kd_produk = sp_kode;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_upd_prod('P002', 'Roti Tawar', 2, 10, 20000);


-- Procedure Delete Pada Tabel Produk
DELIMITER //
CREATE PROCEDURE sp_del_prod (
    sp_kode VARCHAR(4)
)
BEGIN
    DELETE FROM produk
    WHERE kd_produk = sp_kode;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_del_prod('P006');

select * from produk;


-- Procedure Pada Table Penjualan
-- Procedure Insert Pada Tabel Penjualan
DELIMITER //
CREATE PROCEDURE sp_ins_penj (
	sp_no_ju varchar(4),
    sp_tgl_ju date,
    sp_kd_pel varchar(6)
)
BEGIN
	INSERT penjualan VALUES (sp_no_ju, sp_tgl_ju, sp_kd_pel);
END //
DELIMITER ;

CALL sp_ins_penj('J001', '2025-09-08', 'PLG001');
CALL sp_ins_penj('J002', '2025-09-08', 'PLG002');
CALL sp_ins_penj('J003', '2025-09-09', 'PLG003');
CALL sp_ins_penj('J004', '2025-09-10', 'PLG004');


-- Procedure Update Pada Tabel Penjualan
DELIMITER //
CREATE PROCEDURE sp_upd_penj (
    sp_no_ju   VARCHAR(4),
    sp_tgl_ju  DATE,
    sp_kd_pel  VARCHAR(6)
)
BEGIN
    UPDATE penjualan
    SET tgl_jual     = sp_tgl_ju,
        kd_pelanggan = sp_kd_pel
    WHERE no_jual = sp_no_ju;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_upd_penj('J001', '2025-09-15', 'PLG007');


-- Procedure Delete Pada Tabel Penjualan
DELIMITER //
CREATE PROCEDURE sp_del_penj (
    sp_no_ju VARCHAR(4)
)
BEGIN
    DELETE FROM penjualan
    WHERE no_jual = sp_no_ju;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_del_penj('J004');

select * from penjualan;


-- Procedure Pada Tabel Detail Penjualan
-- Procedure Insert Pada Tabel Detail Penjualan
DELIMITER //
CREATE PROCEDURE sp_ins_detail_penj (
	sp_no_ju varchar(4),
    sp_kd_prod varchar(4),
    sp_juml int
)
BEGIN
	INSERT detail_penjualan VALUES (sp_no_ju, sp_kd_prod, sp_juml);
END //
DELIMITER ;

CALL sp_ins_detail_penj('J001', 'P001', '2');
CALL sp_ins_detail_penj('J001', 'P003', '1');
CALL sp_ins_detail_penj('J001', 'P004', '1');
CALL sp_ins_detail_penj('J002', 'P006', '3');
CALL sp_ins_detail_penj('J002', 'P007', '1');
CALL sp_ins_detail_penj('J003', 'P001', '5');
CALL sp_ins_detail_penj('J003', 'P004', '2');
CALL sp_ins_detail_penj('J003', 'P008', '2');
CALL sp_ins_detail_penj('J003', 'P003', '1');


-- Procedure Update Pada Tabel Detail Penjualan
DELIMITER //
CREATE PROCEDURE sp_upd_detail_penj (
    sp_no_ju   VARCHAR(4),
    sp_kd_prod VARCHAR(4),
    sp_juml    INT
)
BEGIN
    UPDATE detail_penjualan
    SET jumlah = sp_juml
    WHERE no_ju   = sp_no_ju
      AND kd_prod = sp_kd_prod;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_upd_detail_penj('J001', 'P001', 4);


-- Procedure Delete Pada Tabel Detail Penjualan
DELIMITER //
CREATE PROCEDURE sp_del_detail_penj (
    sp_no_ju   VARCHAR(4),
    sp_kd_prod VARCHAR(4)
)
BEGIN
    DELETE FROM detail_penjualan
    WHERE no_ju   = sp_no_ju
      AND kd_prod = sp_kd_prod;
END //
DELIMITER ;

-- Contoh pemanggilan
-- CALL sp_del_detail_penj('J002', 'P006');

select * from penjualan;


-- view Table Pelanggan
CREATE OR REPLACE VIEW vw_pelanggan AS
SELECT
    pel.kd_pelanggan AS kd_pelanggan,
    pel.nama AS nama_pelanggan,
    kel.jenis_kelamin AS kelamin,
    pel.alamat,
    kt.nama AS kota
FROM pelanggan pel
JOIN kelamin kel ON pel.kd_kelamin = kel.kd_kelamin
JOIN kota kt ON pel.kd_kota = kt.kd_kota;
SELECT * FROM vw_pelanggan;


-- View Table Kota
CREATE OR REPLACE VIEW vw_kota AS
SELECT
	kt.kd_kota AS kd_kota,
    kt.nama AS kota
FROM kota kt;
SELECT * FROM vw_kota;


-- VIew Tabel Kelamin
CREATE OR REPLACE VIEW vw_kelamin AS
SELECT
	kel.kd_kelamin AS kd_kelamin,
    kel.jenis_kelamin AS kelamin
FROM kelamin kel;
SELECT * FROM vw_kelamin;


-- View Table Produk
CREATE OR REPLACE VIEW vw_produk AS
SELECT
	pr.kd_produk AS kd_produk,
    pr.nama AS nama,
    s.nama AS satuan,
    pr.stok AS stok,
    pr.harga AS harga
FROM produk pr
JOIN satuan s ON pr.kd_satuan = s.kd_satuan;
SELECT * FROM vw_produk;

-- View Tabel Satuan
CREATE OR REPLACE VIEW vw_satuan AS
SELECT
	s.kd_satuan,
    s.nama AS satuan
FROM  satuan s;
SELECT * FROM vw_satuan;

-- View Transaksi Lengkap
CREATE OR REPLACE VIEW vw_transaksi_lengkap AS
SELECT
	penj.no_jual,
    penj.tgl_jual,
    pel.kd_pelanggan AS kd_pelanggan,
    pel.nama AS nama_pelanggan,
    kel.jenis_kelamin AS kelamin,
    pel.alamat,
    kt.nama AS kota,
    dp.kd_produk,
    pr.nama AS nama_produk,
    s.nama AS satuan,
    dp.jumlah,
    pr.harga,
    (dp.jumlah * pr.harga) AS total
FROM penjualan penj
JOIN pelanggan pel ON penj.kd_pelanggan = pel.kd_pelanggan
JOIN kelamin kel ON pel.kd_kelamin = kel.kd_kelamin
JOIN kota kt ON pel.kd_kota = kt.kd_kota
JOIN detail_penjualan dp ON penj.no_jual = dp.no_jual
JOIN produk pr ON dp.kd_produk = pr.kd_produk
JOIN satuan s ON pr.kd_satuan = s.kd_satuan;
SELECT * FROM vw_transaksi_lengkap;

-- Fungsi Menghitung Penjualan
DROP FUNCTION IF EXISTS fn_total_penjualan;
DELIMITER //
CREATE FUNCTION fn_total_penjualan(sp_no_ju VARCHAR(4))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT SUM(dp.jumlah * p.harga)
    INTO total
    FROM detail_penjualan dp
    JOIN produk p ON dp.kd_produk = p.kd_produk
    WHERE dp.no_jual = sp_no_ju;

    RETURN IFNULL(total, 0);
END //
DELIMITER ;

SELECT fn_total_penjualan('J001') AS total_harga;

-- Procedure Mencari Data Penjualan dari Kolom Tabel Penjualan
DROP PROCEDURE IF EXISTS sp_cari_penj_by_noju;
DELIMITER //
CREATE PROCEDURE sp_cari_penj_by_noju (
    IN sp_noju VARCHAR(4)
)
BEGIN
    SELECT * 
    FROM penjualan
    WHERE no_jual = sp_noju;
END //
DELIMITER ;

CALL sp_cari_penj_by_noju('J001');
