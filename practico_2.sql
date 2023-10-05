CREATE DATABASE DataBaseEstudiantil;
USE DataBaseEstudiantil;

CREATE TABLE USUARIOS (
    Cedula VARCHAR(8) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255),
    Email VARCHAR(255) NOT NULL,
    Email_de_Usuario VARCHAR(255) NOT NULL,
    Tipo_de_usuario INT
);

CREATE TABLE PROFESOR (
    Cedula VARCHAR(8) PRIMARY KEY,
    IdProfesor INT PRIMARY KEY,
    Grado VARCHAR(255)
);

CREATE TABLE ALUMNOS (
    Cedula VARCHAR(8) PRIMARY KEY,
    IdAlumnos INT PRIMARY KEY
);

CREATE TABLE BEDELÍAS (
    Cedula VARCHAR(8) PRIMARY KEY,
    IdBedelia INT PRIMARY KEY,
    Cargo VARCHAR(255)
);

CREATE TABLE MATERIAS (
    IdMateria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);

CREATE TABLE GRUPOS (
    idGrupo VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Año_electivo INT NOT NULL,
    Fecha_Creacion DATE NOT NULL
);

CREATE TABLE FORO (
    IdForo INT AUTO_INCREMENT PRIMARY KEY,
    Información VARCHAR(MAX),
    Data VARBINARY(MAX)
);

CREATE TABLE TAREAS (
    IdTareas INT AUTO_INCREMENT PRIMARY KEY,
    Descripción VARCHAR(MAX) NOT NULL,
    Fecha_de_Vencimiento VARCHAR(255) NOT NULL,
    Archivo VARBINARY(MAX),
    Fecha_de_Creación DATE NOT NULL
);

CREATE TABLE DATOS_FORO (
    IdDatos INT AUTO_INCREMENT PRIMARY KEY,
    IdForo BIGINT,
    idUsuario VARCHAR(8),
    mensaje VARCHAR(MAX) NOT NULL,
    archivo VARBINARY(MAX)
);

CREATE TABLE HISTORIAL_REGISTRO (
    ID VARCHAR(8) PRIMARY KEY,
    app VARCHAR(255),
    acción VARCHAR(255),
    Mensaje VARCHAR(255)
);

CREATE TABLE MATERIAL_PUBLICO (
    ID VARCHAR(8) PRIMARY KEY,
    titulo VARCHAR(255),
    Mensaje VARCHAR(MAX)
);

CREATE TABLE CARRERA (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    categoria VARCHAR(10) NOT NULL,
    plan VARCHAR(8) NOT NULL
);

CREATE TABLE GRADO (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    carrera_id INT,
    FOREIGN KEY (carrera_id) REFERENCES CARRERA(Id)
);

CREATE TABLE DICTA (
    IdMateria BIGINT,
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdMateria, idProfesor),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE PERTENECEN (
    IdAlumno VARCHAR(8),
    idGrupo VARCHAR(10),
    PRIMARY KEY (IdAlumno, idGrupo),
    FOREIGN KEY (IdAlumno) REFERENCES ALUMNOS(Cedula),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo)
);

CREATE TABLE TIENEN (
    IdMateria BIGINT,
    idGrupo VARCHAR(10),
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdMateria, idGrupo, idProfesor),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE CREA (
    IdMateria BIGINT,
    IdTareas INT,
    idGrupo VARCHAR(10),
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdMateria, IdTareas, idGrupo, idProfesor),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (IdTareas) REFERENCES TAREAS(IdTareas),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE ENTREGA (
    IdAlumno INT,
    IdTareas INT,
    Archivo VARBINARY(MAX),
    Calificación INT,
    Fecha_entrega INT NOT NULL,
    PRIMARY KEY (IdAlumno, IdTareas),
    FOREIGN KEY (IdAlumno) REFERENCES ALUMNOS(IdAlumnos),
    FOREIGN KEY (IdTareas) REFERENCES TAREAS(IdTareas)
);

CREATE TABLE ESTAN (
    IdForo BIGINT,
    IdMateria BIGINT,
    idGrupo VARCHAR(10),
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdForo, IdMateria, idGrupo, idProfesor),
    FOREIGN KEY (IdForo) REFERENCES FORO(IdForo),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE RE_HACER_TAREA (
    IdTareasNueva BIGINT PRIMARY KEY,
    IdTareas INT,
    Calificación INT,
    Fecha_entrega INT NOT NULL,
    Archivo VARBINARY(MAX)
);

CREATE TABLE CARRERA_MATERIA (
    IdMateria BIGINT,
    IdCarrera BIGINT,
    IdGrado BIGINT,
    PRIMARY KEY (IdMateria, IdCarrera, IdGrado),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (IdCarrera) REFERENCES CARRERA(Id),
    FOREIGN KEY (IdGrado) REFERENCES GRADO(Id)
);

INSERT INTO USUARIOS (Cedula, Nombre, Apellido, Email, Email_de_Usuario, Tipo_de_usuario) VALUES
    ('12345678', 'Juan', 'Perez', 'juan@example.com', 'juanperez', 1),
    ('23456789', 'Maria', 'Gomez', 'maria@example.com', 'mariagomez', 2),
    ('34567890', 'Pedro', 'Lopez', 'pedro@example.com', 'pedrolopez', 3);
