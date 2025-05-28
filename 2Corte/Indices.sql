-- indices
--create index nombre_indice on Nombre_Tabla using  Metodo
--BTREE
-- HASH
-- GIST
-- SPGIT
--GIN
--BRIN


--(NOMBRE COLUMNA)

-- DROP INDEX CONCURRENTLY Nombre_indice [cascade][restrict]


create index user_name on users(
	name
);