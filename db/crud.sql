-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-02-2025 a las 21:11:59
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `crud`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ALTAS` (IN `iID` VARCHAR(50) CHARSET utf8, IN `iNOMBRE` VARCHAR(250) CHARSET utf8, IN `iPAPELLIDO` VARCHAR(250) CHARSET utf8, IN `iSAPELLIDO` VARCHAR(250) CHARSET utf8, IN `iLOGIN` VARCHAR(50) CHARSET utf8, IN `iPWD` VARCHAR(50) CHARSET utf8)   BEGIN
	START TRANSACTION;
    
    # 1.- Registro los datos personales
    INSERT INTO datospersonales(id, nombre, pApellido) VALUES(iID, iNOMBRE, iPAPELLIDO);
    
    # 2.- Si es necesario, registro un segundo apellido
    IF iSAPELLIDO <> globales.CC("NO_DEFINIDO") THEN
    	INSERT INTO sapellidos(id, sapellido) VALUES(iID, iSAPELLIDO);
    END IF;
    
    # 3.- Registro el login
    INSERT INTO logins(id, login, pwd) VALUES(iID, iLOGIN, iPWD);
    
    # 4.- Registro un acceso del usuario
    INSERT INTO accesos(id) VALUES(iID);
    
    # 5.- Confirmo la transacción
	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BAJAS` (IN `iID` VARCHAR(50) CHARSET utf8)   BEGIN
	IF NOT EXISTS(SELECT * FROM datospersonales WHERE id = iID) THEN
		SELECT globales.CN("BAJA_FALLIDA") AS resultado;
	ELSE
		DELETE FROM datospersonales WHERE id = iID;
		SELECT IF(NOT EXISTS(SELECT * FROM datospersonales WHERE id = iID), globales.CN("BAJA_EXITOSA"), globales.CN("BAJA_FALLIDA")) AS resultado;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CAMBIOS` (IN `iID` VARCHAR(50) CHARSET utf8, IN `iNOMBRE` VARCHAR(250) CHARSET utf8, IN `iPAPELLIDO` VARCHAR(250) CHARSET utf8, IN `iSAPELLIDO` VARCHAR(250) CHARSET utf8, IN `iLOGIN` VARCHAR(50) CHARSET utf8, IN `iPWD` VARCHAR(50) CHARSET utf8)   BEGIN
	START TRANSACTION;
    
    # 1.- Actualizar los datos personales
    UPDATE datospersonales SET id = iID, nombre = iNOMBRE, pApellido = iPAPELLIDO WHERE id = iID;
    
    # 2.- Si es necesario, actualizar el segundo apellido
    IF iSAPELLIDO <> globales.CC("NO_DEFINIDO") THEN
        UPDATE sapellidos SET id = iID, sapellido = iSAPELLIDO WHERE id = iID;
        ELSE
        	INSERT INTO logins(id, login, pwd) VALUES(iID, iLOGIN, iPWD);
    END IF;
    
    # 3.- Actualizar el login
    UPDATE logins SET id = iID, login = iLOGIN, pwd = iPWD WHERE id = iID;
    
    # 4.- Confirmo la transacción
	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS` (IN `iPAGINA` INT)   BEGIN
    DECLARE PAGINADOR INT DEFAULT globales.CN('PAGINADOR');
    DECLARE COMIENZO INT;
    DECLARE PAGINACION VARCHAR(250) DEFAULT '';

    IF iPAGINA <> 0 THEN
        SET COMIENZO = PAGINADOR * (iPAGINA-1);
        SET PAGINACION = CONCAT(' LIMIT ', COMIENZO, ',' ,PAGINADOR);
    END IF;

    SET @sql = CONCAT('SELECT datospersonales.id, nombre, pApellido, IF(sApellido = "", "ND", sApellido) as sApellido, login FROM datospersonales
    LEFT JOIN sapellidos ON datospersonales.id = sapellidos.id
    JOIN logins ON datospersonales.id = logins.id', PAGINACION, ';');
    PREPARE stm FROM @sql;
    EXECUTE stm;
    DEALLOCATE PREPARE stm;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSULTAS_ID` (IN `iID` VARCHAR(50) CHARSET utf8)   SELECT datospersonales.id,nombre,papellido, IF (ISNULL(sapellido), globales.CC("NO_DEFINIDO"), sapellido) AS sapellido FROM datospersonales LEFT JOIN sapellidos ON datospersonales.id = sapellidos.id WHERE datospersonales.id = iID$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accesos`
--

CREATE TABLE `accesos` (
  `id` varchar(50) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `accesos`
--

INSERT INTO `accesos` (`id`, `fecha`) VALUES
('H7X9K2L3V8B5D1N4M6', '2025-02-14 13:19:28'),
('P5F8R2L9D3X7M1B6V4', '2025-02-14 13:40:33'),
('X3V7M5B1L9P4F8D2R6', '2025-02-14 13:42:32'),
('L2D8X9B5F3V7P1M4R6', '2025-02-14 13:50:01'),
('M4B7V1X9D3F8P5L2R6', '2025-02-14 14:09:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datospersonales`
--

CREATE TABLE `datospersonales` (
  `id` varchar(50) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `pApellido` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `datospersonales`
--

INSERT INTO `datospersonales` (`id`, `nombre`, `pApellido`) VALUES
('H7X9K2L3V8B5D1N4M6', 'Carlos', 'Gómez'),
('L2D8X9B5F3V7P1M4R6', 'Ana', 'Rodríguez'),
('M4B7V1X9D3F8P5L2R6', 'Pedro', 'Hernández'),
('P5F8R2L9D3X7M1B6V4', 'María', 'Fernández'),
('X3V7M5B1L9P4F8D2R6', 'Javier', 'Martínez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logins`
--

CREATE TABLE `logins` (
  `id` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `pwd` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `logins`
--

INSERT INTO `logins` (`id`, `login`, `pwd`) VALUES
('H7X9K2L3V8B5D1N4M6', 'CarlosG', 'abc12345'),
('P5F8R2L9D3X7M1B6V4', 'MariaFL', 'pass2024'),
('X3V7M5B1L9P4F8D2R6', 'JavierM', 'test9876'),
('L2D8X9B5F3V7P1M4R6', 'AnaRG', 'qwerty12'),
('M4B7V1X9D3F8P5L2R6', 'PedroH', 'pedro789');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sapellidos`
--

CREATE TABLE `sapellidos` (
  `id` varchar(50) NOT NULL,
  `sApellido` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `sapellidos`
--

INSERT INTO `sapellidos` (`id`, `sApellido`) VALUES
('H7X9K2L3V8B5D1N4M6', 'Ramírez'),
('P5F8R2L9D3X7M1B6V4', 'López'),
('X3V7M5B1L9P4F8D2R6', 'Sánchez'),
('L2D8X9B5F3V7P1M4R6', 'Gutiérrez'),
('M4B7V1X9D3F8P5L2R6', 'Morales');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesos`
--
ALTER TABLE `accesos`
  ADD KEY `accesos_datosPersonales` (`id`);

--
-- Indices de la tabla `datospersonales`
--
ALTER TABLE `datospersonales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `logins`
--
ALTER TABLE `logins`
  ADD KEY `logins_datosPersonales` (`id`);

--
-- Indices de la tabla `sapellidos`
--
ALTER TABLE `sapellidos`
  ADD KEY `sApellidos_datosPersonales` (`id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `accesos`
--
ALTER TABLE `accesos`
  ADD CONSTRAINT `accesos_datosPersonales` FOREIGN KEY (`id`) REFERENCES `datospersonales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `logins`
--
ALTER TABLE `logins`
  ADD CONSTRAINT `logins_datosPersonales` FOREIGN KEY (`id`) REFERENCES `datospersonales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sapellidos`
--
ALTER TABLE `sapellidos`
  ADD CONSTRAINT `sApellidos_datosPersonales` FOREIGN KEY (`id`) REFERENCES `datospersonales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
