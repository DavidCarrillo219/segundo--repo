CREATE TABLE IF NOT EXISTS album(
	id_album INT PRIMARY KEY NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	anio_album date
);
CREATE TABLE IF NOT EXISTS artista(
	id_artista INT PRIMARY KEY NOT NULL,
	nombre VARCHAR (45) NOT NULL
);
CREATE TABLE IF NOT EXISTS album_artista(
	id_album INT NOT NULL,
	id_artista INT NOT NULL,
	FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE,
	FOREIGN KEY (id_artista) REFERENCES artista(id_artista) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS genero_musical(
	id_genero_musical INT PRIMARY KEY NOT NULL,
	nombre_genero VARCHAR (45) NOT NULL
);
CREATE TABLE IF NOT EXISTS album_genero_musical(
	id_album INT NOT NULL,
	id_genero_musical INT NOT NULL,
	FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE,
	FOREIGN KEY (id_genero_musical) REFERENCES genero_musical(id_genero_musical) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS artista_genero_musical(
	id_artista INT NOT NULL,
	id_genero_musical INT NOT NULL,
	FOREIGN KEY (id_artista) REFERENCES artista(id_artista) ON DELETE CASCADE,
	FOREIGN KEY (id_genero_musical) REFERENCES genero_musical(id_genero_musical) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS producto_precio(
	id_precio INT PRIMARY KEY NOT NULL,
	precio FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS producto_existencia(
	id_exis INT PRIMARY KEY NOT NULL,
	existencia INT NOT NULL
);

CREATE TABLE IF NOT EXISTS producto(
	id_producto INT PRIMARY KEY NOT NULL,
	id_precio INT NOT NULL,
	id_exis INT NOT NULL,
	FOREIGN KEY (id_precio) REFERENCES producto_precio(id_precio) ON DELETE CASCADE,
	FOREIGN KEY (id_exis)   REFERENCES producto_existencia(id_exis) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS producto_nombre(
	id_producto INT NOT NULL,
	nombre VARCHAR (90),
	descripcion VARCHAR(90),
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS genero_musical_producto(
	id_genero_musical INT NOT NULL,
	id_producto INT NOT NULL,
	FOREIGN KEY (id_genero_musical) REFERENCES genero_musical(id_genero_musical) ON DELETE CASCADE,
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS provedor_direccion(
	id_direccion INT PRIMARY KEY NOT NULL,
	calle VARCHAR(45) NOT NULL,
	colonia VARCHAR (45) NOT NULL,
	numero INT NOT NULL
);
CREATE TABLE IF NOT EXISTS provedor_nombre(
	id_nombre INT PRIMARY KEY NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	apellido_paterno VARCHAR(45) NOT NULL,
	apellido_materno VARCHAR(45) NOT NULL
);
CREATE TABLE IF NOT EXISTS provedor_ruta(
	id_ruta INT PRIMARY KEY NOT NULL,
	ruta VARCHAR(45)
);
CREATE TABLE IF NOT EXISTS provedor(
	id_provedor INT PRIMARY KEY NOT NULL,
	id_ruta INT NOT NULL,
	id_direccion INT NOT NULL,
	id_producto INT NOT NULL,
	id_nombre INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
	FOREIGN KEY (id_direccion) REFERENCES provedor_direccion(id_direccion) ON DELETE CASCADE,
	FOREIGN KEY (id_ruta) REFERENCES provedor_ruta(id_ruta) ON DELETE CASCADE,
	FOREIGN KEY (id_nombre) REFERENCES provedor_nombre(id_nombre) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS provedor_telefono(
	id_provedor INT NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	FOREIGN KEY (id_provedor) REFERENCES provedor(id_provedor) ON DELETE CASCADE,
	CHECK (telefono ~ '[0-9]{10}')
);
CREATE TABLE IF NOT EXISTS almacen_titulo(
	id_titulo INT PRIMARY KEY NOT NULL,
	titulo VARCHAR(45) NOT NULL
);
CREATE TABLE IF NOT EXISTS almacen(
	codigo_barras INT PRIMARY KEY NOT NULL,
	id_titulo INT NOT NULL,
	FOREIGN KEY (id_titulo) REFERENCES almacen_titulo(id_titulo) ON DELETE CASCADE,
	CHECK(codigo_barras BETWEEN 900000 AND 999999 )
);
CREATE TABLE IF NOT EXISTS almacen_precio(
	codigo_barras INT NOT NULL,
	precio FLOAT NOT NULL,
	FOREIGN KEY (codigo_barras) REFERENCES almacen(codigo_barras) ON DELETE CASCADE,
	CHECK(codigo_barras BETWEEN 900000 AND 999999 )
);
CREATE TABLE IF NOT EXISTS almacen_inventario(
	codigo_barras INT NOT NULL,
	exis_inventario INT NOT NULL,
	FOREIGN KEY (codigo_barras) REFERENCES almacen(codigo_barras) ON DELETE CASCADE,
	CHECK(codigo_barras BETWEEN 900000 AND 999999)
);
CREATE TABLE IF NOT EXISTS producto_almacen(
	id_producto INT NOT NULL,
	codigo_barras INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
	FOREIGN KEY (codigo_barras) REFERENCES almacen(codigo_barras) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS provedor_almacen(
	id_provedor INT NOT NULL,
	codigo_barras INT NOT NULL,
	FOREIGN KEY (id_provedor) REFERENCES provedor(id_provedor) ON DELETE CASCADE,
	FOREIGN KEY (codigo_barras) REFERENCES almacen(codigo_barras) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS compra_material(
	id_compra INT PRIMARY KEY NOT NULL,
	fecha DATE NOT NULL
);
CREATE TABLE IF NOT EXISTS compra_total(
	id_compra INT NOT NULL,
	total INT NOT NULL,
	FOREIGN KEY (id_compra) REFERENCES compra_material(id_compra) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS almacen_compra_material(
	codigo_barras INT NOT NULL,
	id_compra INT NOT NULL,	
	FOREIGN KEY (codigo_barras) REFERENCES almacen(codigo_barras) ON DELETE CASCADE,
	FOREIGN KEY (id_compra) REFERENCES compra_material(id_compra) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS producto_compra_material(
	id_producto INT NOT NULL,
	id_compra INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
	FOREIGN KEY (id_compra) REFERENCES compra_material(id_compra) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS cliente_nombre(
	id_nombre INT PRIMARY KEY NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45) NOT NULL,
	apellido_materno VARCHAR(45) NOT NULL
);
CREATE TABLE IF NOT EXISTS cliente_direccion(
	id_direccion INT PRIMARY KEY NOT NULL,
	calle VARCHAR(45) NOT NULL,
	colonia VARCHAR (45) NOT NULL,
	numero INT NOT NULL
);
CREATE TABLE IF NOT EXISTS cliente(
	id_cliente INT PRIMARY KEY NOT NULL,
	id_nombre INT NOT NULL,
	id_direccion INT NOT NULL,
	FOREIGN KEY (id_nombre) REFERENCES cliente_nombre(id_nombre) ON DELETE CASCADE,
	FOREIGN KEY (id_direccion) REFERENCES cliente_direccion(id_direccion) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS cliente_telefono(
	id_cliente INT NOT NULL,
	telefono VARCHAR (10) NOT NULL,
	CHECK (telefono ~ '[0-9]{10}'),
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE

);
CREATE TABLE IF NOT EXISTS producto_cliente(
	id_producto INT NOT NULL,
	id_cliente INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS sucursal_direccion(
	id_direccion INT PRIMARY KEY NOT NULL,
	calle VARCHAR(45) NOT NULL,
	colonia VARCHAR (45) NOT NULL,
	numero INT NOT NULL
);
CREATE TABLE IF NOT EXISTS sucursal(
	id_sucursal INT PRIMARY KEY NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	id_direccion INT NOT NULL,
	FOREIGN KEY (id_direccion) REFERENCES sucursal_direccion(id_direccion) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS producto_sucursal(
	id_producto INT NOT NULL,
	id_sucursal INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
	FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS empleado(
	id_empleado INT PRIMARY KEY NOT NULL,
	id_nombre VARCHAR (45) NOT NULL,
	id_direccion VARCHAR(50) NOT NULL,
	id_sucursal INT NOT NULL,
	FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS empleado_nombre(
	id_nombre INT PRIMARY KEY NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45) NOT NULL,
	apellido_materno VARCHAR(45) NOT NULL
);
CREATE TABLE IF NOT EXISTS empleado_direccion(
	id_direccion INT PRIMARY KEY NOT NULL,
	calle VARCHAR(45) NOT NULL,
	colonia VARCHAR(45) NOT NULL,
	numero INT NOT NULL
);
CREATE TABLE IF NOT EXISTS empleado_telefono(
	id_empleado INT NOT NULL,
	telefono VARCHAR (10) NOT NULL,
	CHECK (telefono ~ '[0-9]{10}'),
	FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS producto_empleado(
	id_producto INT NOT NULL,
	id_empleado INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
	FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
);

INSERT INTO album(id_album,nombre,anio_album)
VALUES
(123,'Off de Wall','01-01-1975'),
(223,'YHLQMDLG','02-02-2020'),
(323,'Psalmos','03-03-2019'),
(423,'Genesis','04-04-2023'),
(523,'Lover','05-05-2019'),
(386,'I am ','10-04-2023'),
(387,'Chill kill ','13-11-2023'),
(388,'Born to be ','08-01-2024'),
(389,'My world ','08-05-2023'),
(390,'The book 2 ','01-12-2021'),
(391,'40 y 20', '05-07-1992'),
(392,'Dookie', '03-05-1994'),
(393,'Queen', '01-10-1993'),
(394,'Vencedor', '27-07-2004'),
(395,'Matador', '01-03-1989');


INSERT INTO artista(id_artista,nombre)
VALUES
(312,'Michael Jackson'),
(412,'Bad Bunny'),
(512,'Jose Madero'),
(612,'Peso Pluma'),
(712,'Taylor Swift'),
(360,'IVE'),
(370,'Red velvet'),
(380,'ITZY'),
(390,'aespa'),
(400,'Yasoabi'),
(410,'José José'),
(420,'Green Day'),
(430,'Queen'),
(440,'Valentín Elizalde'),
(450,'Nirvana');

INSERT INTO genero_musical(id_genero_musical,nombre_genero)
VALUES
(132,'Pop'),
(232,'Regueton'),
(332,'Pop-Rock'),
(432,'Urban'),
(433,'Electropop'),
(286,'Kpop'),
(287,'Kpop'),
(288,'Kpop'),
(289,'kpop'),
(290,'kpop'),
(291,'Pop Latino'),
(292,'Pop Rock'),
(293,'Rock'),
(294,'Corrido'),
(295,'Punk');


INSERT INTO compra_material(id_compra,fecha)
VALUES
(99,'22-12-2020'),
(98,'25-12-2020'),
(97,'27-12-2000'),
(96,'29-12-2020'),
(95,'31-12-2020'),
(56,'22-04-2024'),
(57,'25-04-2024'),
(58,'27-04-2004'),
(59,'29-04-2024'),
(60,'31-03-2024'),
(61,'12-05-2010'),
(62,'27-03-2010'),
(63,'10-01-2011'),
(64,'21-05-2011'),
(65,'11-02-2013');


INSERT INTO compra_total(id_compra,total)
VALUES
(99,253),
(98,120),
(97,400),
(96,371),
(95,219),
(56,656),
(57,234),
(58,274),
(59,294),
(60,224),
(61,324),
(62,365),
(63,325),
(64,324),
(65,365);


INSERT INTO almacen_titulo(id_titulo,titulo)
VALUES
(5963,'Discos'),
(5982,'Bolsas'),
(5938,'Plumas'),
(5972,'Gorras'),
(5901,'Accesorios'),
(6963,'Vinilo'),
(6982,'Camisas'),
(6938,'Chamarra'),
(6972,'Pines'),
(6901,'Lonas'),
(7895,'Llavero'),
(7985,'Playeras'),
(7528,'Mochilas'),
(7652,'Posters'),
(7523,'Stickers');


INSERT INTO almacen(codigo_barras,id_titulo)
VALUES
(956789,5963),
(956788,5982),
(956787,5938),
(956786,5972),
(956785,5901),
(989898,6963),
(923344,6982),
(945656,6938),
(953544,6972),
(967553,6901),
(987654,7895),
(987653,7985),
(987652,7528),
(987651,7652),
(987650,7523);


INSERT INTO almacen_precio(codigo_barras,precio)
VALUES
(956789,100),
(956788,50),
(956787,20),
(956786,150),
(956785,85),
(989898,124),
(923344,222),
(945656,89),
(953544,800),
(967553,300),
(987654,35),
(987653,350),
(987652,60),
(987651,652),
(987650,89);

INSERT INTO almacen_inventario(codigo_barras,exis_inventario)
VALUES
(956789,100),
(956788,50),
(956787,120),
(956786,40),
(956785,60),
(989898,450),
(923344,300),
(945656,950),
(953544,200),
(967553,380),
(987654,100),
(987653,600),
(987652,120),
(987651,85),
(987650,6);

INSERT INTO cliente_nombre(id_nombre,nombre,apellido_paterno,apellido_materno)
VALUES 
(2367,'Jorge','Figueroa','Hernandez'),
(2394,'Mariana','Estrada','Lopez'),
(2318,'Gustavo','Soto','Peña'),
(2372,'Leonardo','Ramirez','Perez'),
(2391,'Omar','Coria','Jimenez'),
(3256,'Gabriela','Lucia','Caballero'),
(3257,'Joel','Posadas','Redo'),
(3285,'Alfredo','Rios','Peña'),
(3286,'Eric','Ramirez','Ramirez'),
(3287,'Liz','Salazar','Ochoa'),
(4561,'Aidee','Martinez','Ramirez'),
(4562,'Alejandro','Serralde','Salinas'),
(4569,'Genaro','Coria','Jimenez'),
(4560,'David','Carrillo','Ramirez'),
(4559,'Gibran','Herrera','Gomez');

INSERT INTO cliente_direccion(id_direccion,calle,colonia,numero)
VALUES 
(7890,'Fuentes brotantes','Parque San Andres','22'),
(7850,'San Lazaro','El Centinela','34'),
(7834,'Patriotismo','Carmen Cendran','76'),
(7812,'Mixcoac','Vicente Villada','45'),
(7809,'Jardines','Magdalena Mixihu','434'),
(8890,'Fuentes brotantes','Parque San Juan','82'),
(8850,'San Lazaro',' Senado de la republica','84'),
(8834,'Patriotismo','Vicente Guerrero','56'),
(8812,'Mixcoac','Plata','75'),
(8809,'Jardines','Oro','90'),
(9965,'Delta','Playa','32'),
(9964,'Calculo','Batalla 5 de mayo','3'),
(9963,'Alfredo','Mirador','356'),
(9962,'Patriotismo','Ejercito de Oriente','2'),
(9961,'Insurgentes','Roma','56');

INSERT INTO cliente(id_cliente,id_nombre,id_direccion)
VALUES
(1234,2367,7890),
(1235,2394,7850),
(1236,2318,7834),
(1237,2372,7812),
(1238,2391,7809),
(5454,3256,8890),
(5787,3257,8850),
(5879,3285,8834),
(5922,3286,8812),
(5285,3287,8809),
(4252,4561,9965),
(4125,4562,9964),
(4165,4561,9963),
(4136,4560,9962),
(42523,4559,9961);



INSERT INTO cliente_telefono(id_cliente,telefono)
VALUES
(1234,5656565656),
(1235,5656565655),
(1236,5656565654),
(1237,5656565653),
(1238,5656565652),
(5454,5589520202),
(5787,5858582128),
(5879,1414141022),
(5922,5878121221),
(5285,8154848481),
(4252,5523698547),
(4125,5523698745),
(4165,5523698547),
(4136,5523698745),
(4252,5536985475);

INSERT INTO producto_precio(id_precio,precio)
VALUES
(52,560),
(53,600),
(54,870),
(55,430),
(56,2200),
(58,600),
(60,700),
(62,270),
(64,530),
(66,7200),
(71,215),
(72,100),
(73,250),
(74,150),
(75,400);


INSERT INTO producto_existencia(id_exis,existencia)
VALUES
(72,10),
(73,20),
(74,15),
(75,18),
(78,32),
(80,40),
(82,60),
(84,55),
(86,78),
(88,102),
(91,45),
(92,82),
(93,800),
(94,200),
(95,42);


INSERT INTO producto(id_producto,id_precio,id_exis)
VALUES
(1,52,72),
(2,53,73),
(3,54,74),
(4,55,75),
(5,56,78),
(6,58,80),
(7,60,82),
(8,62,84),
(9,64,86),
(20,66,88),
(21,71,91),
(22,72,92),
(23,73,93),
(24,74,94),
(25,75,95);


INSERT INTO producto_nombre(id_producto,nombre,descripcion)
VALUES
(1,'Red_velvet Birthday','Disco Edicion especial album birthday de red velvet'),
(2,'Disco Zoe Aztlan','Disco album Zoe Aztlan'),
(3,'Vinilo banda radiohead Album Pablo Honey','Vinilo album Pablo honey'),
(4,'Album edicion estandar IVE i am','Disco IVE album i am edicion estandar'),
(5,'Album edicion especial TWICE','Disco edicion especial Twice del album'),
(6,'Red_velvet Camisa','Playeta banda kpop'),
(7,'Disco Zoe Andromeda','Disco album Zoe Andromeda'),
(8,'Lona IVE','Lona del grupo IVE'),
(9,'Album edicion estandar aespa My world','Disco aespa album my world edicion estandar'),
(20,'Album edicion especial ITZY','Disco edicion especial ITZY del album'),
(21,'Camisetas','Con lámpara brillante'),
(22,'Gorras','De colores obscuros'),
(23,'Posters','Grandes medianos y pequeños'),
(24,'Pantuflas Nirvana', 'Pantunflas de la banda de rock nirvana'),
(25,'Mochilas','Para niño y para adultos');



INSERT INTO provedor_nombre(id_nombre,nombre,apellido_paterno,apellido_materno)
VALUES
(9,'Juan','Perez','Ochoa'),
(8,'Sarahi','Ramirez','Landa'),
(7,'Diego','Salazar','Robles'),
(6,'Karla','Caballero','Lucia'),
(5,'Francisco','Lopez','Beltran'),
(33,'Polo','Savedra','Ochoa'),
(36,'Javier','Salinas','Salas'),
(38,'Samuel','Salazar','Lechuga'),
(39,'Eli','Nuvia','Piña'),
(40,'Elo','Guzman','Beltran'),
(23,'Alan','Perez','Alvarez'),
(24,'Diego','Robledo','Herrera'),
(25,'Javier','Martínez','Poblete'),
(26,'Gerardo','Rosas','Mata'),
(27,'Pablo','Gomez','Lora');

INSERT INTO provedor_direccion(id_direccion,calle,colonia,numero)
VALUES
(30,'Claz de la Viga','Barrio La Asuncion','22'),
(31,'Fray Servando','Jardin Balbuena','34'),
(32,'Calz Ignacio','El Paraiso','76'),
(33,'Eje 3 Oriente','Valle del Sur','45'),
(34,'Canal Rio','Area Federal Centro','434'),
(50,'Ejercito','Nacional','4000'),
(52,'Hanbada','Seul','34'),
(54,'Shibuya','Tokio','76'),
(56,'Hamburgo','Del valle','405'),
(58,'San Lazaro','Merced','525'),
(29,'Av Guelatao','Plantas','253'),
(28,'Insurgentes','Mangres','52'),
(27,'Carmelo','Antonio Dominguez','59'),
(26,'Fuerte de Loreto','La joya','526'),
(25,'Eje 5','Paraíso','658');

INSERT INTO provedor_ruta(id_ruta,ruta)
VALUES
(41,'Veracruz-CDMX'),
(42,'NuevoLeon-CDMX'),
(43,'Barbosa-CDMX'),
(45,'CDMX-CDMX'),
(46,'Puebla-CDMX'),
(61,'Tijuana-CDMX'),
(62,'Seul-CDMX'),
(63,'Tokio-CDMX'),
(65,'CDMX-CDMX'),
(66,'CDMX-CDMX'),
(72,'Guerrero-CDMX'),
(73,'Aguas Calientes-CDMX'),
(74,'Tabasco-CDMX'),
(75,'Veracruz-CDMX'),
(76,'Colina-CDMX');

INSERT INTO provedor(id_provedor,id_nombre,id_direccion,id_ruta,id_producto)
VALUES
(1,9,30,41,5),
(2,8,31,42,4),
(3,7,32,43,3),
(4,6,33,45,2),
(5,5,34,46,1),
(12,33,50,65,6),
(14,36,52,72,7),
(16,38,54,73,8),
(18,39,56,74,9),
(20,40,58,75,20),
(21,23,29,76,21),
(22,24,28,61,22),
(23,25,27,62,23),
(24,26,26,63,24),
(25,27,25,66,25);


INSERT INTO provedor_telefono(id_provedor,telefono)
VALUES
(1,5656565646),
(2,5656565645),
(3,5656565644),
(4,5656565643),
(5,5656565642),
(12,5654565646),
(14,5525482212),
(16,5521212021),
(18,5584355120),
(20,5815545212),
(21,5552584712),
(22,5525365522),
(23,5523697459),
(24,5526825741),
(25,5556987412);

INSERT INTO sucursal_direccion(id_direccion,calle,colonia,numero)
VALUES
(31,'Av Tenochtitlan','Santa Cruz Acaplixtla','162'),
(32,'Av Wilfrido Mass','Gustavo A. Madero','77'),
(33,'Puente de Piedra','Toriello Guerra','12'),
(34,'Av Sta. Lucia','Colina del Sur','1408'),
(35,'Av Hidalgo','Pueblo de Santa Cruz','9700'),
(36,'Av Patria','Santa Ana','182'),
(37,'Av Zapotitla','Tlahuac','777'),
(38,'Olla de  Piedra','Francisco Guerra','22'),
(39,'Av Sta. Luis','Colina del Norte','1808'),
(40,'Pedro Aquil','Pueblo Machu','850'),
(42,'Av Gustavo','Santa Fe','882'),
(44,'Av Lopez','Magdalena Contreras','666'),
(46,'Olla de  Bronce',' Guerra Baltica','32'),
(48,'Av Sta. Peter','Colina del Guerrero','108'),
(50,'Millan Ramos','Taka','5220');

INSERT INTO sucursal(id_sucursal,nombre,id_direccion)
VALUES
(1,'Sucursal Sur',31),
(2,'Sucursal Norte',32),
(3,'Sucursal Centro',33),
(4,'Sucursal Este',34),
(5,'Sucursal Oeste',35),
(6,'Sucursal Polanco',50),
(7,'Sucursal Ciudad Universitaria',36),
(8,'Sucursal Mixcoac',37),
(9,'Sucursal Cien Metros',38),
(10,'Sucursal Ecatepec',39),
(15,'Sucursal Oriente',40),
(16,'Sucursal Naucalpan',46),
(17,'Sucursal Sureste',42),
(18,'Sucursal Azcapozalco',48),
(19,'Sucursal Comandante',44);

INSERT INTO empleado(id_empleado,id_nombre,id_direccion,id_sucursal)
VALUES
(1,1,1,5),
(2,2,2,4),
(3,3,3,3),
(4,4,4,2),
(5,5,5,1),
(6,6,6,6),
(7,7,7,7),
(8,8,8,8),
(9,9,9,9),
(10,10,10,10),
(11,11,11,16),
(12,12,12,17),
(13,13,13,18),
(14,14,14,19),
(15,15,15,15);


INSERT INTO empleado_nombre(id_nombre,nombre,apellido_paterno,apellido_materno)
VALUES
(1,'Juan','Ramirez','Rodriguez'),
(2,'Maria','Roma','Hernandez'),
(3,'Carlo','Hernandez','Perez'),
(4,'Cesar','Leon','Lopez'),
(5,'Valeria','Carmona','Flores'),
(6,'Perry','Ramirez','Regida'),
(7,'Xavi','Flores','Hernandez'),
(8,'Griselda','Hernandez','Luna'),
(9,'Cynthia','Leon','Sol'),
(10,'Daniela','Flores','Flores'),
(11,'Pedro','Sela','Come'),
(12,'Mario','Gonzalez','Mata'),
(13,'Manuel','García','Alvarez'),
(14,'Jenny','Lopez','Estrada'),
(15, 'Elsa','Patito', 'Garcia');



INSERT INTO empleado_direccion(id_direccion,calle,colonia,numero)
VALUES
(1,'Batalla 5 de Mayo','San Juan',5),
(2,'Miguel Hidalgo','Ejercito de Agua',26),
(3,'Soledad','Fuentes',8),
(4,'Juan Angustin','San Francisco',77),
(5,'BuenaVista','Paseos',25),
(6,'Batalla 20 de Noviembre','San Carlos',50),
(7,'Miguel Negrete','Ejercito de Tierra',64),
(8,'Educacion primaria','Soledad',45),
(9,'Juan de la Barrera','San Jacinto',707),
(10,'Buenaaventura','Grand Prix',25000),
(11,'Fuerte de Loreto','Hangares','58'),
(12,'Vicente Guerrero','Recreo','85'),
(13,'Morelos','Insurgentes',98),
(14,'Republica Salvador','Ecatepec', 788),
(15,'Salvador Allende','Viaducto libre',58);


INSERT INTO empleado_telefono(id_empleado,telefono)
VALUES
(1,5555555555),
(2,5555555554),
(3,5555555553),
(4,5555555552),
(5,5555555551),
(6,6555555555),
(7,6555555554),
(8,6555555553),
(9,6555555552),
(10,6555555551),
(11,7555555555),
(12,7555555554),
(13,7555555553),
(14,7555555552),
(15,7555555551);

select * from producto where id_producto = 5;

UPDATE album
SET nombre = 'JP'
WHERE id_album = 1;

UPDATE album
SET nombre = 'SEDGD'
WHERE id_album = 2;

UPDATE artista
SET nombre = 'sdgasg'
WHERE id_artista = 312;

UPDATE artista
SET nombre = 'Jfdhwsd'
WHERE id_artista = 412;

UPDATE genero_musical
SET nombre_genero = 'fgdhd'
WHERE id_genero_musical = 132;

UPDATE genero_musical
SET nombre_genero = 'shjdfh'
WHERE id_genero_musical = 232;

UPDATE compra_material
SET fecha = '02-02-2020'
WHERE id_compra = 99;

UPDATE compra_material
SET fecha = '02-03-2020'
WHERE id_compra = 98;

UPDATE compra_total
SET total = 560
WHERE id_compra = 99;

UPDATE compra_total
SET total = 561
WHERE id_compra = 98;

UPDATE almacen_titulo
SET titulo = 'Discoss'
WHERE id_titulo = 5963;

UPDATE almacen_titulo
SET titulo = 'Bolsass'
WHERE id_titulo = 5982;

UPDATE almacen
SET id_titulo = 5963
WHERE codigo_barras = 956789;

UPDATE almacen
SET id_titulo = 5901
WHERE codigo_barras = 956785;

UPDATE almacen_precio
SET precio = 56
WHERE codigo_barras = 956788;

UPDATE almacen_precio
SET precio = 101
WHERE codigo_barras = 956789;

UPDATE almacen_inventario
SET exis_inventario = 141
WHERE codigo_barras = 956787;

UPDATE almacen_inventario
SET exis_inventario = 90
WHERE codigo_barras = 956785;

UPDATE cliente_nombre
SET nombre = 'JORGE'
WHERE id_nombre = 2367;

UPDATE cliente_nombre
SET nombre = 'MARIANA'
WHERE id_nombre = 2394;

UPDATE cliente_direccion
SET calle = 'nose'
WHERE id_direccion = 7890;

UPDATE cliente_direccion
SET calle = 'Batallon'
WHERE id_direccion = 7850;

UPDATE cliente
SET id_nombre = 2367
WHERE id_cliente = 1236;

UPDATE cliente
SET id_nombre = 2394
WHERE id_cliente = 1235;

UPDATE cliente_telefono
SET telefono = 5656565651
WHERE id_cliente = 1234;

UPDATE cliente_telefono
SET telefono = 5656565650
WHERE id_cliente = 1238;

UPDATE provedor_nombre
SET nombre = 'JUAN'
WHERE id_nombre = 9;

UPDATE provedor_nombre
SET nombre = 'SARAHI'
WHERE id_nombre = 8;

UPDATE provedor_direccion
SET numero = '22'
WHERE id_direccion = 31;

UPDATE provedor_direccion
SET numero = '35'
WHERE id_direccion = 32;

UPDATE provedor_ruta
SET ruta = 'CDMX-CDMXX'
WHERE id_ruta = 45;

UPDATE provedor_ruta
SET ruta = 'Buebla-CDMX'
WHERE id_ruta = 46;

UPDATE provedor
SET id_producto = 5
WHERE id_provedor = 5;

UPDATE provedor
SET id_producto = 2
WHERE id_provedor = 2;


UPDATE provedor_telefono
SET telefono = 5656565601
WHERE id_provedor = 15;

UPDATE provedor_telefono
SET telefono = 5656565603
WHERE id_provedor = 14;

UPDATE producto_precio
SET precio = 561
WHERE id_precio = 52;

UPDATE producto_precio
SET precio = 601
WHERE id_precio = 53;

UPDATE producto_existencia
SET existencia = 12
WHERE id_exis = 72;

UPDATE producto_existencia
SET existencia = 125
WHERE id_exis = 75;

UPDATE producto
SET id_exis = 72
WHERE id_producto = 1;

UPDATE producto_nombre
SET nombre = 'GORRAS'
WHERE id_producto = 22;

UPDATE producto_nombre
SET nombre = 'MOCHILAS'
WHERE id_producto = 25;

UPDATE sucursal_direccion
SET numero = '168'
WHERE calle = 'Olla de Piedra';

UPDATE sucursal_direccion
SET numero = '189'
WHERE calle = 'Av Lopez';

UPDATE sucursal
SET id_direccion = 31
WHERE id_sucursal = 10;

UPDATE sucursal
SET id_direccion = 32
WHERE id_sucursal = 4;

UPDATE empleado
SET id_direccion = 58
WHERE id_sucursal = 10;

UPDATE empleado
SET id_direccion = 98
WHERE id_sucursal = 11;

UPDATE empleado_nombre
SET apellido_paterno = 'Suzuki'
WHERE apellido_materno = 'Lopez';

UPDATE empleado_nombre
SET apellido_paterno = 'Hami'
WHERE apellido_paterno = 'Leon';

UPDATE empleado_direccion
SET colonia = 'SNU'
WHERE id_direccion = 6;

UPDATE empleado_direccion
SET colonia = 'SNU'
WHERE id_direccion = 3;

UPDATE empleado_telefono
SET telefono = 6666666666
WHERE id_empleado = 1;

UPDATE empleado_telefono
SET telefono = 6666666669
WHERE id_empleado = 2;



SELECT nombre,anio_album FROM album;
SELECT * FROM album;

SELECT nombre FROM artista;
SELECT * FROM artista;

SELECT * FROM genero_musical;
SELECT nombre_genero FROM genero_musical;

SELECT * FROM producto_precio;
SELECT * FROM producto_precio
WHERE id_precio BETWEEN 52 and 55;

SELECT * FROM producto_existencia;
SELECT * FROM producto_existencia
WHERE id_exis BETWEEN 72 and 75;

SELECT * FROM producto;
SELECT * FROM producto
WHERE id_precio < 55;

SELECT * FROM producto_nombre;
Select * FROM producto_nombre
WHERE nombre LIKE 'A%';

SELECT * FROM provedor_direccion;
SELECT * FROM provedor_direccion 
WHERE numero > 100;

SELECT * FROM provedor_nombre;
SELECT id_nombre FROM provedor_nombre;

SELECT * FROM provedor_ruta;
SELECT ruta FROM provedor_ruta;

SELECT * FROM provedor;
SELECT id_provedor,id_ruta FROM provedor;

SELECT * FROM provedor_telefono;
SELECT telefono FROM provedor_telefono;

SELECT * FROM almacen_titulo;
SELECT titulo FROM almacen_titulo;

SELECT * FROM almacen;
SELECT codigo_barras FROM almacen;

SELECT * FROM almacen_precio;
SELECT precio FROM almacen_precio;

SELECT * FROM almacen_inventario;
SELECT exis_inventario FROM almacen_inventario;

SELECT * FROM compra_material;
SELECT id_compra FROM compra_material;

SELECT * FROM compra_total;
SELECT total FROM compra_total;

SELECT * FROM cliente_nombre;
SELECT nombre FROM cliente_nombre;

SELECT * FROM cliente_direccion;
SELECT id_direccion FROM cliente_direccion;

SELECT * FROM cliente;
SELECT id_cliente FROM cliente;

SELECT * FROM cliente_telefono;
SELECT telefono FROM cliente_telefono;

SELECT * FROM sucursal_direccion;
SELECT colonia FROM sucursal_direccion;

SELECT * FROM sucursal;
SELECT nombre FROM sucursal;

SELECT * FROM empleado;
SELECT id_empleado FROM empleado;

SELECT * FROM empleado_nombre;
SELECT nombre FROM empleado_nombre;

SELECT * FROM empleado_direccion;
SELECT colonia FROM empleado_direccion;

SELECT * FROM empleado_telefono;
SELECT telefono FROM empleado_telefono;

SELECT nombre FROM empleado_nombre
WHERE nombre = 'Juan';

SELECT * FROM empleado
JOIN sucursal
ON empleado.id_empleado = sucursal.id_sucursal;

SELECT empleado_nombre.nombre,sucursal.nombre FROM empleado_nombre
JOIN sucursal
ON empleado_nombre.id_nombre = sucursal.id_sucursal;

DELETE FROM album
WHERE nombre= 'The book ';

DELETE FROM album
WHERE id_album= 391;


DELETE FROM artista
WHERE nombre= 'Jose Madero';

DELETE FROM artista
WHERE id_artista=420;

DELETE FROM genero_musical
WHERE id_genero_musical=433;

DELETE FROM genero_musical
WHERE nombre_genero='Kpop';


DELETE FROM compra_total
WHERE id_compra=98;


DELETE FROM compra_total
WHERE total=400;

DELETE FROM almacen
WHERE id_titulo=6549;


DELETE FROM almacen_precio
WHERE codigo_barras= 987651;

DELETE FROM almacen_precio
WHERE precio=300;

DELETE FROM almacen_inventario
WHERE codigo_barras=945656;


DELETE FROM almacen_inventario
WHERE exis_inventario=120;

 

DELETE FROM cliente_nombre
WHERE nombre= 'Jorge';

DELETE FROM cliente
WHERE id_nombre=4559;

DELETE FROM  cliente_telefono
WHERE id_cliente=5787;


DELETE FROM cliente_telefono
WHERE telefono = '5656565654';

DELETE FROM provedor
WHERE id_provedor=22;

DELETE FROM provedor
WHERE id_nombre=29;



DELETE FROM provedor_telefono
WHERE id_provedor=6;


DELETE FROM provedor_telefono
WHERE telefono='5656565644';

DELETE FROM provedor_telefono
WHERE telefono='5656565644';


DELETE FROM producto_nombre
WHERE nombre = 'Red_velvet Birthday';


DELETE FROM producto_nombre
WHERE descripcion = 'Lona del grupo IVE';


DELETE FROM sucursal_direccion
WHERE numero = '31';


DELETE FROM sucursal_direccion
WHERE id_direccion = 34;


DELETE FROM empleado
WHERE id_empleado= 1;

DELETE FROM empleado_nombre
WHERE apellido_paterno = 'Roma';


DELETE FROM empleado_nombre
WHERE apellido_materno = 'Sol';


DELETE FROM empleado_direccion
WHERE calle = 'Batalla 5 de Mayo';


DELETE FROM empleado_direccion
WHERE colonia= 'Ecatepec' ;


DELETE FROM empleado_telefono
WHERE telefono = '5555555555';


DELETE FROM empleado_telefono
WHERE id_empleado = 10;



