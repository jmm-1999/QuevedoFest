## 6 CREACIÓN DE VISTAS, SECUENCIAS E ÍNDICES SOBRE LA BASE DE DATOS

### VISTAS

Una vista es una tabla virtual que almacena una consulta como objeto para utilizarse posteriormente. En general, se puede dar un nombre a cualquier consulta y almacenarla como vista, dado que posee la misma estructura que una tabla.  

Este tipo de procedimientos se emplean para consultas grandes y usuales respecto a su construcción, puesto que facilitan su uso.

* **Información de clientes que pertenecen a algún club de fans, información del club de fans e información de sus entradas.**
```sql
CREATE OR REPLACE VIEW clientes AS
SELECT c.*, cf.id, cf.nombre AS "Nombre club de fans", cf.recaudacion AS "Recaudación club de fans", e.id_festival, e.precio AS "Precio entrada"
FROM cliente c
    JOIN pertenecer p ON (c.dni = p.dni_mayorEdad)
    JOIN clubFans cf ON (p.id_clubFans = cf.id)
    JOIN entrada e ON (c.id_entrada = e.id);
```
```Resultado
quevedofest=> SELECT * FROM clientes;
    dni    | id_entrada |  nombre   | apellido1 | apellido2 |  fechanac  |     localidad     | telefono  | id | Nombre club de fans | Recaudación club de fans | id_festival | Precio entrada
-----------+------------+-----------+-----------+-----------+------------+-------------------+-----------+----+---------------------+--------------------------+-------------+----------------
 78954623L |          2 | Cristiano | Ronaldo   | Pérez     | 1997-10-05 | Mérida            | 645123789 |  1 | Los Tanguitos       |                     3000 |           2 |             70
 65897423N |          5 | Sergio    | Ramos     | Palao     | 1990-04-24 | Rivas-Vaciamadrid | 678951423 |  3 | Ros-alitas          |                     1800 |           3 |             90
(2 rows)
```

* **Información de los artistas y el cartel en el que actúan cuyo género musical es Bachata**
```sql
CREATE OR REPLACE VIEW artistas_carteles AS
SELECT a.*, c.nombre AS "Nombre cartel", c.fecha AS "Fecha cartel", c.hora AS "Hora cartel"
FROM artista a 
    JOIN cartel c ON (a.id_cartel = c.id)
WHERE a.generoMusical = 'Bachata';
```
```Resultado
quevedofest=> SELECT * FROM artistas_carteles;
    dni    | id_cartel | dni_manager | fechayhora_camerino |     nombre     | nacionalidad | salario | generomusical | hora_entrada | hora_salida | Nombre cartel | Fecha cartel | Hora cartel
-----------+-----------+-------------+---------------------+----------------+--------------+---------+---------------+--------------+-------------+---------------+--------------+-------------
 72486593H |        12 | 46685513F   | 2021-07-12 14:00:00 | Romeo Santos   | Colombia     |    1700 | Bachata       | 15:30:00     | 18:00:00    | Rumba         | 2021-07-13   | 15:30:00
 81592634T |        12 | 55566989Q   | 2021-07-12 18:15:00 | Wellinton Quiw | Colombia     |     800 | Bachata       | 18:30:00     | 19:00:00    | Rumba         | 2021-07-13   | 15:30:00
 94587126A |        12 | 56351711M   | 2021-07-12 18:00:00 | Farruko        | Puerto Rico  |    2400 | Bachata       | 19:00:00     | 21:00:00    | Rumba         | 2021-07-13   | 15:30:00
(3 rows)
```

