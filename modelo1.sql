
------- Geolocalizacion -------------------


create table geolocalizacion(
    idGeolocalizacion serial primary key,
    nombre varchar(52),
    idparent int REFERENCES geolocalizacion(idGeolocalizacion),
    nombreImagen varchar(250)
)

SELECT * FROM geolocalizacion;




------- Categoria -------------------


create table categoria(
    idCategoria serial primary key,
    nombre varchar(52),
    descripcion varchar(250),
    nombreImagen varchar(250),
    created_at timestamp default current_timestamp,
    idparent int REFERENCES categoria(idCategoria)
)

SELECT * FROM categoria;




------- Usuario -------------------

create table usuario(
    idUsuario serial primary key,
    nombre varchar(52),
    edad int,
    email varchar(52),
    --passsword encrypt
    password varchar(52),
    nommbreImagen varchar(250),
    telefono varchar(10) UNIQUE,
    idGeolocalizacion int REFERENCES geolocalizacion(idGeolocalizacion),
    idEvento int REFERENCES evento(idEvento),
)

SELECT * FROM usuario;


------- Evento -------------------

create table evento(
    idEvento serial primary key,
    nombre varchar(52) not null,
    descripcion varchar(250) not NULL,
    fechaInicio datetime not null,
    fechaFin datetime not null,
    publico boolean not null,
    tematica boolean DEFAULT false,
    costo decimal(10,2),
    create_at timestamp default current_timestamp,
    precioEntradaAdulto decimal(10,2) not null,
    precioEntradaNino decimal(10,2) not null,
    requerimientos varchar(500),
    idCategoria int REFERENCES categoria(idCategoria),
    idGeolocalizacion int REFERENCES geolocalizacion(idGeolocalizacion),
    idUsuario int REFERENCES usuario(idUsuario)
)


SELECT * FROM evento;




------- Mesas -------------------

create table mesas(
    idMesa serial primary key,
    maximoPersonas int,
    idEvento int REFERENCES evento(idEvento)
)

SELECT * FROM mesas;




------- Sillas -------------------

create table sillas(
    idSilla serial primary key,
    idMesa int REFERENCES mesas(idMesa),
)

SELECT * FROM sillas;



------- Invitacion -------------------

create table invitaciones(
    idInvitacion serial primary key,
    cantidadAdultos int,
    cantidadNinos int,
    idSilla int REFERENCES sillas(idSilla),
    idEvento int REFERENCES evento(idEvento),
    idUsuario int REFERENCES usuario(idUsuario)
)


SELECT * FROM invitaciones;


------- Provedor -------------------

create table provedor(
    idProvedor serial primary key,
    nombre varchar(52),
    create_at timestamp default current_timestamp,
    idUsuario int REFERENCES usuario(idUsuario)
)

SELECT * FROM provedor;


------- Producto -------------------

create table producto(
    idProducto serial primary key,
    nombre varchar(52),
    descripcion varchar(250),
    nombreImagen varchar(250),
    precio decimal(10,2),
    disponibilidad boolean,
    idProvedor int REFERENCES provedor(idProvedor),
    idcategoria int REFERENCES categoria(idCategoria),
    idGeolocalizacion int REFERENCES geolocalizacion(idGeolocalizacion) -- Para los que son producto tipo lugar
)


SELECT * FROM producto;


------- Cotizacion -------------------

create table cotizacion(
    idCotizacion serial primary key,
    estado varchar(10), -- Tipo enviada, pagada, cancelada, propuesta, aceptada, rechazada,etc.
    vencimiento datetime,
    create_at timestamp default current_timestamp,
    idProducto int REFERENCES producto(idProducto),
    idDescuento int REFERENCES descuento(idDescuento),
    idUsuario int REFERENCES usuario(idUsuario)
)

SELECT * FROM cotizacion;


------- Descuento -------------------


create table descuento(
    idDescuento serial primary key,
    nombre varchar(52),
    descripcion varchar(250),
    porcentaje decimal(10,2),
    create_at timestamp default current_timestamp
)

