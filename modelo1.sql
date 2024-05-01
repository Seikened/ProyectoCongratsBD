
------- Geolocalizacion -------------------


create table geolocalizacion(
    idGeolocalizacion serial primary key,
    nombre varchar(52),
    idparent int REFERENCES geolocalizacion(idGeolocalizacion),
    nombreImagen varchar(250)
)

------ Datos para Geolocalizacion ------------------- 
-- solo los de estado de guanajuato  en el pais de mexico
INSERT into geolocalizacion (nombre, idparent, nombreImagen) VALUES
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




------- Categoria -------------------


create table categoria(
    idCategoria serial primary key,
    nombre varchar(52),
    descripcion varchar(250),
    nombreImagen varchar(250),
    created_at timestamp default current_timestamp,
    idparent int REFERENCES categoria(idCategoria)
)

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
    idEvento int REFERENCES evento(idEvento)
)

------ Datos para Usuario -------------------

INSERT INTO usuario (nombre, edad, email, password, nommbreImagen, telefono, idGeolocalizacion, idEvento)
VALUES
  ('Ana Martínez', 28, 'ana.martinez@example.com', 'contraseñaCifrada123', 'ana.jpg', '1234567890', 1, null),
  ('Luis Rodríguez', 34, 'luis.rodriguez@example.com', 'contraseñaCifrada456', 'luis.jpg', '1234567891', 2, null),
  ('Sofía Castro', 22, 'sofia.castro@example.com', 'contraseñaCifrada789', 'sofia.jpg', '1234567892', 3, null),
  ('Carlos Gómez', 45, 'carlos.gomez@example.com', 'contraseñaCifrada101', 'carlos.jpg', '1234567893', 4, null),
  ('Mónica López', 37, 'monica.lopez@example.com', 'contraseñaCifrada102', 'monica.jpg', '1234567894', 5, null);


SELECT * FROM usuario;
--id usuario va del 11-15



------- Evento -------------------

create table evento(
  idEvento serial primary key,
  nombre varchar(52) not null,
  descripcion varchar(250) not NULL,
  fechaInicio timestamp not null,
  fechaFin timestamp not null,
  publico boolean not null,
  tematica boolean DEFAULT false,
  costo decimal(10,2),
  create_at timestamp default current_timestamp,
  precioEntradaAdulto decimal(10,2) not null,
  precioEntradaNino decimal(10,2) not null,
  requerimientos varchar(500),
  idCategoria int REFERENCES categoria(idCategoria),
  idGeolocalizacion int REFERENCES geolocalizacion(idGeolocalizacion)
)


ALTER TABLE evento ADD COLUMN idUsuario int REFERENCES usuario(idUsuario);

INSERT INTO evento (nombre, descripcion, fechaInicio, fechaFin, publico, tematica, costo, precioEntradaAdulto, precioEntradaNino, requerimientos, idCategoria, idGeolocalizacion, idUsuario)
VALUES
  ('Concierto de rock', 'Concierto de rock en vivo con bandas locales', '2021-10-15 20:00:00', '2021-10-15 23:00:00', true, false, 0.00, 100.00, 50.00, 'Traer identificación oficial', 2, 3, 11),
  ('Festival de cine', 'Festival de cine independiente con proyecciones al aire libre', '2021-10-16 18:00:00', '2021-10-16 22:00:00', true, false, 0.00, 50.00, 25.00, 'Traer silla plegable', 3, 4, 12),
  ('Conferencia de tecnología', 'Conferencia sobre las últimas tendencias en tecnología', '2021-10-17 10:00:00', '2021-10-17 13:00:00', true, false, 0.00, 200.00, 100.00, 'Traer cuaderno y pluma', 4, 5, 13),
  ('Maratón de 10k', 'Competencia de carrera de 10 kilómetros en la ciudad', '2021-10-18 07:00:00', '2021-10-18 10:00:00', true, false, 0.00, 150.00, 75.00, 'Traer ropa deportiva', 5, 6, 14),
  ('Exposición de arte', 'Exhibición de pinturas y esculturas de artistas locales', '2021-10-19 12:00:00', '2021-10-19 16:00:00', true, false, 0.00, 75.00, 37.50, 'Traer cubrebocas', 6, 7, 15),
  ('Graduacion', 'Graduacion de la generacion 2021', '2021-10-20 12:00:00', '2021-10-20 16:00:00', true, true, 0.00, 75.00, 37.50, 'Traer cubrebocas', 6, 7, 13);


