-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 27, 2023 at 01:57 AM
-- Server version: 5.7.36
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventario_libros`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_detallesLibro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detallesLibro` (IN `_codigo` VARCHAR(9))  BEGIN
SELECT libros.codigo_libro,
       libros.nombre_libro,
       libros.existencias,
       libros.precio,
       autores.nombre_autor,
       editoriales.nombre_editorial,
       generos.nombre_genero,
       libros.descripcion
  FROM ((inventario_libros.libros libros
         INNER JOIN inventario_libros.generos generos
            ON (libros.id_genero = generos.id_genero))
        INNER JOIN inventario_libros.autores autores
           ON (libros.codigo_autor = autores.codigo_autor))
       INNER JOIN inventario_libros.editoriales editoriales
          ON (libros.codigo_editorial = editoriales.codigo_editorial)
          WHERE libros.codigo_libro=_codigo;
END$$

DROP PROCEDURE IF EXISTS `sp_eliminarAutor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminarAutor` (IN `_codigo_autor` VARCHAR(6))  BEGIN
	DELETE FROM autores WHERE codigo_autor=_codigo_autor;
END$$

DROP PROCEDURE IF EXISTS `sp_insertarAutor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarAutor` (IN `_codigo_autor` VARCHAR(6), IN `_nombre_autor` VARCHAR(50), IN `_nacionalidad` VARCHAR(50))  BEGIN
  INSERT INTO autores VALUES(_codigo_autor, _nombre_autor, _nacionalidad );
END$$

DROP PROCEDURE IF EXISTS `sp_listarAutores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarAutores` ()  BEGIN
	SELECT *FROM autores;
END$$

DROP PROCEDURE IF EXISTS `sp_listarLibros`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarLibros` ()  BEGIN
SELECT libros.codigo_libro,
       libros.nombre_libro,
       libros.existencias,
       libros.precio,
       autores.nombre_autor,
       editoriales.nombre_editorial,
       generos.nombre_genero
  FROM ((inventario_libros.libros libros
         INNER JOIN inventario_libros.generos generos
            ON (libros.id_genero = generos.id_genero))
        INNER JOIN inventario_libros.autores autores
           ON (libros.codigo_autor = autores.codigo_autor))
       INNER JOIN inventario_libros.editoriales editoriales
          ON (libros.codigo_editorial = editoriales.codigo_editorial);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
CREATE TABLE IF NOT EXISTS `autores` (
  `codigo_autor` varchar(6) NOT NULL,
  `nombre_autor` varchar(50) NOT NULL,
  `nacionalidad` varchar(50) NOT NULL,
  PRIMARY KEY (`codigo_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `autores`
--

INSERT INTO `autores` (`codigo_autor`, `nombre_autor`, `nacionalidad`) VALUES
('AUT001', 'Julio Cortazar', 'Argentinoo'),
('AUT002', 'Roque Dalton', 'Salvadoreño'),
('AUT003', 'Miguel de Cervantes', 'Español'),
('AUT004', 'Oscar Wilde', 'Irlandes'),
('AUT006', 'Luis Alonso Arenivar', 'Salvadoreño'),
('AUT007', 'Eugenia Perez Martinez', 'Española'),
('AUT008', 'Aurelio Baldor', 'Cubano'),
('AUT009', 'Gabriel Garcia Marquez', 'Colombiano'),
('AUT010', 'Victor Lopez Castellanos', 'Salvadoreño'),
('AUT011', 'Mario Vargas Llosa', 'Peruano'),
('AUT012', 'Doris Lessing', 'Britanica');

-- --------------------------------------------------------

--
-- Table structure for table `editoriales`
--