SELECT * FROM descuento;





------- Vamos a introducir datos en la base de datos minimo para poder hacer pruebas (en todo caso las tablas que no tengan datos no se podran probar) -------------------

------ Datos para Geolocalizacion ------------------- 
-- solo los de estado de guanajuato  en el pais de mexico
INSERT into geolocalizacion values
('Mexico', null, 'mexico.jpg'),
('Guanajuato', 1, 'guanajuato.jpg'),
('Leon', 2, 'leon.jpg'),
('Irapuato', 2, 'irapuato.jpg'),
('Celaya', 2, 'celaya.jpg'),
('Salamanca', 2, 'salamanca.jpg'),
('Silao', 2, 'silao.jpg'),
('San Miguel de Allende', 2, 'sanmigueldeallende.jpg'),
('Dolores Hidalgo', 2, 'doloreshidalgo.jpg'),
('San Francisco del Rincon', 2, 'sanfranciscodelrincon.jpg'),
('Purisima del Rincon', 2, 'purisimadelrincon.jpg'),
('Valle de Santiago', 2, 'valledesantiago.jpg'),
('Guanajuato', 2, 'guanajuato.jpg'),
('San Luis de la Paz', 2, 'sanluisdelapaz.jpg'),
('Cortazar', 2, 'cortazar.jpg'),
('Acambaro', 2, 'acambaro.jpg'),
('Tarimoro', 2, 'tarimoro.jpg'),
('Yuriria', 2, 'yuriria.jpg'),
('Salvatierra', 2, 'salvatierra.jpg'),
('Comonfort', 2, 'comonfort.jpg'),
('Santa Cruz de Juventino Rosas', 2, 'santacruzdejuventinorosas.jpg'),
('San Felipe', 2, 'sanfelipe.jpg'),
('Jerécuaro', 2, 'jerecuaro.jpg'),
('Coroneo', 2, 'coroneo.jpg'),
('Apaseo el Alto', 2, 'apaseoelalto.jpg'),
('Apaseo el Grande', 2, 'apaseoelgrande.jpg'),
('Doctor Mora', 2, 'doctormora.jpg'),
('Victoria', 2, 'victoria.jpg'),
('Santa Catarina', 2, 'santacatarina.jpg'),
('Tierra Blanca', 2, 'tierrablanca.jpg')

SELECT * FROM geolocalizacion;

------ Datos para Categoria ------------------- (para eventos de chavos)

------ Categorias Padre -------------------

INSERT INTO categoria (nombre, descripcion, nombreImagen)
VALUES
  ('Cultural', 'Eventos relacionados con arte, historia y cultura', 'cultural.jpg'),
  ('Deportivo', 'Eventos deportivos incluyendo partidos y competiciones', 'deportes.jpg'),
  ('Entretenimiento', 'Eventos de entretenimiento como festivales y circos', 'entretenimiento.jpg'),
  ('Educativo', 'Eventos educativos, seminarios y conferencias académicas', 'educativo.jpg'),
  ('Social', 'Eventos sociales que facilitan la interacción y el networking', 'social.jpg');

------ Categorias Hijo -------------------

INSERT INTO categoria (nombre, descripcion, nombreImagen, idparent)
VALUES
  ('Teatro', 'Obras de teatro y espectáculos en vivo', 'teatro.jpg', (SELECT idCategoria FROM categoria WHERE nombre = 'Cultural')),
  ('Música', 'Conciertos y eventos musicales', 'musica.jpg', (SELECT idCategoria FROM categoria WHERE nombre = 'Entretenimiento')),
  ('Cine', 'Proyecciones y festivales de cine', 'cine.jpg', (SELECT idCategoria FROM categoria WHERE nombre = 'Cultural')),
  ('Conferencia', 'Eventos enfocados en la disertación y el intercambio de ideas', 'conferencia.jpg', (SELECT idCategoria FROM categoria WHERE nombre = 'Educativo')),
  ('Carrera', 'Eventos deportivos de carrera, como maratones', 'carrera.jpg', (SELECT idCategoria FROM categoria WHERE nombre = 'Deportivo')),
  ('Exposición', 'Exhibiciones temporales o permanentes en galerías o museos', 'exposicion.jpg', (SELECT idCategoria FROM categoria WHERE nombre = 'Cultural'));


