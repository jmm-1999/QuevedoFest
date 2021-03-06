--SUBCONSULTAS SOBRE LA BASE DE DATOS

--¿Cuántas entradas se vendieron para el festival en el que se celebró el cartel Swing?
SELECT COUNT(e.id) AS "Número de entradas", f.id AS "Número de festival", c.nombre AS "Nombre cartel"
FROM entrada e 
    JOIN festival f ON (e.id_festival = f.id)
    JOIN cartel c ON (f.id = c.id_festival)
WHERE c.nombre = 'Swing'
GROUP BY f.id, c.nombre;

```Resultado
 Número de entradas | Número de festival | Nombre cartel
--------------------+--------------------+---------------
                  3 |                  3 | Swing
(1 row)
```

--¿Cuál es el nombre y el teléfono del mánager de Coone y Farruko?
SELECT m.nombre_completo AS "Nombre mánager", m.telefono AS "Teléfono mánager", a.nombre AS "Nombre artista"
FROM manager m 
    JOIN artista a ON (m.dni = a.dni_manager)
WHERE (a.nombre = 'Coone') OR (a.nombre = 'Farruko');

```Resultado
   Nombre mánager   | Teléfono mánager | Nombre artista
--------------------+------------------+----------------
 Mariano Rajoy Rojo |        677284663 | Coone
 Irene Montero      |        623245112 | Farruko
(2 rows)
```

--¿A qué género musical pertenecen los carteles que se celebran en el festival de este año?
SELECT c.generoMusical AS "Género musical", c.id AS "Número de cartel", f.fechaInicio AS "Fecha de festival"
FROM cartel c 
    JOIN festival f ON (c.id_festival = f.id)
WHERE f.fechaInicio BETWEEN '2021-01-01' AND '2021-12-31'
ORDER BY generoMusical ASC;

```Resultado
 Género musical | Número de cartel | Fecha de festival
----------------+------------------+-------------------
 Bachata        |               12 | 2021-07-10
 Flamenco       |               11 | 2021-07-10
 Hardcore       |                9 | 2021-07-10
 Pop            |               10 | 2021-07-10
(4 rows)
```

--¿Cuántos asistentes pertenecen al club de fans de Rosalía?
SELECT COUNT(p.dni_mayorEdad) AS "Número participantes", cf.nombre AS "Nombre club de fans", a.nombre  AS "Nombre artista"
FROM pertenecer p
    JOIN clubFans cf ON (p.id_clubFans = cf.id)
    JOIN artista a ON (cf.dni_artista = a.dni)
WHERE a.nombre = 'Rosalia'
GROUP BY cf.nombre, a.nombre;
    
```Resultado
 Número participantes | Nombre club de fans | Nombre artista
----------------------+---------------------+----------------
                    1 | Ros-alitas          | Rosalia
(1 row)
```

--¿Qué artista es el que más cobra del cartel número 12?
SELECT a.nombre AS "Nombre artista", a.salario AS "Sueldo artista", c.id AS "ID Cartel"
FROM artista a
    JOIN cartel c ON (a.id_cartel = c.id)
WHERE a.salario =
    (SELECT MAX(salario) FROM artista WHERE id_cartel = 12);

```Resultado
 Nombre artista | Sueldo artista | ID Cartel
----------------+----------------+-----------
 Farruko        |           2400 |        12
(1 row)
```

--¿En qué escenario y a qué hora canta Chambao?
SELECT e.id AS "ID Escenario", e.nombre AS "Nombre escenario", a.nombre  AS "Nombre artista", a.hora_entrada, a.hora_salida
FROM escenario e 
    JOIN cartel c ON (e.id_cartel = c.id)
    JOIN artista a ON (c.id = a.id_cartel)
WHERE a.nombre = 'Chambao';

```Resultado
 ID Escenario | Nombre escenario | Nombre artista | hora_entrada | hora_salida
--------------+------------------+----------------+--------------+-------------
            4 | Fire             | Chambao        | 18:30:00     | 19:30:00
(1 row)
```

--¿A qué hora comienza el cartel en el que canta Wellinton Quiw?
SELECT c.id AS "ID Artista", c.nombre AS "Nombre cartel", c.fecha, c.hora AS "Hora comienzo cartel", 
a.nombre AS "Nombre artista", a.hora_entrada AS "Hora entrada artista" 
FROM cartel c 
    JOIN artista a ON (c.id = a.id_cartel)
WHERE a.nombre = 'Wellinton Quiw';

```Resultado
 ID Artista | Nombre cartel |   fecha    | Hora comienzo cartel | Nombre artista | Hora entrada artista
------------+---------------+------------+----------------------+----------------+----------------------
         12 | Rumba         | 2021-07-13 | 15:30:00             | Wellinton Quiw | 18:30:00
(1 row)
```

--¿Cuánta gente podrá ver a Romeo Santos en directo?
SELECT e.nombre AS "Nombre escenario", e.capacidad AS "Capacidad escenario", a.nombre AS "Nombre artista"
FROM escenario e 
    JOIN cartel c ON (e.id_cartel = c.id)
    JOIN artista a ON (c.id = a.id_cartel)
WHERE a.nombre = 'Romeo Santos';

```Resultado
 Nombre escenario | Capacidad escenario | Nombre artista
------------------+---------------------+----------------
 Summer           |                 950 | Romeo Santos
(1 row)
```

--¿Cuál es el teléfono del mánager de aquellos artistas cuyo nombre comienza por J?
SELECT m.nombre_completo AS "Nombre mánager", m.telefono AS "Teléfono mánager", a.nombre AS "Nombre artista"
FROM manager m
    JOIN artista a ON (m.dni = a.dni_manager)
WHERE a.nombre LIKE 'J%';

```Resultado
  Nombre mánager   | Teléfono mánager | Nombre artista
-------------------+------------------+----------------
 Irene Montero     |        623245112 | Justin Biever
 Sebastián Filimón |        673525366 | Jennifer López
(2 rows)
```

--¿Qué día acaba el festival de la entrada número 2?
SELECT f.nombre AS "Nombre festival", f.fechaFin AS "Fecha fin festival", e.id AS "ID Entrada"
FROM festival f 
    JOIN entrada e ON (f.id = e.id_festival) 
WHERE e.id = 2;

```Resultado
 Nombre festival | Fecha fin festival | ID Entrada
-----------------+--------------------+------------
 QuevedoFest     | 2020-08-18         |          2
(1 row)
```

--Nombre y hora de salida del último artista que actúa en el festival de este año
SELECT a.nombre AS "Nombre artista", a.hora_entrada AS "Actuación artista", 
f.nombre AS "Nombre festival", f.fechaInicio AS "Comienzo de festival"
FROM artista a 
    JOIN cartel c ON (a.id_cartel = c.id)
    JOIN festival f ON (c.id_festival = f.id)
WHERE f.fechaInicio BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY a.nombre, f.nombre, f.fechaInicio, a.hora_entrada
HAVING a.hora_entrada > '20:00' AND a.hora_entrada < '22:00';

```Resultado
 Nombre artista | Actuación artista | Nombre festival | Comienzo de festival
----------------+-------------------+-----------------+----------------------
 Coone          | 20:30:00          | QuevedoFest     | 2021-07-10
(1 row)
```