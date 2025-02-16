-- 10 FORMAS DE SELECT

-- 1. OBTENER TODAS LAS EMPRESAS

SELECT * FROM empresa;


-- 2. Obtener nombres y sectores de empresas en orden alfabético

SELECT nombre_empresa, sector FROM empresa ORDER BY nombre_empresa;

-- 3. Buscar candidatos con correo registrado

SELECT nom_candidato, apellidos, mail FROM candidato WHERE mail IS NOT NULL;


-- 4. Contar el número de vacantes por empresa

SELECT empresa, COUNT(*) AS total_vacantes FROM vacante GROUP BY empresa;

-- 5. Obtener las vacantes publicadas en el último mes

SELECT * FROM vacante WHERE fecha_pub >= DATE_SUB(NOW(), INTERVAL 1 MONTH);

-- 6. Mostrar las solicitudes con información de candidato y vacante

SELECT r.nom_candidato, r.apellidos, v.titulo_vacante 
FROM registro_solicitud rs
JOIN candidato r ON rs.rfc = r.rfc
JOIN vacante v ON rs.vacante = v.id_vacante;


-- 7. Buscar candidatos con teléfono que inicie con "55"

SELECT * FROM candidato WHERE tel LIKE '55%';

-- 8. Vacantes con sueldo superior a 30,000 ordenadas de mayor a menor

SELECT * FROM vacante WHERE sueldo > 30000 ORDER BY sueldo DESC;


-- 9. Empresas con más de 2 vacantes publicadas
FROM empresa e
JOIN vacante v ON e.id_empresa = v.empresa
GROUP BY e.id_empresa
HAVING COUNT(v.id_vacante) > 2;

-- 10. Vacantes con información de la empresa
SELECT v.titulo_vacante, v.descripcion, v.sueldo, e.nombre_empresa, e.sector
FROM vacante v
JOIN empresa e ON v.empresa = e.id_empresa;


-- 10 FORMAS DE UPDATE

-- 1. Actualizar el nombre de una empresa

UPDATE empresa SET nombre_empresa = 'Tech Solutions México' WHERE id_empresa = 1;

-- 2. Actualizar el sector de todas las empresas del sector "Moda" a "Diseño"

UPDATE empresa SET sector = 'Diseño' WHERE sector = 'Moda';

-- 3. Actualizar el correo de un candidato específico

UPDATE candidato SET mail = 'nuevo.correo@mail.com' WHERE rfc = 'GARC840715HDFRLL01';

-- 4. Ajustar sueldos en un 10% para todas las vacantes de tecnología

UPDATE vacante SET sueldo = sueldo * 1.1 WHERE empresa IN 
(SELECT id_empresa FROM empresa WHERE sector = 'Tecnología');

-- 5. Actualizar el número de teléfono de un candidato

UPDATE candidato SET tel = '5587654321' WHERE rfc = 'MRTJ930812HTLJMS09';

-- 6. Modificar la dirección de una empresa

UPDATE empresa SET dir_empresa = 'Nueva dirección 999, Ciudad de México' WHERE id_empresa = 5;

-- 7. Actualizar el título de una vacante

UPDATE vacante SET titulo_vacante = 'Desarrollador Full Stack' WHERE id_vacante = 1;

-- 8. Cambiar la empresa de una vacante

UPDATE vacante SET empresa = 2 WHERE id_vacante = 4;

-- 9. Actualizar la fecha de publicación de una vacante específica

UPDATE vacante SET fecha_pub = NOW() WHERE id_vacante = 3;

-- 10. Asignar un correo a todos los candidatos sin email registrado

UPDATE candidato SET mail = 'sin.correo@default.com' WHERE mail IS NULL;



-- 10 FORMAS DE PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)

-- 1. Insertar una nueva empresa

DELIMITER //
CREATE PROCEDURE InsertarEmpresa(
    IN nombre VARCHAR(70), 
    IN sector VARCHAR(30), 
    IN direccion VARCHAR(200)
)
BEGIN
    INSERT INTO empresa (nombre_empresa, sector, dir_empresa) 
    VALUES (nombre, sector, direccion);
