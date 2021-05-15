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
create or replace function dif_horas(
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
select dif_horas('14725835J');
```