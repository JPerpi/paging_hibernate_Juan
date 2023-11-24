-- Instituto.Persona definition
CREATE DATABASE  IF NOT EXISTS `Instituto`;
USE `Instituto`;

CREATE TABLE `Persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `Persona` VALUES (1,'Juan Andres','Pérez Gómez',22),(2,'Ana','Mira Pons',21),(3,'Jaime','Nilo Pla',34),(4,'Andres','Pons Piera',38),(5,'Eva','Velló Garcia',20),(6,'Maria','Viñó Pons',20),(7,'Javi','Montes Llanos',40),(8,'Isabel','Grau Sainz',30),(9,'Manolo','Gimenez Estruch',19),(10,'Manuel','Bo Agut',38),
(11,'Kyoichi','Maliniak',55),(12,'Eberhardt','Terkki',63),(13,'Cristinel','Bouloucos',58),(14,'Adamantios','Portugali',59),(15,'Alejandro','Brender',56),(16,'Magy','Stamatiou',23),(17,'Alejandro','Lopez Moreno',17),(18,'Maria Luisa','Salamanca Peleteiro',30),(19,'Juan', 'Martínez Gómez', 28),(20,'María', 'López Fernández', 35),
(21,'Clara', 'Ruiz González', 26),(22,'Francisco', 'Jiménez Díaz', 38),(23,'Laura', 'Gómez Pérez', 27),(24,'David', 'Ramírez Morales', 31),(25,'Marta', 'Sánchez Ortega', 29),(26,'Miguel', 'Torres Serrano', 33),(27,'Isabel', 'Fernández Gutiérrez', 25),(28,'Javier', 'Pérez Ruiz', 30),(29,'Ana', 'Rodríguez Martín', 40),(30,'Alejandro', 'García Hernández', 22),
(31,'Pedro', 'Martín López', 34),(32,'Elena', 'Hernández Castro', 23),(33,'Adrián', 'Morales Sánchez', 32),(34,'Paula', 'Medina Fuentes', 39),(35,'Sergio', 'Díaz Rodríguez', 24),(36,'Beatriz', 'Ortiz Molina', 37),(37,'Luis', 'González Navarro', 36),(38,'Silvia', 'Castro Ferrer', 21),(39,'Alberto', 'Navarro Vega', 28),(40,'Raquel', 'Ruiz Moreno', 33),
(41,'Alicia', 'Torres Sanz', 26),(42,'Iván', 'Gutiérrez López', 39),(43,'Laura', 'Ramos Fuentes', 22),(44,'Gabriel', 'Morales Cabrera', 34),(45,'Carmen', 'Serrano Gómez', 25),(46,'Ángel', 'Vargas Ramos', 38),(47,'Nuria', 'López García', 27),(48,'Carlos', 'Herrera Romero', 31),(49,'Sara', 'Molina Martínez', 29),(50,'José', 'Torres Soto', 30);



-- Instituto.Profesor definition

CREATE TABLE `Profesor` (
  `idProfesor` int(11) NOT NULL AUTO_INCREMENT,
  `departmento` varchar(20) NOT NULL,
  `jefeDepartamento` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idProfesor`),
  CONSTRAINT `fk_Pro_Per` FOREIGN KEY (`idProfesor`) REFERENCES `Persona` (`idPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `Profesor` VALUES (3,'Informática',1),(4,'Matematicas',0),(7,'Informática',0);


-- Instituto.Clase definition

CREATE TABLE `Clase` (
  `idClase` int(11) NOT NULL AUTO_INCREMENT,
  `curso` int(11) NOT NULL,
  `grupo` char(1) NOT NULL,
  `nivel` varchar(3) NOT NULL,
  `idTutor` int(11) NOT NULL,
  PRIMARY KEY (`idClase`),
  UNIQUE KEY `idTutor` (`idTutor`),
  CONSTRAINT `fk_Cla_Pro` FOREIGN KEY (`idTutor`) REFERENCES `Profesor` (`idProfesor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `Clase` VALUES (3,1,'C','BTX',3),(4,2,'A','ESO',4),(5,1,'B','BTX',7);



-- Instituto.Alumno definition

CREATE TABLE `Alumno` (
  `idAlumno` int(11) NOT NULL AUTO_INCREMENT,
  `ampa` tinyint(1) DEFAULT NULL,
  `clase` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAlumno`),
  KEY `fk_Alu_Cla` (`clase`),
  CONSTRAINT `fk_Alu_Cla` FOREIGN KEY (`clase`) REFERENCES `Clase` (`idClase`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_Alu_Per` FOREIGN KEY (`idAlumno`) REFERENCES `Persona` (`idPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `Alumno` VALUES (1,1,3),(2,0,3),(5,1,4),(6,1,4);



-- Instituto.Docencia definition

CREATE TABLE `Docencia` (
  `idAlumno` int(11) NOT NULL,
  `idProfesor` int(11) NOT NULL,
  PRIMARY KEY (`idAlumno`,`idProfesor`),
  KEY `fk_Doc_Pro` (`idProfesor`),
  CONSTRAINT `fk_Doc_Alu` FOREIGN KEY (`idAlumno`) REFERENCES `Alumno` (`idAlumno`) ON UPDATE CASCADE,
  CONSTRAINT `fk_Doc_Pro` FOREIGN KEY (`idProfesor`) REFERENCES `Profesor` (`idProfesor`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO `Docencia` VALUES (1,3),(6,3),(1,4),(2,4),(6,4),(1,7),(2,7),(5,7),(6,7);




