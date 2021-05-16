## 7 PROGRAMACIÓN CON SCRIPTS EN PL/PGSQL

Un script es un programa o conjunto de comandos que almacenan una serie de instrucciones y se le da a un motor SQL para que las ejecute en un determinado orden. Dichos scripts nos permiten, entre otras cosas, la creación de bases de datos, tablas, dominios, primary keys, índices...  

Al final, la ejecución de estos scripts nos permitirá llevar documentados todos los cambios realizados en la base de datos.


1. Procedimiento para borrar un cliente/asistente del festival

```sql
create or replace procedure borrar_asistente(
	p_cliente_dni cliente.dni%type
)
language plpgsql
as
$$
declare
   v_cliente_dni cliente.dni%type;
begin
   -- primero comprobar si existe el cliente
   select dni from cliente
   into v_cliente_dni
   where dni = p_cliente_dni;
   -- borrar cliente
   delete from cliente
   where dni = p_cliente_dni;
   raise notice 'Cliente eliminado correctamente';
   -- capturar excepciones
   exception
      when no_data_found then 
         raise notice 'El cliente % no existe', p_cliente_dni;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```

Antes de llamar al procedimiento, creamos un nuevo asistente de prueba para la ejecución del script y una entrada al que asociarle:
```sql
INSERT INTO entrada (id, id_festival, fecha, precio) VALUES (6, 3, '2021-07-10', 95);
INSERT INTO cliente (dni, id_entrada, nombre, apellido1, apellido2, fechaNac, localidad, telefono) VALUES
    ('64584955A', 6, 'Lionel', 'Messi', 'pérez', '1988-11-10', 'Cuenca', '636963966');
```
```sql
call borrar_asistente('645849552A');
```


2. Función que permite averiguar el tiempo de actuación de un artista
```sql
create or replace function actuacion_artista(
	p_artista_dni artista.dni%type
)
returns time
language plpgsql
as
$$
declare
    v_artista_dni artista.dni%type;
    v_artista_horaTotal time;
begin
    -- primero comprobar si existe el artista
    select dni from artista
    into v_artista_dni
    where dni = p_artista_dni;
    --realizar la operación de resta entre las horas
    select hora_salida - hora_entrada as "horas que actúa" from artista
    into v_artista_horaTotal
    where dni = p_artista_dni;
    return v_artista_horaTotal;
    raise notice 'El artista actúa % horas', v_artista_horaTotal;
    -- excepciones
   exception
      when no_data_found then 
         raise notice 'El artista % no pertenece al festival', p_emp_id;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$ 
```
```sql
select actuacion_artista('14725835J');
```


3. Función que permite averigurar el menor precio de una entrada para un festival en concreto
```sql
create or replace function menor_precio_entradas (
   p_entrada_idFestival entrada.id_festival%type
)
returns integer
language plpgsql
as
$$
declare
    v_entrada_idFestival entrada.id_festival%type;
    v_entrada_menor entrada.precio%type;
begin
   -- buscamos el menor precio
   select min(precio) from entrada
   into v_entrada_menor
   where id_festival = p_entrada_idFestival;
   return v_entrada_menor;
   -- excepciones
   exception
      when no_data_found then 
         raise notice 'No se localiza la entrada indicada';
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
```sql
select menor_precio_entradas(3);
```


4. Función que permite averigurar el mayor precio de una entrada para un festival en concreto
```sql
create or replace function mayor_precio_entradas (
   p_entrada_idFestival entrada.id_festival%type
)
returns integer
language plpgsql
as
$$
declare
    v_entrada_idFestival entrada.id_festival%type;
    v_entrada_mayor entrada.precio%type;
begin
   -- buscamos el menor precio
   select max(precio) from entrada
   into v_entrada_mayor
   where id_festival = p_entrada_idFestival;
   return v_entrada_mayor;
   -- excepciones
   exception
      when no_data_found then 
         raise notice 'No se localiza la entrada indicada';
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
```sql
select mayor_precio_entradas(3);
```


