/*Ejercicio 1*/
CREATE DATABASE modelo_relacional1;

CREATE TABLE tarjeta 
(numero_tarjeta serial,nombre varchar(50),codigo varchar(4),fecha_venc date,
 CONSTRAINT pk_tarjeta PRIMARY KEY(numero_tarjeta));

CREATE TABLE cliente
(codigo_cliente serial,nombre varchar(80),fecha_nac date,
 dni_cliente varchar(15), ciudad varchar(50),id_tarjeta integer,
 CONSTRAINT pk_cliente PRIMARY KEY(codigo_cliente),
 CONSTRAINT fk_tarjeta FOREIGN KEY(id_tarjeta)
  REFERENCES tarjeta(numero_tarjeta));
 
CREATE TABLE sucursal
(numero_sucursal serial, domicilio varchar(100), ciudad varchar(50),
 CONSTRAINT pk_sucursal PRIMARY KEY(numero_sucursal));

CREATE TABLE compra
(id_compra serial, id_cliente integer, id_sucursal integer, descuento integer,
 CONSTRAINT pk_compra PRIMARY KEY(id_compra),
 CONSTRAINT fk_cliente FOREIGN KEY (id_cliente)
  REFERENCES cliente(codigo_cliente),
 CONSTRAINT fk_sucursal FOREIGN KEY (id_sucursal)
  REFERENCES sucursal(numero_sucursal));

CREATE TABLE empleado 
(legajo_empleado serial,dni_empleado varchar(15),nombre varchar(50),
 domicilio_ciudad varchar(50),domicilio_calle varchar(50),
 domicilio_numero varchar(50), 
 CONSTRAINT pk_empleado PRIMARY KEY(legajo_empleado));
 
CREATE TABLE telefonos
(id_telefono serial, telefono varchar(10), id_empleado integer,
 CONSTRAINT pk_telefono PRIMARY KEY (id_telefono),
 CONSTRAINT fk_empleado FOREIGN KEY (id_empleado)
  REFERENCES empleado(legajo_empleado));

CREATE TABLE trabaja
(id_trabaja serial, id_sucursal integer,id_empleado integer,
 dias_trabajo varchar(50), horario_trabajo tstzrange,
 CONSTRAINT pk_trabaja PRIMARY KEY (id_trabaja),
 CONSTRAINT fk_sucursal FOREIGN KEY (id_sucursal)
  REFERENCES sucursal(numero_sucursal),
 CONSTRAINT fk_empleado FOREIGN KEY (id_empleado)
  REFERENCES empleado(legajo_empleado));
  
CREATE TABLE fabrica
(cuit serial, nombre varchar(50), pais varchar(50), gerente varchar(50),
 cantEmp integer,
 CONSTRAINT pk_fabrica PRIMARY KEY (cuit));

CREATE TABLE producto
(codigo_producto serial, descripcion varchar(100), 
 color varchar(30), costo integer,id_fabrica integer,
 CONSTRAINT pk_producto PRIMARY KEY (codigo_producto),
 CONSTRAINT fk_fabrica FOREIGN KEY (id_fabrica)
  REFERENCES fabrica(cuit));
  
/*Ejercicio 2*/
CREATE DATABASE modelo_relacional2;

CREATE TABLE profesores
(rfc serial, nombre varchar(50), ap_pat varchar(50), ap_mat varchar(50),
 dir_calle varchar(50), dir_colonia varchar(50), dir_num_int integer,
 dir_num_ext integer, telefono varchar(10),
 CONSTRAINT pk_profesores PRIMARY KEY (rfc));

CREATE TABLE materias
(codigo_materia serial, nombre varchar(50),
 CONSTRAINT pk_materia PRIMARY KEY (codigo_materia));

CREATE TABLE alumnos
(boleta integer not null, nombre varchar(50), ap_pat varchar(50),
 ap_mat varchar(50), fecha_nac date,
 CONSTRAINT pkk_alumnos PRIMARY KEY (boleta));

CREATE TABLE grupo
(id_grupo serial, salon integer, id_jefe_grupo integer,
 CONSTRAINT pk_grupo PRIMARY KEY (id_grupo)
 CONSTRAINT fk_jefe_grupo FOREIGN KEY (id_jefe_grupo
  REFERENCES alumnos(boleta)));
  
CREATE TABLE imparte
(id_imparte serial, id_profesor integer, id_materia integer,
 CONSTRAINT pk_imparte PRIMARY KEY (id_imparte),
 CONSTRAINT fk_profesor FOREIGN KEY (id_profesor)
 REFERENCES profesores(rfc),
 CONSTRAINT fk_materia FOREIGN KEY (id_materia)
 REFERENCES materias(codigo_materia));

CREATE TABLE inscribe
(id_inscribe serial, id_alumno integer, id_materia integer,
 CONSTRAINT pk_inscribe PRIMARY KEY (id_inscribe),
 CONSTRAINT fk_alumno FOREIGN KEY (id_alumno)
 REFERENCES alumnos(boleta),
 CONSTRAINT fk_materia FOREIGN KEY (id_materia)
 REFERENCES materias(codigo_materia));

CREATE TABLE pertenece
(id_pertenece serial, id_alumno integer, id_grupo integer,
 CONSTRAINT pk_pertenece PRIMARY KEY (id_pertenece),
 CONSTRAINT fk_alumno FOREIGN KEY (id_alumno)
 REFERENCES alumnos(boleta),
 CONSTRAINT fk_grupo FOREIGN KEY (id_grupo)
 REFERENCES grupo(id_grupo));


  
/*Ejercicio 3*/
CREATE DATABASE modelo_relacional3;

CREATE TABLE actor
(codigo_actor serial, fecha_nac date, nombre varchar(30), apellido varchar(30),
 edad integer GENERATED ALWAYS AS (DATE_PART('year',CURRENT_DATE)-DATE_PART('year'),fecha_nac),
 CONSTRAINT pk_actor PRIMARY KEY (codigo_actor));
 
CREATE TABLE telefonos
(id_telefonos serial, id_actor integer,telefono varchar(10),
 CONSTRAINT pk_telefonos PRIMARY KEY (id_telefonos),
 CONSTRAINT fk_actor FOREIGN KEY (id_actor),
  REFERENCES actor(codigo_actor));
  
CREATE TABLE pelicula
(codigo_pelicula serial, titulo varchar(100), direccion varchar(50),
 CONSTRAINT pk_pelicula PRIMARY KEY (codigo_pelicula));
 
CREATE TABLE estudio
(codigo_estudio serial, nombre varchar(50), pais varchar(50),
 ciudad varchar(50), direccion varchar(150),
 CONSTRAINT pk_estudio PRIMARY KEY (codigo_estudio));

CREATE TABLE actua
(id_actua serial, id_actor integer, id_pelicula integer,
 CONSTRAINT pk_actua PRIMARY KEY (id_actua),
 CONSTRAINT fk_actor FOREIGN KEY (id_actor)
 REFERENCES actor(codigo_actor),
 CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula)
 REFERENCES pelicula(codigo_pelicula));

CREATE TABLE produce
(id_produce serial, id_estudio integer, id_pelicula integer,
 CONSTRAINT pk_produce PRIMARY KEY (id_produce),
 CONSTRAINT fk_estudio FOREIGN KEY (id_estudio) REFERENCES estudio(codigo_estudio),
 CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula(codigo_pelicula));