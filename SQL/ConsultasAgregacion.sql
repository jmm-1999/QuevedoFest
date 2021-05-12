--CONSULTAS SOBRE LA BASE DE DATOS DE AGREGACIÓN Y AGRUPAMIENTO

--¿Qué artista cobra o ha cobrado menos de aquellos cuyo nombre contiene la 'o'?
SELECT MIN(salario), nombre FROM artista WHERE nombre LIKE '%o%' GROUP BY nombre;

```Resultado
 min  |       nombre
------+--------------------
  800 | Wellinton Quiw
 2400 | Farruko
 1200 | Daviles de Novelda
 1700 | Romeo Santos
 1600 | Rosalia
 1250 | Chambao
 1500 | Kidd Keo
 2100 | Coone
(8 rows)
```

--¿Cuál es la media de recaudaciones obtenidas con los clubs de fans?
SELECT ROUND(AVG(recaudacion), 2) AS "Media de recaudaciones" FROM clubFans;

```Resultado
 Media de recaudaciones
------------------------
                2500.00
(1 row)
```

--¿Cuál es la media de recaudaciones obtenidas con la venta de entradas?
SELECT ROUND(AVG(precio), 2) AS "Media de recaudaciones" FROM entrada;

```Resultado
 Media de recaudaciones
------------------------
                  84.00
(1 row)
```

--¿Cuántos clientes han pagado 90€ por su entrada?
SELECT COUNT(c.dni) AS "Número de Clientes", e.precio
FROM cliente c 
    JOIN entrada e ON (c.id_entrada = e.id)
WHERE precio = '90'
GROUP BY e.precio;

```Resultado
 Número de Clientes | precio
--------------------+--------
                  3 |     90
(1 row)
```

--¿Cuántos artistas actúan en el cartel 12?
SELECT COUNT(a.dni) AS "Número de Artistas", c.id AS "ID Cartel"
FROM artista a
    JOIN cartel c ON (a.id_cartel = c.id)
WHERE c.id = '12'
GROUP BY c.id
ORDER BY c.id ASC;

```Resultado
 Número de Artistas | ID Cartel
--------------------+-----------
                  3 |        12
(1 row)
```

--¿Cuál es el menor precio que se llegó a cobrar por una entrada y para que festival fué?
SELECT e.precio AS "Menor precio entrada", f.id AS "ID Festival", f.nombre AS "Nombre festival"
FROM entrada e 
    JOIN festival f ON (e.id_festival = f.id)
WHERE e.precio = 
    (SELECT MIN(precio) FROM entrada);

```Resultado
 Menor precio entrada | ID Festival | Nombre festival
----------------------+-------------+-----------------
                   70 |           2 | QuevedoFest
(1 row)
```    

--¿Quién de los asistentes es el más pequeño?
SELECT MAX(fechaNac) AS "Asistente más pequeño" FROM cliente;

```Resultado
 Asistente más pequeño
-----------------------
 2006-08-15
(1 row)
```

--¿Cuál es el total de recaudaciones obtenidas con la venta de entradas del festival de este año?
SELECT SUM(e.precio) AS "Recaudación total", f.fechaInicio AS "Fecha de festival"
FROM entrada e 
    JOIN festival f ON (e.id_festival = f.id)
WHERE f.fechaInicio BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY f.fechaInicio;

```Resultado
 Recaudación total | Fecha de festival
-------------------+-------------------
               270 | 2021-07-10
(1 row)
```

--¿Cuántos festivales se han celebrado en el 2020?
SELECT COUNT(id) AS "Número de festivales" FROM festival WHERE fechaInicio BETWEEN '2020-01-01' AND '2020-12-31';

```Resultado
 Número de festivales
----------------------
                    2
(1 row)
```

--¿Cuánta gente asistirá al festival que se celebra este año?
SELECT COUNT(e.id) AS "Número de asistentes", f.fechaInicio AS "Fecha festival"
FROM entrada e
    JOIN festival f ON (e.id_festival = f.id)
WHERE f.fechaInicio BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY f.fechaInicio;

```Resultado
 Número de asistentes | Fecha festival
----------------------+----------------
                    3 | 2021-07-10
(1 row)
```

--Suma del salario de los artistas que actúan en el primer cartel del primer festival
SELECT SUM(a.salario) AS "Pago total artistas", c.id as "Cartel", f.id as "Festival"
FROM artista a
    JOIN cartel c ON (a.id_cartel = c.id)
    JOIN festival f ON (c.id_festival = f.id)
WHERE (c.id = 1) AND (f.id = 1)
GROUP BY c.id, f.id;

```Resultado
 Pago total artistas | Cartel | Festival
---------------------+--------+----------
                6000 |      1 |        1
(1 row)
```