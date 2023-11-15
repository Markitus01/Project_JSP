-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-11-2023 a las 19:12:44
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `practica_jsp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `nom_cat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `nom_cat`) VALUES
(2, 'Miscelanea'),
(1, 'Tecnologia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objectes`
--

CREATE TABLE `objectes` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `descripcio` varchar(250) DEFAULT NULL,
  `categoria` int(11) DEFAULT NULL,
  `subcategoria` int(11) DEFAULT NULL,
  `preu` decimal(6,2) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `usuari` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `objectes`
--

INSERT INTO `objectes` (`id`, `nom`, `descripcio`, `categoria`, `subcategoria`, `preu`, `img`, `usuari`) VALUES
(1, 'Pantalla 4k(g)', 'Pantalla marca Ele Skroto 4k(ilograms).\r\nNo escolto ofertes', 1, 3, '345.99', NULL, 'markoskke@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `nom_subcat` varchar(50) NOT NULL,
  `categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `subcategories`
--

INSERT INTO `subcategories` (`id`, `nom_subcat`, `categoria`) VALUES
(1, 'Smartphones', 1),
(2, 'Ordinadors', 1),
(3, 'Perifèrics', 1),
(4, 'Decoració', 2),
(5, 'Components', 1),
(6, 'Software', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuaris`
--

CREATE TABLE `usuaris` (
  `nick` varchar(50) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `pswd` varchar(50) NOT NULL,
  `ROL` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuaris`
--

INSERT INTO `usuaris` (`nick`, `mail`, `pswd`, `ROL`) VALUES
('Mao', 'markoskke@gmail.com', 'msv741', 1),
('Mayuu', 'marksand2001@gmail.com', 'msv741', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom_cat` (`nom_cat`);

--
-- Indices de la tabla `objectes`
--
ALTER TABLE `objectes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria` (`categoria`),
  ADD KEY `subcategoria` (`subcategoria`),
  ADD KEY `usuari` (`usuari`);

--
-- Indices de la tabla `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria` (`categoria`);

--
-- Indices de la tabla `usuaris`
--
ALTER TABLE `usuaris`
  ADD PRIMARY KEY (`mail`),
  ADD UNIQUE KEY `nick_unic` (`nick`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `objectes`
--
ALTER TABLE `objectes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `objectes`
--
ALTER TABLE `objectes`
  ADD CONSTRAINT `objectes_ibfk_2` FOREIGN KEY (`categoria`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `objectes_ibfk_3` FOREIGN KEY (`subcategoria`) REFERENCES `subcategories` (`id`),
  ADD CONSTRAINT `objectes_ibfk_4` FOREIGN KEY (`usuari`) REFERENCES `usuaris` (`mail`);

--
-- Filtros para la tabla `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`categoria`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