SELECT * FROM evento;

-- id evento va del 25 al 30


------- Mesas -------------------

create table mesas(
    idMesa serial primary key,
    maximoPersonas int,
    idEvento int REFERENCES evento(idEvento)
)

------ Datos para Mesas -------------------


INSERT INTO mesas (maximoPersonas, idEvento)
VALUES
  (2, 25),
  (4, 26),
  (6, 27),
  (8, 28),
  (10, 29)


SELECT * FROM mesas;




------- Sillas -------------------

create table sillas(
    idSilla serial primary key,
    idMesa int REFERENCES mesas(idMesa)
)

------ Datos para Sillas -------------------
-- los id's de las mesas van del 21-25
INSERT INTO sillas (idMesa)
VALUES
  (21),
  (22),
  (23),
  (24),
  (25);

SELECT * FROM sillas;
-- id de sillas del 1 al 5


------- Invitacion -------------------

create table invitaciones(
    idInvitacion serial primary key,
    cantidadAdultos int,
    cantidadNinos int,
    idSilla int REFERENCES sillas(idSilla),
    idEvento int REFERENCES evento(idEvento),
    idUsuario int REFERENCES usuario(idUsuario)
)


------ Datos para Invitaciones -------------------

INSERT INTO invitaciones (cantidadAdultos, cantidadNinos, idSilla, idEvento, idUsuario)
VALUES -- timando en cuenta que los id de silla van del 1 al 5, los id de evento van del 25 al 30 y los id de usuario van del 11 al 15
  (2, 0, 1, 25, 11),
  (4, 0, 2, 26, 12),
  (6, 0, 3, 27, 13),
  (8, 0, 4, 28, 14),
  (10, 0, 5, 29, 15);


SELECT * FROM invitaciones;



------- Provedor -------------------

create table provedor(
    idProvedor serial primary key,
    nombre varchar(52),
    create_at timestamp default current_timestamp,
    idUsuario int REFERENCES usuario(idUsuario)
)

------ Datos para Provedor -------------------

INSERT INTO provedor (nombre, idUsuario)
VALUES
  ('Restaurante', 11),
  ('Hotel', 12),
  ('Bar', 13),
  ('Cafetería', 14),
  ('Gimnasio', 15);


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

------ Datos para Producto -------------------

INSERT INTO producto (nombre, descripcion, nombreImagen, precio, disponibilidad, idProvedor, idcategoria, idGeolocalizacion)
VALUES
  ('Restaurante', 'Restaurante de comida mexicana con terraza', 'restaurante.jpg', 500.00, true, 1, 1, 1),
  ('Hotel', 'Hotel boutique con alberca y spa', 'hotel.jpg', 1500.00, true, 2, 2, 2),
  ('Bar', 'Bar con música en vivo y cocteles artesanales', 'bar.jpg', 200.00, true, 3, 3, 3),
  ('Cafetería', 'Cafetería con repostería y café de especialidad', 'cafeteria.jpg', 100.00, true, 4, 4, 4),
  ('Gimnasio', 'Gimnasio con entrenadores personales y clases grupales', 'gimnasio.jpg', 300.00, true, 5, 5, 5);


SELECT * FROM producto;



------- Cotizacion -------------------

create table cotizacion(
    idCotizacion serial primary key,
    estado varchar(10), -- Tipo enviada, pagada, cancelada, propuesta, aceptada, rechazada,etc.
    vencimiento timestamp,
    create_at timestamp default current_timestamp,
    idProducto int REFERENCES producto(idProducto),
    idDescuento int REFERENCES descuento(idDescuento),
    idUsuario int REFERENCES usuario(idUsuario)
)