* **Información de los artistas (relevante a su identidad, no a la actuación) que cobran más de 1600€ con sus mánager**
```sql
CREATE OR REPLACE VIEW artistas_manager AS
SELECT a.dni AS "DNI artista", a.nombre AS "Nombre artista", a.nacionalidad, a.salario, m.*
FROM artista a 
    JOIN manager m ON (a.dni_manager = m.dni)
WHERE a.salario > 1600;
```
```Resultado
quevedofest=> SELECT * FROM artistas_manager ;
 DNI artista | Nombre artista | nacionalidad | salario |    dni    |  nombre_completo   | telefono
-------------+----------------+--------------+---------+-----------+--------------------+-----------
 54982175B   | HeadHunter     | Holanda      |    2200 | 45447824A | Manolo Lama        | 644777456
 45698235S   | C. Tangana     | España       |    1900 | 32365362P | Ramón Moreno       | 644665544
 86249517B   | AngerFirst     | Alemania     |    2000 | 21546866W | Nuria Ros Plaz     | 685867417
 75324861M   | Coone          | Francia      |    2100 | 95987994I | Mariano Rajoy Rojo | 677284663
 94587126A   | Farruko        | Puerto Rico  |    2400 | 56351711M | Irene Montero      | 623245112
 78998754T   | Justin Biever  | EEUU         |    2500 | 56351711M | Irene Montero      | 623245112
 48269125W   | Jennifer López | EEUU         |    2600 | 12321141T | Sebastián Filimón  | 673525366
 72486593H   | Romeo Santos   | Colombia     |    1700 | 46685513F | Pablo Moreno Pérez | 666666645
(8 rows)
```

* **Información de la actuación de los artistas cuyo género musical es Flamenco, Hardcore o Trap con sus respectivos camerinos**
```sql
CREATE OR REPLACE VIEW artistas_camerino AS
SELECT a.id_cartel AS "Cartel", a.nombre AS "Nombre artista", a.generoMusical, a.hora_entrada AS "Hora actuación", a.hora_salida AS "Hora fin actuación", c.*
FROM artista a
    JOIN camerino c ON (a.fechaYHora_camerino = c.fechaYHora)
WHERE (a.generoMusical = 'Trap') OR (a.generoMusical = 'Hardcore') OR (a.generoMusical = 'Flamenco');
```
```Resultado
quevedofest=> SELECT * FROM artistas_camerino;
 Cartel |   Nombre artista   | generomusical | Hora actuación | Hora fin actuación |     fechayhora      | id | gama  | nombre
--------+--------------------+---------------+----------------+--------------------+---------------------+----+-------+--------
      1 | Kidd Keo           | Trap          | 15:30:00       | 17:30:00           | 2020-07-20 14:30:00 |  1 | Alta  | Rumba
      1 | Camin              | Trap          | 17:30:00       | 18:30:00           | 2020-07-20 16:30:00 |  2 | Media | World
      1 | Rosalia            | Trap          | 18:30:00       | 22:30:00           | 2020-07-20 17:30:00 |  1 | Alta  | Rumba
      1 | C. Tangana         | Trap          | 22:30:00       | 24:00:00           | 2020-07-20 21:30:00 |  1 | Alta  | Rumba
      9 | AngerFirst         | Hardcore      | 15:00:00       | 19:30:00           | 2021-07-10 14:00:00 |  2 | Media | World
      9 | HeadHunter         | Hardcore      | 19:30:00       | 20:30:00           | 2021-07-10 18:30:00 |  1 | Alta  | Rumba
      9 | Coone              | Hardcore      | 20:30:00       | 22:00:00           | 2021-07-10 19:30:00 |  2 | Media | World
     11 | Daviles de Novelda | Flamenco      | 17:00:00       | 18:30:00           | 2021-07-12 16:00:00 |  2 | Media | World
     11 | Chambao            | Flamenco      | 18:30:00       | 19:30:00           | 2021-07-12 17:30:00 |  2 | Media | World
(9 rows)
```


### SECUENCIAS

Una secuencia es un objeto de bases de datos creado por el usuario que genera números enteros y los incrementa a nuestra necesidad. Este objeto suele ser útil, por ejemplo, para la columna identificadora numérica de una tabla. 

