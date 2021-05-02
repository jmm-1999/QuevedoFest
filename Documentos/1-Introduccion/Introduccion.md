## INTRODUCCIÓN

![ImagenBBDD](../../Images/Captura.PNG)

El proyecto a realizar se basa en la creación de una base de datos que aborde el Área Artísticas del gran QuevedoFest. La crearemos y dessarrollaremos en PostgreSQL con el usuario Javier.

Dicha base de datos gestionará diversos aspectos del festival mediante numerosas tablas de datos, así como los festivales que se celebran, los artistas que asisten, el cartel, las entradas vendidas, el club de fans, los clientes y los escenarios donde se celebrarán los conciertos.

El desarrollo de la base de datos irá evolucionando por etapas:   

Lo primero a realizar es el modelo conceptual, donde se indicarán las especificaciones y se hará el diagrama Entidad-Relación de nuestra base de datos indicando la cardinalidad y la relación entre las distintas tablas. 

El segundo paso hablaremos sobre el modelo lógico, enfocando el modelo relacional y la normalización de las tablas.  

Como último modelo a explicar tenemos el físico, en el que crearemos las tablas, diseñaremos el diagrama de la base de datos y cargaremos datos de prueba.  

Otro apartado a tratar es el de consultas, donde se reflejarán las más frecuentes, las más sencillas y las subconsultas, entre otras. Nos interesará saber, por ejemplo, cuántos festivales y en qué fechas acontecen, el número de carteles que ofrecen, las entradas vendidas y su recaudación total, el número de espectadores o clientes que asisten, los artistas que asisten y pertenecen a cada cartel (y su sueldo), la gestión de los clubes de fans... 

Relacionado con lo anterior, también tendremos un espacio de vistas, secuencias, indices y scripts en PL/pgSQL.

Los últimos aspectos que tendremos en cuenta serán algunos como cursores, planes de prueba y especificaciones en formato Gherkin o el diagrama de clases, entre algunas otras.