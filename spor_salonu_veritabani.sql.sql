-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: fitness_salonu
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `antrenman_detaylari`
--

DROP TABLE IF EXISTS `antrenman_detaylari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `antrenman_detaylari` (
  `detay_id` int NOT NULL AUTO_INCREMENT,
  `antrenman_id` int NOT NULL,
  `egzersiz_id` int NOT NULL,
  `ekipman_id` int DEFAULT NULL,
  `sira_no` int DEFAULT NULL,
  `set_sayisi` int DEFAULT NULL,
  `tekrar_sayisi` int DEFAULT NULL,
  `agirlik_kg` decimal(6,2) DEFAULT NULL,
  `sure_saniye` int DEFAULT NULL,
  `mesafe_metre` int DEFAULT NULL,
  `dinlenme_saniye` int DEFAULT NULL,
  `notlar` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`detay_id`),
  KEY `antrenman_id` (`antrenman_id`),
  KEY `egzersiz_id` (`egzersiz_id`),
  KEY `ekipman_id` (`ekipman_id`),
  CONSTRAINT `antrenman_detaylari_ibfk_1` FOREIGN KEY (`antrenman_id`) REFERENCES `antrenman_kayitlari` (`antrenman_id`) ON DELETE CASCADE,
  CONSTRAINT `antrenman_detaylari_ibfk_2` FOREIGN KEY (`egzersiz_id`) REFERENCES `egzersizler` (`egzersiz_id`),
  CONSTRAINT `antrenman_detaylari_ibfk_3` FOREIGN KEY (`ekipman_id`) REFERENCES `ekipmanlar` (`ekipman_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antrenman_detaylari`
--

LOCK TABLES `antrenman_detaylari` WRITE;
/*!40000 ALTER TABLE `antrenman_detaylari` DISABLE KEYS */;
/*!40000 ALTER TABLE `antrenman_detaylari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antrenman_kayitlari`
--

DROP TABLE IF EXISTS `antrenman_kayitlari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `antrenman_kayitlari` (
  `antrenman_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `antrenor_id` int DEFAULT NULL,
  `tarih` date NOT NULL,
  `baslangic_saati` time DEFAULT NULL,
  `bitis_saati` time DEFAULT NULL,
  `antrenman_tipi` enum('bireysel','pt','grup_dersi') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `toplam_sure_dk` int DEFAULT NULL,
  `yaklasik_kalori` int DEFAULT NULL,
  `yorgunluk_seviyesi` tinyint DEFAULT NULL,
  `motivasyon_seviyesi` tinyint DEFAULT NULL,
  `genel_notlar` text COLLATE utf8mb4_unicode_ci,
  `tamamlandi_mi` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`antrenman_id`),
  KEY `antrenor_id` (`antrenor_id`),
  KEY `idx_uye_tarih` (`uye_id`,`tarih`),
  CONSTRAINT `antrenman_kayitlari_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE,
  CONSTRAINT `antrenman_kayitlari_ibfk_2` FOREIGN KEY (`antrenor_id`) REFERENCES `antrenorler` (`antrenor_id`),
  CONSTRAINT `antrenman_kayitlari_chk_1` CHECK ((`yorgunluk_seviyesi` between 1 and 10)),
  CONSTRAINT `antrenman_kayitlari_chk_2` CHECK ((`motivasyon_seviyesi` between 1 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antrenman_kayitlari`
--

LOCK TABLES `antrenman_kayitlari` WRITE;
/*!40000 ALTER TABLE `antrenman_kayitlari` DISABLE KEYS */;
INSERT INTO `antrenman_kayitlari` VALUES (1,1,1,'2026-03-20','07:35:00','09:10:00','bireysel',95,NULL,NULL,NULL,NULL,1),(2,2,2,'2026-03-20','10:05:00','11:25:00','pt',80,NULL,NULL,NULL,NULL,1),(3,1,NULL,'2026-03-21','07:50:00','08:55:00','bireysel',65,NULL,NULL,NULL,NULL,1),(4,3,3,'2026-03-21','18:10:00','19:50:00','pt',100,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `antrenman_kayitlari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antrenor_uzmanlik`
--

DROP TABLE IF EXISTS `antrenor_uzmanlik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `antrenor_uzmanlik` (
  `id` int NOT NULL AUTO_INCREMENT,
  `antrenor_id` int NOT NULL,
  `brans_id` int NOT NULL,
  `uzmanlik_seviyesi` enum('temel','orta','uzman','master') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_antrenor_brans` (`antrenor_id`,`brans_id`),
  KEY `brans_id` (`brans_id`),
  CONSTRAINT `antrenor_uzmanlik_ibfk_1` FOREIGN KEY (`antrenor_id`) REFERENCES `antrenorler` (`antrenor_id`) ON DELETE CASCADE,
  CONSTRAINT `antrenor_uzmanlik_ibfk_2` FOREIGN KEY (`brans_id`) REFERENCES `spor_branslari` (`brans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antrenor_uzmanlik`
--

LOCK TABLES `antrenor_uzmanlik` WRITE;
/*!40000 ALTER TABLE `antrenor_uzmanlik` DISABLE KEYS */;
/*!40000 ALTER TABLE `antrenor_uzmanlik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antrenorler`
--

DROP TABLE IF EXISTS `antrenorler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `antrenorler` (
  `antrenor_id` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soyad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deneyim_yili` tinyint DEFAULT NULL,
  `sertifikalar` text COLLATE utf8mb4_unicode_ci,
  `maas` decimal(10,2) DEFAULT NULL,
  `ise_baslama` date NOT NULL,
  `calisma_durumu` enum('tam_zamanli','yari_zamanli','freelance') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aktif_mi` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`antrenor_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antrenorler`
--

LOCK TABLES `antrenorler` WRITE;
/*!40000 ALTER TABLE `antrenorler` DISABLE KEYS */;
INSERT INTO `antrenorler` VALUES (1,'Ahmet','Yılmaz','05321234567','ahmet@fitness.com',8,NULL,NULL,'2020-01-15','tam_zamanli',1),(2,'Elif','Kaya','05339876543','elif@fitness.com',5,NULL,NULL,'2021-03-01','tam_zamanli',1),(3,'Mert','Demir','05357654321','mert@fitness.com',10,NULL,NULL,'2019-06-01','tam_zamanli',1),(4,'Zeynep','Çelik','05361112233','zeynep@fitness.com',3,NULL,NULL,'2022-09-01','yari_zamanli',1),(5,'Can','Öztürk','05374445566','can@fitness.com',6,NULL,NULL,'2021-01-01','freelance',1);
/*!40000 ALTER TABLE `antrenorler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beslenme_planlari`
--

DROP TABLE IF EXISTS `beslenme_planlari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beslenme_planlari` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `olusturma_tarihi` date NOT NULL,
  `hedef_kalori` int DEFAULT NULL,
  `protein_gram` int DEFAULT NULL,
  `karbonhidrat_gram` int DEFAULT NULL,
  `yag_gram` int DEFAULT NULL,
  `ogun_sayisi` tinyint DEFAULT NULL,
  `su_litre` decimal(3,1) DEFAULT NULL,
  `kisitlamalar` text COLLATE utf8mb4_unicode_ci,
  `notlar` text COLLATE utf8mb4_unicode_ci,
  `hazirlayan` int DEFAULT NULL,
  PRIMARY KEY (`plan_id`),
  KEY `uye_id` (`uye_id`),
  KEY `hazirlayan` (`hazirlayan`),
  CONSTRAINT `beslenme_planlari_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE,
  CONSTRAINT `beslenme_planlari_ibfk_2` FOREIGN KEY (`hazirlayan`) REFERENCES `antrenorler` (`antrenor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beslenme_planlari`
--

LOCK TABLES `beslenme_planlari` WRITE;
/*!40000 ALTER TABLE `beslenme_planlari` DISABLE KEYS */;
/*!40000 ALTER TABLE `beslenme_planlari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ders_katilimlari`
--

DROP TABLE IF EXISTS `ders_katilimlari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ders_katilimlari` (
  `katilim_id` int NOT NULL AUTO_INCREMENT,
  `ders_id` int NOT NULL,
  `uye_id` int NOT NULL,
  `tarih` date NOT NULL,
  `rezervasyon_zamani` datetime DEFAULT CURRENT_TIMESTAMP,
  `katildi_mi` tinyint(1) DEFAULT NULL,
  `iptal_mi` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`katilim_id`),
  KEY `uye_id` (`uye_id`),
  KEY `idx_ders_tarih` (`ders_id`,`tarih`),
  CONSTRAINT `ders_katilimlari_ibfk_1` FOREIGN KEY (`ders_id`) REFERENCES `dersler` (`ders_id`),
  CONSTRAINT `ders_katilimlari_ibfk_2` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ders_katilimlari`
--

LOCK TABLES `ders_katilimlari` WRITE;
/*!40000 ALTER TABLE `ders_katilimlari` DISABLE KEYS */;
/*!40000 ALTER TABLE `ders_katilimlari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dersler`
--

DROP TABLE IF EXISTS `dersler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dersler` (
  `ders_id` int NOT NULL AUTO_INCREMENT,
  `ders_adi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `antrenor_id` int DEFAULT NULL,
  `salon_id` int DEFAULT NULL,
  `gun` enum('pazartesi','sali','carsamba','persembe','cuma','cumartesi','pazar') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baslangic_saati` time NOT NULL,
  `bitis_saati` time NOT NULL,
  `kapasite` int NOT NULL,
  `seviye` enum('baslangic','orta','ileri','tum_seviyeler') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aktif_mi` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`ders_id`),
  KEY `antrenor_id` (`antrenor_id`),
  KEY `salon_id` (`salon_id`),
  CONSTRAINT `dersler_ibfk_1` FOREIGN KEY (`antrenor_id`) REFERENCES `antrenorler` (`antrenor_id`),
  CONSTRAINT `dersler_ibfk_2` FOREIGN KEY (`salon_id`) REFERENCES `salonlar` (`salon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dersler`
--

LOCK TABLES `dersler` WRITE;
/*!40000 ALTER TABLE `dersler` DISABLE KEYS */;
INSERT INTO `dersler` VALUES (1,'Sabah Yogası',4,5,'pazartesi','07:00:00','08:00:00',15,'tum_seviyeler',1),(2,'Spinning',2,6,'sali','19:00:00','20:00:00',20,'orta',1),(3,'HIIT',1,4,'carsamba','18:00:00','18:45:00',20,'ileri',1),(4,'Pilates',4,5,'persembe','10:00:00','11:00:00',15,'baslangic',1),(5,'Zumba',2,4,'cuma','19:00:00','20:00:00',25,'tum_seviyeler',1),(6,'CrossFit',3,1,'cumartesi','10:00:00','11:00:00',15,'ileri',1);
/*!40000 ALTER TABLE `dersler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egzersizler`
--

DROP TABLE IF EXISTS `egzersizler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `egzersizler` (
  `egzersiz_id` int NOT NULL AUTO_INCREMENT,
  `egzersiz_adi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kas_grubu` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `egzersiz_tipi` enum('kardio','kuvvet','esneklik','denge','fonksiyonel') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zorluk_seviyesi` enum('baslangic','orta','ileri') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aciklama` text COLLATE utf8mb4_unicode_ci,
  `kalori_dk` int DEFAULT NULL,
  PRIMARY KEY (`egzersiz_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egzersizler`
--

LOCK TABLES `egzersizler` WRITE;
/*!40000 ALTER TABLE `egzersizler` DISABLE KEYS */;
INSERT INTO `egzersizler` VALUES (1,'Bench Press','Göğüs','kuvvet','orta',NULL,NULL,8),(2,'Squat','Bacak','kuvvet','orta',NULL,NULL,10),(3,'Deadlift','Sırt, Bacak','kuvvet','ileri',NULL,NULL,12),(4,'Koşu Bandı','Kardio','kardio','baslangic',NULL,NULL,10),(5,'Bisiklet','Kardio, Bacak','kardio','baslangic',NULL,NULL,8),(6,'Lat Pulldown','Sırt','kuvvet','baslangic',NULL,NULL,6),(7,'Shoulder Press','Omuz','kuvvet','orta',NULL,NULL,7),(8,'Plank','Core','denge','baslangic',NULL,NULL,5),(9,'Barbell Row','Sırt','kuvvet','orta',NULL,NULL,8),(10,'Leg Press','Bacak','kuvvet','baslangic',NULL,NULL,9),(11,'Bicep Curl','Kol','kuvvet','baslangic',NULL,NULL,5),(12,'Tricep Dips','Kol','kuvvet','orta',NULL,NULL,6),(13,'Burpee','Tüm Vücut','fonksiyonel','ileri',NULL,NULL,15),(14,'Mountain Climber','Core, Kardio','fonksiyonel','orta',NULL,NULL,12),(15,'Kürek Çekme','Sırt, Kol','kardio','orta',NULL,NULL,11);
/*!40000 ALTER TABLE `egzersizler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ekipman_bakim`
--

DROP TABLE IF EXISTS `ekipman_bakim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ekipman_bakim` (
  `bakim_id` int NOT NULL AUTO_INCREMENT,
  `ekipman_id` int NOT NULL,
  `bakim_tarihi` date NOT NULL,
  `bakim_turu` enum('periyodik','ariza','genel_kontrol') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yapilan_islem` text COLLATE utf8mb4_unicode_ci,
  `maliyet` decimal(10,2) DEFAULT NULL,
  `teknisyen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sonraki_bakim` date DEFAULT NULL,
  PRIMARY KEY (`bakim_id`),
  KEY `ekipman_id` (`ekipman_id`),
  CONSTRAINT `ekipman_bakim_ibfk_1` FOREIGN KEY (`ekipman_id`) REFERENCES `ekipmanlar` (`ekipman_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ekipman_bakim`
--

LOCK TABLES `ekipman_bakim` WRITE;
/*!40000 ALTER TABLE `ekipman_bakim` DISABLE KEYS */;
/*!40000 ALTER TABLE `ekipman_bakim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ekipmanlar`
--

DROP TABLE IF EXISTS `ekipmanlar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ekipmanlar` (
  `ekipman_id` int NOT NULL AUTO_INCREMENT,
  `salon_id` int DEFAULT NULL,
  `ekipman_adi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marka` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seri_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alis_tarihi` date DEFAULT NULL,
  `alis_fiyati` decimal(10,2) DEFAULT NULL,
  `garanti_bitis` date DEFAULT NULL,
  `durum` enum('aktif','arizali','bakimda','hurda') COLLATE utf8mb4_unicode_ci DEFAULT 'aktif',
  `son_bakim_tarihi` date DEFAULT NULL,
  PRIMARY KEY (`ekipman_id`),
  UNIQUE KEY `seri_no` (`seri_no`),
  KEY `salon_id` (`salon_id`),
  CONSTRAINT `ekipmanlar_ibfk_1` FOREIGN KEY (`salon_id`) REFERENCES `salonlar` (`salon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ekipmanlar`
--

LOCK TABLES `ekipmanlar` WRITE;
/*!40000 ALTER TABLE `ekipmanlar` DISABLE KEYS */;
INSERT INTO `ekipmanlar` VALUES (1,1,'Bench Press Sehpası','Hammer Strength',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(2,1,'Squat Rack','Rogue',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(3,3,'Smith Machine','Life Fitness',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(4,2,'Koşu Bandı 1','Technogym',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(5,2,'Koşu Bandı 2','Technogym',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(6,2,'Koşu Bandı 3','Technogym',NULL,NULL,NULL,NULL,NULL,'bakimda',NULL),(7,2,'Eliptik Bisiklet','Matrix',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(8,6,'Spinning Bisikleti','Schwinn',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(9,3,'Cable Crossover','Precor',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(10,3,'Leg Press Makinesi','Cybex',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(11,1,'Dumbbell Seti (2-40kg)','Eleiko',NULL,NULL,NULL,NULL,NULL,'aktif',NULL),(12,1,'Barbell Set','Eleiko',NULL,NULL,NULL,NULL,NULL,'aktif',NULL);
/*!40000 ALTER TABLE `ekipmanlar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fiziksel_olculer`
--

DROP TABLE IF EXISTS `fiziksel_olculer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fiziksel_olculer` (
  `olcum_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `olcum_tarihi` date NOT NULL,
  `kilo_kg` decimal(5,2) DEFAULT NULL,
  `yag_orani` decimal(5,2) DEFAULT NULL,
  `kas_kutle_kg` decimal(5,2) DEFAULT NULL,
  `su_orani` decimal(5,2) DEFAULT NULL,
  `bmi` decimal(4,2) DEFAULT NULL,
  `bazal_metabolizma` int DEFAULT NULL,
  `gogus_cm` decimal(5,2) DEFAULT NULL,
  `bel_cm` decimal(5,2) DEFAULT NULL,
  `kalca_cm` decimal(5,2) DEFAULT NULL,
  `kol_cm` decimal(5,2) DEFAULT NULL,
  `bacak_cm` decimal(5,2) DEFAULT NULL,
  `olcum_yapan` int DEFAULT NULL,
  `notlar` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`olcum_id`),
  KEY `olcum_yapan` (`olcum_yapan`),
  KEY `idx_uye_tarih` (`uye_id`,`olcum_tarihi`),
  CONSTRAINT `fiziksel_olculer_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE,
  CONSTRAINT `fiziksel_olculer_ibfk_2` FOREIGN KEY (`olcum_yapan`) REFERENCES `antrenorler` (`antrenor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fiziksel_olculer`
--

LOCK TABLES `fiziksel_olculer` WRITE;
/*!40000 ALTER TABLE `fiziksel_olculer` DISABLE KEYS */;
INSERT INTO `fiziksel_olculer` VALUES (1,1,'2026-01-05',82.50,18.50,35.20,NULL,26.10,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(2,1,'2026-02-05',80.00,17.20,36.00,NULL,25.30,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(3,2,'2026-01-10',58.00,22.00,24.50,NULL,21.30,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL),(4,3,'2026-02-15',95.00,25.00,38.00,NULL,28.70,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(5,4,'2026-03-01',65.00,28.00,22.00,NULL,22.50,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL),(6,5,'2026-01-20',88.00,30.00,30.00,NULL,28.70,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL);
/*!40000 ALTER TABLE `fiziksel_olculer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giris_cikis`
--

DROP TABLE IF EXISTS `giris_cikis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giris_cikis` (
  `kayit_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `giris_zamani` datetime NOT NULL,
  `cikis_zamani` datetime DEFAULT NULL,
  `giris_tipi` enum('kart','qr','parmak_izi','manuel') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `toplam_sure_dk` int DEFAULT NULL,
  PRIMARY KEY (`kayit_id`),
  KEY `idx_giris_tarih` (`giris_zamani`),
  KEY `idx_uye_giris` (`uye_id`,`giris_zamani`),
  CONSTRAINT `giris_cikis_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giris_cikis`
--

LOCK TABLES `giris_cikis` WRITE;
/*!40000 ALTER TABLE `giris_cikis` DISABLE KEYS */;
INSERT INTO `giris_cikis` VALUES (1,1,'2026-03-20 07:30:00','2026-03-20 09:15:00','kart',105),(2,2,'2026-03-20 10:00:00','2026-03-20 11:30:00','qr',90),(3,1,'2026-03-21 07:45:00','2026-03-21 09:00:00','kart',75),(4,3,'2026-03-21 18:00:00','2026-03-21 20:00:00','parmak_izi',120),(5,4,'2026-03-22 12:00:00','2026-03-22 13:00:00','kart',60);
/*!40000 ALTER TABLE `giris_cikis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hedefler`
--

DROP TABLE IF EXISTS `hedefler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hedefler` (
  `hedef_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `hedef_tipi` enum('kilo_verme','kilo_alma','kas_yapma','dayaniklilik','esneklik','genel_saglik') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hedef_aciklama` text COLLATE utf8mb4_unicode_ci,
  `baslangic_degeri` decimal(6,2) DEFAULT NULL,
  `hedef_degeri` decimal(6,2) DEFAULT NULL,
  `mevcut_degeri` decimal(6,2) DEFAULT NULL,
  `baslangic_tarihi` date NOT NULL,
  `hedef_tarihi` date DEFAULT NULL,
  `durum` enum('devam_ediyor','tamamlandi','iptal') COLLATE utf8mb4_unicode_ci DEFAULT 'devam_ediyor',
  PRIMARY KEY (`hedef_id`),
  KEY `uye_id` (`uye_id`),
  CONSTRAINT `hedefler_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hedefler`
--

LOCK TABLES `hedefler` WRITE;
/*!40000 ALTER TABLE `hedefler` DISABLE KEYS */;
INSERT INTO `hedefler` VALUES (1,1,'kilo_verme','5 kg vermek',82.50,77.50,80.00,'2026-01-05','2026-04-05','devam_ediyor'),(2,2,'kas_yapma','Kas kütlesini artırmak',24.50,27.00,24.50,'2026-01-10','2026-07-10','devam_ediyor'),(3,3,'kilo_verme','10 kg vermek',95.00,85.00,95.00,'2026-02-15','2026-08-15','devam_ediyor'),(4,5,'genel_saglik','Diyabet kontrolü için düzenli egzersiz',NULL,NULL,NULL,'2026-01-20',NULL,'devam_ediyor');
/*!40000 ALTER TABLE `hedefler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saglik_bilgileri`
--

DROP TABLE IF EXISTS `saglik_bilgileri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saglik_bilgileri` (
  `saglik_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `kan_grubu` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `boy_cm` decimal(5,2) DEFAULT NULL,
  `kronik_hastalik` text COLLATE utf8mb4_unicode_ci,
  `alerji` text COLLATE utf8mb4_unicode_ci,
  `gecirilen_ameliyat` text COLLATE utf8mb4_unicode_ci,
  `kullanilan_ilac` text COLLATE utf8mb4_unicode_ci,
  `sakatlik_gecmisi` text COLLATE utf8mb4_unicode_ci,
  `doktor_izni` tinyint(1) DEFAULT '0',
  `doktor_notu` text COLLATE utf8mb4_unicode_ci,
  `son_guncelleme` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`saglik_id`),
  UNIQUE KEY `uye_id` (`uye_id`),
  CONSTRAINT `saglik_bilgileri_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saglik_bilgileri`
--

LOCK TABLES `saglik_bilgileri` WRITE;
/*!40000 ALTER TABLE `saglik_bilgileri` DISABLE KEYS */;
INSERT INTO `saglik_bilgileri` VALUES (1,1,'A+',178.00,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-04-01 21:56:24'),(2,2,'B+',165.00,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-04-01 21:56:24'),(3,3,'O-',182.00,'Astım',NULL,NULL,NULL,NULL,1,NULL,'2026-04-01 21:56:24'),(4,4,'0+',170.00,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-04-01 21:56:24'),(5,5,'AB+',175.00,'Diyabet Tip 2',NULL,NULL,NULL,NULL,1,NULL,'2026-04-01 21:56:24');
/*!40000 ALTER TABLE `saglik_bilgileri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salonlar`
--

DROP TABLE IF EXISTS `salonlar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salonlar` (
  `salon_id` int NOT NULL AUTO_INCREMENT,
  `salon_adi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kapasite` int DEFAULT NULL,
  `alan_m2` decimal(6,2) DEFAULT NULL,
  `kat` tinyint DEFAULT NULL,
  `aciklama` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`salon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salonlar`
--

LOCK TABLES `salonlar` WRITE;
/*!40000 ALTER TABLE `salonlar` DISABLE KEYS */;
INSERT INTO `salonlar` VALUES (1,'Ana Fitness Salonu',50,300.00,1,NULL),(2,'Kardio Bölümü',30,150.00,1,NULL),(3,'Ağırlık Salonu',25,200.00,1,NULL),(4,'Grup Dersleri Stüdyosu',20,100.00,2,NULL),(5,'Yoga Stüdyosu',15,80.00,2,NULL),(6,'Spinning Odası',20,60.00,2,NULL);
/*!40000 ALTER TABLE `salonlar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spor_branslari`
--

DROP TABLE IF EXISTS `spor_branslari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spor_branslari` (
  `brans_id` int NOT NULL AUTO_INCREMENT,
  `brans_adi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aciklama` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`brans_id`),
  UNIQUE KEY `brans_adi` (`brans_adi`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spor_branslari`
--

LOCK TABLES `spor_branslari` WRITE;
/*!40000 ALTER TABLE `spor_branslari` DISABLE KEYS */;
INSERT INTO `spor_branslari` VALUES (1,'Fitness','genel',NULL),(2,'Yoga','esneklik',NULL),(3,'Pilates','esneklik',NULL),(4,'CrossFit','fonksiyonel',NULL),(5,'Boks','dövüş',NULL),(6,'Yüzme','kardio',NULL),(7,'Spinning','kardio',NULL),(8,'Zumba','dans',NULL),(9,'Kickboks','dövüş',NULL),(10,'TRX','fonksiyonel',NULL),(11,'Vücut Geliştirme','kuvvet',NULL),(12,'Powerlifting','kuvvet',NULL);
/*!40000 ALTER TABLE `spor_branslari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uye_spor_branslari`
--

DROP TABLE IF EXISTS `uye_spor_branslari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uye_spor_branslari` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `brans_id` int NOT NULL,
  `ilgi_seviyesi` enum('dusuk','orta','yuksek') COLLATE utf8mb4_unicode_ci DEFAULT 'orta',
  `deneyim_seviyesi` enum('baslangic','orta','ileri','profesyonel') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baslangic_tarihi` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_uye_brans` (`uye_id`,`brans_id`),
  KEY `brans_id` (`brans_id`),
  CONSTRAINT `uye_spor_branslari_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE,
  CONSTRAINT `uye_spor_branslari_ibfk_2` FOREIGN KEY (`brans_id`) REFERENCES `spor_branslari` (`brans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uye_spor_branslari`
--

LOCK TABLES `uye_spor_branslari` WRITE;
/*!40000 ALTER TABLE `uye_spor_branslari` DISABLE KEYS */;
/*!40000 ALTER TABLE `uye_spor_branslari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uyeler`
--

DROP TABLE IF EXISTS `uyeler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uyeler` (
  `uye_id` int NOT NULL AUTO_INCREMENT,
  `tc_kimlik` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soyad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dogum_tarihi` date NOT NULL,
  `cinsiyet` enum('E','K','D') COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adres` text COLLATE utf8mb4_unicode_ci,
  `acil_durum_kisi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acil_durum_tel` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profil_foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kayit_tarihi` datetime DEFAULT CURRENT_TIMESTAMP,
  `aktif_mi` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`uye_id`),
  UNIQUE KEY `tc_kimlik` (`tc_kimlik`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_ad_soyad` (`ad`,`soyad`),
  KEY `idx_telefon` (`telefon`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uyeler`
--

LOCK TABLES `uyeler` WRITE;
/*!40000 ALTER TABLE `uyeler` DISABLE KEYS */;
INSERT INTO `uyeler` VALUES (1,'12345678901','Ali','Koç','1990-05-15','E','05301112233','ali@email.com',NULL,NULL,NULL,NULL,'2026-04-01 21:56:24',1),(2,'23456789012','Ayşe','Yıldız','1995-08-22','K','05302223344','ayse@email.com',NULL,NULL,NULL,NULL,'2026-04-01 21:56:24',1),(3,'34567890123','Mehmet','Şahin','1988-03-10','E','05303334455','mehmet@email.com',NULL,NULL,NULL,NULL,'2026-04-01 21:56:24',1),(4,'45678901234','Fatma','Arslan','1992-11-28','K','05304445566','fatma@email.com',NULL,NULL,NULL,NULL,'2026-04-01 21:56:24',1),(5,'56789012345','Emre','Güneş','1985-07-04','E','05305556677','emre@email.com',NULL,NULL,NULL,NULL,'2026-04-01 21:56:24',1);
/*!40000 ALTER TABLE `uyeler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uyelik_paketleri`
--

DROP TABLE IF EXISTS `uyelik_paketleri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uyelik_paketleri` (
  `paket_id` int NOT NULL AUTO_INCREMENT,
  `paket_adi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sure_gun` int NOT NULL,
  `fiyat` decimal(10,2) NOT NULL,
  `pt_seans_hakki` int DEFAULT '0',
  `grup_ders_hakki` int DEFAULT NULL,
  `dolap_dahil` tinyint(1) DEFAULT '0',
  `havuz_erisim` tinyint(1) DEFAULT '0',
  `sauna_erisim` tinyint(1) DEFAULT '0',
  `aciklama` text COLLATE utf8mb4_unicode_ci,
  `aktif_mi` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`paket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uyelik_paketleri`
--

LOCK TABLES `uyelik_paketleri` WRITE;
/*!40000 ALTER TABLE `uyelik_paketleri` DISABLE KEYS */;
INSERT INTO `uyelik_paketleri` VALUES (1,'Aylık Temel',30,500.00,0,NULL,0,0,0,NULL,1),(2,'Aylık Premium',30,800.00,4,NULL,0,1,1,NULL,1),(3,'3 Aylık Temel',90,1350.00,0,NULL,0,0,0,NULL,1),(4,'3 Aylık Premium',90,2100.00,12,NULL,0,1,1,NULL,1),(5,'Yıllık Temel',365,4800.00,0,NULL,0,0,0,NULL,1),(6,'Yıllık VIP',365,8500.00,52,NULL,0,1,1,NULL,1),(7,'Öğrenci Paketi',30,350.00,0,NULL,0,0,0,NULL,1),(8,'Sadece Havuz',30,400.00,0,NULL,0,1,0,NULL,1);
/*!40000 ALTER TABLE `uyelik_paketleri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uyelikler`
--

DROP TABLE IF EXISTS `uyelikler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uyelikler` (
  `uyelik_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `paket_id` int NOT NULL,
  `baslangic_tarihi` date NOT NULL,
  `bitis_tarihi` date NOT NULL,
  `odenen_tutar` decimal(10,2) NOT NULL,
  `odeme_yontemi` enum('nakit','kredi_karti','havale','eft') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indirim_orani` decimal(5,2) DEFAULT '0.00',
  `kalan_pt_seans` int DEFAULT '0',
  `durum` enum('aktif','pasif','dondurulmus','iptal') COLLATE utf8mb4_unicode_ci DEFAULT 'aktif',
  PRIMARY KEY (`uyelik_id`),
  KEY `paket_id` (`paket_id`),
  KEY `idx_uye_durum` (`uye_id`,`durum`),
  KEY `idx_bitis` (`bitis_tarihi`),
  CONSTRAINT `uyelikler_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE,
  CONSTRAINT `uyelikler_ibfk_2` FOREIGN KEY (`paket_id`) REFERENCES `uyelik_paketleri` (`paket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uyelikler`
--

LOCK TABLES `uyelikler` WRITE;
/*!40000 ALTER TABLE `uyelikler` DISABLE KEYS */;
INSERT INTO `uyelikler` VALUES (1,1,2,'2026-01-01','2026-01-31',800.00,'kredi_karti',0.00,0,'aktif'),(2,2,6,'2026-01-01','2026-12-31',8500.00,'havale',0.00,0,'aktif'),(3,3,4,'2026-02-01','2026-04-30',2100.00,'kredi_karti',0.00,0,'aktif'),(4,4,1,'2026-03-01','2026-03-31',500.00,'nakit',0.00,0,'aktif'),(5,5,5,'2025-06-01','2026-05-31',4800.00,'eft',0.00,0,'aktif');
/*!40000 ALTER TABLE `uyelikler` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-01 22:10:13