* **Codificación de secuencia para asignar id a la tabla festival**
```sql
CREATE SEQUENCE IF NOT EXISTS idFestival
AS BIGINT
INCREMENT 1
START 4;

INSERT INTO festival (id, nombre, fechaInicio, fechaFin) VALUES 
    (NEXTVAL('idFestival'), 'Aquasella', '2022-07-15', '2022-07-19');
```
```Resultado
quevedofest=> SELECT * FROM festival;
 id |   nombre    | fechainicio |  fechafin
----+-------------+-------------+------------
  1 | ArenalSound | 2020-07-20  | 2020-07-23
  2 | QuevedoFest | 2020-08-15  | 2020-08-18
  3 | QuevedoFest | 2021-07-10  | 2021-08-13
  4 | Aquasella   | 2022-07-15  | 2022-07-19
(4 rows)
```

* **Codificación de secuencia para asignar id a la tabla escenario**
```sql
CREATE SEQUENCE IF NOT EXISTS idEscenario
AS BIGINT
INCREMENT 1
START 6;

INSERT INTO escenario (id, id_cartel, nombre, fecha, hora, capacidad) VALUES 
    (NEXTVAL('idEscenario'), 8, 'Winter', '2020-08-15', '16:30', 1050);
```
```Resultado
quevedofest=> SELECT * FROM escenario;
 id | id_cartel |  nombre  |   fecha    |   hora   | capacidad
----+-----------+----------+------------+----------+-----------
  1 |         9 | Jungly   | 2020-07-22 | 15:30:00 |      1000
  2 |         7 | BigSound | 2020-08-16 | 17:30:00 |      1200
  3 |        10 | Kontrol  | 2021-07-10 | 15:00:00 |       950
  4 |        11 | Fire     | 2020-08-15 | 15:30:00 |       900
  5 |        12 | Summer   | 2021-07-12 | 17:00:00 |       950
  6 |         8 | Winter   | 2020-08-15 | 16:30:00 |      1050
(6 rows)
```

* **Codificación de secuencia para asignar id a la tabla clubFans que a su vez incremente la columna 'id_clubFans' de la tabla _pertenecer_**
```sql
CREATE SEQUENCE IF NOT EXISTS idClubFans
AS BIGINT
INCREMENT 1
START 4;

INSERT INTO clubFans (id, dni_artista, fecha_creacion, nombre, recaudacion) VALUES 
    (NEXTVAL('idClubFans'), '94587126A', '2020-03-25', 'Farrukitos', 2800);

INSERT INTO pertenecer (dni_mayorEdad, id_clubFans) VALUES
    ('12365478R', CURRVAL('idClubFans'));
```
```Resultado
quevedofest=> SELECT * FROM clubfans;
 id | dni_artista | fecha_creacion |    nombre     | recaudacion
----+-------------+----------------+---------------+-------------
  1 | 45698235S   | 2017-09-18     | Los Tanguitos |        3000
  2 | 78998754T   | 2015-10-25     | Believers     |        2700
  3 | 25896346K   | 2018-02-20     | Ros-alitas    |        1800
  4 | 94587126A   | 2020-03-25     | Farrukitos    |        2800
(4 rows)

quevedofest=> SELECT * FROM pertenecer;
 dni_mayoredad | id_clubfans
---------------+-------------
 78954623L     |           1
 65897423N     |           3
 12365478R     |           4
(3 rows)
```



### ÍNDICES

Un índice es un objeto de base de datos que puede mejorar el rendimiento en la ejecución de ciertas consultas, ya que accede rápidamente a la localización de los datos actuando como puntero.
En numerosas ocasiones, la propia base de datos crea estos índices al definir una clave primaria o una restricción única.  
Debemos crear índices en caso de que una columna contenga un amplio rango de valores, un gran número de valores nulos, o si se usan varias columnas en una condición _where_ o _join_,por ejemplo.  

* **Índice para la tabla _artista_ con la columna 'id_cartel'**
```sql
CREATE INDEX artista_cartel_id_ix
ON artista(id_cartel);
```
![index1](../../Images/BBDD/index1.png)

* **Índice para la tabla _cartel_ con la columna 'id_festival'**
```sql
CREATE INDEX cartel_festival_id_ix
ON cartel(id_festival);
```
![index2](../../Images/BBDD/index2.png)
