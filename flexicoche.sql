-- Base de datos: `flexicoche`


--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `dni` int(8) PRIMARY KEY NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `telefono` int(9) DEFAULT NULL,
  `email` varchar(40) NOT NULL,
  `fec_nac` date NOT NULL,
  `rol` tinyint(1) NOT NULL,
  `foto` blob DEFAULT NULL,
  `passwd` varchar(20) NOT NULL
);
  
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
  `id` int(11) PRIMARY KEY NOT NULL,
  `matricula` varchar(10) NOT NULL,
  `combustible` enum('gasolina','diésel','híbrido no enchufable','híbrido enchufable','tracción humana') NOT NULL,
  `color` enum('negro','blanco','gris','plata','rojo','azul','verde','amarillo','naranja','marrón','dorado','púrpura','rosa','multicolor') NOT NULL,
  `precio_dia` float NOT NULL CHECK (`precio_dia` >= 0),
  `anio_matricula` date NOT NULL,
  `disponibilidad` tinyint(1) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `n_plazas` int(2) DEFAULT NULL,
  `transmision` enum('Manual','Automática','CVT','Semiautomática','Dual-Clutch') DEFAULT NULL
);

-- --------------------------------------------------------

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
  `id_usuario` int(11) NOT NULL,
  `estado` enum('a pagar','procesando','denegado','en alquiler','devuelto','retraso') NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  CONSTRAINT `alquiler_vehiculo_fk` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`),
  CONSTRAINT `alquiler_usuario_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`dni`)
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
-- Inserts de prueba
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
(12, '3456BBB', 'diésel', 'rojo', 110, '2019-05-14', 1, 'Mercedes Actros', 2, 'Automática');

INSERT INTO `usuario` (`dni`, `nombre`, `apellidos`, `telefono`, `email`, `fec_nac`, `rol`, `foto`, `passwd`) VALUES
(10123457, 'Mario', 'Moreno Romero', 612345687, 'mario.moreno@email.com', '1983-12-18', 1, NULL, 'contraseña117'),
(12345678, 'Carlos', 'García Pérez', 612345678, 'carlos.garcia@email.com', '1985-03-10', 1, NULL, 'contraseña123'),
(23456789, 'Ana', 'Martínez Sánchez', 612345679, 'ana.martinez@email.com', '1990-07-22', 0, NULL, 'contraseña456'),
(34567890, 'Juan', 'Rodríguez López', 612345680, 'juan.rodriguez@email.com', '1982-01-15', 1, NULL, 'contraseña789'),
(45678901, 'Laura', 'Fernández Gómez', 612345681, 'laura.fernandez@email.com', '1995-11-25', 0, NULL, 'contraseña101'),
(56789012, 'José', 'López Ruiz', 612345682, 'jose.lopez@email.com', '1979-02-14', 1, NULL, 'contraseña112'),
(67890123, 'Pedro', 'Sánchez Martínez', 612345683, 'pedro.sanchez@email.com', '1988-08-30', 0, NULL, 'contraseña113'),
(78901234, 'Marta', 'González García', 612345684, 'marta.gonzalez@email.com', '1992-06-05', 1, NULL, 'contraseña114'),
(89012345, 'David', 'Álvarez Díaz', 612345685, 'david.alvarez@email.com', '1980-04-20', 1, NULL, 'contraseña115'),
(90123456, 'Lucía', 'Jiménez Pérez', 612345686, 'lucia.jimenez@email.com', '1996-09-10', 0, NULL, 'contraseña116');

INSERT INTO `coche` (`id`, `id_vehiculo`, `carroceria`, `puertas`, `potencia`) VALUES
(0, 1, 'Sedán', 4, 150),
(0, 2, 'Hatchback', 5, 180),
(0, 3, 'Sedán', 4, 120),
(0, 1, 'Sedán', 4, 150),
(0, 2, 'Hatchback', 5, 180),
(0, 3, 'Sedán', 4, 120);

INSERT INTO `moto` (`id`, `id_vehiculo`, `cilindrada`, `baul`) VALUES
(1, 4, 500, 0),
(1, 5, 600, 0),
(1, 6, 700, 0);

INSERT INTO `furgoneta` (`id`, `id_vehiculo`, `volumen`, `longitud`, `peso_max`) VALUES
(2, 7, 18, 6.2, 3500),
(2, 8, 20, 6.5, 3700),
(2, 9, 22, 7, 4000);

INSERT INTO `camion` (`id`, `id_vehiculo`, `peso_max`, `altura`, `n_remolques`, `tipo_carga`, `matricula_rem`) VALUES
(3, 10, 18000, 4.5, 1, 'Carga general', 'AB1234CD'),
(3, 11, 22000, 5, 2, 'Automóviles', 'EF5678GH'),
(3, 12, 20000, 4.8, 1, 'Materiales de constr', 'IJ9101KL'),
(3, 10, 18000, 4.5, 1, 'Carga general', 'AB1234CD'),
(3, 11, 22000, 5, 2, 'Automóviles', 'EF5678GH'),
(3, 12, 20000, 4.8, 1, 'Materiales de constr', 'IJ9101KL');

INSERT INTO `alquiler` (`id`, `id_vehiculo`, `id_usuario`, `estado`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 1, 12345678, 'en alquiler', '2025-02-01', '2025-02-05'),
(2, 2, 23456789, 'a pagar', '2025-02-02', '2025-02-06'),
(3, 3, 34567890, 'procesando', '2025-02-03', '2025-02-07'),
(4, 4, 45678901, 'denegado', '2025-02-04', '2025-02-08'),
(5, 5, 56789012, 'en alquiler', '2025-02-05', '2025-02-09'),
(6, 6, 67890123, 'devuelto', '2025-02-06', '2025-02-10'),
(7, 7, 78901234, 'retraso', '2025-02-07', '2025-02-11'),
(8, 8, 89012345, 'a pagar', '2025-02-08', '2025-02-12'),
(9, 9, 90123456, 'procesando', '2025-02-09', '2025-02-13'),
(10, 10, 10123457, 'en alquiler', '2025-02-10', '2025-02-14');

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
