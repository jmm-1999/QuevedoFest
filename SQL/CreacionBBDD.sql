/*CREACIÓN DE LA BASE DE DATOS*/
CREATE DATABASE QuevedoFest OWNER javi;


/*CREACIÓN DE LAS TABLAS*/

/*TABLA FESTIVAL*/
CREATE TABLE festival (
    id NUMERIC(6) PRIMARY KEY,
    nombre VARCHAR(30),
    fecha DATE
);

/*TABLA CARTEL*/
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

/*TABLA ESCENARIO*/
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

/*TABLA ENTRADA*/
CREATE TABLE entrada (
    id NUMERIC(3) PRIMARY KEY NOT NULL,
    id_festival NUMERIC(6) NOT NULL,
    fecha DATE NOT NULL,
    precio NUMERIC(6) NOT NULL,
    CONSTRAINT entrada_festival_id FOREIGN KEY (id_festival)
        REFERENCES festival (id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*TABLA CLIENTE*/
CREATE TABLE cliente (
    dni VARCHAR(9) PRIMARY KEY NOT NULL,
    id_entrada NUMERIC(3) NOT NULL,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    fechaNac DATE,
    localidad VARCHAR(40),
    CONSTRAINT cliente_entrada_id FOREIGN KEY (id_entrada)
        REFERENCES entrada (id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*TABLA MAYOR DE EDAD*/
CREATE TABLE mayorEdad (
    dni VARCHAR(9) PRIMARY KEY NOT NULL
);

/*TABLA PERTENECER*/
CREATE TABLE pertenecer (
    dni_mayorEdad VARCHAR(9) NOT NULL,
    id_clubFans NUMERIC(3) NOT NULL,
    CONSTRAINT pertenecer_mayorEdad_dni FOREIGN KEY (dni_mayorEdad)
        REFERENCES mayorEdad (dni) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT pertenecer_clubFans_id FOREIGN KEY (id_clubFans)
        REFERENCES clubFans (id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*TABLA CLUB DE FANS*/
CREATE TABLE clubFans (
    id NUMERIC(3) PRIMARY KEY NOT NULL,
    dni_artista VARCHAR(9) NOT NULL,
    fecha_creacion DATE NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT clubFans_artista_dni FOREIGN KEY (dni_artista)
        REFERENCES artista (dni) ON DELETE CASCADE ON UPDATE CASCADE
);

/*TABLA ARTISTA*/
CREATE TABLE artista (
    dni VARCHAR(9) PRIMARY KEY NOT NULL,
    id_cartel NUMERIC(6) NOT NULL,
    id_camerino NUMERIC(2) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    salario NUMERIC(5) NOT NULL,
    generoMusical VARCHAR(30),
    hora_entrada TIME,
    hora_salida TIME,
    CONSTRAINT artista_cartel_id FOREIGN KEY (id_cartel)
        REFERENCES cartel (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT artista_camerino_id FOREIGN KEY (id_camerino)
        REFERENCES camerino (id) ON DELETE CASCADE ON UPDATE CASCADE
    /*Añadimos FK posterior de fechaYHora camerino*/
);

/*TABLA CAMERINO*/
CREATE TABLE camerino (
    id NUMERIC(2) PRIMARY KEY NOT NULL,
    dni_artista VARCHAR(9) NOT NULL,
    fechaYHora TIMESTAMP NOT NULL,
    gama VARCHAR(20),
    CONSTRAINT camerino_artista_dni FOREIGN KEY (dni_artista)
        REFERENCES artista (dni) ON DELETE CASCADE ON UPDATE CASCADE
);