SELECT * FROM categoria;

------ Datos para Usuario -------------------

INSERT INTO usuario (nombre, edad, email, password, nommbreImagen, telefono, idGeolocalizacion, idEvento)
VALUES
  ('Ana Martínez', 28, 'ana.martinez@example.com', 'contraseñaCifrada123', 'ana.jpg', '1234567890', 1, 1),
  ('Luis Rodríguez', 34, 'luis.rodriguez@example.com', 'contraseñaCifrada456', 'luis.jpg', '1234567891', 2, 2),
  ('Sofía Castro', 22, 'sofia.castro@example.com', 'contraseñaCifrada789', 'sofia.jpg', '1234567892', 3, 3),
  ('Carlos Gómez', 45, 'carlos.gomez@example.com', 'contraseñaCifrada101', 'carlos.jpg', '1234567893', 4, 4),
  ('Mónica López', 37, 'monica.lopez@example.com', 'contraseñaCifrada102', 'monica.jpg', '1234567894', 5, 5);


SELECT * FROM usuario;

------ Datos para Evento -------------------

INSERT INTO evento (nombre, descripcion, fechaInicio, fechaFin, publico, tematica, costo, precioEntradaAdulto, precioEntradaNino, requerimientos, idCategoria, idGeolocalizacion, idUsuario)
VALUES
  ('Concierto de rock', 'Concierto de rock en vivo con bandas locales', '2021-10-15 20:00:00', '2021-10-15 23:00:00', true, false, 0.00, 100.00, 50.00, 'Traer identificación oficial', 2, 3, 3),
  ('Festival de cine', 'Festival de cine independiente con proyecciones al aire libre', '2021-10-16 18:00:00', '2021-10-16 22:00:00', true, false, 0.00, 50.00, 25.00, 'Traer silla plegable', 3, 4, 4),
  ('Conferencia de tecnología', 'Conferencia sobre las últimas tendencias en tecnología', '2021-10-17 10:00:00', '2021-10-17 13:00:00', true, false, 0.00, 200.00, 100.00, 'Traer cuaderno y pluma', 4, 5, 5),
  ('Maratón de 10k', 'Competencia de carrera de 10 kilómetros en la ciudad', '2021-10-18 07:00:00', '2021-10-18 10:00:00', true, false, 0.00, 150.00, 75.00, 'Traer ropa deportiva', 5, 6, 6),
  ('Exposición de arte', 'Exhibición de pinturas y esculturas de artistas locales', '2021-10-19 12:00:00', '2021-10-19 16:00:00', true, false, 0.00, 75.00, 37.50, 'Traer cubrebocas', 6, 7, 7);


SELECT * FROM evento;

------ Datos para Mesas -------------------


INSERT INTO mesas (maximoPersonas, idEvento)
VALUES
  (4, 1),
  (6, 2),
  (8, 3),
  (10, 4),
  (12, 5);


SELECT * FROM mesas;

------ Datos para Sillas -------------------

INSERT INTO sillas (idMesa)
VALUES
  (1),
  (2),
  (3),
  (4),
  (5),
  (1),
  (2),
  (3),
  (4),
  (5);


SELECT * FROM sillas;

------ Datos para Invitaciones -------------------

INSERT INTO invitaciones (cantidadAdultos, cantidadNinos, idSilla, idEvento, idUsuario)
VALUES
  (2, 1, 1, 1, 1),
  (3, 2, 2, 2, 2),
  (4, 3, 3, 3, 3),
  (5, 4, 4, 4, 4),
  (6, 5, 5, 5, 5);


SELECT * FROM invitaciones;

------ Datos para Provedor -------------------

