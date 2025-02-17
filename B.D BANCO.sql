SHOW ENGINES;

SHOW VARIABLES;

SET default_storage_engine = 'InnoDB';

-CREACIÓN DE LA BD
CREATE DATABASE banco CHARACTER SET UTF8MB4
COLLATE UTF8MB4_UNICODE_CI;

SHOW DATABASES;

-SELECCIÓN DE LA BD
USE banco;

-CREACIÓN DE LAS TABLAS
CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT,
    nombre_cliente VARCHAR(60) NOT NULL,
    apellidos_cliente VARCHAR(120) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(10),
    PRIMARY KEY(id_cliente)
);

CREATE TABLE cuenta(
    id_cuenta INT AUTO_INCREMENT,
    tipo_cuenta VARCHAR(20) NOT NULL,
    saldo DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    id_cliente INT,
    fecha_apertura DATE,
    PRIMARY KEY(id_cuenta)
);

CREATE TABLE empleado(
    id_empleado INT AUTO_INCREMENT,
    nombre_empleado VARCHAR(60) NOT NULL,
    apellidos_empleado VARCHAR(120) NOT NULL,
    puesto VARCHAR(50),
    telefono VARCHAR(10),
    PRIMARY KEY(id_empleado)
);

CREATE TABLE transaccion(
    id_transaccion INT AUTO_INCREMENT,
    fecha_transaccion DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_transaccion VARCHAR(20) NOT NULL,
-Ej: depósito, retiro
    monto DECIMAL(15,2) NOT NULL,
    id_cuenta INT,
    id_empleado INT,
    PRIMARY KEY(id_transaccion)
);
SHOW TABLES;

-RELACIONES Y RESTRICCIONES
ALTER TABLE cuenta ADD CONSTRAINT fk_cliente_cuenta
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE transaccion ADD CONSTRAINT fk_cuenta_transaccion
FOREIGN KEY(id_cuenta) REFERENCES cuenta(id_cuenta);

ALTER TABLE transaccion ADD CONSTRAINT fk_empleado_transaccion
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado);
