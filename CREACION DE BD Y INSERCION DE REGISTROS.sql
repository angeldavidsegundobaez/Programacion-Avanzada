SHOW ENGINES;

SHOW VARIABLES;

SET default_storage_engine = 'InnoDB';

-- CREACION DE LA BD

CREATE DATABASE bolsa_trabajo CHARACTER SET UTF8MB4
COLLATE UTF8MB4_UNICODE_CI;

SHOW DATABASES;

-- SELECCION DE LA BD

USE bolsa_trabajo;

-- CREACION DE LAS TABLAS

CREATE TABLE empresa(
    id_empresa INT AUTO_INCREMENT,
    nombre_empresa VARCHAR(70) NOT NULL UNIQUE,
    sector VARCHAR(30) NOT NULL,
    dir_empresa VARCHAR(200) NOT NULL,
    PRIMARY KEY(id_empresa)
);

CREATE TABLE candidato(
    rfc VARCHAR(13),
    nom_candidato VARCHAR(60) NOT NULL,
    apellidos VARCHAR(120) NOT NULL,
    mail VARCHAR(80),
    tel VARCHAR(10),
    PRIMARY KEY(rfc)
);

CREATE TABLE vacante(
    id_vacante INT AUTO_INCREMENT,
    titulo_vacante VARCHAR(50)NOT NULL,
    descripcion VARCHAR(200)NOT NULL,
    sueldo VARCHAR(6),
    fecha_pub DATETIME DEFAULT CURRENT_TIMESTAMP,
    empresa INT,
    PRIMARY KEY(id_vacante)
);

CREATE TABLE registro_solicitud(
    id_registro INT AUTO_INCREMENT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    rfc VARCHAR(13),
    vacante INT,
    PRIMARY KEY(id_registro)
);

SHOW TABLES;

-- relaciones y restricciones

ALTER TABLE vacante ADD CONSTRAINT fK_empresa_vacante
FOREIGN KEY(empresa) REFERENCES empresa(id_empresa);

ALTER TABLE registro_solicitud ADD CONSTRAINT fk_sol_can
FOREIGN KEY(rfc) REFERENCES candidato(rfc);

ALTER TABLE registro_solicitud ADD CONSTRAINT fk_sol_vac
FOREIGN KEY(vacante) REFERENCES vacante(id_vacante);


REGISTROS PARA EMPRESA:

INSERT INTO empresa (nombre_empresa, sector, dir_empresa) VALUES
('Tech Solutions SA', 'Tecnología', 'Av. Reforma 123, Ciudad de México, CDMX'),
('Green World Ltd', 'Energía Renovable', 'Calle Verde 456, Monterrey, Nuevo León'),
('FinCorp Advisors', 'Finanzas', 'Paseo de la Reforma 789, Ciudad de México, CDMX'),
('EcoFriendly Builders', 'Construcción', 'Calle del Bosque 101, Guadalajara, Jalisco'),
('HealthCare Plus', 'Salud', 'Av. Insurgentes 555, Ciudad de México, CDMX'),
('AutoMoto MX', 'Automotriz', 'Carretera Nacional 3421, Monterrey, Nuevo León'),
('Fashion Forward', 'Moda', 'Calle Madero 234, Ciudad de México, CDMX'),
('AgroMex SA', 'Agricultura', 'Calle Rural 12, Toluca, Estado de México'),
('TravelPro Agency', 'Turismo', 'Calle del Sol 987, Cancún, Quintana Roo'),
('EduTech Innovators', 'Educación', 'Av. Universidad 2020, Puebla, Puebla');

REGISTROS PARA CANDIDATO:

INSERT INTO candidato (rfc, nom_candidato, apellidos, mail, tel) VALUES
('GARC840715HDFRLL01', 'Carlos', 'García Ramírez', 'carlos.garcia@mail.com', '5512345678'),
('MRTJ930812HTLJMS09', 'Juan', 'Martínez Jiménez', 'juan.martinez@mail.com', '5523456789'),
('PZLM850529HMNPLL07', 'Lucía', 'Pérez López', 'lucia.perez@mail.com', '5534567890'),
('RVAV900103HTLRLV09', 'Ana', 'Rivera Valenzuela', 'ana.rivera@mail.com', '5545678901'),
('RDRL790425HDFGRL04', 'Luis', 'Rodríguez Lara', 'luis.rodriguez@mail.com', '5556789012'),
('LZGS830907HMNRZS02', 'Sofía', 'López González', 'sofia.lopez@mail.com', '5567890123'),
('MNTS970112HGRNLL09', 'José', 'Montes Ruíz', 'jose.montes@mail.com', '5578901234'),
('FDZJ760324HDFRJD03', 'Javier', 'Fernández Díaz', 'javier.fernandez@mail.com', '5589012345'),
('BRCS920216HDFBRR06', 'Elena', 'Barrios Castillo', 'elena.barrios@mail.com', '5590123456'),
('HMNV880811HDFJZN08', 'Fernando', 'Hernández Mendoza', 'fernando.hernandez@mail.com', '5512346789');

REGISTROS PARA VACANTE:

INSERT INTO vacante (titulo_vacante, descripcion, sueldo, empresa) VALUES
('Desarrollador Web', 'Responsable del desarrollo de sitios web con tecnologías modernas.', '25000', 1),
('Analista Financiero', 'Análisis y evaluación financiera de proyectos y empresas.', '30000', 3),
('Ingeniero de Software', 'Desarrollo y mantenimiento de sistemas de software complejos.', '40000', 1),
('Gerente de Marketing', 'Responsable de la creación e implementación de estrategias de marketing.', '35000', 7),
('Asesor de Ventas', 'Atención a clientes y ventas de productos y servicios.', '15000', 6),
('Consultor de Recursos Humanos', 'Gestión del talento y mejora de procesos de recursos humanos.', '32000', 9),
('Diseñador Gráfico', 'Diseño de materiales gráficos para campañas publicitarias y productos.', '20000', 7),
('Arquitecto de Soluciones TI', 'Diseño e implementación de soluciones tecnológicas a nivel empresarial.', '45000', 1),
('Especialista en Energías Renovables', 'Desarrollo e implementación de proyectos de energía verde.', '28000', 2),
('Agente de Viajes', 'Organización y gestión de paquetes de viajes para clientes.', '18000', 9);

INSERT INTO registro_solicitud (rfc, vacante) VALUES
('GARC840715HDFRLL01', 1),
('MRTJ930812HTLJMS09', 2),
('PZLM850529HMNPLL07', 3),
('RVAV900103HTLRLV09', 4),
('RDRL790425HDFGRL04', 5),
('LZGS830907HMNRZS02', 6),
('MNTS970112HGRNLL09', 7),
('FDZJ760324HDFRJD03', 8),
('BRCS920216HDFBRR06', 9),
('HMNV880811HDFJZN08', 10);

