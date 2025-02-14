-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-12-2023 a las 06:10:12
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `globales`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONSTANTES_CONSULTAS` ()   SELECT * FROM constantes ORDER BY constante$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MENSAJES_CONSULTAS` (IN `iMODULO` INT)   SELECT mensaje, descripcion FROM mensajes WHERE modulo = 0 OR modulo = iMODULO ORDER BY mensaje$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CC` (`iCONSTANTE` VARCHAR(250) CHARSET utf8) RETURNS VARCHAR(250) CHARSET utf8 COLLATE utf8_general_ci COMMENT 'Retorna el valor de una constante numérica' IF(EXISTS(SELECT * FROM constantes WHERE constante = iCONSTANTE AND numerica = "0")) THEN
	RETURN (SELECT valor FROM constantes WHERE constante = iCONSTANTE AND numerica = "0");
ELSE
	RETURN "ND";
END IF$$

CREATE DEFINER=`root`@`localhost` FUNCTION `CN` (`iCONSTANTE` VARCHAR(250) CHARSET utf8) RETURNS INT(11) COMMENT 'Retorna el valor de una constante de tipo numérico' IF(EXISTS(SELECT * FROM constantes WHERE constante = iCONSTANTE AND numerica = "1")) THEN
	RETURN (SELECT CAST(valor AS INT) FROM constantes WHERE constante = iCONSTANTE AND numerica = "1");
ELSE
	RETURN -1;
END IF$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `constantes`
--

CREATE TABLE `constantes` (
  `constante` varchar(250) NOT NULL,
  `valor` varchar(250) NOT NULL,
  `numerica` int(11) NOT NULL DEFAULT 1,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `constantes`
--

INSERT INTO `constantes` (`constante`, `valor`, `numerica`, `descripcion`) VALUES
('ALTA_EXITOSA', '1', 1, 'Reporta un alta exitosa sobre una base de datos.'),
('ALTA_FALLIDA', '2', 1, 'Reporta un alta fallida sobre una base de datos.'),
('BAJA_EXITOSA', '3', 1, 'Reporta una baja exitosa sobre una base de datos.'),
('BAJA_FALLIDA', '4', 1, 'Reporta una baja fallida sobre una base de datos.'),
('CAMBIO_EXITOSO', '5', 1, 'Reporta un cambio exitoso sobre una base de datos.'),
('CAMBIO_FALLIDO', '6', 1, 'Reporta un cambio fallido sobre una base de datos.'),
('CONSULTA_EXITOSA', '7', 1, 'Reporta una consulta exitosa sobre una base de datos.'),
('CONSULTA_FALLIDA', '8', 1, 'Reporta una consulta sin resultados sobre una base de datos.'),
('NO_DEFINIDO', 'ND', 0, 'Representa cualquier valor no definido'),
('PAGINADOR', '50', 1, 'Indica el número de registros a recuperar por consulta.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `mensaje` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descripcion` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modulo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `modulo` int(11) NOT NULL,
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `constantes`
--
ALTER TABLE `constantes`
  ADD UNIQUE KEY `constantes_indice` (`constante`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`mensaje`),
  ADD KEY `mensajes_modulos` (`modulo`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`modulo`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_modulos` FOREIGN KEY (`modulo`) REFERENCES `modulos` (`modulo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
