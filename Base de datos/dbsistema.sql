DROP DATABASE IF EXISTS dbsistema;
CREATE DATABASE dbsistema CHARACTER SET utf8mb4;
USE dbsistema;

/* .............Creacion de tablas............ */

-- Crea tabla de Usuarios
CREATE TABLE usuarios (
    IdUsuario INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Cedula VARCHAR(20) UNIQUE NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Contrasena VARCHAR(100) NOT NULL,
    Rol ENUM('Admin', 'Usuario') NOT NULL
);

-- Crear tabla TipoSolicitud
CREATE TABLE TipoSolicitud (
    IdTipoSolicitud INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Solicitudes (
    IdSolicitud INT PRIMARY KEY AUTO_INCREMENT,
    IdUsuario INT NOT NULL,
    IdTipoSolicitud INT NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Mensaje TEXT NOT NULL,
    RutaArchivo VARCHAR(255), -- Cambiado de BLOB a VARCHAR
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Estado ENUM('Sin revisar', 'Revisado') NOT NULL,
    Respuesta TEXT,
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdTipoSolicitud) REFERENCES TipoSolicitud(IdTipoSolicitud)
);


/* .............Creacion de procedimientos de usuarios............ */
DELIMITER //

CREATE PROCEDURE crearUsuarios(
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Cedula VARCHAR(20),
    IN p_Correo VARCHAR(100),
    IN p_Contrasena VARCHAR(100),
    IN p_Rol ENUM('Admin', 'Usuario')
)
BEGIN
    INSERT INTO usuarios (Nombre, Apellido, Cedula, Correo, Contrasena, Rol)
    VALUES (p_Nombre, p_Apellido, p_Cedula, p_Correo, p_Contrasena, p_Rol);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE borrarUsuarios(
    IN p_IdUsuario INT
)
BEGIN
    DELETE FROM usuarios WHERE IdUsuario = p_IdUsuario;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE editarUsuarios(
    IN p_IdUsuario INT,
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Cedula VARCHAR(20),
    IN p_Correo VARCHAR(100),
    IN p_Contrasena VARCHAR(100)
)
BEGIN
    UPDATE usuarios
    SET Nombre = p_Nombre, Apellido = p_Apellido, Cedula = p_Cedula, Correo = p_Correo, Contrasena = p_Contrasena
    WHERE IdUsuario = p_IdUsuario;
END //

DELIMITER ;



/* .............Creacion de procedimientos de solicitudes............ */

DELIMITER //
CREATE PROCEDURE crearSolicitud(
    IN p_IdUsuario INT,
    IN p_IdTipoSolicitud INT,
    IN p_Titulo VARCHAR(100),
    IN p_Mensaje TEXT,
    IN p_RutaArchivo VARCHAR(255) -- Cambiado de BLOB a VARCHAR
)
BEGIN
    INSERT INTO Solicitudes (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, RutaArchivo, Estado, Respuesta)
    VALUES (p_IdUsuario, p_IdTipoSolicitud, p_Titulo, p_Mensaje, p_RutaArchivo, 'Sin revisar', 'No hay respuestas todavia :(');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borrarSolicitud(
    IN p_IdSolicitud INT
)
BEGIN
    DELETE FROM Solicitudes WHERE IdSolicitud = p_IdSolicitud;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE editarSolicitud(
    IN p_IdSolicitud INT,
    IN p_Titulo VARCHAR(100),
    IN p_Mensaje TEXT,
    IN p_RutaArchivo VARCHAR(255),
    IN p_IdTipoSolicitud INT
)
BEGIN
    UPDATE Solicitudes
    SET Titulo = p_Titulo, Mensaje = p_Mensaje, RutaArchivo = p_RutaArchivo, IdTipoSolicitud = p_IdTipoSolicitud
    WHERE IdSolicitud = p_IdSolicitud;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE atenderSolicitud(
    IN p_IdSolicitud INT,
    IN p_Respuesta TEXT
)
BEGIN
    UPDATE Solicitudes
    SET Respuesta = p_Respuesta, Estado = 'Revisado'
    WHERE IdSolicitud = p_IdSolicitud;
END //
DELIMITER ;


/* .............Creacion de datos de prueba............ */

-- Insertar un nuevo usuario o admin
INSERT INTO Usuarios (Nombre, Apellido, Cedula, Correo, Contrasena, Rol)
VALUES ('Juan', 'Perez', '123', 'juan@example.com', '123', 'Usuario'),
       ('Administrador', 'Gonzalez', '098', 'admin@example.com', '098', 'Admin');

 
 -- Insertar tipos de solicitud
INSERT INTO TipoSolicitud (tipo) VALUES
('Preguntas'),
('Quejas'),
('Reclamos'),
('Sugerencias'),
('Felicitaciones');

-- Insertar una solicitud de ejemplo

INSERT INTO Solicitudes (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, RutaArchivo, Estado, Respuesta)
VALUES (1, 2, 'Problema de Conexion', 'Hola, recientemente he experimentado algunos problemas de conexion', NULL, 'Sin revisar', 'No hay respuestas todavia :('),
	(1, 3, 'Error en la Facturación', 'Buenos días, me gustaría reportar un error en la facturación de mi cuenta.', NULL, 'Sin revisar', 'No hay respuestas todavía :('),
    (1, 4, 'Sugerencia de Mejora', 'Hola, tengo una sugerencia para mejorar el sistema de atención al cliente.', NULL, 'Sin revisar', 'No hay respuestas todavía :('),
    (1, 1, 'Consulta sobre un Producto', 'Quisiera hacer una consulta sobre las características de un producto en particular.', NULL, 'Sin revisar', 'No hay respuestas todavía :(');
    

