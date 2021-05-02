/*INSERCIÓN DE DATOS EN LA TABLA FESTIVAL*/
INSERT INTO festival (id, nombre, fechaInicio, fechaFin) VALUES
    (1, 'ArenalSound', '2020-07-20', '2020-07-23'),
    (2, 'QuevedoFest', '2020-08-15', '2020-08-18'),
    (3, 'QuevedoFest', '2021-07-10', '2021-08-14')

/*INSERCIÓN DE DATOS EN LA TABLA CARTEL*/
INSERT INTO cartel (id, id_festival, nombre, fecha, hora, generoMusical) VALUES
    (1, 1, 'Savage', '2020-07-20', '15:30', 'Trap'),
    (2, 1, 'Colors', '2020-07-21', '16:30', 'Reggaetón'),
    (3, 1, 'Random', '2020-07-22', '15:30', 'Rock'),
    (4, 1, 'Reel', '2020-07-23', '15:00', 'Rap'),

    (1, 2, 'Sun', '2020-08-15', '15:30', 'Hardcore'),
    (2, 2, 'Fandom', '2020-08-16', '17:30', 'Reggae'),
    (3, 2, 'Moon', '2020-08-17', '16:30', 'Pop'),
    (4, 2, 'World', '2020-08-18', '15:00', 'Punky'),

    (1, 3, 'Luxury', '2021-07-10', '15:00', 'Hardcore'),
    (2, 3, 'Swing', '2021-07-11', '16:00', 'Heavy Metal'),
    (3, 3, 'Gang', '2021-07-12', '17:00', 'Flamenco'),
    (4, 3, 'Rumba', '2021-07-13', '15:30', 'Bachata'),

    (1, 3, 'Luxury', '2021-07-10', '15:00', 'Hardcore'),