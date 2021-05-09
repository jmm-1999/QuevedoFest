--CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE QuevedoFest OWNER javi;


--CREACIÓN DE LAS TABLAS

--TABLA FESTIVAL
CREATE TABLE festival (
    id NUMERIC(6) PRIMARY KEY,
    nombre VARCHAR(30),
    fechaInicio DATE NOT NULL,
    fechaFIn DATE NOT NULL
);

--TABLA CARTEL
CREATE TABLE cartel (
    id NUMERIC(6) PRIMARY KEY NOT NULL,
    id_festival NUMERIC(6) NOT NULL,
    nombre VARCHAR(30),
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    generoMusical VARCHAR(30),
    CONSTRAINT cartel_festival_id FOREIGN KEY (id_festival)
        REFERENCES festival (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--TABLA ESCENARIO
CREATE TABLE escenario (
    id NUMERIC(6) PRIMARY KEY NOT NULL,
    id_cartel NUMERIC(6) NOT NULL,
    nombre VARCHAR(30),
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    capacidad NUMERIC(6),
    CONSTRAINT escenario_cartel_id FOREIGN KEY (id_cartel)
        REFERENCES cartel (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--TABLA ENTRADA
CREATE TABLE entrada (
    id NUMERIC(3) PRIMARY KEY NOT NULL,
    id_festival NUMERIC(6) NOT NULL,
    fecha DATE NOT NULL,
    precio NUMERIC(6) NOT NULL,
    CONSTRAINT entrada_festival_id FOREIGN KEY (id_festival)
        REFERENCES festival (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--TABLA CLIENTE
CREATE TABLE cliente (
    dni VARCHAR(9) PRIMARY KEY NOT NULL,
    id_entrada NUMERIC(3) NOT NULL,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    fechaNac DATE,
    localidad VARCHAR(40),
    telefono NUMERIC(9) NOT NULL,
    CONSTRAINT cliente_entrada_id FOREIGN KEY (id_entrada)
        REFERENCES entrada (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--TABLA MAYOR DE EDAD
CREATE TABLE mayorEdad (
    dni VARCHAR(9) PRIMARY KEY NOT NULL
);

--TABLA PERTENECER
CREATE TABLE pertenecer (
    dni_mayorEdad VARCHAR(9) NOT NULL,
    id_clubFans NUMERIC(3) NOT NULL,
    CONSTRAINT pertenecer_mayorEdad_dni FOREIGN KEY (dni_mayorEdad)
        REFERENCES mayorEdad (dni) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT pertenecer_clubFans_id FOREIGN KEY (id_clubFans)
        REFERENCES clubFans (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--TABLA CLUB DE FANS
CREATE TABLE clubFans (
    id NUMERIC(3) PRIMARY KEY NOT NULL,
    dni_artista VARCHAR(9) NOT NULL,
    fecha_creacion DATE NOT NULL,
    nombre VARCHAR(50),
    recaudacion NUMERIC NOT NULL,
    CONSTRAINT clubFans_artista_dni FOREIGN KEY (dni_artista)
        REFERENCES artista (dni) ON DELETE CASCADE ON UPDATE CASCADE
);

--TABLA ARTISTA
CREATE TABLE artista (
    dni VARCHAR(9) PRIMARY KEY NOT NULL,
    id_cartel NUMERIC(6) NOT NULL,
    dni_manager VARCHAR(9) NOT NULL,
    fechaYHora_camerino TIMESTAMP NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    salario NUMERIC(5) NOT NULL,
    generoMusical VARCHAR(30),
    hora_entrada TIME,
    hora_salida TIME,
    CONSTRAINT artista_cartel_id FOREIGN KEY (id_cartel)
        REFERENCES cartel (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT artista_camerino_fechaYHora FOREIGN KEY (fechaYHora_camerino)
        REFERENCES camerino (fechaYHora) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT artista_manager_dni FOREIGN KEY (dni_manager)
        REFERENCES manager (dni) ON DELETE CASCADE ON UPDATE CASCADE
);

--TABLA CAMERINO
CREATE TABLE camerino (
    fechaYHora TIMESTAMP PRIMARY KEY NOT NULL,
    id NUMERIC(2) NOT NULL,
    gama VARCHAR(20),
    nombre VARCHAR(30)
);


--TABLA MÁNAGER CREADA POSTERIORMENTE
CREATE TABLE manager (
    dni VARCHAR(9) PRIMARY KEY NOT NULL,
    nombre_completo VARCHAR(60) NOT NULL,
    telefono NUMERIC(9) NOT NULL
);