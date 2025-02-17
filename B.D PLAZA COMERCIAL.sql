SHOW ENGINES;

SHOW VARIABLES;

SET default_storage_engine = 'InnoDB';

-CREACIÓN DE LA BD
CREATE DATABASE plaza_comercial CHARACTER SET UTF8MB4
COLLATE UTF8MB4_UNICODE_CI;

SHOW DATABASES;

-SELECCIÓN DE LA BD
USE plaza_comercial;

-CREACIÓN DE LAS TABLAS
CREATE TABLE tienda(
    id_tienda INT AUTO_INCREMENT,
    nombre_tienda VARCHAR(70) NOT NULL UNIQUE,
    sector VARCHAR(30) NOT NULL,
    dir_tienda VARCHAR(200) NOT NULL,
    PRIMARY KEY(id_tienda)
);

CREATE TABLE empleado(
    id_empleado INT AUTO_INCREMENT,
    nombre_empleado VARCHAR(60) NOT NULL,
    apellidos VARCHAR(120) NOT NULL,
    email VARCHAR(80),
    telefono VARCHAR(10),
    id_tienda INT,
    PRIMARY KEY(id_empleado)
);

CREATE TABLE producto(
    id_producto INT AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2),
    stock INT,
    id_tienda INT,
    PRIMARY KEY(id_producto)
);

CREATE TABLE registro_venta(
    id_venta INT AUTO_INCREMENT,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_producto INT,
    id_empleado INT,
    cantidad INT,
    PRIMARY KEY(id_venta)
);

SHOW TABLES;

-RELACIONES Y RESTRICCIONES
ALTER TABLE empleado ADD CONSTRAINT fk_tienda_empleado
FOREIGN KEY(id_tienda) REFERENCES tienda(id_tienda);

ALTER TABLE producto ADD CONSTRAINT fk_tienda_producto
FOREIGN KEY(id_tienda) REFERENCES tienda(id_tienda);

ALTER TABLE registro_venta ADD CONSTRAINT fk_producto_venta
FOREIGN KEY(id_producto) REFERENCES producto(id_producto);

ALTER TABLE registro_venta ADD CONSTRAINT fk_empleado_venta
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado);