DROP TABLE IF EXISTS `editoriales`;
CREATE TABLE IF NOT EXISTS `editoriales` (
  `codigo_editorial` varchar(6) NOT NULL DEFAULT '',
  `nombre_editorial` varchar(30) NOT NULL,
  `contacto` varchar(30) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  PRIMARY KEY (`codigo_editorial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `editoriales`
--

INSERT INTO `editoriales` (`codigo_editorial`, `nombre_editorial`, `contacto`, `telefono`) VALUES
('EDI001', 'Clasicos Roxsil', 'Francisco Merin', '2333-3333'),
('EDI002', 'Editorial UDB', 'Jose Perez Sosa', '2273-8574'),
('EDI003', 'Alfaguara', 'Santiago Morales', '2285-7485'),
('EDI004', 'Rama Editores', 'Marlon Castro', '2285-7485'),
('EDI005', 'McGraw-Hill', 'Steven Garcia', '2274-8596'),
('EDI006', 'Editorial Santillana', 'Miguel Sanchez', '2274-8574'),
('EDI659', 'Editorial UDB', 'Jose Perez Sosa', '2273-8574'),
('EDI722', 'Clasicos Roxsil', 'Francisco Merin', '2333-3333');

-- --------------------------------------------------------

--
-- Table structure for table `generos`
--

DROP TABLE IF EXISTS `generos`;
CREATE TABLE IF NOT EXISTS `generos` (
  `id_genero` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_genero` varchar(40) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `generos`
--

INSERT INTO `generos` (`id_genero`, `nombre_genero`, `descripcion`) VALUES
(1, 'Novela', 'Genero narrativo'),
(2, 'Poesía', 'Genero lirico'),
(3, 'Teatro', 'Obras clásicas de teatro'),
(4, 'Programación', 'Libros de programación'),
(5, 'Superación', 'Libros de superación y autoayuda'),
(6, 'Ciencias exactas', 'Libros de matemática y física'),
(7, 'Diccionarios', 'Diccionarios de diferentes idiomas y temas');

-- --------------------------------------------------------

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
CREATE TABLE IF NOT EXISTS `libros` (
  `codigo_libro` varchar(9) NOT NULL,
  `nombre_libro` varchar(50) NOT NULL,
  `existencias` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `codigo_autor` varchar(6) NOT NULL,
  `codigo_editorial` varchar(6) NOT NULL,
  `id_genero` int(11) NOT NULL,
  `descripcion` text,
  `imagen` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo_libro`),
  KEY `fk_libro_autor` (`codigo_autor`),
  KEY `fk_libro_editorial` (`codigo_editorial`),
  KEY `fk_libro_genero` (`id_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `libros`
--

INSERT INTO `libros` (`codigo_libro`, `nombre_libro`, `existencias`, `precio`, `codigo_autor`, `codigo_editorial`, `id_genero`, `descripcion`, `imagen`) VALUES
('LIB000001', 'Rayuela', 3, '15.25', 'AUT001', 'EDI004', 1, 'Rayuela es una novela del escritor argentino Julio Cortázar. Escrita en París y publicada por primera vez el 28 de junio de 1963,​ constituye una de las obras centrales del boom latinoamericano.', NULL),
('LIB000002', 'Historias de Cronopios', 10, '5.39', 'AUT001', 'EDI003', 1, 'Historias de Cronopios y de Famas es una obra fantástica del escritor argentino Julio Cortázar publicada en 1962 por el editorial Minotauro.', NULL),
('LIB000003', 'Las historias prohibidas de pulgarcito', 4, '8.75', 'AUT002', 'EDI001', 1, 'Hay dos cosas que son ciertas aquí, ahora y siempre. La primera es que la historia –la oficial, la de mayúsculas reverenciales– la escriben los ganadores...', NULL),
('LIB000004', 'Don Quijote de la Mancha', 5, '18.50', 'AUT003', 'EDI003', 1, 'Don Quijote de la Mancha​ es una novela escrita por el español Miguel de Cervantes Saavedra. Publicada su primera parte con el título de El ingenioso hidalgo don Quijote de la Mancha.', NULL),
('LIB000005', 'Novelas ejemplares', 2, '5.78', 'AUT003', 'EDI003', 1, 'Se trata de doce novelas cortas que siguen el modelo establecido en Italia. Su denominación de ejemplares obedece al carácter didáctico y moral que incluyen en alguna medida los relatos. ', NULL),
('LIB000006', 'De profundis', 1, '3.25', 'AUT004', 'EDI001', 1, 'De profundis es la epístola que Oscar Wilde escribió para su compañero, Lord Alfred Douglas en la prisión de Reading en marzo de 1897, dos meses antes de que cumpliera su sentencia, la cual fue impuesta por el delito de sodomía.', NULL),
('LIB000007', 'La Balada de la Cárcel de Reading ', 3, '2.25', 'AUT004', 'EDI001', 2, 'La Balada de la Cárcel de Reading es un poema escrito por Oscar Wilde durante su exilio en Berneval o Dieppe, Francia. Fue escrito tras su liberación de la prisión de Reading en torno al 19 de mayo de 1897. El poema es una de las baladas más representativas tanto del autor como de la literatura.', NULL),
('LIB000008', 'Algebra Vectorial. Cuadernos de catedra', 20, '15.50', 'AUT006', 'EDI002', 6, 'Cuadernos de cátedra sobre matrices y vectores para las carreras de la facultad de ingeniería de la Universidad Don Bosco.', NULL),
('LIB000009', 'Calculo diferencial. Cuadernos de cátedra', 5, '16.00', 'AUT006', 'EDI002', 6, 'Libro de calculo diferencial para los estudiantes de ingeniería de la Universidad Don Bosco. Abarca desde introducción a las funciones hasta aplicaciones de la derivada.', NULL),
('LIB000010', 'Cálculo integral. Cuadernos de cátedra.', 50, '15.50', 'AUT006', 'EDI002', 6, 'Libro de calculo integral para los estudiantes de ingeniería de la Universidad Don Bosco. Abarca desde integrales definidas hasta aplicaciones de las integrales.', NULL),
('LIB000011', 'HIBERNATE. PERSISTENCIA DE OBJETOS EN JEE', 2, '25.96', 'AUT007', 'EDI004', 4, 'Este libro ofrece, además de una introducción al framework y a la persistencia de datos en Java, un recorrido por las distintas maneras de interactuar con una base de datos relacional, empezando desde ejemplos sencillos a escenarios más complejos de mapeos. También cubre otros aspectos como el lenguaje HQL que nos permite un control más preciso de las consultas a la base de datos', NULL),
('LIB000012', 'DESARROLLO DE APLICACIONES CON EL FRAMEWORK SPRING', 3, '20.99', 'AUT007', 'EDI004', 4, 'A través de este libro te introducirás en el framework Spring y en sus conceptos clave como la inversión de control. Partiendo de ejemplos simples irás descubriendo las distintas facetas de este framework con especial énfasis en el desarrollo de aplicaciones web y sin perder de vista la integración con Hibernate.', NULL),
('LIB000015', 'Algebra', 50, '23.50', 'AUT008', 'EDI006', 6, 'Álgebra​ es un libro del matemático y profesor cubano Aurelio Baldor. La primera edición se produjo el 19 de junio de 1941. El texto de Baldor es el libro más consultado en escuelas y colegios de Latinoamérica.', NULL),
('LIB000016', 'Aritmetica', 50, '26.50', 'AUT008', 'EDI006', 6, ' No hay mejor manera que empezar el estudio de los números o matemáticas elementales que con el libro de aritmética baldor.', NULL),
('LIB000018', '100 años de soledad', 2, '15.00', 'AUT009', 'EDI001', 1, 'Cien años de soledad es una novela del escritor colombiano Gabriel García Márquez, ganador del Premio Nobel de Literatura en 1982. Es considerada una obra maestra de la literatura hispanoamericana y universal, así como una de las obras más traducidas y leídas en español.', NULL),
('LIB000019', 'El coronel no tiene quien le escriba', 3, '3.25', 'AUT009', 'EDI001', 1, 'El coronel no tiene quien le escriba es una novela corta publicada por el escritor colombiano Gabriel García Márquez en 1961. Es una de las más célebres de las escritas por el autor, y su protagonista, un viejo coronel que espera la pensión que nunca llega, es considerado como uno de los personajes más entrañables de la literatura hispanoamericana del siglo XX. Fue incluida en la lista de las 100 mejores novelas en español del siglo XX del periódico español El Mundo.', NULL),
('LIB000020', 'Apuntes de cátedra para una física de equilibrio', 17, '12.00', 'AUT010', 'EDI002', 6, 'Cuaderno de cátedra para el curso de Física Aplicada para los alumnos de la Facultad de Estudios Tecnológicos de la Universidad Don Bosco.', NULL),
('LIB000021', 'La ciudad y los perros', 2, '15.00', 'AUT011', 'EDI003', 1, 'La ciudad y los perros es la primera novela del escritor peruano Mario Vargas Llosa, Premio Nobel de Literatura 2010. Ganador con el Premio Biblioteca Breve en 1962, fue publicada en octubre de 1963 y ganó el Premio de la Crítica Española.', NULL),
('LIB000022', 'El quinto hijo', 1, '17.25', 'AUT012', 'EDI003', 1, 'Harriet y David están enamorados, deciden casarse y formar un hogar en donde poder criar felices a sus hijos. Después de los cuatro primeros niños, la llegada del quinto parece prometer aún más dicha a la pareja. Sin embargo, el bebé se empieza a mover en las entrañas de Harriet demasiado pronto y con demasiada violencia. Harriet da a luz en un difícil parto y eso no es más que el comienzo: el niño se desarrolla de forma inusual y se convierte en un extraño para sus hermanos... Un inquietante retrato de familia que habla crudamente de la naturaleza humana.', NULL),
('LIB000258', 'Programacion en Java', 2, '50.30', 'AUT007', 'EDI002', 4, 'Esta es una prueba         \r\n                                ', NULL),
('LIB748596', 'Prueba', 10, '10.00', 'AUT001', 'EDI001', 1, 'Estaa es una prueba', NULL),
('LIB785965', 'Hola', 10, '10.00', 'AUT001', 'EDI001', 1, 'Ok', NULL),
('LIB786968', 'Prueba', 10, '20.00', 'AUT001', 'EDI001', 1, 'Hola', NULL),
('LIB859632', 'Hpla', 10, '10.00', 'AUT001', 'EDI001', 1, 'Esta es una prueba', NULL),
('LIB859635', 'Hola', 10, '10.00', 'AUT001', 'EDI001', 1, 'Hola', NULL),
('LIB859685', 'Prueba', 10, '10.00', 'AUT001', 'EDI001', 1, 'Esta semana', NULL),
('LIB859689', 'Prueba', 10, '10.00', 'AUT001', 'EDI001', 1, 'Esta semana', NULL),
('LIB873696', 'Prueba', 10, '10.00', 'AUT001', 'EDI001', 1, 'Hola', NULL),
('LIB996856', 'Prueba', 10, '10.00', 'AUT001', 'EDI001', 1, 'Prueba', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_usuarios`
--

DROP TABLE IF EXISTS `tipo_usuarios`;
CREATE TABLE IF NOT EXISTS `tipo_usuarios` (
  `id_tipo_usuario` int(11) NOT NULL,
  `tipo_usuario` varchar(30) NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipo_usuarios`
--

INSERT INTO `tipo_usuarios` (`id_tipo_usuario`, `tipo_usuario`) VALUES
(1, 'ADMIN'),
(2, 'USER');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `usuario` varchar(20) NOT NULL,
  `activo` int(11) NOT NULL,
  `password` varchar(64) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`usuario`),
  KEY `FKoow8x2v17mkigyn5wqptgucu` (`id_tipo_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`usuario`, `activo`, `password`, `id_tipo_usuario`) VALUES
('guille', 1, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1),
('juan', 1, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `fk_libro_autor` FOREIGN KEY (`codigo_autor`) REFERENCES `autores` (`codigo_autor`),
  ADD CONSTRAINT `fk_libro_editorial` FOREIGN KEY (`codigo_editorial`) REFERENCES `editoriales` (`codigo_editorial`),
  ADD CONSTRAINT `fk_libro_genero` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id_genero`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `FKoow8x2v17mkigyn5wqptgucu` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuarios` (`id_tipo_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
