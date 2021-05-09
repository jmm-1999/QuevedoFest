--CONSULTAS SOBRE LA BASE DE DATOS MÁS FRECUENTES

--¿Qué clientes asisten al festival de este año y de que localidades son?
SELECT c.dni, c.localidad, EXTRACT(YEAR FROM f.fechaInicio) AS "Fecha Festival" 
FROM cliente c
    JOIN entrada e ON (c.id_entrada = e.id)
    JOIN festival f ON (e.id_festival = f.id)
WHERE EXTRACT(YEAR FROM f.fechaInicio) = 2021
GROUP BY c.dni, f.fechaInicio;

```Resultado
    dni    |     localidad     | Fecha Festival
-----------+-------------------+----------------
 45612378D | Alcorcón          |           2021
 65784147M | Getafe            |           2021
 65897423N | Rivas-Vaciamadrid |           2021
```

--¿Qué día acaba el Festival de este verano?
SELECT id, fechaFIn, EXTRACT(YEAR FROM fechaInicio) AS "Fecha Inicio" FROM festival WHERE EXTRACT(YEAR FROM fechaInicio) = 2021;

```Resultado
id |  fechafin  | Fecha Inicio
----+------------+--------------
  3 | 2021-08-13 |         2021
(1 row)
```

--¿En qué cartel y a que hóra canta C.Tangana?
SELECT a.nombre, a.hora_entrada, c.id AS "ID CARTEL", c.nombre AS "NOMBRE CARTEL"
FROM artista a
    JOIN cartel c ON (a.id_cartel = c.id)
WHERE a.nombre = 'C. Tangana';

```Resultado
 nombre   | hora_entrada | ID CARTEL | NOMBRE CARTEL
------------+--------------+-----------+---------------
 C. Tangana | 22:30:00     |         1 | Savage
(1 row)
```

--¿Cuál es el teléfono del mánager de Rosalía?
SELECT a.nombre, m.telefono AS "teléfono del mánager"
FROM artista a 
    JOIN manager m ON (a.dni_manager = m.dni)
WHERE a.nombre = 'Rosalia';

```Resultado
 nombre  | teléfono del mánager
---------+----------------------
 Rosalia |            633662211
(1 row)
```

--¿Qué artistas poseen club de fans y cómo se llaman?
SELECT a.nombre, cf.id, cf.nombre AS "Nombre Club Fans"
FROM artista a 
    JOIN clubFans cf ON (a.dni = cf.dni_artista);

```Resultado
    nombre     | id | Nombre Club Fans
---------------+----+------------------
 C. Tangana    |  1 | Los Tanguitos
 Justin Biever |  2 | Believers
 Rosalia       |  3 | Ros-alitas
(3 rows)
```    

--¿Cuántos clientes o asistentes pertenecen al club de fans de Justin Biever?
SELECT COUNT(p.dni_mayorEdad) AS "Nº asistentes", cf.id AS "CF Justin Biever"
FROM pertenecer p
    JOIN clubFans cf ON (p.id_clubFans = cf.id)
    JOIN artista a ON (cf.dni_artista = a.dni)
WHERE cf.nombre = 'Justin Biever'
GROUP BY cf.id;

```Resultado
Nº asistentes | CF Justin Biever
---------------+------------------
(0 rows)
```

--¿Cuánto cobran Kidd Keo y Farruko?
SELECT nombre, salario FROM artista WHERE (nombre = 'Kidd Keo') OR (nombre = 'Farruko');

```Resultado
  nombre  | salario
----------+---------
 Kidd Keo |    1500
 Farruko  |    2400
(2 rows)
```

--¿En qué escenario se celebró el cartel Gang?
SELECT c.nombre AS "Nombre Cartel", e.nombre AS "Nombre Escenario", e.fecha 
FROM cartel c 
    JOIN escenario e ON (c.id = e.id_cartel)
WHERE c.nombre = 'Gang';

```Resultado
 Nombre Cartel | Nombre Escenario |   fecha
---------------+------------------+------------
 Gang          | Fire             | 2020-08-15
(1 row)
```

--¿Cuánto es lo máximo que se ha pagado por una entrada?
SELECT MAX(precio) AS "Precio Máximo" FROM entrada;

```Resultado
 Precio Máximo
---------------
            90
(1 row)
```

--¿Qué recaudación se ha obtenido con el club de fans de C.Tangana?
SELECT cf.recaudacion, cf.nombre AS "Nombre Club Fans", a.nombre 
FROM clubFans cf 
    JOIN artista a ON (cf.dni_artista = a.dni)
WHERE a.nombre = 'C. Tangana';

 ```Resultado
 recaudacion | Nombre Club Fans |   nombre
-------------+------------------+------------
        3000 | Los Tanguitos    | C. Tangana
(1 row)
```