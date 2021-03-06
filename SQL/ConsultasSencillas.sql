--CONSULTAS SOBRE LA BASE DE DATOS MÁS SENCILLAS

--¿Cuándo se celebró el primer festival?
SELECT id, fechaInicio, fechaFin FROM festival WHERE id = 1;

```Resultado
 id | fechainicio |  fechafin
----+-------------+------------
  1 | 2020-07-20  | 2020-07-23
(1 row)
```

--¿A qué género musical pertenece cada cartel?
SELECT id, nombre, generoMusical FROM cartel;

```Resultado
 id | nombre | generomusical
----+--------+---------------
  1 | Savage | Trap
  2 | Colors | Reggaetón
  3 | Random | Rock
  4 | Reel   | Rap
  5 | Sun    | Hardcore
  6 | Fandom | Reggae
  7 | Moon   | Pop
  8 | World  | Punky
  9 | Luxury | Hardcore
 10 | Swing  | Pop
 11 | Gang   | Flamenco
 12 | Rumba  | Bachata
(12 rows)
```

--¿Qué capacidad tiene cada uno de los escenarios?
SELECT id, capacidad FROM escenario;

```sql
 id | capacidad
----+-----------
  1 |      1000
  2 |      1200
  3 |       950
  4 |       900
  5 |       950
(5 rows)
```

--Todos los nombres de los mánager cuyo número de teléfono contiene 66
SELECT nombre_completo, telefono FROM manager WHERE CAST(telefono AS TEXT) LIKE '%66%';

```Resultado
  nombre_completo   | telefono
--------------------+-----------
 María Gomez Palos  | 633662211
 Ramón Moreno       | 644665544
 Mariano Rajoy Rojo | 677284663
 Sebastián Filimón  | 673525366
 Pablo Moreno Pérez | 666666645
(5 rows)
```

--¿Cuánto cobra cada artista?
SELECT dni, nombre, salario FROM artista ORDER BY nombre ASC;

```Resultado
    dni    |       nombre       | salario
-----------+--------------------+---------
 86249517B | AngerFirst         |    2000
 45698235S | C. Tangana         |    1900
 36985214H | Camin              |    1000
 64859127F | Chambao            |    1250
 75324861M | Coone              |    2100
 45987623G | Daviles de Novelda |    1200
 94587126A | Farruko            |    2400
 54982175B | HeadHunter         |    2200
 48269125W | Jennifer López     |    2600
 78998754T | Justin Biever      |    2500
 14725835J | Kidd Keo           |    1500
 72486593H | Romeo Santos       |    1700
 25896346K | Rosalia            |    1600
 81592634T | Wellinton Quiw     |     800
(14 rows)
```

--¿En que fecha se creó cada club de fans?
SELECT id, nombre, fecha_creacion FROM clubFans;

```Resultado
id |    nombre     | fecha_creacion
----+---------------+----------------
  1 | Los Tanguitos | 2017-09-18
  2 | Believers     | 2015-10-25
  3 | Ros-alitas    | 2018-02-20
(3 rows)
```

--Toda la información de ocupación de los camerinos
SELECT * FROM camerino GROUP BY fechaYHora ORDER BY fechaYHora ASC;

```Resultado
     fechayhora      | id | gama  | nombre
---------------------+----+-------+--------
 2020-07-20 14:30:00 |  1 | Alta  | Rumba
 2020-07-20 16:30:00 |  2 | Media | World
 2020-07-20 17:30:00 |  1 | Alta  | Rumba
 2020-07-20 21:30:00 |  1 | Alta  | Rumba
 2021-07-10 14:00:00 |  2 | Media | World
 2021-07-10 18:30:00 |  1 | Alta  | Rumba
 2021-07-10 19:30:00 |  2 | Media | World
 2021-07-11 15:30:00 |  1 | Alta  | Rumba
 2021-07-11 18:00:00 |  1 | Alta  | Rumba
 2021-07-12 14:00:00 |  2 | Media | World
 2021-07-12 16:00:00 |  2 | Media | World
 2021-07-12 17:30:00 |  2 | Media | World
 2021-07-12 18:00:00 |  2 | Alta  | World
 2021-07-12 18:15:00 |  1 | Alta  | Rumba
(14 rows)
```

--¿Cuál es el teléfono y la localidad del cliente con DNI 65784147M?
SELECT dni, telefono, localidad FROM cliente WHERE dni = '65784147M';

```Resultado
    dni    | telefono  | localidad
-----------+-----------+-----------
 65784147M | 636521425 | Getafe
(1 row)
```

--¿A qué hora empieza y termina su actuación Jennifer López el día que actúa?*
SELECT nombre, hora_entrada, hora_salida FROM artista WHERE nombre = 'Jennifer López';

```Resultado
     nombre     | hora_entrada | hora_salida
----------------+--------------+-------------
 Jennifer López | 19:00:00     | 20:00:00
(1 row)
```

--¿Hay algún asistente (cliente) de Barcelona?
SELECT * FROM cliente WHERE localidad = 'Barcelona';

```Resultado
 dni | id_entrada | nombre | apellido1 | apellido2 | fechanac | localidad | telefono
-----+------------+--------+-----------+-----------+----------+-----------+----------
(0 rows)
```

--¿En qué fecha y hora se ocupa el escenario Summer en el cartel 12?
SELECT id, nombre, fecha, hora FROM escenario WHERE id_cartel = 12;

```Resultado
 id | nombre |   fecha    |   hora
----+--------+------------+----------
  5 | Summer | 2021-07-12 | 17:00:00
(1 row)
```

--Apellidos y nombre de todos los clientes, ordenados alfabéticamente.
SELECT apellido1, apellido2, nombre FROM cliente ORDER BY apellido1 ASC;

```Resultado
 apellido1 | apellido2 |  nombre
-----------+-----------+-----------
 Alonso    | De Mateo  | Carla
 Gonzalez  | Fernandez | Raúl
 Ramos     | Palao     | Sergio
 Ronaldo   | Pérez     | Cristiano
 Ruiz      | Verde     | Luisa
(5 rows)
```

--Clientes cuyo nombre acaba en 'a'
SELECT dni, nombre FROM cliente WHERE nombre LIKE '%a';

```Resultado
    dni    | nombre
-----------+--------
 45612378D | Luisa
 65784147M | Carla
(2 rows)
```