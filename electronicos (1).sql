-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-08-2021 a las 03:12:17
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `electronicos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createAddress` (IN `p_street` VARCHAR(64), IN `p_town` VARCHAR(64), IN `p_zipCode` INT, IN `p_state` VARCHAR(64), IN `p_country` VARCHAR(64), OUT `p_id` INT)  BEGIN
	INSERT INTO addresses (street, town, zipCode, state, country)
    VALUES (p_street, p_town, p_zipCode, p_state, p_country);
    SET p_id = LAST_INSERT_ID();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createDevice` (IN `p_name` VARCHAR(64), IN `p_address` INT)  BEGIN
	INSERT INTO devices (name, address)
    VALUES (p_name, p_address);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDevice` (IN `p_id` INT)  BEGIN
	UPDATE devices AS d
    SET d.status = 0
    WHERE d.id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAddresses` ()  BEGIN
	SELECT * FROM addresses;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllDevices` ()  BEGIN
	SELECT * FROM devices AS d
    INNER JOIN addresses AS a ON d.address = a.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDeviceById` (IN `p_id` INT)  BEGIN
	SELECT * FROM devices AS d
    INNER JOIN addresses AS a ON d.address = a.id
    WHERE d.id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateDevice` (IN `p_id` INT, IN `p_name` VARCHAR(64), IN `p_address` INT)  BEGIN
	UPDATE devices as d 
    SET name = p_name, address = p_address
    WHERE id = p_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `street` varchar(64) NOT NULL,
  `town` varchar(64) NOT NULL,
  `zipCode` int(11) NOT NULL,
  `state` varchar(64) NOT NULL,
  `country` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `addresses`
--

INSERT INTO `addresses` (`id`, `street`, `town`, `zipCode`, `state`, `country`) VALUES
(6, 'Torres', 'Ocotepec', 62847, 'Morelos', 'México');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `address` int(11) NOT NULL,
  `registerDate` date NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `devices`
--

INSERT INTO `devices` (`id`, `name`, `address`, `registerDate`, `status`) VALUES
(9, 'Laptop', 6, '2021-08-27', 1);

--
-- Disparadores `devices`
--
DELIMITER $$
CREATE TRIGGER `checkAdresses` AFTER UPDATE ON `devices` FOR EACH ROW BEGIN
    DECLARE v_countAddress INT;
    SELECT COUNT(*) 
    INTO v_countAddress
    FROM devices AS d
    WHERE d.address = OLD.id;
    
    IF v_countAddress = 0 THEN
    	DELETE FROM addresses WHERE id = OLD.id;
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `devices_addresses_fk` (`address`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `devices`
--
ALTER TABLE `devices`
  ADD CONSTRAINT `devices_addresses_fk` FOREIGN KEY (`address`) REFERENCES `addresses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
