--INSERCIÓN DE DATOS EN LA TABLA FESTIVAL
INSERT INTO festival (id, nombre, fechaInicio, fechaFin) VALUES
    (1, 'ArenalSound', '2020-07-20', '2020-07-23'),
    (2, 'QuevedoFest', '2020-08-15', '2020-08-18'),
    (3, 'QuevedoFest', '2021-07-10', '2021-08-13');

--INSERCIÓN DE DATOS EN LA TABLA CARTEL
INSERT INTO cartel (id, id_festival, nombre, fecha, hora, generoMusical) VALUES
    (1, 1, 'Savage', '2020-07-20', '15:30', 'Trap'),
    (2, 1, 'Colors', '2020-07-21', '16:30', 'Reggaetón'),
    (3, 1, 'Random', '2020-07-22', '15:30', 'Rock'),
    (4, 1, 'Reel', '2020-07-23', '15:00', 'Rap'),

    (5, 2, 'Sun', '2020-08-15', '15:30', 'Hardcore'),
    (6, 2, 'Fandom', '2020-08-16', '17:30', 'Reggae'),
    (7, 2, 'Moon', '2020-08-17', '16:30', 'Pop'),
    (8, 2, 'World', '2020-08-18', '15:00', 'Punky'),

    (9, 3, 'Luxury', '2021-07-10', '15:00', 'Hardcore'),
    (10, 3, 'Swing', '2021-07-11', '16:00', 'Pop'),
    (11, 3, 'Gang', '2021-07-12', '17:00', 'Flamenco'),
    (12, 3, 'Rumba', '2021-07-13', '15:30', 'Bachata');

--INSERCIÓN DE DATOS EN LA TABLA ESCENARIO
INSERT INTO escenario (id, id_cartel, nombre, fecha, hora, capacidad) VALUES
    (1, 3, 'Salvage', '2020-07-22', '15:30', 1000),
    (2, 2, 'BigSound', '2020-08-16', '17:30', 1200),
    (3, 1, 'Kontrol', '2021-07-10', '15:00', 950),
    (4, 1, 'Fire', '2020-08-15', '15:30', 900),
    (5, 3, 'Summer', '2021-07-12', '17:00', 950);

--INSERCIÓN DE DATOS EN LA TABLA ENTRADA
INSERT INTO entrada (id, id_festival, fecha, precio) VALUES
    (1, 1, '2020-07-20', 80),
    (2, 2, '2020-08-15', 70),
    (3, 3, '2021-07-10', 90),
    (4, 3, '2021-07-10', 90),
    (5, 3, '2021-07-10', 90);

--INSERCIÓN DE DATOS EN LA TABLA CLIENTE
INSERT INTO cliente (dni, id_entrada, nombre, apellido1, apellido2, fechaNac, localidad) VALUES
    ('12365478R', 1, 'Raúl', 'Gonzalez', 'Fernandez', '1998-12-20', 'Móstoles'),
    ('78954623L', 2, 'Cristiano', 'Ronaldo', 'Pérez', '1997-10-05', 'Mérida'),
    ('45612378D', 3, 'Luisa', 'Ruiz', 'Verde', '2005-07-11', 'Alcorcón'),
    ('65784147M', 4, 'Carla', 'Alonso', 'De Mateo', '2006-08-15', 'Getafe'),
    ('65897423N', 5, 'Sergio', 'Ramos', 'Palao', '1990-04-24', 'Rivas-Vaciamadrid');

    --INSERCIÓN POSTERIOR EN CLIENTE
    INSERT INTO cliente (telefono) VALUES
        ('654987321'),
        ('645123789'),
        ('698675645'),
        ('636521425'),
        ('678951423');

--INSERCIÓN DE DATOS EN LA TABLA MAYOR DE EDAD
INSERT INTO mayorEdad (dni) VALUES
    ('12365478R'),
    ('78954623L'),
    ('65897423N');

--INSERCIÓN DE DATOS EN LA TABLA PERTENECER
INSERT INTO pertenecer (dni_mayorEdad, id_clubFans) VALUES
    ('78954623L', 001),
    ('65897423N', 003);

--INSERCIÓN DE DATOS EN LA TABLA CLUB DE FANS
INSERT INTO clubFans (id, dni_artista, fecha_creacion, nombre) VALUES
    (1, '45698235S', '2017-09-18', 'Los Tanguitos'),
    (2, '78998754T', '2015-10-25', 'Believers'),
    (3, '25896346K', '2018-02-20', 'Ros-alitas');

    --INSERCIÓN POSTERIOR EN CLUB DE FANS
    INSERT INTO clubFans (recaudacion) VALUES
        (3000),
        (2700),
        (1800);

