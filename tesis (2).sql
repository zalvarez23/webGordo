-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-01-2017 a las 00:19:50
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `tesis`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`(
_nombres varchar(35),
_apellidos varchar(35),
_dni varchar(35),
_edad varchar(35),
_direccion varchar(50))
BEGIN
		
INSERT INTO `tesis`.`persona` 
(`ID_PERSONA`, `NOMBRE_PERSONA`, `APELLIDOS_PERSONA`, `DNI`, `EDAD`, `SEXO`, `DIRECCION`, `ESTADO`) 
VALUES (NULL, _nombres, _apellidos, _dni, _edad, 'M', _direccion, '1');
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listViajes`(_tipo int,_idorigen int,_iddestino int,_fechap varchar(35),_fechar varchar(35))
BEGIN
    IF _tipo = 1 THEN 
 	SELECT DES.ID_DESTINO,DES.ID_PROGRAMACION,DES.PRECIO_VIAJES,DES.ESTADO_VIAJES,
	CIUO.ID_CIUDAD idorigen,CIUO.NOMBRE_CIUDAD origen,CIUD.ID_CIUDAD iddestino,CIUD.NOMBRE_CIUDAD destino,
	DATE_FORMAT(PRO.FECHA_PROGRAMADO,'%d/%m/%Y') FECHA_PROGRAMADO,PRO.HORA_PROGRAMADO,PRO.TIPO_VIAJE,DATE_FORMAT(PRO.FECHA_REGRESO,'%d/%m/%Y') FECHA_REGRESO,
	PRO.HORA_REGRESO,BU.NUMERO_BUS,BU.NUMERO_PLACA,BU.CAPACIDAD,ASI.NUMERO_ASIENTO,DES.ASIENTOS_RESERVADOS
	FROM DESTINOS DES
	INNER JOIN PROG_HORIOS PRO ON PRO.ID_PROGRAMACION = DES.ID_PROGRAMACION
	INNER JOIN BUSES BU ON BU.ID_BUSES = PRO.ID_BUSES
	INNER JOIN ASIENTOS ASI ON ASI.ID_ASIENTOS = BU.ID_ASIENTOS
	INNER JOIN CIUDADES CIUO ON CIUO.ID_CIUDAD = DES.ID_CIUDAD_ORIGEN
	INNER JOIN CIUDADES CIUD ON CIUD.ID_CIUDAD = DES.ID_CIUDAD_DESTINO

	WHERE CIUO.ID_CIUDAD = _idorigen AND CIUD.ID_CIUDAD = _iddestino AND PRO.FECHA_PROGRAMADO = _fechap;   
    ELSE
	SELECT DES.ID_DESTINO,DES.ID_PROGRAMACION,DES.PRECIO_VIAJES,DES.ESTADO_VIAJES,
	CIUO.ID_CIUDAD idorigen,CIUO.NOMBRE_CIUDAD origen,CIUD.ID_CIUDAD iddestino,CIUD.NOMBRE_CIUDAD destino,
	DATE_FORMAT(PRO.FECHA_PROGRAMADO,'%d/%m/%Y') FECHA_PROGRAMADO,PRO.HORA_PROGRAMADO,PRO.TIPO_VIAJE,DATE_FORMAT(PRO.FECHA_REGRESO,'%d/%m/%Y') FECHA_REGRESO,
	PRO.HORA_REGRESO,BU.NUMERO_BUS,BU.NUMERO_PLACA,BU.CAPACIDAD,ASI.NUMERO_ASIENTO,DES.ASIENTOS_RESERVADOS
	FROM DESTINOS DES
	INNER JOIN PROG_HORIOS PRO ON PRO.ID_PROGRAMACION = DES.ID_PROGRAMACION
	INNER JOIN BUSES BU ON BU.ID_BUSES = PRO.ID_BUSES
	INNER JOIN ASIENTOS ASI ON ASI.ID_ASIENTOS = BU.ID_ASIENTOS
	INNER JOIN CIUDADES CIUO ON CIUO.ID_CIUDAD = DES.ID_CIUDAD_ORIGEN
	INNER JOIN CIUDADES CIUD ON CIUD.ID_CIUDAD = DES.ID_CIUDAD_DESTINO

	WHERE CIUO.ID_CIUDAD = _idorigen AND CIUD.ID_CIUDAD = _iddestino AND PRO.FECHA_PROGRAMADO = _fechap AND PRO.FECHA_REGRESO = _fechar; 
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_newUsuasrio`(
_nombres varchar(35),
_apellidos varchar(35),
_dni varchar(35),
_edad varchar(35),
_direccion varchar(50),
_usuario varchar(35),
_pass varchar(35))
BEGIN
		
INSERT INTO `tesis`.`persona` 
(`ID_PERSONA`, `NOMBRE_PERSONA`, `APELLIDOS_PERSONA`, `DNI`, `EDAD`, `SEXO`, `DIRECCION`, `ESTADO`) 
VALUES (NULL, _nombres, _apellidos, _dni, _edad, 'M', _direccion, '1');

SET @IDPERSONA = last_insert_id();


INSERT INTO `tesis`.`usuarios` 
(`ID_USUARIO`, `ID_PERSONA`, `USUARIO`, `CONTRASENA`, `ESTADO`) VALUES (NULL, @IDPERSONA, _usuario, _pass, '1'); 
   
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asientos`
--

