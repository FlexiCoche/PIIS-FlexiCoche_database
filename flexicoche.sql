-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 28-02-2025 a las 16:58:02
-- Versión del servidor: 11.7.2-MariaDB-ubu2404
-- Versión de PHP: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `flexicoche`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alquiler`
--

CREATE TABLE `alquiler` (
  `id` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `id_usuario` varchar(40) NOT NULL,
  `estado` enum('a pagar','procesando','denegado','en alquiler','devuelto','retraso') NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `alquiler`
--

INSERT INTO `alquiler` (`id`, `id_vehiculo`, `id_usuario`, `estado`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 1, 'mario.moreno@email.com', 'en alquiler', '2025-02-01', '2025-02-05'),
(2, 2, 'carlos.garcia@email.com', 'a pagar', '2025-02-02', '2025-02-06'),
(3, 3, 'ana.martinez@email.com', 'procesando', '2025-02-03', '2025-02-07'),
(4, 4, 'juan.rodriguez@email.com', 'denegado', '2025-02-04', '2025-02-08'),
(5, 5, 'laura.fernandez@email.com', 'en alquiler', '2025-02-05', '2025-02-09'),
(6, 6, 'jose.lopez@email.com', 'devuelto', '2025-02-06', '2025-02-10'),
(7, 7, 'pedro.sanchez@email.com', 'retraso', '2025-02-07', '2025-02-11'),
(8, 8, 'marta.gonzalez@email.com', 'a pagar', '2025-02-08', '2025-02-12'),
(9, 9, 'silvia.ortega@email.com', 'procesando', '2025-02-09', '2025-02-13'),
(10, 10, 'tomas.perez@email.com', 'en alquiler', '2025-02-10', '2025-02-14');

--
-- Disparadores `alquiler`
--
DELIMITER $$
CREATE TRIGGER `check_fecha_alquiler` BEFORE INSERT ON `alquiler` FOR EACH ROW BEGIN
    IF NEW.fecha_inicio > NEW.fecha_fin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio no puede ser mayor que la fecha de fin';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `camion`
--

CREATE TABLE `camion` (
  `id` int(1) DEFAULT 3,
  `id_vehiculo` int(11) NOT NULL,
  `peso_max` float NOT NULL CHECK (`peso_max` > 0),
  `altura` float NOT NULL CHECK (`altura` > 0),
  `n_remolques` int(11) DEFAULT NULL CHECK (`n_remolques` >= 0),
  `tipo_carga` varchar(30) DEFAULT NULL,
  `matricula_rem` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `camion`
--

INSERT INTO `camion` (`id`, `id_vehiculo`, `peso_max`, `altura`, `n_remolques`, `tipo_carga`, `matricula_rem`) VALUES
(3, 10, 18000, 4.5, 1, 'Carga general', 'AB1234CD'),
(3, 11, 22000, 5, 2, 'Automóviles', 'EF5678GH'),
(3, 12, 20000, 4.8, 1, 'Materiales de constr', 'IJ9101KL'),
(3, 106, 25000, 5.2, 2, 'Carga refrigerada', 'MN1234OP'),
(3, 107, 27000, 5.5, 3, 'Materiales de construcción', 'QR5678ST'),
(3, 108, 22000, 5, 1, 'Carga líquida', 'UV9101WX'),
(3, 109, 26000, 5.3, 2, 'Ganado', 'YZ2345AB'),
(3, 110, 24000, 4.9, 1, 'Madera', 'CD6789EF'),
(3, 111, 28000, 5.6, 3, 'Combustible', 'GH1234IJ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coche`
--

