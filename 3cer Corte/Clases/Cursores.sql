-- Cursores en PL/pgSQL - Exploración de datos con prioridad
-- Recorriendo registros uno a uno desde una tabla ficticia de personas

-- Tabla de ejemplo: personas (id, nombre, correo, fecha_registro, pais)
-- INSERT INTO personas (nombre, correo, fecha_registro, pais) VALUES
-- ('Camila Soto', 'csoto@mail.com', NOW(), 'mexico');

-- Cursor explícito sin parámetros
DO
$$
DECLARE
  persona_reg personas%ROWTYPE;
  cursor_personas CURSOR FOR SELECT * FROM personas WHERE pais = 'mexico';
BEGIN
  RAISE NOTICE 'Comenzando revisión de registros...';
  FOR persona_reg IN cursor_personas LOOP
    RAISE NOTICE 'Persona encontrada: %', persona_reg;
  END LOOP;
  RAISE NOTICE 'Revisión finalizada.';
END;
$$ LANGUAGE plpgsql;


-- Cursor implícito (no se declara cursor ni variable)
DO
$$
BEGIN
  RAISE NOTICE 'Inicio de búsqueda de usuarios mexicanos...';
  FOR reg IN SELECT * FROM personas WHERE LOWER(pais) = 'mexico' LOOP
    RAISE NOTICE 'Dato: %', reg;
  END LOOP;
  RAISE NOTICE 'Fin de búsqueda.';
END;
$$ LANGUAGE plpgsql;


-- Cursor explícito con argumento (país como parámetro)
DO
$$
DECLARE
  persona_reg personas%ROWTYPE;
  cursor_filtrado CURSOR(pais_filtro TEXT) FOR 
    SELECT * FROM personas WHERE LOWER(pais) = LOWER(pais_filtro);
  pais_objetivo TEXT := 'argentina';
BEGIN
  RAISE NOTICE 'Buscando registros para el país: %', pais_objetivo;
  FOR persona_reg IN cursor_filtrado(pais_objetivo) LOOP
    RAISE NOTICE 'Resultado: %', persona_reg;
  END LOOP;
END;
$$ LANGUAGE plpgsql;