CREATE TABLE IF NOT EXISTS `asientos` (
  `ID_ASIENTOS` int(11) NOT NULL,
  `NUMERO_ASIENTO` int(11) NOT NULL,
  `ESTADO_ASIENTO` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID_ASIENTOS`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `asientos`
--

INSERT INTO `asientos` (`ID_ASIENTOS`, `NUMERO_ASIENTO`, `ESTADO_ASIENTO`) VALUES
(1, 15, '1'),
(2, 15, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buses`
--

CREATE TABLE IF NOT EXISTS `buses` (
  `ID_BUSES` int(11) NOT NULL,
  `NUMERO_BUS` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `NUMERO_PLACA` char(7) COLLATE utf8_unicode_ci NOT NULL,
  `CAPACIDAD` int(11) NOT NULL,
  `ESTADO` varchar(50) CHARACTER SET utf8 NOT NULL,
  `ID_ASIENTOS` int(11) NOT NULL,
  PRIMARY KEY (`ID_BUSES`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `buses`
--

INSERT INTO `buses` (`ID_BUSES`, `NUMERO_BUS`, `NUMERO_PLACA`, `CAPACIDAD`, `ESTADO`, `ID_ASIENTOS`) VALUES
(1, '001', 'KEV123', 1, '1', 1),
(2, '002', 'SDAKJ23', 1, '1', 2),
(3, '003', 'OIEWK2', 1, '1', 1),
(4, '004', 'KOK48', 1, '1', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE IF NOT EXISTS `ciudades` (
  `ID_CIUDAD` int(11) NOT NULL,
  `NOMBRE_CIUDAD` varchar(50) CHARACTER SET utf8 NOT NULL,
  `descripcion2` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `img` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `ubicacion` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `ESTADO_CIUDAD` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`ID_CIUDAD`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`ID_CIUDAD`, `NOMBRE_CIUDAD`, `descripcion2`, `img`, `ubicacion`, `ESTADO_CIUDAD`) VALUES
(1, 'Trujillo', 'Trujillo, capital del departamento de La Libertad, se encuentra ubicada a 335 metros sobre el nivel del mar, a 5 Km de la costa,', 'img/trujillo.png', '-8.1134168|-79.0329839', '1'),
(2, 'Ica', '	\nReseña Histórica\n\nEn 1534, Nicolás de Ribera el Viejo - uno de los Trece del Gallo, hombre de confianza de Francisco Pizarro - estuvo buscando un lugar ', 'img/ica.jpg', '-14.0836684|-75.7807629', '1'),
(3, 'Huaraz', '	\nReseña Histórica\n\nEn 1534, Nicolás de Ribera el Viejo - uno de los Trece del Gallo, hombre de confianza de Francisco Pizarro - estuvo buscando un lugar ', 'img/huaraz.png', '-9.5156855|-77.5417829', '1'),
(4, 'Huacho', '	\nReseña Histórica\n\nEn 1534, Nicolás de Ribera el Viejo - uno de los Trece del Gallo, hombre de confianza de Francisco Pizarro - estuvo buscando un lugar ', 'img/trujillo.png', '-11.1262353|-77.6248698', '1'),
(5, 'CAJAMARCA', '	\nReseña Histórica\n\nEn 1534, Nicolás de Ribera el Viejo - uno de los Trece del Gallo, hombre de confianza de Francisco Pizarro - estuvo buscando un lugar ', 'img/ica.jpg', '-7.160593|-78.5217548', '1'),
(6, 'LIMA', '	\nReseña Histórica\n\nEn 1534, Nicolás de Ribera el Viejo - uno de los Trece del Gallo, hombre de confianza de Francisco Pizarro - estuvo buscando un lugar ', 'img/huaraz.png', '-12.0552608|-77.0627752', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `destinos`
--

CREATE TABLE IF NOT EXISTS `destinos` (
  `ID_DESTINO` int(11) NOT NULL,
  `ID_PROGRAMACION` int(11) NOT NULL,
  `ID_CIUDAD_ORIGEN` int(11) NOT NULL,
  `ID_CIUDAD_DESTINO` int(11) NOT NULL,
  `PRECIO_VIAJES` decimal(10,2) NOT NULL,
  `ESTADO_VIAJES` varchar(50) CHARACTER SET utf8 NOT NULL,
  `ASIENTOS_RESERVADOS` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID_DESTINO`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `destinos`
--

INSERT INTO `destinos` (`ID_DESTINO`, `ID_PROGRAMACION`, `ID_CIUDAD_ORIGEN`, `ID_CIUDAD_DESTINO`, `PRECIO_VIAJES`, `ESTADO_VIAJES`, `ASIENTOS_RESERVADOS`) VALUES
(1, 1, 6, 1, '50.00', '1', '[2,16]'),
(2, 2, 6, 2, '60.00', '1', ''),
(3, 3, 1, 3, '80.00', '1', ''),
(4, 4, 1, 4, '66.00', '1', ''),
(5, 5, 2, 5, '55.00', '1', '[2,15,23]'),
(6, 6, 6, 1, '55.00', '1', '[2,6,9,16]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE IF NOT EXISTS `empleados` (
  `ID_EMPLEADO` int(11) NOT NULL,
  `ID_PERSONA` int(11) NOT NULL,
  `ID_BUSES` int(11) NOT NULL,
  `CARGO` varchar(50) CHARACTER SET utf8 NOT NULL,
  `ESTADO` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`ID_EMPLEADO`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `list_checklist_all`
--

CREATE TABLE IF NOT EXISTS `list_checklist_all` (
  `id` tinyint(4) NOT NULL,
  `fecha` tinyint(4) NOT NULL,
  `fechaA` tinyint(4) NOT NULL,
  `unidad` tinyint(4) NOT NULL,
  `hora` tinyint(4) NOT NULL,
  `observacion` tinyint(4) NOT NULL,
  `ubicacion` tinyint(4) NOT NULL,
  `regTotal` tinyint(4) NOT NULL,
  `nombres` tinyint(4) NOT NULL,
  `apellidos` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `ID_PERSONA` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE_PERSONA` varchar(50) CHARACTER SET utf8 NOT NULL,
  `APELLIDOS_PERSONA` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `DNI` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `EDAD` int(11) NOT NULL,
  `SEXO` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `DIRECCION` varchar(100) CHARACTER SET utf8 NOT NULL,
  `ESTADO` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`ID_PERSONA`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`ID_PERSONA`, `NOMBRE_PERSONA`, `APELLIDOS_PERSONA`, `DNI`, `EDAD`, `SEXO`, `DIRECCION`, `ESTADO`) VALUES
(1, 'kevin luis', 'salazar ramos', '47523297', 24, 'M', 'a.v jorge basadre 3282', '1'),
(6, 'luis', 'Salazar Ramos', '475232', 22, 'M', 'a.v', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prog_horios`
--

CREATE TABLE IF NOT EXISTS `prog_horios` (
  `ID_PROGRAMACION` int(11) NOT NULL,
  `ID_BUSES` int(11) NOT NULL,
  `FECHA_PROGRAMADO` date NOT NULL,
  `HORA_PROGRAMADO` time NOT NULL,
  `TIPO_VIAJE` int(11) NOT NULL,
  `FECHA_REGRESO` date NOT NULL,
  `HORA_REGRESO` time NOT NULL,
  `ESTADO_PROGRAMACION` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`ID_PROGRAMACION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `prog_horios`
--

INSERT INTO `prog_horios` (`ID_PROGRAMACION`, `ID_BUSES`, `FECHA_PROGRAMADO`, `HORA_PROGRAMADO`, `TIPO_VIAJE`, `FECHA_REGRESO`, `HORA_REGRESO`, `ESTADO_PROGRAMACION`) VALUES
(1, 1, '2017-01-04', '09:00:00', 1, '0000-00-00', '00:00:00', '1'),
(2, 2, '2017-01-14', '10:00:00', 1, '0000-00-00', '00:00:00', '1'),
(3, 3, '2017-01-14', '12:00:00', 1, '0000-00-00', '00:00:00', '1'),
(4, 4, '2017-01-14', '10:00:00', 2, '2017-01-25', '10:00:00', '1'),
(5, 1, '2017-01-20', '13:00:00', 2, '2017-01-30', '13:00:00', '1'),
(6, 2, '2017-01-04', '19:00:00', 1, '0000-00-00', '00:00:00', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE IF NOT EXISTS `reservas` (
  `ID_RESERVAS` int(11) NOT NULL AUTO_INCREMENT,
  `ID_USUARIO` int(11) NOT NULL,
  `ID_PERSONA` int(11) NOT NULL,
  `ID_DESTINO` int(11) NOT NULL,
  `ASIENTOS_RESERVADOS` varchar(50) NOT NULL,
  `FECHA_RESERVA` date NOT NULL,
  `HORA_RESERVA` time NOT NULL,
  `CANTIDAD` int(11) NOT NULL,
  `PRECIO_TOTAL` varchar(45) NOT NULL,
  `puntaje` int(11) NOT NULL,
  `ESTADO_RESERVA` char(1) NOT NULL,
  PRIMARY KEY (`ID_RESERVAS`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`ID_RESERVAS`, `ID_USUARIO`, `ID_PERSONA`, `ID_DESTINO`, `ASIENTOS_RESERVADOS`, `FECHA_RESERVA`, `HORA_RESERVA`, `CANTIDAD`, `PRECIO_TOTAL`, `puntaje`, `ESTADO_RESERVA`) VALUES
(8, 1, 0, 6, '[2,6,9,16]', '2017-01-06', '10:34:11', 4, '335.00', 2, '1'),
(9, 1, 1, 6, '[2,6,9,16]', '2017-01-06', '10:47:47', 4, '335.00', 5, '1'),
(10, 1, 1, 5, '[2,15,23]', '2017-01-06', '11:30:40', 3, '240.00', 4, '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `ID_USUARIO` int(11) NOT NULL AUTO_INCREMENT,
  `ID_PERSONA` int(11) NOT NULL,
  `USUARIO` varchar(50) CHARACTER SET utf8 NOT NULL,
  `CONTRASENA` varchar(50) CHARACTER SET utf8 NOT NULL,
  `ESTADO` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`ID_USUARIO`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID_USUARIO`, `ID_PERSONA`, `USUARIO`, `CONTRASENA`, `ESTADO`) VALUES
(1, 1, 'kevin', '123', '1'),
(5, 6, 'luis', '123', '1');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_listahistorial`
--
CREATE TABLE IF NOT EXISTS `v_listahistorial` (
`ID_DESTINO` int(11)
,`ID_RESERVAS` int(11)
,`ID_PROGRAMACION` int(11)
,`PRECIO_VIAJES` decimal(10,2)
,`ESTADO_VIAJES` varchar(50)
,`idorigen` int(11)
,`origen` varchar(50)
,`iddestino` int(11)
,`destino` varchar(50)
,`FECHA_PROGRAMADO` varchar(10)
,`HORA_PROGRAMADO` time
,`TIPO_VIAJE` int(11)
,`FECHA_REGRESO` varchar(10)
,`HORA_REGRESO` time
,`NUMERO_BUS` char(10)
,`NUMERO_PLACA` char(7)
,`CAPACIDAD` int(11)
,`NUMERO_ASIENTO` int(11)
,`ASIENTOS_RESERVADOS` varchar(200)
,`ID_USUARIO` int(11)
,`ID_PERSONA` int(11)
,`ASIENTOS_SELECCIONADOS` varchar(50)
,`FECHA_RESERVA` varchar(10)
,`HORA_RESERVA` time
,`CANTIDAD_SELECCIONADOS` int(11)
,`PRECIO_TOTAL` varchar(45)
,`ESTADO_RESERVA` char(1)
,`puntaje` int(11)
);
-- --------------------------------------------------------

--
-- Estructura para la vista `v_listahistorial`
--
DROP TABLE IF EXISTS `v_listahistorial`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_listahistorial` AS select `des`.`ID_DESTINO` AS `ID_DESTINO`,`re`.`ID_RESERVAS` AS `ID_RESERVAS`,`des`.`ID_PROGRAMACION` AS `ID_PROGRAMACION`,`des`.`PRECIO_VIAJES` AS `PRECIO_VIAJES`,`des`.`ESTADO_VIAJES` AS `ESTADO_VIAJES`,`ciuo`.`ID_CIUDAD` AS `idorigen`,`ciuo`.`NOMBRE_CIUDAD` AS `origen`,`ciud`.`ID_CIUDAD` AS `iddestino`,`ciud`.`NOMBRE_CIUDAD` AS `destino`,date_format(`pro`.`FECHA_PROGRAMADO`,'%d/%m/%Y') AS `FECHA_PROGRAMADO`,`pro`.`HORA_PROGRAMADO` AS `HORA_PROGRAMADO`,`pro`.`TIPO_VIAJE` AS `TIPO_VIAJE`,date_format(`pro`.`FECHA_REGRESO`,'%d/%m/%Y') AS `FECHA_REGRESO`,`pro`.`HORA_REGRESO` AS `HORA_REGRESO`,`bu`.`NUMERO_BUS` AS `NUMERO_BUS`,`bu`.`NUMERO_PLACA` AS `NUMERO_PLACA`,`bu`.`CAPACIDAD` AS `CAPACIDAD`,`asi`.`NUMERO_ASIENTO` AS `NUMERO_ASIENTO`,`des`.`ASIENTOS_RESERVADOS` AS `ASIENTOS_RESERVADOS`,`re`.`ID_USUARIO` AS `ID_USUARIO`,`re`.`ID_PERSONA` AS `ID_PERSONA`,`re`.`ASIENTOS_RESERVADOS` AS `ASIENTOS_SELECCIONADOS`,date_format(`re`.`FECHA_RESERVA`,'%d/%m/%Y') AS `FECHA_RESERVA`,`re`.`HORA_RESERVA` AS `HORA_RESERVA`,`re`.`CANTIDAD` AS `CANTIDAD_SELECCIONADOS`,`re`.`PRECIO_TOTAL` AS `PRECIO_TOTAL`,`re`.`ESTADO_RESERVA` AS `ESTADO_RESERVA`,`re`.`puntaje` AS `puntaje` from ((((((`destinos` `des` join `prog_horios` `pro` on((`pro`.`ID_PROGRAMACION` = `des`.`ID_PROGRAMACION`))) join `buses` `bu` on((`bu`.`ID_BUSES` = `pro`.`ID_BUSES`))) join `asientos` `asi` on((`asi`.`ID_ASIENTOS` = `bu`.`ID_ASIENTOS`))) join `ciudades` `ciuo` on((`ciuo`.`ID_CIUDAD` = `des`.`ID_CIUDAD_ORIGEN`))) join `ciudades` `ciud` on((`ciud`.`ID_CIUDAD` = `des`.`ID_CIUDAD_DESTINO`))) join `reservas` `re` on((`re`.`ID_DESTINO` = `des`.`ID_DESTINO`)));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