CREATE TABLE `coche` (
  `id` int(1) DEFAULT 0,
  `id_vehiculo` int(11) NOT NULL,
  `carroceria` enum('Sedán','SUV','Hatchback','Coupé','Convertible','Pickup','Furgoneta','Wagon','Deportivo') NOT NULL,
  `puertas` int(11) DEFAULT NULL CHECK (`puertas` > 0),
  `potencia` int(11) DEFAULT NULL CHECK (`potencia` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `coche`
--

INSERT INTO `coche` (`id`, `id_vehiculo`, `carroceria`, `puertas`, `potencia`) VALUES
(0, 1, 'Sedán', 4, 150),
(0, 2, 'Hatchback', 5, 180),
(0, 3, 'Sedán', 4, 120),
(0, 13, 'SUV', 5, 250),
(0, 14, 'SUV', 5, 280),
(0, 15, 'SUV', 5, 320),
(0, 16, 'SUV', 5, 180),
(0, 17, 'SUV', 5, 170),
(0, 18, 'SUV', 5, 200),
(0, 20, 'SUV', 5, 300),
(0, 21, 'SUV', 5, 340),
(0, 22, 'SUV', 5, 250),
(0, 23, 'Pickup', 5, 240),
(0, 24, 'Coupé', 4, 350),
(0, 25, 'SUV', 5, 400),
(0, 26, 'SUV', 5, 220),
(0, 28, 'Coupé', 4, 450),
(0, 29, 'Deportivo', 2, 500),
(0, 30, 'SUV', 5, 190),
(0, 31, 'Sedán', 5, 450),
(0, 32, 'Hatchback', 5, 320),
(0, 33, 'Sedán', 5, 250),
(0, 34, 'SUV', 5, 280),
(0, 35, 'Deportivo', 2, 400),
(0, 36, 'Pickup', 5, 350),
(0, 37, 'SUV', 5, 290),
(0, 38, 'Sedán', 4, 550),
(0, 39, 'Deportivo', 2, 650),
(0, 40, 'Sedán', 5, 1020),
(0, 41, 'SUV', 5, 220),
(0, 42, 'SUV', 5, 250),
(0, 43, 'SUV', 5, 180),
(0, 44, 'SUV', 5, 400),
(0, 45, 'SUV', 5, 300),
(0, 46, 'SUV', 5, 380),
(0, 47, 'Sedán', 5, 350),
(0, 48, 'SUV', 5, 500),
(0, 49, 'SUV', 5, 180),
(0, 50, 'Hatchback', 5, 220),
(0, 51, 'Deportivo', 2, 250),
(0, 52, 'Sedán', 5, 270),
(0, 53, 'Sedán', 5, 300),
(0, 54, 'SUV', 5, 600),
(0, 55, 'Sedán', 5, 320),
(0, 56, 'SUV', 5, 220),
(0, 57, 'SUV', 5, 210),
(0, 58, 'Deportivo', 2, 500),
(0, 59, 'SUV', 5, 190),
(0, 60, 'SUV', 5, 300),
(0, 61, 'SUV', 5, 250),
(0, 62, 'Sedán', 5, 450),
(0, 63, 'SUV', 5, 280),
(0, 64, 'SUV', 5, 300),
(0, 65, 'Sedán', 5, 500),
(0, 66, 'SUV', 5, 250),
(0, 67, 'Sedán', 5, 280),
(0, 68, 'SUV', 5, 260),
(0, 69, 'SUV', 5, 400),
(0, 70, 'Coupé', 4, 450),
(0, 71, 'SUV', 5, 200),
(0, 72, 'SUV', 5, 250),
(0, 73, 'SUV', 5, 500),
(0, 74, 'Hatchback', 5, 180),
(0, 75, 'Sedán', 5, 250),
(0, 76, 'SUV', 5, 400),
(0, 77, 'Sedán', 5, 600),
(0, 78, 'SUV', 5, 230),
(0, 79, 'SUV', 5, 300),
(0, 80, 'SUV', 5, 280),
(0, 81, 'SUV', 5, 550),
(0, 82, 'SUV', 5, 380),
(0, 83, 'Sedán', 5, 210),
(0, 84, 'SUV', 5, 320),
(0, 85, 'SUV', 5, 450),
(0, 86, 'Hatchback', 4, 200),
(0, 87, 'SUV', 5, 250);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `id_alquiler` int(11) NOT NULL,
  `importe` float NOT NULL CHECK (`importe` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id`, `id_alquiler`, `importe`) VALUES
(1, 1, 250),
(2, 2, 300),
(3, 3, 280),
(4, 4, 200),
(5, 5, 220),
(6, 6, 190),
(7, 7, 260),
(8, 8, 210),
(9, 9, 240),
(10, 10, 230);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `furgoneta`
--

CREATE TABLE `furgoneta` (
  `id` int(1) DEFAULT 2,
  `id_vehiculo` int(11) NOT NULL,
  `volumen` float DEFAULT NULL CHECK (`volumen` > 0),
  `longitud` float DEFAULT NULL CHECK (`longitud` > 0),
  `peso_max` float NOT NULL CHECK (`peso_max` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `furgoneta`
--

INSERT INTO `furgoneta` (`id`, `id_vehiculo`, `volumen`, `longitud`, `peso_max`) VALUES
(2, 7, 18, 6.2, 3500),
(2, 8, 20, 6.5, 3700),
(2, 9, 22, 7, 4000),
(2, 98, 16, 5.5, 3200),
(2, 99, 24, 7.2, 4000),
(2, 100, 18, 6, 3500),
(2, 101, 20, 6.8, 3700),
(2, 102, 22, 7.1, 3900),
(2, 103, 19, 6.3, 3300),
(2, 104, 21, 6.7, 3600),
(2, 105, 23, 7, 3800);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
--

CREATE TABLE `imagen` (
  `id_vehiculo` int(11) NOT NULL,
  `imagen` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moto`
--

CREATE TABLE `moto` (
  `id` int(1) DEFAULT 1,
  `id_vehiculo` int(11) NOT NULL,
  `cilindrada` int(11) NOT NULL CHECK (`cilindrada` > 0),
  `baul` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `moto`
--

INSERT INTO `moto` (`id`, `id_vehiculo`, `cilindrada`, `baul`) VALUES
(1, 4, 500, 0),
(1, 5, 600, 0),
(1, 6, 700, 0),
(1, 88, 900, 1),
(1, 89, 1100, 0),
(1, 90, 750, 1),
(1, 91, 650, 0),
(1, 92, 1200, 1),
(1, 93, 500, 0),
(1, 94, 700, 1),
(1, 95, 800, 0),
(1, 96, 600, 0),
(1, 97, 1000, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `correo` varchar(40) PRIMARY KEY,
  `n_documento` int(10) DEFAULT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `telefono` int(9) DEFAULT NULL,
  `fec_nac` date DEFAULT NULL,
  `rol` tinyint(1) DEFAULT 1,
  `foto` blob DEFAULT NULL,
  `passwd` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`correo`, `n_documento`, `nombre`, `apellidos`, `telefono`, `fec_nac`, `rol`, `foto`, `passwd`) VALUES
('adriana.luna@email.com', 99123456, 'Adriana', 'Luna Torres', 612345697, '1997-03-18', 0, NULL, 'contraseña127'),
('alberto.castro@email.com', 91234567, 'Alberto', 'Castro Ruiz', 612345688, '1984-05-12', 0, NULL, 'contraseña118'),
('ana.martinez@email.com', 23456789, 'Ana', 'Martínez Sánchez', 612345679, '1990-07-22', 0, NULL, 'contraseña456'),
('andrea.medina@email.com', 99789012, 'Andrea', 'Medina Torres', 612345703, '1991-04-10', 0, NULL, 'contraseña133'),
('beatriz.suarez@email.com', 99567890, 'Beatriz', 'Suárez Peña', 612345701, '1994-06-18', 0, NULL, 'contraseña131'),
('carlos.garcia@email.com', 12345678, 'Carlos', 'García Pérez', 612345678, '1985-03-10', 0, NULL, 'contraseña123'),
('carmen.reyes@email.com', 98901234, 'Carmen', 'Reyes Sánchez', 612345695, '1992-12-05', 0, NULL, 'contraseña125'),
('david.alvarez@email.com', 89012345, 'David', 'Álvarez Díaz', 612345685, '1980-04-20', 0, NULL, 'contraseña115'),
('elena.mendoza@email.com', 92345678, 'Elena', 'Mendoza Gil', 612345689, '1991-07-07', 0, NULL, 'contraseña119'),
('elisa.navarro@email.com', 99923456, 'Elisa', 'Navarro Gutiérrez', 612345707, '1997-02-28', 0, NULL, 'contraseña137'),
('fernando.cabrera@email.com', 99890123, 'Fernando', 'Cabrera León', 612345704, '1985-12-07', 0, NULL, 'contraseña134'),
('francisco.ortiz@email.com', 93456789, 'Francisco', 'Ortiz Peña', 612345690, '1987-03-15', 0, NULL, 'contraseña120'),
('gabriel.hernandez@email.com', 99234567, 'Gabriel', 'Hernández Soto', 612345698, '1983-05-22', 0, NULL, 'contraseña128'),
('isabel.dominguez@email.com', 94567890, 'Isabel', 'Domínguez Herrera', 612345691, '1993-11-20', 0, NULL, 'contraseña121'),
('javier.serrano@email.com', 95678901, 'Javier', 'Serrano Vargas', 612345692, '1986-09-25', 0, NULL, 'contraseña122'),
('joaquin.delgado@email.com', 99678901, 'Joaquín', 'Delgado Vera', 612345702, '1982-09-25', 0, NULL, 'contraseña132'),
('jose.lopez@email.com', 56789012, 'José', 'López Ruiz', 612345682, '1979-02-14', 0, NULL, 'contraseña112'),
('juan.rodriguez@email.com', 34567890, 'Juan', 'Rodríguez López', 612345680, '1982-01-15', 0, NULL, 'contraseña789'),
('laura.fernandez@email.com', 45678901, 'Laura', 'Fernández Gómez', 612345681, '1995-11-25', 0, NULL, 'contraseña101'),
('lucia.jimenez@email.com', 90123456, 'Lucía', 'Jiménez Pérez', 612345686, '1996-09-10', 0, NULL, 'contraseña116'),
('manuel.castillo@email.com', 99456789, 'Manuel', 'Castillo Paredes', 612345700, '1986-11-30', 0, NULL, 'contraseña130'),
('mario.moreno@email.com', 10123457, 'Mario', 'Moreno Romero', 612345687, '1983-12-18', 1, NULL, 'contraseña117'),
('marta.gonzalez@email.com', 78901234, 'Marta', 'González García', 612345684, '1992-06-05', 0, NULL, 'contraseña114'),
('natalia.rojas@email.com', 99345678, 'Natalia', 'Rojas Mendoza', 612345699, '1990-08-15', 0, NULL, 'contraseña129'),
('patricia.flores@email.com', 96789012, 'Patricia', 'Flores Ramírez', 612345693, '1994-08-30', 0, NULL, 'contraseña123'),
('pedro.sanchez@email.com', 67890123, 'Pedro', 'Sánchez Martínez', 612345683, '1988-08-30', 0, NULL, 'contraseña113'),
('raul.navarro@email.com', 97890123, 'Raúl', 'Navarro Morales', 612345694, '1981-02-14', 1, NULL, 'contraseña124'),
('sergio.jimenez@email.com', 99012345, 'Sergio', 'Jiménez Pérez', 612345696, '1985-06-10', 0, NULL, 'contraseña126'),
('silvia.ortega@email.com', 99901234, 'Silvia', 'Ortega Herrera', 612345705, '1993-07-21', 0, NULL, 'contraseña135'),
('tomas.perez@email.com', 99912345, 'Tomás', 'Pérez Sánchez', 612345706, '1989-03-05', 0, NULL, 'contraseña136');

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `check_fec_nac` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN
    IF NEW.fec_nac > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de nacimiento no puede ser posterior a la fecha de hoy';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE `vehiculo` (
  `id` int(11) NOT NULL,
  `matricula` varchar(10) NOT NULL,
  `combustible` enum('gasolina','diésel','híbrido no enchufable','híbrido enchufable','tracción humana', 'eléctrico') NOT NULL,
  `color` enum('negro','blanco','gris','plata','rojo','azul','verde','amarillo','naranja','marrón','dorado','púrpura','rosa','multicolor') NOT NULL,
  `precio_dia` float NOT NULL CHECK (`precio_dia` >= 0),
  `anio_matricula` date NOT NULL,
  `disponibilidad` tinyint(1) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `n_plazas` int(2) DEFAULT NULL,
  `transmision` enum('Manual','Automática','CVT','Semiautomática','Dual-Clutch') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Estructura de tabla para la tabla `moto`
--

CREATE TABLE `moto` (
  `id` int(1) DEFAULT 1,
  `id_vehiculo` int(11) NOT NULL,
  `cilindrada` int(11) NOT NULL CHECK (`cilindrada` > 0),
  `baul` tinyint(1) DEFAULT NULL,
  CONSTRAINT `moto_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`)
);


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coche`
--

CREATE TABLE `coche` (
  `id` int(1) DEFAULT 0,
  `id_vehiculo` int(11) NOT NULL,
  `carroceria` enum('Sedán','SUV','Hatchback','Coupé','Convertible','Pickup','Furgoneta','Wagon','Deportivo') NOT NULL,
  `puertas` int(11) DEFAULT NULL CHECK (`puertas` > 0),
  `potencia` int(11) DEFAULT NULL CHECK (`potencia` > 0),
  CONSTRAINT `coche_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `furgoneta`
--

CREATE TABLE `furgoneta` (
  `id` int(1) DEFAULT 2,
  `id_vehiculo` int(11) NOT NULL,
  `volumen` float DEFAULT NULL CHECK (`volumen` > 0),
  `longitud` float DEFAULT NULL CHECK (`longitud` > 0),
  `peso_max` float NOT NULL CHECK (`peso_max` > 0),
  CONSTRAINT `furgoneta_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `camion`
--

CREATE TABLE `camion` (
  `id` int(1) DEFAULT 3,
  `id_vehiculo` int(11) NOT NULL,
  `peso_max` float NOT NULL CHECK (`peso_max` > 0),
  `altura` float NOT NULL CHECK (`altura` > 0),
  `n_remolques` int(11) DEFAULT NULL CHECK (`n_remolques` >= 0),
  `tipo_carga` varchar(20) DEFAULT NULL,
  `matricula_rem` varchar(10) DEFAULT NULL,
  CONSTRAINT `camion_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
--

CREATE TABLE `imagen` (
  `id_vehiculo` int(11) NOT NULL,
  `imagen` blob NOT NULL,
  CONSTRAINT `imagen_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`)
);


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alquiler`
--

CREATE TABLE `alquiler` (
  `id` int(11) PRIMARY KEY NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `id_usuario` varchar(40) NOT NULL,
  `estado` enum('a pagar','procesando','denegado','en alquiler','devuelto','retraso') NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  CONSTRAINT `alquiler_vehiculo_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`),
  CONSTRAINT `alquiler_usuario_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`correo`)
);
  
ALTER TABLE `alquiler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
  

--
-- Disparadores `alquiler`
--
DELIMITER $$
CREATE TRIGGER `check_fecha_alquiler` BEFORE INSERT ON `alquiler` FOR EACH ROW BEGIN
    IF NEW.fecha_inicio > NEW.fecha_fin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio no puede ser mayor que la fecha de fin';
    END IF;
END
$$
DELIMITER ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) PRIMARY KEY NOT NULL,
  `id_alquiler` int(11) NOT NULL,
  `importe` float NOT NULL CHECK (`importe` >= 0),
  CONSTRAINT `factura_fk` FOREIGN KEY (`id_alquiler`) REFERENCES `alquiler` (`id`)
);

ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

-- --------------------------------------------------------

--
-- Inserts
--

INSERT INTO `vehiculo` (`id`, `matricula`, `combustible`, `color`, `precio_dia`, `anio_matricula`, `disponibilidad`, `nombre`, `n_plazas`, `transmision`) VALUES
(1, '1234ABC', 'gasolina', 'rojo', 50, '2018-04-15', 1, 'Ford Focus', 5, 'Automática'),
(2, '2345DEF', 'diésel', 'blanco', 60, '2020-07-10', 1, 'Volkswagen Golf', 5, 'Manual'),
(3, '3456GHI', 'híbrido enchufable', 'azul', 70, '2022-01-20', 1, 'Toyota Prius', 5, 'CVT'),
(4, '4567JKL', 'gasolina', 'negro', 80, '2021-08-10', 1, 'Honda CB500', 2, 'Manual'),
(5, '5678MNO', 'diésel', 'plata', 55, '2017-06-12', 1, 'Kawasaki Ninja', 2, 'Manual'),
(6, '6789PQR', 'híbrido no enchufable', 'rojo', 65, '2020-09-15', 1, 'Yamaha MT-07', 2, 'Semiautomática'),
(7, '7890STU', 'gasolina', 'gris', 70, '2023-02-02', 1, 'Renault Master', 3, 'Manual'),
(8, '8901VWX', 'diésel', 'amarillo', 85, '2019-11-11', 1, 'Mercedes-Benz Vito', 3, 'Automática'),
(9, '9012XYZ', 'gasolina', 'verde', 75, '2022-03-22', 1, 'Ford Transit', 3, 'Manual'),
(10, '1234ZZZ', 'híbrido no enchufable', 'marrón', 100, '2021-04-10', 1, 'Scania R500', 2, 'Manual'),
(11, '2345AAA', 'gasolina', 'azul', 120, '2020-12-01', 1, 'Volvo FH16', 2, 'Manual'),
(12, '3456BBB', 'diésel', 'rojo', 110, '2019-05-14', 1, 'Mercedes Actros', 2, 'Automática'),
(13, '4567CCC', 'gasolina', 'negro', 95, '2018-07-20', 1, 'BMW X5', 5, 'Automática'),
(14, '5678DDD', 'diésel', 'blanco', 80, '2021-10-10', 1, 'Audi Q7', 5, 'Automática'),
(15, '6789EEE', 'híbrido enchufable', 'gris', 85, '2022-08-15', 1, 'Tesla Model Y', 5, 'Automática'),
(16, '7890FFF', 'gasolina', 'rojo', 70, '2017-06-18', 1, 'Mazda CX-5', 5, 'Manual'),
(17, '8901GGG', 'diésel', 'azul', 75, '2019-12-05', 1, 'Nissan Qashqai', 5, 'Manual'),
(18, '9012HHH', 'híbrido no enchufable', 'verde', 65, '2020-03-25', 1, 'Hyundai Tucson', 5, 'Automática'),
(19, '1234III', 'gasolina', 'marrón', 110, '2021-07-30', 1, 'Jeep Wrangler', 4, 'Manual'),
(20, '2345JJJ', 'diésel', 'negro', 90, '2023-01-12', 1, 'Land Rover Defender', 5, 'Automática'),
(21, '3456KKK', 'gasolina', 'plata', 120, '2019-04-14', 1, 'Porsche Cayenne', 5, 'Automática'),
(22, '4567LLL', 'híbrido enchufable', 'blanco', 100, '2022-11-11', 1, 'Mitsubishi Outlander', 5, 'CVT'),
(23, '5678MMM', 'diésel', 'rojo', 95, '2018-05-10', 1, 'Toyota Hilux', 5, 'Manual'),
(24, '6789NNN', 'gasolina', 'gris', 110, '2020-09-28', 1, 'Chevrolet Camaro', 4, 'Manual'),
(25, '7890OOO', 'eléctrico', 'azul', 130, '2023-02-05', 1, 'Ford Mustang Mach-E', 5, 'Automática'),
(26, '8901PPP', 'híbrido no enchufable', 'blanco', 85, '2021-06-17', 1, 'Volkswagen Tiguan', 5, 'Automática'),
(27, '9012QQQ', 'diésel', 'negro', 75, '2019-08-22', 1, 'Mercedes Sprinter', 3, 'Manual'),
(28, '1234RRR', 'gasolina', 'verde', 105, '2017-11-14', 1, 'Dodge Challenger', 4, 'Automática'),
(29, '2345SSS', 'híbrido enchufable', 'amarillo', 115, '2022-04-10', 1, 'Ferrari Roma', 2, 'Automática'),
(30, '3456TTT', 'diésel', 'azul', 95, '2019-10-30', 1, 'Peugeot 3008', 5, 'Manual'),
(31, '4567UUU', 'eléctrico', 'plata', 140, '2023-07-20', 1, 'Lucid Air', 5, 'Automática'),
(32, '5678VVV', 'gasolina', 'rojo', 90, '2018-09-18', 1, 'Honda Civic Type R', 5, 'Manual'),
(33, '6789WWW', 'diésel', 'blanco', 85, '2020-12-12', 1, 'BMW Serie 3', 5, 'Automática'),
(34, '7890XXX', 'híbrido enchufable', 'gris', 110, '2021-05-25', 1, 'Lexus RX', 5, 'CVT'),
(35, '8901YYY', 'gasolina', 'negro', 100, '2019-07-07', 1, 'Jaguar F-Type', 2, 'Automática'),
(36, '9012ZZZ', 'eléctrico', 'azul', 120, '2023-03-15', 1, 'Rivian R1T', 5, 'Automática'),
(37, '1234AAA', 'diésel', 'plata', 95, '2017-10-10', 1, 'Volvo XC90', 5, 'Automática'),
(38, '2345BBB', 'híbrido enchufable', 'blanco', 105, '2022-02-28', 1, 'Porsche Taycan', 4, 'Automática'),
(39, '3456CCC', 'gasolina', 'rojo', 130, '2018-06-14', 1, 'Lamborghini Huracán', 2, 'Automática'),
(40, '4567DDD', 'eléctrico', 'verde', 150, '2023-09-10', 1, 'Tesla Model S Plaid', 5, 'Automática'),
(41, '5678EEE', 'diésel', 'negro', 85, '2019-12-20', 1, 'Skoda Kodiaq', 5, 'Manual'),
(42, '6789FFF', 'híbrido enchufable', 'azul', 90, '2021-04-12', 1, 'Ford Escape Hybrid', 5, 'CVT'),
(43, '7890GGG', 'gasolina', 'gris', 75, '2018-08-30', 1, 'Kia Sportage', 5, 'Manual'),
(44, '8901HHH', 'eléctrico', 'blanco', 135, '2022-10-25', 1, 'BMW iX', 5, 'Automática'),
(45, '9012III', 'diésel', 'plata', 110, '2020-03-10', 1, 'Range Rover Evoque', 5, 'Automática'),
(46, '1234JJJ', 'híbrido enchufable', 'negro', 120, '2023-06-05', 1, 'Mercedes GLE 450e', 5, 'CVT'),
(47, '2345KKK', 'gasolina', 'rojo', 80, '2019-09-09', 1, 'Subaru WRX STI', 5, 'Manual'),
(48, '3456LLL', 'eléctrico', 'verde', 140, '2022-12-20', 1, 'Audi e-tron GT', 5, 'Automática'),
(49, '4567MMM', 'diésel', 'blanco', 95, '2020-07-15', 1, 'Opel Grandland X', 5, 'Manual'),
(50, '5678NNN', 'gasolina', 'azul', 85, '2018-11-22', 1, 'Suzuki Swift Sport', 5, 'Manual'),
(51, '6789OOO', 'gasolina', 'rojo', 95, '2018-08-12', 1, 'Mazda MX-5', 2, 'Manual'),
(52, '7890PPP', 'diésel', 'negro', 110, '2019-05-17', 1, 'Volkswagen Passat', 5, 'Automática'),
(53, '8901QQQ', 'híbrido enchufable', 'blanco', 120, '2021-06-10', 1, 'Hyundai Ioniq', 5, 'CVT'),
(54, '9012RRR', 'eléctrico', 'azul', 140, '2023-03-08', 1, 'Tesla Model X', 5, 'Automática'),
(55, '1234SSS', 'gasolina', 'gris', 100, '2017-12-25', 1, 'Alfa Romeo Giulia', 5, 'Manual'),
(56, '2345TTT', 'diésel', 'rojo', 90, '2019-07-14', 1, 'Ford Kuga', 5, 'Automática'),
(57, '3456UUU', 'híbrido no enchufable', 'marrón', 85, '2020-02-22', 1, 'Honda CR-V', 5, 'CVT'),
(58, '4567VVV', 'gasolina', 'negro', 130, '2021-10-30', 1, 'Chevrolet Corvette', 2, 'Automática'),
(59, '5678WWW', 'diésel', 'blanco', 95, '2018-05-09', 1, 'Renault Koleos', 5, 'Manual'),
(60, '6789XXX', 'eléctrico', 'verde', 145, '2023-01-15', 1, 'Nissan Ariya', 5, 'Automática'),
(61, '7890YYY', 'híbrido enchufable', 'azul', 110, '2022-06-19', 1, 'Toyota RAV4', 5, 'CVT'),
(62, '8901ZZZ', 'gasolina', 'plata', 125, '2021-09-21', 1, 'Dodge Charger', 5, 'Automática'),
(63, '9012AAA', 'diésel', 'gris', 100, '2020-12-11', 1, 'Jeep Grand Cherokee', 5, 'Manual'),
(64, '1234BBB', 'híbrido no enchufable', 'rojo', 120, '2023-02-05', 1, 'Lexus NX', 5, 'CVT'),
(65, '2345CCC', 'eléctrico', 'blanco', 135, '2022-05-28', 1, 'BMW i4', 5, 'Automática'),
(66, '3456DDD', 'gasolina', 'azul', 90, '2019-04-14', 1, 'Subaru Forester', 5, 'Manual'),
(67, '4567EEE', 'diésel', 'negro', 110, '2020-08-10', 1, 'Audi A6', 5, 'Automática'),
(68, '5678FFF', 'híbrido enchufable', 'plata', 115, '2021-11-13', 1, 'Mitsubishi Eclipse Cross', 5, 'CVT'),
(69, '6789GGG', 'eléctrico', 'verde', 140, '2023-07-02', 1, 'Polestar 2', 5, 'Automática'),
(70, '7890HHH', 'gasolina', 'marrón', 130, '2018-06-05', 1, 'Ford Mustang GT', 4, 'Manual'),
(71, '8901III', 'diésel', 'blanco', 95, '2019-09-18', 1, 'Citroën C5 Aircross', 5, 'Manual'),
(72, '9012JJJ', 'híbrido no enchufable', 'azul', 105, '2020-11-24', 1, 'Kia Sorento', 5, 'CVT'),
(73, '1234KKK', 'eléctrico', 'rojo', 150, '2023-04-12', 1, 'Lucid Gravity', 5, 'Automática'),
(74, '2345LLL', 'gasolina', 'gris', 90, '2017-07-22', 1, 'Peugeot 208 GT', 5, 'Manual'),
(75, '3456MMM', 'diésel', 'negro', 100, '2019-06-08', 1, 'Mercedes CLA', 5, 'Automática'),
(76, '4567NNN', 'híbrido enchufable', 'plata', 120, '2022-03-01', 1, 'Volvo XC60', 5, 'CVT'),
(77, '5678OOO', 'eléctrico', 'verde', 135, '2023-09-05', 1, 'Tesla Model 3', 5, 'Automática'),
(78, '6789PPP', 'gasolina', 'blanco', 95, '2018-10-10', 1, 'Hyundai Tucson', 5, 'Manual'),
(79, '7890QQQ', 'diésel', 'azul', 110, '2020-05-29', 1, 'Jaguar F-Pace', 5, 'Automática'),
(80, '8901RRR', 'híbrido no enchufable', 'marrón', 125, '2021-12-20', 1, 'Honda HR-V', 5, 'CVT'),
(81, '9012SSS', 'eléctrico', 'gris', 140, '2023-07-15', 1, 'Porsche Macan EV', 5, 'Automática'),
(82, '1234TTT', 'gasolina', 'rojo', 130, '2019-02-14', 1, 'Alfa Romeo Stelvio', 5, 'Automática'),
(83, '2345UUU', 'diésel', 'negro', 95, '2018-11-17', 1, 'Toyota Corolla', 5, 'Manual'),
(84, '3456VVV', 'híbrido enchufable', 'plata', 110, '2021-08-12', 1, 'BMW X3', 5, 'CVT'),
(85, '4567WWW', 'eléctrico', 'azul', 145, '2023-06-09', 1, 'Ford Explorer EV', 5, 'Automática'),
(86, '5678XXX', 'gasolina', 'verde', 90, '2017-05-25', 1, 'Mini Cooper S', 4, 'Manual'),
(87, '6789YYY', 'diésel', 'blanco', 100, '2019-03-15', 1, 'Volkswagen T-Roc', 5, 'Automática'),
(88, '5678AAA', 'gasolina', 'negro', 75, '2021-05-14', 1, 'Ducati Panigale V4', 2, 'Manual'),
(89, '6789BBB', 'diésel', 'rojo', 80, '2022-03-20', 1, 'Harley-Davidson Sportster', 2, 'Manual'),
(90, '7890CCC', 'gasolina', 'blanco', 65, '2020-06-11', 1, 'KTM Duke 790', 2, 'Manual'),
(91, '8901DDD', 'diésel', 'azul', 70, '2019-08-05', 1, 'Yamaha XSR700', 2, 'Manual'),
(92, '9012EEE', 'híbrido no enchufable', 'verde', 90, '2023-01-17', 1, 'BMW R1250GS', 2, 'Manual'),
(93, '1234FFF', 'gasolina', 'negro', 85, '2018-10-22', 1, 'Honda CBR500R', 2, 'Manual'),
(94, '2345GGG', 'diésel', 'gris', 95, '2021-07-30', 1, 'Suzuki V-Strom 650', 2, 'Manual'),
(95, '3456HHH', 'híbrido enchufable', 'plata', 100, '2022-11-15', 1, 'Kawasaki Versys 1000', 2, 'Manual'),
(96, '4567III', 'eléctrico', 'rojo', 110, '2023-09-01', 1, 'Zero SR/F', 2, 'Automática'),
(97, '5678JJJ', 'gasolina', 'azul', 105, '2019-05-25', 1, 'Triumph Tiger 900', 2, 'Manual'),
(98, '6789KKK', 'diésel', 'blanco', 85, '2018-08-10', 1, 'Fiat Ducato', 3, 'Manual'),
(99, '7890LLL', 'gasolina', 'gris', 95, '2020-12-05', 1, 'Peugeot Boxer', 3, 'Automática'),
(100, '8901MMM', 'híbrido no enchufable', 'azul', 90, '2019-11-30', 1, 'Ford E-Transit', 3, 'Automática'),
(101, '9012NNN', 'diésel', 'negro', 100, '2021-06-22', 1, 'Iveco Daily', 3, 'Manual'),
(102, '1234OOO', 'gasolina', 'rojo', 105, '2023-03-18', 1, 'Volkswagen Crafter', 3, 'Automática'),
(103, '2345PPP', 'diésel', 'plata', 110, '2017-07-07', 1, 'Opel Movano', 3, 'Manual'),
(104, '3456QQQ', 'híbrido enchufable', 'verde', 115, '2022-04-10', 1, 'Renault Trafic', 3, 'Automática'),
(105, '4567RRR', 'eléctrico', 'marrón', 120, '2023-08-25', 1, 'Mercedes eSprinter', 3, 'Automática'),
(106, '5678SSS', 'diésel', 'negro', 150, '2020-10-10', 1, 'Volvo FH16', 2, 'Manual'),
(107, '6789TTT', 'diésel', 'blanco', 140, '2019-09-15', 1, 'MAN TGX', 2, 'Automática'),
(108, '7890UUU', 'híbrido no enchufable', 'rojo', 130, '2021-12-01', 1, 'DAF XF', 2, 'Manual'),
(109, '8901VVV', 'diésel', 'azul', 160, '2022-06-20', 1, 'Iveco S-Way', 2, 'Automática'),
(110, '9012WWW', 'eléctrico', 'gris', 180, '2023-05-05', 1, 'Tesla Semi', 2, 'Automática'),
(111, '1234XXX', 'híbrido enchufable', 'blanco', 170, '2022-07-12', 1, 'Scania Super', 2, 'Manual');


INSERT INTO `usuario` (`correo`, `n_documento`, `nombre`, `apellidos`, `telefono`,`fec_nac`, `rol`, `foto`, `passwd`) VALUES
('mario.moreno@email.com', 10123457, 'Mario', 'Moreno Romero', 612345687, '1983-12-18', 1, NULL, 'contraseña117'),
('carlos.garcia@email.com', 12345678, 'Carlos', 'García Pérez', 612345678, '1985-03-10', 0, NULL, 'contraseña123'),
('ana.martinez@email.com', 23456789, 'Ana', 'Martínez Sánchez', 612345679, '1990-07-22', 0, NULL, 'contraseña456'),
('juan.rodriguez@email.com', 34567890, 'Juan', 'Rodríguez López', 612345680, '1982-01-15', 0, NULL, 'contraseña789'),
('laura.fernandez@email.com', 45678901, 'Laura', 'Fernández Gómez', 612345681, '1995-11-25', 0, NULL, 'contraseña101'),
('jose.lopez@email.com', 56789012, 'José', 'López Ruiz', 612345682, '1979-02-14', 0, NULL, 'contraseña112'),
('pedro.sanchez@email.com', 67890123, 'Pedro', 'Sánchez Martínez', 612345683, '1988-08-30', 0, NULL, 'contraseña113'),
('marta.gonzalez@email.com', 78901234, 'Marta', 'González García', 612345684, '1992-06-05', 0, NULL, 'contraseña114'),
('david.alvarez@email.com', 89012345, 'David', 'Álvarez Díaz', 612345685, '1980-04-20', 0, NULL, 'contraseña115'),
('lucia.jimenez@email.com', 90123456, 'Lucía', 'Jiménez Pérez', 612345686, '1996-09-10', 0, NULL, 'contraseña116'),
('alberto.castro@email.com', 91234567, 'Alberto', 'Castro Ruiz', 612345688, '1984-05-12', 0, NULL, 'contraseña118'),
('elena.mendoza@email.com', 92345678, 'Elena', 'Mendoza Gil', 612345689, '1991-07-07', 0, NULL, 'contraseña119'),
('francisco.ortiz@email.com', 93456789, 'Francisco', 'Ortiz Peña', 612345690, '1987-03-15', 0, NULL, 'contraseña120'),
('isabel.dominguez@email.com', 94567890, 'Isabel', 'Domínguez Herrera', 612345691, '1993-11-20', 0, NULL, 'contraseña121'),
('javier.serrano@email.com', 95678901, 'Javier', 'Serrano Vargas', 612345692, '1986-09-25', 0, NULL, 'contraseña122'),
('patricia.flores@email.com', 96789012, 'Patricia', 'Flores Ramírez', 612345693, '1994-08-30', 0, NULL, 'contraseña123'),
('raul.navarro@email.com', 97890123, 'Raúl', 'Navarro Morales', 612345694, '1981-02-14', 1, NULL, 'contraseña124'),
('carmen.reyes@email.com', 98901234, 'Carmen', 'Reyes Sánchez', 612345695, '1992-12-05', 0, NULL, 'contraseña125'),
('sergio.jimenez@email.com', 99012345, 'Sergio', 'Jiménez Pérez', 612345696, '1985-06-10', 0, NULL, 'contraseña126'),
('adriana.luna@email.com', 99123456, 'Adriana', 'Luna Torres', 612345697, '1997-03-18', 0, NULL, 'contraseña127'),
('gabriel.hernandez@email.com', 99234567, 'Gabriel', 'Hernández Soto', 612345698, '1983-05-22', 0, NULL, 'contraseña128'),
('natalia.rojas@email.com', 99345678, 'Natalia', 'Rojas Mendoza', 612345699, '1990-08-15', 0, NULL, 'contraseña129'),
('manuel.castillo@email.com', 99456789, 'Manuel', 'Castillo Paredes', 612345700, '1986-11-30', 0, NULL, 'contraseña130'),
('beatriz.suarez@email.com', 99567890, 'Beatriz', 'Suárez Peña', 612345701, '1994-06-18', 0, NULL, 'contraseña131'),
('joaquin.delgado@email.com', 99678901, 'Joaquín', 'Delgado Vera', 612345702, '1982-09-25', 0, NULL, 'contraseña132'),
('andrea.medina@email.com', 99789012, 'Andrea', 'Medina Torres', 612345703, '1991-04-10', 0, NULL, 'contraseña133'),
('fernando.cabrera@email.com', 99890123, 'Fernando', 'Cabrera León', 612345704, '1985-12-07', 0, NULL, 'contraseña134'),
('silvia.ortega@email.com', 99901234, 'Silvia', 'Ortega Herrera', 612345705, '1993-07-21', 0, NULL, 'contraseña135'),
('tomas.perez@email.com', 99912345, 'Tomás', 'Pérez Sánchez', 612345706, '1989-03-05', 0, NULL, 'contraseña136'),
('elisa.navarro@email.com', 99923456, 'Elisa', 'Navarro Gutiérrez', 612345707, '1997-02-28', 0, NULL, 'contraseña137');

INSERT INTO `coche` (`id`, `id_vehiculo`, `carroceria`, `puertas`, `potencia`) VALUES
(0, 1, 'Sedán', 4, 150),
(0, 2, 'Hatchback', 5, 180),
(0, 3, 'Sedán', 4, 120),
(0, 13, 'SUV', 5, 250),
(0, 14, 'SUV', 5, 280),
(0, 15, 'SUV', 5, 320),
(0, 16, 'SUV', 5, 180),
(0, 17, 'SUV', 5, 170),
(0, 18, 'SUV', 5, 200),
(0, 19, 'Todoterreno', 4, 270),
(0, 20, 'SUV', 5, 300),
(0, 21, 'SUV', 5, 340),
(0, 22, 'SUV', 5, 250),
(0, 23, 'Pickup', 5, 240),
(0, 24, 'Coupé', 4, 350),
(0, 25, 'SUV', 5, 400),
(0, 26, 'SUV', 5, 220),
(0, 28, 'Coupé', 4, 450),
(0, 29, 'Deportivo', 2, 500),
(0, 30, 'SUV', 5, 190),
(0, 31, 'Sedán', 5, 450),
(0, 32, 'Hatchback', 5, 320),
(0, 33, 'Sedán', 5, 250),
(0, 34, 'SUV', 5, 280),
(0, 35, 'Deportivo', 2, 400),
(0, 36, 'Pickup', 5, 350),
(0, 37, 'SUV', 5, 290),
(0, 38, 'Sedán', 4, 550),
(0, 39, 'Deportivo', 2, 650),
(0, 40, 'Sedán', 5, 1020),
(0, 41, 'SUV', 5, 220),
(0, 42, 'SUV', 5, 250),
(0, 43, 'SUV', 5, 180),
(0, 44, 'SUV', 5, 400),
(0, 45, 'SUV', 5, 300),
(0, 46, 'SUV', 5, 380),
(0, 47, 'Sedán', 5, 350),
(0, 48, 'SUV', 5, 500),
(0, 49, 'SUV', 5, 180),
(0, 50, 'Hatchback', 5, 220),
(0, 51, 'Roadster', 2, 250),
(0, 52, 'Sedán', 5, 270),
(0, 53, 'Sedán', 5, 300),
(0, 54, 'SUV', 5, 600),
(0, 55, 'Sedán', 5, 320),
(0, 56, 'SUV', 5, 220),
(0, 57, 'SUV', 5, 210),
(0, 58, 'Deportivo', 2, 500),
(0, 59, 'SUV', 5, 190),
(0, 60, 'SUV', 5, 300),
(0, 61, 'SUV', 5, 250),
(0, 62, 'Sedán', 5, 450),
(0, 63, 'SUV', 5, 280),
(0, 64, 'SUV', 5, 300),
(0, 65, 'Sedán', 5, 500),
(0, 66, 'SUV', 5, 250),
(0, 67, 'Sedán', 5, 280),
(0, 68, 'SUV', 5, 260),
(0, 69, 'SUV', 5, 400),
(0, 70, 'Coupé', 4, 450),
(0, 71, 'SUV', 5, 200),
(0, 72, 'SUV', 5, 250),
(0, 73, 'SUV', 5, 500),
(0, 74, 'Hatchback', 5, 180),
(0, 75, 'Sedán', 5, 250),
(0, 76, 'SUV', 5, 400),
(0, 77, 'Sedán', 5, 600),
(0, 78, 'SUV', 5, 230),
(0, 79, 'SUV', 5, 300),
(0, 80, 'SUV', 5, 280),
(0, 81, 'SUV', 5, 550),
(0, 82, 'SUV', 5, 380),
(0, 83, 'Sedán', 5, 210),
(0, 84, 'SUV', 5, 320),
(0, 85, 'SUV', 5, 450),
(0, 86, 'Hatchback', 4, 200),
(0, 87, 'SUV', 5, 250);

INSERT INTO `moto` (`id`, `id_vehiculo`, `cilindrada`, `baul`) VALUES
(1, 4, 500, 0),
(1, 5, 600, 0),
(1, 6, 700, 0),
(1, 88, 900, 1),
(1, 89, 1100, 0),
(1, 90, 750, 1),
(1, 91, 650, 0),
(1, 92, 1200, 1),
(1, 93, 500, 0),
(1, 94, 700, 1),
(1, 95, 800, 0),
(1, 96, 600, 0),
(1, 97, 1000, 1);


INSERT INTO `furgoneta` (`id`, `id_vehiculo`, `volumen`, `longitud`, `peso_max`) VALUES
(2, 7, 18, 6.2, 3500),
(2, 8, 20, 6.5, 3700),
(2, 9, 22, 7, 4000),
(2, 98, 16, 5.5, 3200),
(2, 99, 24, 7.2, 4000),
(2, 100, 18, 6.0, 3500),
(2, 101, 20, 6.8, 3700),
(2, 102, 22, 7.1, 3900),
(2, 103, 19, 6.3, 3300),
(2, 104, 21, 6.7, 3600),
(2, 105, 23, 7.0, 3800);

INSERT INTO `camion` (`id`, `id_vehiculo`, `peso_max`, `altura`, `n_remolques`, `tipo_carga`, `matricula_rem`) VALUES
(3, 10, 18000, 4.5, 1, 'Carga general', 'AB1234CD'),
(3, 11, 22000, 5, 2, 'Automóviles', 'EF5678GH'),
(3, 12, 20000, 4.8, 1, 'Materiales de constr', 'IJ9101KL'),
(3, 106, 25000, 5.2, 2, 'Carga refrigerada', 'MN1234OP'),
(3, 107, 27000, 5.5, 3, 'Materiales de construcción', 'QR5678ST'),
(3, 108, 22000, 5.0, 1, 'Carga líquida', 'UV9101WX'),
(3, 109, 26000, 5.3, 2, 'Ganado', 'YZ2345AB'),
(3, 110, 24000, 4.9, 1, 'Madera', 'CD6789EF'),
(3, 111, 28000, 5.6, 3, 'Combustible', 'GH1234IJ');

INSERT INTO `alquiler` (`id`, `id_vehiculo`, `id_usuario`, `estado`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 1, 'mario.moreno@email.com', 'en alquiler', '2025-02-01', '2025-02-05'),
(2, 2, 'carlos.garcia@email.com', 'a pagar', '2025-02-02', '2025-02-06'),
(3, 3, 'ana.martinez@email.com', 'procesando', '2025-02-03', '2025-02-07'),
(4, 4, 'juan.rodriguez@email.com', 'denegado', '2025-02-04', '2025-02-08'),
(5, 5, 'laura.fernandez@email.com', 'en alquiler', '2025-02-05', '2025-02-09'),
(6, 6, 'jose.lopez@email.com', 'devuelto', '2025-02-06', '2025-02-10'),
(7, 7, 'pedro.sanchez@email.com', 'retraso', '2025-02-07', '2025-02-11'),
(8, 8, 'marta.gonzalez@email.com', 'a pagar', '2025-02-08', '2025-02-12'),
(9, 9, 'silvia.ortega@email.com', 'procesando', '2025-02-09', '2025-02-13'),
(10, 10, 'tomas.perez@email.com', 'en alquiler', '2025-02-10', '2025-02-14');


--
-- Indices de la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD KEY `imagen_fk` (`id_vehiculo`);

--
-- Indices de la tabla `moto`
--
ALTER TABLE `moto`
  ADD KEY `moto_fk` (`id_vehiculo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`correo`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alquiler`
--
ALTER TABLE `alquiler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alquiler`
--
ALTER TABLE `alquiler`
  ADD CONSTRAINT `alquiler_usuario_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`correo`),
  ADD CONSTRAINT `alquiler_vehiculo_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `camion`
--
ALTER TABLE `camion`
  ADD CONSTRAINT `camion_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `coche`
--
ALTER TABLE `coche`
  ADD CONSTRAINT `coche_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_fk` FOREIGN KEY (`id_alquiler`) REFERENCES `alquiler` (`id`);

--
-- Filtros para la tabla `furgoneta`
--
ALTER TABLE `furgoneta`
  ADD CONSTRAINT `furgoneta_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD CONSTRAINT `imagen_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `moto`
--
ALTER TABLE `moto`
  ADD CONSTRAINT `moto_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
