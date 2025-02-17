SHOW ENGINES;

SHOW VARIABLES;

SET default_storage_engine = 'InnoDB';

-CREACIÓN DE LA BD
CREATE DATABASE escuela CHARACTER SET UTF8MB4
COLLATE UTF8MB4_UNICODE_CI;

SHOW DATABASES;

-SELECCIÓN DE LA BD
USE escuela;

-CREACIÓN DE LAS TABLAS
CREATE TABLE alumno(
    id_alumno INT AUTO_INCREMENT,
    nombre_alumno VARCHAR(60) NOT NULL,
    apellidos_alumno VARCHAR(120) NOT NULL,
    correo VARCHAR(80),
    telefono VARCHAR(10),
    PRIMARY KEY(id_alumno)
);

CREATE TABLE curso(
    id_curso INT AUTO_INCREMENT,
    nombre_curso VARCHAR(70) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    creditos INT NOT NULL,
    id_profesor INT,
    PRIMARY KEY(id_curso)
);

CREATE TABLE profesor(
    id_profesor INT AUTO_INCREMENT,
    nombre_profesor VARCHAR(60) NOT NULL,
    apellidos_profesor VARCHAR(120) NOT NULL,
    especialidad VARCHAR(50),
    telefono VARCHAR(10),
    PRIMARY KEY(id_profesor)
);

CREATE TABLE inscripcion(
    id_inscripcion INT AUTO_INCREMENT,
    fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_alumno INT,
    id_curso INT,
    PRIMARY KEY(id_inscripcion)
);

SHOW TABLES;

-RELACIONES Y RESTRICCIONES
ALTER TABLE curso ADD CONSTRAINT fk_profesor_curso
FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor);

ALTER TABLE inscripcion ADD CONSTRAINT fk_alumno_inscripcion
FOREIGN KEY(id_alumno) REFERENCES alumno(id_alumno);

ALTER TABLE inscripcion ADD CONSTRAINT fk_curso_inscripcion
FOREIGN KEY(id_curso) REFERENCES curso(id_curso);
