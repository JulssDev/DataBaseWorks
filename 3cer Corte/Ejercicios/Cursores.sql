-- TAREA: Buscar tareas con prioridad 'baja' usando cursores

-- Mostrar tareas con prioridad baja (versión implícita, sin declarar cursor)
DO
$$
BEGIN
  RAISE NOTICE 'Listado de tareas con prioridad baja:';
  FOR tarea IN
    SELECT t.*
    FROM tasks t
    JOIN priorities p ON t.pid = p.pid
    WHERE LOWER(p.p_name) = 'baja'
  LOOP
    RAISE NOTICE 'Tarea: ID %, Título: %', tarea.tid, tarea.title;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Mostrar tareas según prioridad indicada (versión explícita con parámetro)
DO
$$
DECLARE
  reg_task tasks%ROWTYPE;
  prioridad_busqueda TEXT := 'baja';
  cur_tareas CURSOR(p_nombre TEXT) FOR
    SELECT t.*
    FROM tasks t
    INNER JOIN priorities p ON t.pid = p.pid
    WHERE LOWER(p.p_name) = LOWER(p_nombre);
BEGIN
  RAISE NOTICE 'Buscando tareas con prioridad "%"...', prioridad_busqueda;
  OPEN cur_tareas(prioridad_busqueda);
  LOOP
    FETCH cur_tareas INTO reg_task;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE 'ID: %, Título: %, Fecha Límite: %',
      reg_task.tid, reg_task.title, reg_task.limit_date;
  END LOOP;
  CLOSE cur_tareas;
END;
$$ LANGUAGE plpgsql;