END //
DELIMITER ;

-- Uso:

CALL InsertarEmpresa('NewTech SA', 'Tecnología', 'Calle Nueva 123, CDMX');


--  2. Obtener todas las vacantes de una empresa

DELIMITER //
CREATE PROCEDURE ObtenerVacantesEmpresa(IN empresa_id INT)
BEGIN
    SELECT * FROM vacante WHERE empresa = empresa_id;
END //
DELIMITER ;

-- Uso:

CALL ObtenerVacantesEmpresa(1);


--  3. Contar el número de candidatos registrados

DELIMITER //
CREATE PROCEDURE ContarCandidatos(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM candidato;
END //
DELIMITER ;

-- Uso:

CALL ContarCandidatos(@total);
SELECT @total;


-- 4. Buscar vacantes con sueldo mayor a cierto monto

DELIMITER //
CREATE PROCEDURE VacantesPorSueldo(IN sueldo_min INT)
BEGIN
    SELECT * FROM vacante WHERE sueldo >= sueldo_min;
END //
DELIMITER ;

-- Uso:

CALL VacantesPorSueldo(30000);

-- 5. Actualizar el teléfono de un candidato

DELIMITER //
CREATE PROCEDURE ActualizarTelefonoCandidato(IN rfc_candidato VARCHAR(13), IN nuevo_tel VARCHAR(10))
BEGIN
    UPDATE candidato SET tel = nuevo_tel WHERE rfc = rfc_candidato;
END //
DELIMITER ;

-- Uso:

CALL ActualizarTelefonoCandidato('GARC840715HDFRLL01', '5599998888');

-- 6. Registrar una nueva vacante

DELIMITER //
CREATE PROCEDURE InsertarVacante(
    IN titulo VARCHAR(50), 
    IN descripcion VARCHAR(200), 
    IN sueldo VARCHAR(6), 
    IN empresa_id INT
)
BEGIN
    INSERT INTO vacante (titulo_vacante, descripcion, sueldo, empresa) 
    VALUES (titulo, descripcion, sueldo, empresa_id);
END //
DELIMITER ;

-- Uso:

CALL InsertarVacante('Administrador de Redes', 'Encargado de la infraestructura de redes', '35000', 2);


-- 7. Listar candidatos que han aplicado a una vacante específica

DELIMITER //
CREATE PROCEDURE CandidatosPorVacante(IN id_vacante INT)
BEGIN
    SELECT c.nom_candidato, c.apellidos, c.mail, c.tel 
    FROM registro_solicitud rs
    JOIN candidato c ON rs.rfc = c.rfc
    WHERE rs.vacante = id_vacante;
END //
DELIMITER ;

--  Uso:

CALL CandidatosPorVacante(1);

-- 8. Actualizar el sector de una empresa

DELIMITER //
CREATE PROCEDURE ActualizarSectorEmpresa(IN id_empresa INT, IN nuevo_sector VARCHAR(30))
BEGIN
    UPDATE empresa SET sector = nuevo_sector WHERE id_empresa = id_empresa;
END //
DELIMITER ;

-- Uso:

CALL ActualizarSectorEmpresa(3, 'Consultoría');

-- 9. Obtener información de una empresa por nombre

DELIMITER //
CREATE PROCEDURE BuscarEmpresaPorNombre(IN nombre_buscar VARCHAR(70))
BEGIN
    SELECT * FROM empresa WHERE nombre_empresa = nombre_buscar;
END //
DELIMITER ;

-- Uso:

CALL BuscarEmpresaPorNombre('Tech Solutions SA');

-- 10. Registrar una nueva solicitud de empleo

DELIMITER //
CREATE PROCEDURE RegistrarSolicitud(
    IN rfc_candidato VARCHAR(13), 
    IN id_vacante INT
)
BEGIN
    INSERT INTO registro_solicitud (rfc, vacante) 
    VALUES (rfc_candidato, id_vacante);
END //
DELIMITER ;


-- Uso:

CALL RegistrarSolicitud('MRTJ930812HTLJMS09', 2);

