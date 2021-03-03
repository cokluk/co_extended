-- CO SQL Dump
-- https://www.cokluk.com/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 03 Mar 2021, 07:28:46
-- Sunucu sürümü: 10.4.14-MariaDB
-- LISANS SAHIBI : COMAVEN 
-- LISANS KODU : CMVN

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `essentialmode`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `co_base`
--

CREATE TABLE `co_base` (
  `online` text NOT NULL,
  `durum` text NOT NULL,
  `degistirilebilir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `co_logger`
--

CREATE TABLE `co_logger` (
  `id` int(11) NOT NULL,
  `tip` text NOT NULL,
  `veri` text NOT NULL,
  `zaman` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `co_playerlist`
--

CREATE TABLE `co_playerlist` (
  `id` int(11) NOT NULL,
  `uid` text NOT NULL,
  `oyuncu_ismi` text NOT NULL,
  `identifier` text NOT NULL,
  `ping` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `co_base`
--
ALTER TABLE `co_base`
  ADD PRIMARY KEY (`degistirilebilir`);

--
-- Tablo için indeksler `co_logger`
--
ALTER TABLE `co_logger`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `co_playerlist`
--
ALTER TABLE `co_playerlist`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `co_base`
--
ALTER TABLE `co_base`
  MODIFY `degistirilebilir` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `co_logger`
--
ALTER TABLE `co_logger`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `co_playerlist`
--
ALTER TABLE `co_playerlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
