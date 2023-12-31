-- Parcial 1 / Práctico 3
CREATE DATABASE DataBaseTicket;
USE DataBaseTicket;

CREATE TABLE Roles (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Usuarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    -- Agrega otros campos de usuario según sea necesario
    FOREIGN KEY (rol_id) REFERENCES Roles(id)
);

CREATE TABLE Departamentos (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Proyectos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    fecha_contrato DATE NOT NULL,
);

CREATE TABLE Estados (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Activos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_adquisicion DATE NOT NULL,
    responsable_id INT NOT NULL,
    usuario_id INT,
    FOREIGN KEY (responsable_id) REFERENCES Usuarios(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

CREATE TABLE Tickets (
    id INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    estado_id INT NOT NULL,
    prioridad INT NOT NULL,
    usuario_solicitante_id INT NOT NULL,
    departamento_id INT NOT NULL,
    proyecto_id INT NOT NULL,
    activo_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responsable_id INT,
    FOREIGN KEY (usuario_solicitante_id) REFERENCES Usuarios(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id),
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id),
    FOREIGN KEY (activo_id) REFERENCES Activos(id),
    FOREIGN KEY (estado_id) REFERENCES Estados(id) -- Referencia al estado actual
);

CREATE TABLE Tickets_Activos (
    Ticket_ID INT,
    Activo_ID INT,
    PRIMARY KEY (Ticket_ID, Activo_ID),
    FOREIGN KEY (Ticket_ID) REFERENCES Tickets(id),
    FOREIGN KEY (Activo_ID) REFERENCES Activos(id)
);

CREATE TABLE Comentarios (
    id INT PRIMARY KEY,
    ticket_id INT NOT NULL,
    usuario_id INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

CREATE TABLE Formularios_de_Satisfaccion (
    id INT PRIMARY KEY,
    ticket_id INT NOT NULL,
    calificacion_id INT NOT NULL,
    comentario TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(id),
    FOREIGN KEY (calificacion_id) REFERENCES Calificaciones_Predeterminadas(id)
);

CREATE TABLE Calificaciones_Predeterminadas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    valor INT NOT NULL
);

CREATE TABLE Tiempos_SLA (
    id INT PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    tiempo_respuesta INT NOT NULL -- Tiempo de respuesta en minutos
);

CREATE PROCEDURE ActualizarTicketsSLA
AS
BEGIN
    DECLARE @FechaActual DATETIME = GETDATE();

    UPDATE Tickets
    SET estado_id = (SELECT id FROM Estados WHERE nombre = 'Vencido')
    WHERE estado_id <> (SELECT id FROM Estados WHERE nombre = 'Cerrado')
        AND (SELECT tiempo_respuesta FROM Tiempos_SLA WHERE categoria = 'normal') < DATEDIFF(MINUTE, Tickets.fecha_creacion, @FechaActual)
        AND Tickets.proyecto_id IS NOT NULL;

    UPDATE Tickets
    SET estado_id = (SELECT id FROM Estados WHERE nombre = 'Escalado'),
        responsable_id = (SELECT usuario_id FROM Departamentos WHERE id = Tickets.departamento_id) -- Asigna el responsable del departamento como escalación
    WHERE estado_id <> (SELECT id FROM Estados WHERE nombre = 'Cerrado')
        AND (SELECT tiempo_respuesta FROM Tiempos_SLA WHERE categoria = 'critica') < DATEDIFF(MINUTE, Tickets.fecha_creacion, @FechaActual)
        AND Tickets.proyecto_id IS NOT NULL;
END;

-- Inserción de datos de ejemplo:

INSERT INTO Roles (id, nombre) VALUES (1, 'Administrador');
INSERT INTO Roles (id, nombre) VALUES (2, 'Usuario');

INSERT INTO Usuarios (id, nombre, email, rol_id) VALUES (1, 'Juan Perez', 'juan@example.com', 1);
INSERT INTO Usuarios (id, nombre, email, rol_id) VALUES (2, 'María García', 'maria@example.com', 2);

INSERT INTO Departamentos (id, nombre) VALUES (1, 'Ventas');
INSERT INTO Departamentos (id, nombre) VALUES (2, 'Soporte');

INSERT INTO Proyectos (id, nombre, fecha_contrato) VALUES (1, 'Proyecto A', '2023-01-15');
INSERT INTO Proyectos (id, nombre, fecha_contrato) VALUES (2, 'Proyecto B', '2023-02-20');

INSERT INTO Estados (id, nombre) VALUES (1, 'Abierto');
INSERT INTO Estados (id, nombre) VALUES (2, 'En Progreso');
INSERT INTO Estados (id, nombre) VALUES (3, 'Cerrado');

INSERT INTO Activos (id, nombre, tipo, descripcion, fecha_adquisicion, responsable_id) VALUES (1, 'Laptop', 'Hardware', 'Laptop Dell XPS 15', '2022-05-10', 1);
INSERT INTO Activos (id, nombre, tipo, descripcion, fecha_adquisicion, responsable_id) VALUES (2, 'Software', 'Software', 'Microsoft Office 365', '2022-04-01', 2);

INSERT INTO Tickets (id, titulo, descripcion, estado_id, prioridad, usuario_solicitante_id, departamento_id, proyecto_id, activo_id, fecha_creacion, responsable_id) VALUES (1, 'Problema con la laptop', 'La laptop no enciende', 1, 1, 1, 1, 1, 1, '2023-10-05 10:00:00', 2);

INSERT INTO Tickets_Activos (Ticket_ID, Activo_ID) VALUES (1, 1);
INSERT INTO Tickets_Activos (Ticket_ID, Activo_ID) VALUES (1, 2);

INSERT INTO Tiempos_SLA (id, categoria, tiempo_respuesta) VALUES (1, 'normal', 120);
INSERT INTO Tiempos_SLA (id, categoria, tiempo_respuesta) VALUES (2, 'critica', 30);