------ Datos para Cotizacion -------------------

INSERT INTO cotizacion (estado, vencimiento, idProducto, idDescuento, idUsuario)
VALUES
  ('Enviada', '2021-10-15 20:00:00', 1, 1, 11),
  ('Pagada', '2021-10-16 18:00:00', 2, 2, 12),
  ('Cancelada', '2021-10-17 10:00:00', 3, 3, 13),
  ('Propuesta', '2021-10-18 07:00:00', 4, 4, 14),
  ('Aceptada', '2021-10-19 12:00:00', 5, 5, 15);

SELECT * FROM cotizacion;


------- Descuento -------------------


create table descuento(
    idDescuento serial primary key,
    nombre varchar(52),
    descripcion varchar(250),
    porcentaje decimal(10,2),
    create_at timestamp default current_timestamp
)

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
-- 5.2 Consulta de Tablas con la Cláusula WHERE !
-- 5.3 Consultar varios valores de un campo de una tabla !
-- 5.4 Consultar Registros Específicos de una Tabla !
-- 5.4 Crear y consultar Vistas !



CREATE VIEW v_eventos AS
SELECT idEvento, nombre, publico, tematica 
FROM evento
WHERE publico = true;

SELECT * FROM v_eventos;

-- Esto es una vista que solo muestra los eventos publicos de la tabla evento
-- se trae los campos idEvento, nombre, publico, tematica







-- Capítulo 6
-- Algebra Relacional
-- 6.1 Selección (SELECT) *repetido
-- 6.2 Proyección
-- 6.3 Unión (UNION)
-- 6.4 Intersección (INTERSECT)
-- 6.5 Diferencia (EXCEPT)
-- 6.6 Producto Cartesiano



SELECT CAST(idUsuario AS varchar), nombre FROM usuario
UNION
SELECT CAST(idInvitacion AS varchar), CAST(cantidadAdultos AS varchar) FROM invitaciones;

SELECT CAST(idUsuario AS varchar), nombre FROM usuario
INTERSECT
SELECT CAST(idInvitacion AS varchar), CAST(cantidadAdultos AS varchar) FROM invitaciones;

SELECT CAST(idUsuario AS varchar), nombre FROM usuario
EXCEPT
SELECT CAST(idInvitacion AS varchar), CAST(cantidadAdultos AS varchar) FROM invitaciones;



SELECT * FROM usuario
CROSS JOIN invitaciones;








-- Capítulo 7
-- Algebra Relacional Extendida
-- 7.1 Join (Unión)
-- 7.2 Left Join (Unión Izquierda)
-- 7.3 Right Join (Unión Derecha)
-- 7.4 Full Join (Unión Completa)
-- 7.5 Cross Join (Producto Cruzado)
-- 7.6 Group By (Agrupar Por)
-- 7.7 Having


SELECT * FROM usuario
JOIN evento ON usuario.idEvento = evento.idEvento;


SELECT * FROM usuario
LEFT JOIN evento ON usuario.idEvento = evento.idEvento;


SELECT * FROM usuario
RIGHT JOIN evento ON usuario.idEvento = evento.idEvento;


SELECT * FROM usuario
FULL JOIN evento ON usuario.idEvento = evento.idEvento;


SELECT * FROM usuario
CROSS JOIN evento;


SELECT * FROM usuario
GROUP BY idUsuario;


SELECT * FROM usuario
GROUP BY idUsuario
HAVING idUsuario = 11;


-- Capítulo 8
-- Trigger

-- Agrega los Triggers que consideres necesarios para tu Proyecto



--Hay que hacer un trigger en la de eventos de una creacion,actualizacion o eliminacion de un evento
CREATE FUNCTION evento_trigger()
RETURNS TRIGGER AS $$
BEGIN
  -- Add trigger logic here
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER evento_trigger
AFTER INSERT OR UPDATE OR DELETE ON evento
FOR EACH ROW
EXECUTE PROCEDURE evento_trigger();






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