--INSERCIÓN DE DATOS EN LA TABLA ARTISTA
INSERT INTO artista (dni, id_cartel, fechaYHora_camerino, nombre, nacionalidad, salario, generoMusical, hora_entrada, hora_salida) VALUES
    ('14725835J', 1, '2020-07-20 14:30:00', 'Kidd Keo', 'España', 1500, 'Trap', '15:30', '17:30'),
    ('36985214H', 1, '2020-07-20 16:30:00', 'Camin', 'España', 1000, 'Trap', '17:30', '18:30'),
    ('25896346K', 1, '2020-07-20 17:30:00', 'Rosalia', 'España', 1600, 'Trap', '18:30', '22:30'),
    ('45698235S', 1, '2020-07-20 21:30:00', 'C. Tangana', 'España', 1900, 'Trap', '22:30', '24:00'),
    ('86249517B', 9, '2021-07-10 14:00:00', 'AngerFirst', 'Alemania', 2000, 'Hardcore', '15:00', '19:30'),
    ('54982175B', 9, '2021-07-10 18:30:00', 'HeadHunter', 'Holanda', 2200, 'Hardcore', '19:30', '20:30'),
    ('75324861M', 9, '2021-07-10 19:30:00', 'Coone', 'Francia', 2100, 'Hardcore', '20:30', '22:00'),
    ('78998754T', 10, '2021-07-11 15:30:00', 'Justin Biever', 'EEUU', 2500, 'Pop', '16:30', '19:00'),
    ('48269125W', 10, '2021-07-11 18:00:00', 'Jennifer López', 'EEUU', 2600, 'Pop', '19:00', '20:00'),
    ('45987623G', 11, '2021-07-12 16:00:00', 'Daviles de Novelda', 'España', 1200, 'Flamenco', '17:00', '18:30'),
    ('64859127F', 11, '2021-07-12 17:30:00', 'Chambao', 'España', 1250, 'Flamenco', '18:30', '19:30'),
    ('72486593H', 12, '2021-07-12 14:00:00', 'Romeo Santos', 'Colombia', 1700, 'Bachata', '15:30', '18:00'),
    ('81592634T', 12, '2021-07-12 18:15:00', 'Wellinton Quiw', 'Colombia', 800, 'Bachata', '18:30', '19:00'),
    ('94587126A', 12, '2021-07-12 18:00:00', 'Farruko', 'Puerto Rico', 2400, 'Bachata', '19:00', '21:00');

    --INSERCIÓN POSTERIOR EN ARTISTA
    INSERT INTO artista (dni_manager) VALUES 
        ('56351711M'),
        ('45447824A'),
        ('65686764S'),
        ('32365362P'),
        ('21546866W'),
        ('45447824A'),
        ('95987994I'),
        ('56351711M'),
        ('12321141T'),
        ('65686764S'),
        ('74455778H'),
        ('46685513F'),
        ('55566989Q'),
        ('56351711M');


--INSERCIÓN DE DATOS EN LA TABLA CAMERINO
INSERT INTO camerino (fechaYHora, id, gama) VALUES
    ('2020-07-20 14:30:00', 1,'Alta'),
    ('2020-07-20 16:30:00', 2, 'Media'),
    ('2020-07-20 17:30:00', 1, 'Alta'),
    ('2020-07-20 21:30:00', 1 , 'Alta'),
    ('2021-07-10 14:00:00', 2 , 'Media'),
    ('2021-07-10 18:30:00', 1, 'Alta'),
    ('2021-07-10 19:30:00', 2, 'Media'),
    ('2021-07-11 15:30:00', 1, 'Alta'),
    ('2021-07-11 18:00:00', 1, 'Alta'),
    ('2021-07-12 16:00:00', 2, 'Media'),
    ('2021-07-12 17:30:00', 2, 'Media'),
    ('2021-07-12 14:00:00', 2, 'Media'),
    ('2021-07-12 18:15:00', 1, 'Alta'),
    ('2021-07-12 18:00:00', 2, 'Alta');

--INSERCIÓN DE DATOS EN LA TABLA MÁNAGER (TABLA CREADA POSTERIORMENTE)
INSERT INTO manager (dni, nombre_completo, telefono) VALUES
    ('55566989Q', 'Luis Fernández Gomez', '699885544'),
    ('45447824A', 'Manolo Lama', '644777456'),
    ('65686764S', 'María Gomez Palos', '633662211'),
    ('32365362P', 'Ramón Moreno', '644665544'),
    ('21546866W', 'Nuria Ros Plaz', '685867417'),
    ('95987994I', 'Mariano Rajoy Rojo', '677284663'),
    ('56351711M', 'Irene Montero', '623245112'),
    ('12321141T', 'Sebastián Filimón', '673525366'),
    ('74455778H', 'Jaime Montaner Pla', '685958685'),
    ('46685513F', 'Pablo Moreno Pérez', '666666645');