5. Procedimiento que cree una nueva entrada y la asocie a un nuevo cliente
```sql
create or replace procedure nueva_entrada(
   p_entrada_nueva entrada.id%type
)
language plpgsql
as
$$
declare
   v_id integer;
   v_entrada_nueva entrada.id%type;
begin 
   -- insertamos una nueva entrada
   insert into entrada (id, id_festival, fecha, precio)
      values ((select MAX(id) from entrada)+1, 3, '2021-07-10', 100);
   raise notice 'Entrada creada correctamente';
   -- buscamos la última entrada creada
   select max(id) from entrada
   into v_entrada_nueva
   where id = p_entrada_nueva;
   -- creamos un nuevo cliente y le asignamos la entrada creada
   insert into cliente (dni, id_entrada, nombre, apellido1, apellido2, fechaNac, localidad, telefono)
      values ('03239746N', v_entrada_nueva, 'Pablo', 'Barnes', 'Ruiz', '1997-05-19', 'Madrid', '666555666');
   raise notice 'Cliente añadido con éxito';   
   -- excepciones
   exception
      when no_data_found then 
         raise notice 'No se localiza la entrada indicada';
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
```sql
call nueva_entrada(7);
```


6. Procedimiento para clasificar el sueldo de los artistas en 3 grupos.
```sql
create or replace function clasificacion_sueldo_artista(
   p_artista_dni artista.dni%type
)
returns varchar
language plpgsql
as
$$
declare
   v_artista_dni artista.dni%type;
   v_artista_sueldo artista.salario%type;
   v_artista_clasificacion VARCHAR(5);
begin
   --buscamos el artista en cuestión
   select dni from artista
   into v_artista_dni
   where dni = p_artista_dni;
   --buscamos el salario del artista
   select salario from artista
   into v_artista_sueldo
   where salario = artista.salario%type;
   --clasificamos en función del sueldo
   if found then
      case 
         when v_artista_sueldo > 1800 then
            v_artista_clasificacion := 'alto';
         when v_artista_sueldo > 1300 then
            v_artista_clasificacion := 'medio';
         else
            v_artista_clasificacion := 'bajo';
      end case;      
      return v_artista_clasificacion;
   end if;   
   -- excepciones
   exception
      when no_data_found then 
         raise notice 'No se localiza el artista indicado';
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
```sql
select clasificacion_sueldo_artista('54982175B');
```


7. Procedimiento que cancela un festival
```sql
create or replace procedure cancelar_festival(
   p_festivaL_id festival.id%type
)
language plpgsql
as
$$
declare
   v_festivaL_id festival.id%type;
begin
   --buscamos el festival en cuestión
   select id from festival
   into v_festivaL_id
   where id = p_festivaL_id;
   --lo borramos
   delete from festival where id = v_festivaL_id;
   raise notice 'El festival % ha sido eliminado correctamente'
   -- excepciones
   exception
      when no_data_found then 
         raise notice 'No se localiza el festival indicado';
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
```sql
call cancelar_festival(1);
```


8. Procedimiento que retrasa la hora de inicio de un cartel
```sql
create or replace procedure cambio_actuacion(
   --recibirá por parámetro el id de un cartel
   p_cartel_id cartel.id%type
   p_horas_retrasadas time;
)
language plpgsql
as
$$
declare
    v_cartel_id cartel.id%type;
    v_horas_retrasadas time;
    v_cartel_hora cartel.hora%type;
begin
   --buscamos al artista pasado por parámetro
   select id from cartel
   into v_cartel_id
   where id = p_cartel_id;
   --buscamos la hora a retrasar
   select hora from cartel
   into v_cartel_hora
   where hora = cartel.hora%type;
   --modificamos la hora del cartel
   update cartel set hora = (v_cartel_hora + v_horas_retrasadas) where id = v_cartel_id;
   return 'Hora de cartel modificada.';
   -- excepciones
   exception
      when no_data_found then 
         raise notice 'No se localiza el cartel indicado';
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
```sql
call cambio_actuacion(1);
```


9. Procedimiento que da de baja a un cliente de un club de fans
```sql
create or replace procedure baja_clubFans (
   p_clubFans_dniMayorEdad pertenecer.dni_mayorEdad%type
)
anguage plpgsql
as
$$
declare
   v_clubFans_dniMayorEdad pertenecer.dni_mayorEdad%type
begin
   --buscamos el cliente en cuestión al que dar de baja
   select dni from pertenecer
   into v_clubFans_dniMayorEdad
   where dni = p_clubFans_dniMayorEdad;
   --lo damos de baja
   delete from pertenecer where dni = v_clubFans_dniMayorEdad;
   raise notice 'El asistente % ya no pertenece a ingún club de fans', v_clubFans_dniMayorEdad;
   exception
      when no_data_found then 
         raise notice 'No se localiza el cliente indicado';
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
```sql
call baja_clubFans('12365478R');
```