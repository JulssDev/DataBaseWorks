/*--Caracteristicas de las transaciiones

-- 1. atomicidad: todas las operaciones se consideran una sola
-- 2. Consistencia: Integridad de la informacion
-- 3. Aislamiento: Funcionand de manera aislada en cade sesion
-- 4. dUrabilidad: Temporal si hacemos rollback, permanente si hacemos comit

-- SINTAXIS

--begin; -- inicia la transaccion
-- sentencias SQL que necesitemos
--rollback;
--commit;

-- Transaccion para hacer pruebas
--begin;
-- sentencias
--rollback;

-- transaccion definitiva
--begin;
-- sentencias
--commit;
*/

begin;
insert into tasks(title,summary,created_date,limit_date,uid,pid)
values ('tarea de transaccion','Es una tarea de transaccion', '2025-05-14', '2025-05-14',2,1)

insert into task_tags(tid,tgid)
values (10,1)

select * from tasks ;

rollback;
commit;

-- transaccion que permita tranferir una tarea de un usuario a otro

begin;
update tasks 
set uid = 3
where tid = 6 

select * from tasks ;

rollback;
commit;

--

commit;