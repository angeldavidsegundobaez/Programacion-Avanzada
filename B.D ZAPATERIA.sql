SHOW ENGINES;

SHOW VARIABLES;

SET default_storage_engine = 'InnoDB';

-CREACIÓN DE LA BD
CREATE DATABASE zapateria CHARACTER SET UTF8MB4
COLLATE UTF8MB4_UNICODE_CI;

SHOW DATABASES;

-SELECCIÓN DE LA BD
USE zapateria;

-CREACIÓN DE LAS TABLAS
CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT,
    nombre_cliente VARCHAR(60) NOT NULL,
    apellidos_cliente VARCHAR(120) NOT NULL,
    correo VARCHAR(80),
    telefono VARCHAR(10),
    PRIMARY KEY(id_cliente)
);

CREATE TABLE producto(
    id_producto INT AUTO_INCREMENT,
    nombre_producto VARCHAR(70) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    talla INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    PRIMARY KEY(id_producto)
);

CREATE TABLE empleado(
    id_empleado INT AUTO_INCREMENT,
    nombre_empleado VARCHAR(60) NOT NULL,
    apellidos_empleado VARCHAR(120) NOT NULL,
    puesto VARCHAR(50),
    telefono VARCHAR(10),
    PRIMARY KEY(id_empleado)
);

CREATE TABLE venta(
    id_venta INT AUTO_INCREMENT,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    id_producto INT,
    id_empleado INT,
    cantidad INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(id_venta)
);

SHOW TABLES;

-RELACIONES Y RESTRICCIONES
ALTER TABLE venta ADD CONSTRAINT fk_cliente_venta
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE venta ADD CONSTRAINT fk_producto_venta
FOREIGN KEY(id_producto) REFERENCES producto(id_producto);

ALTER TABLE venta ADD CONSTRAINT fk_empleado_venta
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado);
