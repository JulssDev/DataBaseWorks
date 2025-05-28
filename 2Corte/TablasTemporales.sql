-- TABLAS TEMPORALES

-- Nivel de Sesión
-- Nivel de Transacción

-- SINTAXIS

-- create (temporary|TEMP) table NOMBRE_TABLE
-- (COLUMN)
-- [on commit (preserve rows | delete row | DROP)]
/*
- preserve rows y delete rows SON OPCIONES PARA INDICAR QUE LAS TABLAS SON TEMPORALES EN UNA SESION
- drop INDICA QUE LA TABLA ES TEMPORAL EN UNA TRANSACCION

-- SINTAXIS DE CONSULTA
create (temporary|TEMP) table NOMBRE_TABLE
[on commit (preserve rows | delete row | DROP)]
as
-- Query
[with [no] data];
*/
drop table temporal1
create temporary table temporal1(
	tuno_id int,
	tuno_data varchar (255)
) on commit delete rows;

insert into temporal1(tuno_id, tuno_data) values(1, 'dato 1 temporal 1');
insert into temporal1(tuno_id, tuno_data) values(2, 'dato 2 temporal 1');

select * from temporal1;

-- crear una tabla temporal con todas las tareas de prioridad media y que muestre el nombre de la prioridad dentro de una transaccion.