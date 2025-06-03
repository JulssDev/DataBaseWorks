
-- CASO 1: Registro automático en tabla de auditoría al insertar en "users"
-- Tablas requeridas:
CREATE TABLE users (
    uid SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE users_log (
    log_id SERIAL PRIMARY KEY,
    action TEXT,
    user_email TEXT,
    log_time TIMESTAMP DEFAULT NOW()
);

-- Insercion de datos:
INSERT INTO users (name, email) VALUES
('Juan Pérez', 'juan@example.com'),
('Ana Torres', 'ana@example.com');

-- Disparador:
CREATE OR REPLACE FUNCTION log_user_insert() RETURNS trigger AS $$
BEGIN
    INSERT INTO users_log(action, user_email)
    VALUES ('INSERT', NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_user_insert
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION log_user_insert();


-- CASO 2: Validar edad mínima al insertar usuario
-- Tablas requeridas:
CREATE TABLE personas (
    id SERIAL PRIMARY KEY,
    nombre TEXT,
    edad INT
);

-- Insercion de datos:
-- Este será válido
INSERT INTO personas (nombre, edad) VALUES
('Carlos Gómez', 22);

-- Este lanzará un error porque la edad es menor a 18
-- INSERT INTO personas (nombre, edad) VALUES
-- ('Laura Niño', 16);

-- Disparador:
CREATE OR REPLACE FUNCTION verificar_edad() RETURNS trigger AS $$
BEGIN
    IF NEW.edad < 18 THEN
        RAISE EXCEPTION 'La persona debe ser mayor de edad';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_edad
BEFORE INSERT ON personas
FOR EACH ROW
EXECUTE FUNCTION verificar_edad();


-- CASO 3: Actualizar fecha de última modificación automáticamente
-- Tablas requeridas:
CREATE TABLE tareas (
    tid SERIAL PRIMARY KEY,
    titulo TEXT,
    descripcion TEXT,
    fecha_actualizacion TIMESTAMP
);

-- Insercion de datos:
-- Insertar una tarea
INSERT INTO tareas (titulo, descripcion) VALUES
('Actualizar documento', 'Editar y subir la nueva versión');

-- Luego actualizarla para que dispare la modificación automática
UPDATE tareas SET descripcion = 'Versión final lista' WHERE tid = 1;

-- Disparador:
CREATE OR REPLACE FUNCTION actualizar_fecha_mod() RETURNS trigger AS $$
BEGIN
    NEW.fecha_actualizacion := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_actualizar_fecha
BEFORE UPDATE ON tareas
FOR EACH ROW
EXECUTE FUNCTION actualizar_fecha_mod();
