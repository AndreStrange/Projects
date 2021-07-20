-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-02-2021 a las 08:52:11
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `app_cine`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cartelera` (`nombre_pelicula` VARCHAR(50))  BEGIN	
SELECT c.nombre, s.numero_sala, p.titulo_distribucion, f.hora_inicio, f.duracion FROM FUNCIONES f, PELICULAS p, SALAS s, CINES c WHERE p.id_pelicula=f.id_pelicula AND f.id_sala=s.id_sala AND s.nombre_cine=c.nombre AND s.nombre_cine=nombre_pelicula ORDER BY s.numero_sala;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peliculas_actor` (`nombre_actor` VARCHAR(50))  BEGIN	
SELECT titulo_original FROM PELICULAS WHERE id_pelicula IN(SELECT id_pelicula FROM peliculas_personas WHERE nombre_actor=nombre_persona);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peliculas_genero` (`genre` VARCHAR(50))  BEGIN	
SELECT * FROM PELICULAS WHERE genero LIKE concat('%', genre ,'%');
	END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calificacion_peliculas` (`pelicula` FLOAT) RETURNS FLOAT BEGIN
DECLARE suma, total float;
SET suma=(SELECT sum(calificacion) FROM opiniones WHERE id_pelicula=pelicula);
SET total=(SELECT count(calificacion) FROM opiniones WHERE id_pelicula=pelicula);
RETURN round(suma/total, 2);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cineinfo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `cineinfo` (
`CINE` varchar(50)
,`DIRECCIÓN` varchar(50)
,`#SALA` bigint(20)
,`BUTACAS` bigint(20)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cines`
--

CREATE TABLE `cines` (
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cines`
--

INSERT INTO `cines` (`nombre`, `direccion`, `telefono`) VALUES
('dworcester0', '25 Onsgard Parkway', 1695730379),
('iwaything3', '7 Susan Center', 2312902253),
('mmacterlagh4', '75046 7th Crossing', 8244609364),
('mwestwater1', '305 Golf View Road', 5736924495),
('oduggon2', '663 Clarendon Hill', 9452438877);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones`
--

CREATE TABLE `funciones` (
  `id_funcion` bigint(20) NOT NULL,
  `duracion` time NOT NULL,
  `hora_inicio` time NOT NULL,
  `id_sala` bigint(20) NOT NULL,
  `numero_sala` bigint(20) NOT NULL,
  `id_pelicula` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `funciones`
--

INSERT INTO `funciones` (`id_funcion`, `duracion`, `hora_inicio`, `id_sala`, `numero_sala`, `id_pelicula`) VALUES
(1, '03:10:25', '10:06:00', 21, 2, 5),
(2, '02:35:13', '18:42:00', 15, 2, 3),
(3, '03:12:34', '17:03:00', 24, 2, 2),
(4, '02:35:13', '23:04:00', 18, 2, 3),
(5, '02:35:13', '16:01:00', 6, 2, 3),
(6, '02:52:02', '23:01:00', 5, 2, 4),
(7, '03:01:19', '16:13:00', 17, 2, 1),
(8, '02:52:02', '20:48:00', 2, 2, 4),
(9, '02:52:02', '17:10:00', 13, 2, 4),
(10, '03:01:19', '19:05:00', 15, 2, 1),
(11, '03:10:25', '10:25:00', 22, 2, 5),
(12, '03:12:34', '16:20:00', 16, 2, 2),
(13, '03:01:19', '23:10:00', 1, 2, 1),
(14, '03:12:34', '14:45:00', 3, 2, 2),
(15, '03:01:19', '17:15:00', 21, 2, 1),
(16, '02:35:13', '13:01:00', 3, 2, 3),
(17, '02:35:13', '19:56:00', 6, 2, 3),
(18, '03:01:19', '20:28:00', 12, 2, 1),
(19, '03:10:25', '18:45:00', 11, 2, 5),
(20, '02:35:13', '21:30:00', 16, 2, 3),
(21, '03:10:25', '11:28:00', 15, 2, 5),
(22, '03:10:25', '11:03:00', 18, 2, 5),
(23, '03:12:34', '13:13:00', 4, 2, 2),
(24, '03:01:19', '12:18:00', 20, 2, 1),
(25, '03:10:25', '23:40:00', 20, 2, 5),
(26, '02:52:02', '13:59:00', 4, 2, 4),
(27, '02:35:13', '13:36:00', 18, 2, 3),
(28, '03:12:34', '22:57:00', 7, 2, 2),
(29, '03:12:34', '15:19:00', 12, 2, 2),
(30, '02:35:13', '11:28:00', 22, 2, 3),
(31, '03:10:25', '11:45:00', 10, 2, 5),
(32, '02:52:02', '10:43:00', 7, 2, 4),
(33, '03:12:34', '15:11:00', 14, 2, 2),
(34, '03:10:25', '22:29:00', 18, 2, 5),
(35, '02:35:13', '11:15:00', 16, 2, 3),
(36, '03:10:25', '19:38:00', 17, 2, 5),
(37, '03:01:19', '22:19:00', 21, 2, 1),
(38, '03:10:25', '17:26:00', 18, 2, 5),
(39, '02:52:02', '22:05:00', 5, 2, 4),
(40, '02:52:02', '17:45:00', 9, 2, 4),
(41, '03:01:19', '19:37:00', 16, 2, 1),
(42, '03:12:34', '10:25:00', 24, 2, 2),
(43, '03:12:34', '11:23:00', 7, 2, 2),
(44, '03:01:19', '20:34:00', 25, 2, 1),
(45, '03:10:25', '14:00:00', 10, 2, 5),
(46, '02:35:13', '23:36:00', 5, 2, 3),
(47, '03:10:25', '23:39:00', 22, 2, 5),
(48, '03:10:25', '16:39:00', 25, 2, 5),
(49, '03:12:34', '20:22:00', 11, 2, 2),
(50, '03:10:25', '20:32:00', 5, 2, 5),
(51, '03:00:00', '12:00:00', 14, 2, 3),
(52, '03:00:00', '12:00:00', 2, 3, 3);

--
-- Disparadores `funciones`
--
DELIMITER $$
CREATE TRIGGER `sala` BEFORE INSERT ON `funciones` FOR EACH ROW BEGIN	
		
        SET new.numero_sala=(SELECT s.numero_sala FROM SALAS s WHERE new.id_sala=s.id_sala);
        
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `masfunciones`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `masfunciones` (
`titulo_distribucion` varchar(50)
,`titulo_original` varchar(50)
,`Cantidad` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opiniones`
--

CREATE TABLE `opiniones` (
  `id_opinion` bigint(20) NOT NULL,
  `nombre_persona` varchar(50) NOT NULL,
  `edad` int(11) DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `calificacion` float NOT NULL,
  `comentario` varchar(250) NOT NULL,
  `id_pelicula` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `opiniones`
--

INSERT INTO `opiniones` (`id_opinion`, `nombre_persona`, `edad`, `fecha_registro`, `calificacion`, `comentario`, `id_pelicula`) VALUES
(1, 'Elvira O\'Hannigan', 20, '2021-01-21', 2.6, 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris', 4),
(2, 'Aleece Rooper', 34, '2021-02-13', 3.4, 'nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id', 4),
(3, 'Candie Withinshaw', 59, '2020-05-11', 1.2, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus', 5),
(4, 'Moore Swanborrow', 52, '2020-07-05', 3.4, 'suscipit a feugiat et eros vestibulum ac est lacinia nisi', 5),
(5, 'Sibylle Axon', 49, '2020-12-22', 3.6, 'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', 2),
(6, 'Matthieu Pulhoster', 31, '2020-08-23', 3.4, 'tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis', 1),
(7, 'Patten Dutch', 23, '2021-01-04', 2.8, 'ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam', 4),
(8, 'Orelle Gosford', 43, '2020-10-10', 3.4, 'mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris', 3),
(9, 'Moises Josefsohn', 28, '2020-11-21', 2.8, 'nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit', 3),
(10, 'Briant Petch', 30, '2020-07-05', 4.7, 'dolor vel est donec odio justo sollicitudin ut suscipit a', 5),
(11, 'Kathlin Elverstone', 54, '2020-10-06', 4.7, 'nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat', 5),
(12, 'Alethea Tuffey', 24, '2020-04-06', 4.9, 'in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet', 3),
(13, 'Uta Hammerton', 49, '2020-03-07', 4.5, 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus', 4),
(14, 'Katrinka Wye', 32, '2020-06-05', 2.5, 'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non', 3),
(15, 'Nari De Ruggero', 55, '2020-10-05', 4.2, 'libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla', 4),
(16, 'Glen Pirnie', 21, '2020-10-26', 1.5, 'nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra', 3),
(17, 'Melli Gergher', 32, '2020-06-19', 3, 'augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac', 1),
(18, 'Maximilien Geerdts', 57, '2020-07-24', 2.5, 'sed justo pellentesque viverra pede ac diam cras pellentesque volutpat', 2),
(19, 'Lottie Tatem', 33, '2021-02-01', 3.7, 'venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peliculas`
--

CREATE TABLE `peliculas` (
  `id_pelicula` bigint(20) NOT NULL,
  `titulo_distribucion` varchar(50) DEFAULT NULL,
  `titulo_original` varchar(50) NOT NULL,
  `genero` varchar(250) NOT NULL,
  `idioma_original` varchar(20) NOT NULL,
  `subtitulos` varchar(10) NOT NULL,
  `pais_origen` varchar(50) DEFAULT NULL,
  `anio_produccion` int(11) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `duracion` time NOT NULL,
  `clasificacion` varchar(15) NOT NULL,
  `fecha_estreno_santiago` date NOT NULL,
  `resumen` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `peliculas`
--

INSERT INTO `peliculas` (`id_pelicula`, `titulo_distribucion`, `titulo_original`, `genero`, `idioma_original`, `subtitulos`, `pais_origen`, `anio_produccion`, `url`, `duracion`, `clasificacion`, `fecha_estreno_santiago`, `resumen`) VALUES
(1, 'Everything Must Go', 'Camila', 'Comedy|Drama', 'Oriya', 'YES', 'China', 2002, 'https://intel.com', '03:01:19', '16', '2010-09-19', 'No c'),
(2, 'Sharkwater', 'Sully', 'Documentary', 'Azeri', 'YES', 'Poland', 2006, 'https://cdbaby.com', '03:12:34', '1', '2009-12-03', 'nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula'),
(3, 'Invictus', 'Aurlie', 'Drama', 'Tsonga', 'YES', 'Kyrgyzstan', 1995, 'https://tinyurl.com', '02:35:13', '10', '2014-01-22', 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit'),
(4, 'World, the Flesh and the Devil, The', 'Avivah', 'Drama|Romance|Sci-Fi', 'Swahili', 'YES', 'Indonesia', 2008, 'http://google.com.hk', '02:52:02', '7', '2012-10-26', 'velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel'),
(5, 'Big Man Japan (Dai-Nihonjin)', 'Shadow', 'Comedy|Sci-Fi', 'Yiddish', 'NOT', 'Greece', 2007, 'http://ebay.co.uk', '03:10:25', '5', '2011-01-16', 'quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida'),
(7, 'CARLITOS', 'SAMUEL', 'CUADRADO', 'TORRES', 'YES', 'mejico', 2020, 'WWW.GOOGLE.COM', '02:00:00', '28', '2021-02-02', 'CARLITOS');

--
-- Disparadores `peliculas`
--
DELIMITER $$
CREATE TRIGGER `Peliculas_Fuera` BEFORE DELETE ON `peliculas` FOR EACH ROW BEGIN
		INSERT INTO PELICULAS_FUERA_DE_CARTELERA(id_pelicula, titulo_original, titulo_distribucion,genero,idioma_original,subtitulos,pais_origen,anio_produccion,url,duracion,clasificacion,fecha_estreno_santiago,resumen) VALUES (old.id_pelicula, old.titulo_original, old.titulo_distribucion,old.genero, old.idioma_original, old.subtitulos, old.pais_origen, old.anio_produccion, old.url, old.duracion, old.clasificacion, old.fecha_estreno_santiago, old.resumen);
	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `titulos` BEFORE INSERT ON `peliculas` FOR EACH ROW BEGIN	
		IF new.titulo_distribucion is null THEN
        SET new.titulo_distribucion=new.titulo_original;
        END IF;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peliculas_fuera_de_cartelera`
--

CREATE TABLE `peliculas_fuera_de_cartelera` (
  `pk_fuera_de_cartelera` bigint(20) NOT NULL,
  `id_pelicula` bigint(20) NOT NULL,
  `titulo_original` varchar(50) NOT NULL,
  `titulo_distribucion` varchar(50) DEFAULT NULL,
  `genero` varchar(250) NOT NULL,
  `idioma_original` varchar(20) NOT NULL,
  `subtitulos` varchar(10) NOT NULL,
  `pais_origen` varchar(50) DEFAULT NULL,
  `anio_produccion` year(4) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `duracion` time NOT NULL,
  `clasificacion` varchar(15) DEFAULT NULL,
  `fecha_estreno_santiago` date DEFAULT NULL,
  `resumen` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `peliculas_fuera_de_cartelera`
--

INSERT INTO `peliculas_fuera_de_cartelera` (`pk_fuera_de_cartelera`, `id_pelicula`, `titulo_original`, `titulo_distribucion`, `genero`, `idioma_original`, `subtitulos`, `pais_origen`, `anio_produccion`, `url`, `duracion`, `clasificacion`, `fecha_estreno_santiago`, `resumen`) VALUES
(1, 6, 'ELCABARCAS', 'ELCABARCAS', 'Humor|Pasión', 'Español', 'YES', 'Colombia', 1999, 'www.elcabarcas.com', '03:00:00', '15', '2020-02-02', 'Elcabarcas siendo elcabarcas'),
(2, 9, 'TORRENEGRA', 'CABARCAS', 'COMEDIA', 'Oriya', 'YES', 'COLOMBIA', 2010, 'https://intel.com', '03:01:19', '18', '2010-09-19', 'NO SÉ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peliculas_personas`
--

CREATE TABLE `peliculas_personas` (
  `pk_peliculas_personas` bigint(20) NOT NULL,
  `id_pelicula` bigint(20) NOT NULL,
  `nombre_persona` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `peliculas_personas`
--

INSERT INTO `peliculas_personas` (`pk_peliculas_personas`, `id_pelicula`, `nombre_persona`) VALUES
(1, 5, 'Stevie Perree'),
(2, 1, 'Elayne Pullman'),
(3, 3, 'Mella Dinwoodie'),
(4, 1, 'Panchito Blaber'),
(5, 3, 'Brear Gowdy'),
(6, 2, 'Lemmie Amys'),
(7, 5, 'Nealson Niave'),
(8, 4, 'Dore Yushmanov'),
(9, 1, 'Andie Monini'),
(10, 1, 'Sandor MacKay'),
(11, 2, 'Nicolea Napleton'),
(12, 2, 'Silvanus Belt'),
(13, 4, 'Rivkah Botwood'),
(14, 2, 'Addi McWhin'),
(15, 2, 'Renard Beaver'),
(16, 2, 'Merrili Phillippo'),
(17, 1, 'Mendie Stearndale'),
(18, 2, 'Gladi Goreway'),
(19, 4, 'Lothaire Bird'),
(20, 2, 'Ennis McIlvaney'),
(21, 5, 'Eulalie Shurey'),
(22, 4, 'Corinna Rubenov'),
(23, 1, 'Joy Rasher'),
(24, 2, 'Benedetto Fermin'),
(25, 1, 'Ilene Huertas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `nombre` varchar(50) NOT NULL,
  `nacionalidad` varchar(20) NOT NULL,
  `cantidad_de_peliculas` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`nombre`, `nacionalidad`, `cantidad_de_peliculas`) VALUES
('Addi McWhin', 'Dinamarca', 2),
('Andie Monini', 'Thailand', 3),
('Andres Hurtado', 'Colombia', 1),
('Benedetto Fermin', 'Netherlands', 2),
('Brear Gowdy', 'Philippines', 1),
('Corinna Rubenov', 'Indonesia', 2),
('Dore Yushmanov', 'Ukraine', 1),
('Elayne Pullman', 'China', 1),
('Ennis McIlvaney', 'Indonesia', 2),
('Eulalie Shurey', 'Russia', 1),
('Gladi Goreway', 'Serbia', 2),
('Ilene Huertas', 'Peru', 3),
('Joy Rasher', 'Belarus', 1),
('Lemmie Amys', 'Turkmenistan', 1),
('Lothaire Bird', 'Indonesia', 2),
('Mella Dinwoodie', 'Vietnam', 3),
('Mendie Stearndale', 'Philippines', 1),
('Merrili Phillippo', 'Russia', 2),
('Nealson Niave', 'Poland', 2),
('Nicolea Napleton', 'Ireland', 3),
('Panchito Blaber', 'Canada', 3),
('Renard Beaver', 'Peru', 2),
('Rivkah Botwood', 'Poland', 1),
('Sandor MacKay', 'Indonesia', 2),
('Silvanus Belt', 'Indonesia', 2),
('Stevie Perree', 'Peru', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

CREATE TABLE `promociones` (
  `id_promocion` bigint(20) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `descuento` decimal(10,0) NOT NULL,
  `id_funcion` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `promociones`
--

INSERT INTO `promociones` (`id_promocion`, `descripcion`, `descuento`, `id_funcion`) VALUES
(1, 'volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus', '68', 42),
(2, 'nulla neque libero convallis eget eleifend luctus ultricies eu nibh', '25', 20),
(3, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus', '33', 43),
(4, 'risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero', '82', 43),
(5, 'non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa', '50', 48),
(6, 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', '81', 49),
(7, 'vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum', '46', 20),
(8, 'felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam', '50', 23),
(9, 'amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales', '26', 8),
(10, 'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam', '27', 26),
(11, 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien', '15', 46),
(12, 'quam pharetra magna ac consequat metus sapien ut nunc vestibulum', '82', 33),
(13, 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue', '32', 16),
(14, 'pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam', '83', 39),
(15, 'aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero', '85', 2),
(16, 'a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet', '35', 38),
(17, 'fusce congue diam id ornare imperdiet sapien urna pretium nisl ut', '33', 31),
(18, 'libero convallis eget eleifend luctus ultricies eu nibh quisque id justo', '86', 32),
(19, 'habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien', '49', 31),
(20, 'odio consequat varius integer ac leo pellentesque ultrices mattis odio donec', '59', 6),
(21, 'amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante', '83', 28),
(22, 'blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent', '80', 34),
(23, 'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc', '82', 14),
(24, 'velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget', '61', 28),
(25, 'curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac', '68', 14),
(26, 'vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque', '71', 10),
(27, 'tempus semper est quam pharetra magna ac consequat metus sapien', '37', 11),
(28, 'nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam', '33', 47),
(29, 'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst', '10', 8),
(30, 'volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna', '32', 34),
(31, 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque', '39', 32),
(32, 'nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel', '67', 30),
(33, 'nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra', '13', 40),
(34, 'nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo', '87', 17),
(35, 'mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede', '39', 48),
(36, 'aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam', '80', 46),
(37, 'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque', '10', 26),
(38, 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi', '21', 15),
(39, 'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi', '13', 6),
(40, 'dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim', '35', 9),
(41, 'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien', '60', 35),
(42, 'maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus', '55', 33),
(43, 'in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec', '89', 26),
(44, 'in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec', '27', 10),
(45, 'donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci', '69', 9),
(46, 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at', '14', 15),
(47, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', '87', 33),
(48, 'consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante', '29', 26),
(49, 'eget nunc donec quis orci eget orci vehicula condimentum curabitur in', '38', 26),
(50, 'quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate', '18', 29);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` bigint(20) NOT NULL,
  `nombre_rol` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
(1, 'Actor'),
(2, 'Director'),
(4, 'Doblexd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_personas`
--

CREATE TABLE `roles_personas` (
  `pk_roles_personas` bigint(20) NOT NULL,
  `id_rol` bigint(20) NOT NULL,
  `nombre_persona` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles_personas`
--

INSERT INTO `roles_personas` (`pk_roles_personas`, `id_rol`, `nombre_persona`) VALUES
(1, 1, 'Stevie Perree'),
(2, 1, 'Elayne Pullman'),
(3, 1, 'Mella Dinwoodie'),
(4, 1, 'Panchito Blaber'),
(5, 1, 'Brear Gowdy'),
(6, 1, 'Lemmie Amys'),
(7, 1, 'Nealson Niave'),
(8, 1, 'Dore Yushmanov'),
(9, 1, 'Andie Monini'),
(10, 1, 'Sandor MacKay'),
(11, 1, 'Nicolea Napleton'),
(12, 1, 'Silvanus Belt'),
(13, 1, 'Rivkah Botwood'),
(14, 2, 'Addi McWhin'),
(15, 1, 'Addi McWhin'),
(16, 2, 'Renard Beaver'),
(17, 1, 'Renard Beaver'),
(18, 1, 'Merrili Phillippo'),
(19, 1, 'Mendie Stearndale'),
(20, 2, 'Gladi Goreway'),
(21, 2, 'Lothaire Bird'),
(22, 1, 'Gladi Goreway'),
(23, 1, 'Ennis McIlvaney'),
(24, 1, 'Eulalie Shurey'),
(25, 2, 'Corinna Rubenov'),
(26, 1, 'Joy Rasher'),
(27, 1, 'Benedetto Fermin'),
(28, 1, 'Ilene Huertas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salas`
--

CREATE TABLE `salas` (
  `id_sala` bigint(20) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `butacas` bigint(20) NOT NULL,
  `numero_sala` bigint(20) NOT NULL,
  `nombre_cine` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `salas`
--

INSERT INTO `salas` (`id_sala`, `nombre`, `butacas`, `numero_sala`, `nombre_cine`) VALUES
(1, 'btutill0', 39, 1, 'dworcester0'),
(2, 'tdurrans1', 39, 3, 'mwestwater1'),
(3, 'aatterbury2', 24, 4, 'oduggon2'),
(4, 'mtriggs3', 23, 1, 'iwaything3'),
(5, 'sjakaway4', 38, 3, 'mmacterlagh4'),
(6, 'slondsdale5', 33, 2, 'oduggon2'),
(7, 'gbarsham6', 26, 5, 'iwaything3'),
(8, 'horry7', 23, 5, 'mmacterlagh4'),
(9, 'rsetterthwait8', 27, 4, 'oduggon2'),
(10, 'jtaunton9', 28, 3, 'iwaything3'),
(11, 'tanthonsena', 22, 5, 'mmacterlagh4'),
(12, 'htrimb', 30, 4, 'dworcester0'),
(13, 'lmcmeekingc', 33, 3, 'mmacterlagh4'),
(14, 'sabadamd', 35, 2, 'oduggon2'),
(15, 'glafranconie', 27, 4, 'mwestwater1'),
(16, 'mbournerf', 27, 5, 'dworcester0'),
(17, 'ncullong', 22, 3, 'mwestwater1'),
(18, 'ghulburth', 23, 3, 'oduggon2'),
(19, 'fbraysoni', 24, 1, 'iwaything3'),
(20, 'evynollj', 22, 2, 'mmacterlagh4'),
(21, 'bbrimsonk', 26, 2, 'dworcester0'),
(22, 'hthireaul', 26, 4, 'mwestwater1'),
(23, 'aamphlettm', 34, 5, 'oduggon2'),
(24, 'oroskeillyn', 39, 2, 'iwaything3'),
(25, 'dhoyo', 20, 5, 'mmacterlagh4');

-- --------------------------------------------------------

--
-- Estructura para la vista `cineinfo`
--
DROP TABLE IF EXISTS `cineinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cineinfo`  AS  select `c`.`nombre` AS `CINE`,`c`.`direccion` AS `DIRECCIÓN`,`s`.`numero_sala` AS `#SALA`,`s`.`butacas` AS `BUTACAS` from (`cines` `c` join `salas` `s`) where `s`.`nombre_cine` = `c`.`nombre` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `masfunciones`
--
DROP TABLE IF EXISTS `masfunciones`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `masfunciones`  AS  select `p`.`titulo_distribucion` AS `titulo_distribucion`,`p`.`titulo_original` AS `titulo_original`,count(`f`.`id_pelicula`) AS `Cantidad` from (`peliculas` `p` join `funciones` `f`) where `p`.`id_pelicula` = `f`.`id_pelicula` group by `f`.`id_pelicula` order by count(`f`.`id_pelicula`) desc ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cines`
--
ALTER TABLE `cines`
  ADD PRIMARY KEY (`nombre`),
  ADD UNIQUE KEY `direccion` (`direccion`),
  ADD UNIQUE KEY `telefono` (`telefono`);

--
-- Indices de la tabla `funciones`
--
ALTER TABLE `funciones`
  ADD PRIMARY KEY (`id_funcion`),
  ADD KEY `duracion_idx` (`duracion`),
  ADD KEY `fk_funciones_salas` (`id_sala`),
  ADD KEY `fk_funciones_peliculas` (`id_pelicula`);

--
-- Indices de la tabla `opiniones`
--
ALTER TABLE `opiniones`
  ADD PRIMARY KEY (`id_opinion`),
  ADD KEY `opinion_idx` (`calificacion`),
  ADD KEY `fk_opiniones_peliculas` (`id_pelicula`);

--
-- Indices de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD PRIMARY KEY (`id_pelicula`),
  ADD UNIQUE KEY `titulo_original` (`titulo_original`),
  ADD KEY `titulo_idx` (`titulo_original`);

--
-- Indices de la tabla `peliculas_fuera_de_cartelera`
--
ALTER TABLE `peliculas_fuera_de_cartelera`
  ADD PRIMARY KEY (`pk_fuera_de_cartelera`);

--
-- Indices de la tabla `peliculas_personas`
--
ALTER TABLE `peliculas_personas`
  ADD PRIMARY KEY (`pk_peliculas_personas`),
  ADD KEY `fk_peliculas_personas` (`id_pelicula`),
  ADD KEY `fk_personas_peliculas` (`nombre_persona`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`nombre`),
  ADD KEY `nombre_idx` (`nombre`);

--
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`id_promocion`),
  ADD KEY `fk_promociones_funciones` (`id_funcion`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `roles_personas`
--
ALTER TABLE `roles_personas`
  ADD PRIMARY KEY (`pk_roles_personas`),
  ADD KEY `fk_roles_personas` (`id_rol`),
  ADD KEY `fk_roles_personass` (`nombre_persona`);

--
-- Indices de la tabla `salas`
--
ALTER TABLE `salas`
  ADD PRIMARY KEY (`id_sala`),
  ADD KEY `fk_salas_cines` (`nombre_cine`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `funciones`
--
ALTER TABLE `funciones`
  MODIFY `id_funcion` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `opiniones`
--
ALTER TABLE `opiniones`
  MODIFY `id_opinion` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  MODIFY `id_pelicula` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `peliculas_fuera_de_cartelera`
--
ALTER TABLE `peliculas_fuera_de_cartelera`
  MODIFY `pk_fuera_de_cartelera` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `peliculas_personas`
--
ALTER TABLE `peliculas_personas`
  MODIFY `pk_peliculas_personas` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `id_promocion` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `roles_personas`
--
ALTER TABLE `roles_personas`
  MODIFY `pk_roles_personas` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `salas`
--
ALTER TABLE `salas`
  MODIFY `id_sala` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `funciones`
--
ALTER TABLE `funciones`
  ADD CONSTRAINT `fk_funciones_peliculas` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id_pelicula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_funciones_salas` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `opiniones`
--
ALTER TABLE `opiniones`
  ADD CONSTRAINT `fk_opiniones_peliculas` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id_pelicula`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `peliculas_personas`
--
ALTER TABLE `peliculas_personas`
  ADD CONSTRAINT `fk_peliculas_personas` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id_pelicula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_personas_peliculas` FOREIGN KEY (`nombre_persona`) REFERENCES `personas` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD CONSTRAINT `fk_promociones_funciones` FOREIGN KEY (`id_funcion`) REFERENCES `funciones` (`id_funcion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `roles_personas`
--
ALTER TABLE `roles_personas`
  ADD CONSTRAINT `fk_roles_personas` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_roles_personass` FOREIGN KEY (`nombre_persona`) REFERENCES `personas` (`nombre`);

--
-- Filtros para la tabla `salas`
--
ALTER TABLE `salas`
  ADD CONSTRAINT `fk_salas_cines` FOREIGN KEY (`nombre_cine`) REFERENCES `cines` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
