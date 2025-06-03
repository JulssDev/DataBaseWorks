
# 📘 Investigación sobre Disparadores en SQL (Triggers)

## 🔍 ¿Qué son los disparadores?

Un **disparador** (trigger) es un mecanismo en las bases de datos relacionales que permite ejecutar de forma automática un bloque de código (generalmente una función) **cuando ocurre un evento específico** sobre una tabla o una vista. Estos eventos pueden ser operaciones como `INSERT`, `UPDATE` o `DELETE`.

Los disparadores permiten incorporar **reglas de negocio** directamente en la base de datos, haciendo que ciertas acciones se ejecuten sin intervención manual ni necesidad de que la aplicación lo controle.

---

## 🎯 ¿Para qué sirven?

Los disparadores se utilizan para:

- Validar reglas antes de insertar o modificar datos.
- Registrar información en tablas de auditoría.
- Realizar cálculos automáticos.
- Mantener sincronización entre tablas relacionadas.
- Implementar controles de seguridad y restricciones adicionales.

---

## ✅ Ventajas

- **Automatización**: Permiten ejecutar tareas automáticamente ante eventos específicos.
- **Seguridad de datos**: Refuerzan la integridad y consistencia de los datos.
- **Auditoría**: Facilitan el registro histórico de cambios (quién, cuándo, qué).
- **Separación de lógica**: Algunas reglas se gestionan en la base de datos y no en la aplicación.

---

## ⚠️ Desventajas

- **Complejidad**: Pueden dificultar la lectura y el mantenimiento del sistema si se abusa de ellos.
- **Problemas de rendimiento**: Si no se diseñan correctamente, pueden ralentizar operaciones frecuentes.
- **Difícil depuración**: No siempre es evidente que un trigger está ejecutándose en segundo plano.
- **Dependencia**: Aumentan la lógica del lado del servidor y la dependencia con el motor de base de datos.

---

## 🛠️ Sintaxis general

```sql
CREATE TRIGGER nombre_trigger
{ BEFORE | AFTER | INSTEAD OF } { INSERT | UPDATE | DELETE }
ON nombre_tabla
[FOR EACH ROW]
EXECUTE FUNCTION nombre_funcion();
```

Para utilizar un trigger, es necesario crear previamente una función que contenga la lógica que queremos ejecutar. En PostgreSQL, esta función se puede escribir en `plpgsql`.

---

## 💡 Ejemplo básico

```sql
-- Función que se ejecutará al insertar un nuevo usuario
CREATE OR REPLACE FUNCTION log_insert_usuario() RETURNS trigger AS $$
BEGIN
    INSERT INTO log_table(email, accion)
    VALUES (NEW.email, 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que invoca la función anterior después de cada inserción
CREATE TRIGGER trg_log_usuario
AFTER INSERT ON usuarios
FOR EACH ROW
EXECUTE FUNCTION log_insert_usuario();
```

---

## 🧪 Casos prácticos implementados

1. **Auditoría de inserciones en la tabla `users`**  
   Cada vez que se agrega un nuevo usuario, se registra su correo y la acción en una tabla de logs.

2. **Validación de edad en la tabla `personas`**  
   Antes de insertar un nuevo registro, se valida que la persona sea mayor de edad. Si no lo es, se cancela la operación.

3. **Actualización automática de fecha en `tareas`**  
   Cuando se actualiza una tarea, se modifica automáticamente el campo `fecha_actualizacion` a la fecha y hora actual.

---

## 🧠 Conclusión

Los disparadores son una herramienta poderosa que mejora la calidad y control sobre los datos en una base de datos. Sin embargo, deben usarse con cuidado para evitar problemas de rendimiento o una arquitectura difícil de mantener.

Idealmente, se deben emplear para **reforzar la lógica crítica de negocio**, mantener integridad o registrar cambios importantes. Siempre que se usen de manera clara y documentada, aportan valor real a las soluciones basadas en bases de datos.

---

*Elaborado como parte de la práctica de programación en bases de datos con PostgreSQL.*