INSERT INTO provedor (nombre, idUsuario)
VALUES
  ('Provedor 1', 1),
  ('Provedor 2', 2),
  ('Provedor 3', 3),
  ('Provedor 4', 4),
  ('Provedor 5', 5);


SELECT * FROM provedor;


------ Datos para Producto -------------------

INSERT INTO producto (nombre, descripcion, nombreImagen, precio, disponibilidad, idProvedor, idcategoria, idGeolocalizacion)
VALUES
  ('Restaurante', 'Restaurante de comida mexicana con terraza', 'restaurante.jpg', 500.00, true, 1, 1, 1),
  ('Hotel', 'Hotel boutique con alberca y spa', 'hotel.jpg', 1500.00, true, 2, 2, 2),
  ('Bar', 'Bar con música en vivo y cocteles artesanales', 'bar.jpg', 200.00, true, 3, 3, 3),
  ('Cafetería', 'Cafetería con repostería y café de especialidad', 'cafeteria.jpg', 100.00, true, 4, 4, 4),
  ('Gimnasio', 'Gimnasio con entrenadores personales y clases grupales', 'gimnasio.jpg', 300.00, true, 5, 5, 5);


SELECT * FROM producto;

------ Datos para Cotizacion -------------------

INSERT INTO cotizacion (estado, vencimiento, idProducto, idDescuento, idUsuario)
VALUES
  ('Enviada', '2021-10-15 23:59:59', 1, 1, 1),
  ('Pagada', '2021-10-16 23:59:59', 2, 2, 2),
  ('Cancelada', '2021-10-17 23:59:59', 3, 3, 3),
  ('Propuesta', '2021-10-18 23:59:59', 4, 4, 4),
  ('Aceptada', '2021-10-19 23:59:59', 5, 5, 5);


------ Datos para Descuento -------------------

INSERT INTO descuento (nombre, descripcion, porcentaje)
VALUES
  ('Descuento 1', 'Descuento del 10% en la compra de alimentos y bebidas', 10.00),
  ('Descuento 2', 'Descuento del 20% en la compra de hospedaje', 20.00),
  ('Descuento 3', 'Descuento del 30% en la compra de bebidas alcohólicas', 30.00),
  ('Descuento 4', 'Descuento del 40% en la compra de café y repostería', 40.00),
  ('Descuento 5', 'Descuento del 50% en la compra de membresía', 50.00);


SELECT * FROM descuento;



-- Capítulo 5
-- Consultas y Vistas

-- 5.1 Consulta de todas Tablas (Hecho en cada creacion de tabla e insercion de datos)
-- 5.2 Consulta de Tablas con la Cláusula WHERE
-- 5.3 Consultar varios valores de un campo de una tabla
-- 5.4 Consultar Registros Específicos de una Tabla
-- 5.4 Crear y consultar Vistas



-- Capítulo 6
-- Algebra Relacional
-- 6.1 Selección (SELECT)
-- 6.2 Proyección
-- 6.3 Unión (UNION)
-- 6.4 Intersección (INTERSECT)
-- 6.5 Diferencia (EXCEPT)
-- 6.6 Producto Cartesiano



-- Capítulo 7
-- Algebra Relacional Extendida
-- 7.1 Join (Unión)
-- 7.2 Left Join (Unión Izquierda)
-- 7.3 Right Join (Unión Derecha)
-- 7.4 Full Join (Unión Completa)
-- 7.5 Cross Join (Producto Cruzado)
-- 7.6 Group By (Agrupar Por)
-- 7.7 Having


-- Capítulo 8
-- Trigger

-- Agrega los Triggers que consideres necesarios para tu Proyecto








------ Seccion de peligro solo para admin de la Base de Datos -------------------

--- Hacer drop de cada tabla

drop table geolocalizacion;
drop table categoria;
drop table usuario;
drop table evento;
drop table mesas;
drop table sillas;
drop table invitaciones;
drop table provedor;
drop table producto;
drop table cotizacion;
drop table descuento;