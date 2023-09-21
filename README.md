# DB2023


## Diccionario de Datos

###ENTIDADES
TABLAS,ATRIBUTOS,TIPO,LARGO,RESTRICCIONES,DESCRIPCIÓN

###USUARIOS
-Cedula tring 8 Clave Primaria Identificador de Usuario
-Nombre String no vacío
-Apellido String de Usuario
-Email String no vacío
-Email_de_Usuario Tipo String no vacío
-Tipo de usuario

###PROFESOR
Cedula String 8  -Clave Primaria - Foreign key Identificador de Usuario
IdProfesor Integer -Clave Primaria Identificador débil de Profesor
Grado string  vacío Grado de Profesor

ALUMNOS
Cedula String 8  Clave Primaria - Foreign key Identificador de Usuario
IdAlumnos Integer Clave Primaria Identificador debil de Alumno

BEDELÍAS
Cedula
String
8
Clave Primaria - Foreign key
Identificador de Usuario
IdBedelia
Integer
-
Clave Primaria
Identificador débil de Bedelía
Cargo
String
-
vacío
Grado del cargo
MATERIAS
IdMateria
Incremental
-
Clave Primaria
Identificador de Materia
Nombre
String
-
no vacío
Nombre de Materia
GRUPOS
idGrupo
String
10
Clave Primaria
Identificador de Grupo por Acrónimo
Nombre
String
-
no vacío
Nombre completo del grupo
año electivo
Integer
-
no vacío
Año electivo del grupo
fecha_Creacion
Integer
-
no vacío
Fecha de creación del grupo
FORO
IdForo
Incremental
-
Clave Primaria
Identificador de Foro
Información
string
-
vacío
Información de Foro
Data
BLOB
-
vacío
Archivos de Foro
TAREAS
IdTareas
Incremental
-
Clave Primaria
Identificador de Tarea
Descripción
string
-
no vacío
Descripción de Tarea
Fecha de Vencimiento
string
-
no vacío
Fecha de Vencimiento de la Tarea
Archivo
BLOB
-
vacío
Archivos de Tarea
Fecha de Creación
date
-
no vacío
Fecha de Creación de la Tarea
DATOS-FORO
IdDatos
Incremental
-
Clave Primaria
Identificador del datos ingresado
IdForo
BigInteger
-
Foreign Key
Identificador de Foro
idUsuario
String
8
Foreign Key
Identificador de Usuario
mensaje
String
-
no vacío
mensaje enviado
archivo
BLOB
-
vacío
archivo
HISTORIAL REGISTRO

Id Usuario
app
acción
Mensaje



ID
String
String
String
-
Clave Primaria - Foreign Key
Identificador de Usuario
MATERIAL PUBLICO

Id Usuario
titulo
Mensaje



ID
String
String
-
Clave Primaria - Foreign Key
Identificador de Usuario


		
CARRERA
Id
Incremental
-
Clave Primaria
Identificador
nombre
String
255
No vacio
Nombre
categoria
String
10
No vacio
Categoria
plan
String
8
No vacio
Plan



GRADO
Id
Incremental
-
Clave Primaria
Identificador
nombre
String
255
No vacio
Nombre
carrera_id
String
10
Foreign Key
Identificador de Carrera


RELACIONES
TABLAS
ATRIBUTOS
TIPO
LARGO
RESTRICCIONES
DESCRIPCION
DICTA
IdMateria
BigInteger
-
Clave Primaria - Foreign Key
Identificador de Materia
idProfesor
String
8
Clave Primaria - Foreign Key
Identificador de Profesor
PERTENECEN
IdAlumno
String
8
Clave Primaria - Foreign Key
Identificador de Alumno
idGrupo
String
10
Foreign Key
Identificador de Grupo
TIENEN
IdMateria
BigInteger
-
Foreign Key
Identificador de Materia
idGrupo
String
10
Clave Primaria - Foreign Key
Identificador de Grupo
idProfesor
String
8
Foreign Key
Identificador de Profesor
CREA
IdMateria
BigInteger
-
Foreign Key
Identificador de Materia
IdTareas
Incremental
-
Clave Primaria - Foreign Key
Identificador de Tarea
idGrupo
String
10
Clave Primaria - Foreign Key
Identificador de Grupo
idProfesor
String
8
Foreign Key
Identificador de Profesor
ENTREGA
IdAlumno
integer
-
Clave Primaria - Foreign Key
Identificador de Alumno
IdTareas
Incremental
-
Clave Primaria - Foreign Key
Identificador de Tarea
Archivo
BLOB
-
vacío
Archivos de Tarea
Calificación
Integer
-
vacío
Calificación de la tarea
Fecha entrega
Integer
-
no vacío
Entrega de la tarea
ESTAN
IdForo
BigInteger
-
Clave Primaria - Foreign Key
Identificador de Foro
IdMateria
BigInteger
-
Foreign Key
Identificador de Materia
idGrupo
String
10
Foreign Key
Identificador de Grupo
idProfesor
String
8
Foreign Key
Identificador de Profesor
RE-HACER-TAREA
IdTareasNueva
BigInteger
-
Clave Primaria - Foreign Key
Identificador de Tarea Nueva
IdTareas
Incremental
-
Clave Primaria - Foreign Key
Identificador de Tarea
Calicacion
Integer
-
vacío
Calificación de la tarea
Fecha entrega
Integer
-
no vacío
Entrega de la tarea
Archivo
BLOB
-
vacío
Archivos de Tarea

		
CARRERA MATERIA
IdMateria
BigInteger
-
Clave Primaria - Foreign Key
Identificador de Materia
IdCarrera
BigInteger
-
Clave Primaria - Foreign Key
Identificador de Carrera
Id Grado
BigInteger
-
Clave Primaria - Foreign Key
Identificador de Grado


