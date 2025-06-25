# Guía Avanzada: Documentos Anidados en MongoDB

## 1. ¿Qué son los documentos anidados?

Los documentos anidados permiten guardar objetos dentro de otros objetos en una sola colección, como estructuras jerárquicas. Esto facilita consultas eficientes y un modelo de datos más realista.

## 2. Insertar documentos anidados

### Sintaxis básica

```javascript
db.usuarios.insertOne({
  nombre: "Ana Gómez",
  edad: 27,
  direccion: {
    calle: "Calle 45 #12-34",
    ciudad: "Medellín",
    pais: "Colombia"
  },
  contactos: [
    { tipo: "email", valor: "ana@correo.com" },
    { tipo: "teléfono", valor: "+57 301 234 5678" }
  ]
});
```

### Insertar múltiples

```javascript
db.productos.insertMany([
  {
    nombre: "Tablet",
    especificaciones: {
      ram: "4GB",
      almacenamiento: "128GB"
    },
    categorias: ["tecnología", "portátiles"],
    reviews: [{ usuario: "clienteA", calificacion: 4 }]
  },
  {
    nombre: "Monitor",
    especificaciones: {
      resolucion: "4K",
      tamaño: "27 pulgadas"
    },
    categorias: ["hardware"]
  }
]);
```

## 3. Consultar documentos anidados

### Dot notation

```javascript
db.usuarios.find({ "direccion.ciudad": "Medellín" });
```

### Arrays anidados

```javascript
db.usuarios.find({ "contactos.tipo": "email" });
```

### Proyección

```javascript
db.usuarios.find({}, {
  nombre: 1,
  "direccion.ciudad": 1,
  "contactos.valor": 1
});
```

## 4. Actualizar documentos anidados

```javascript
// Actualizar una ciudad
db.usuarios.updateOne(
  { nombre: "Ana Gómez" },
  { $set: { "direccion.ciudad": "Cali" } }
);

// Agregar nuevo contacto
db.usuarios.updateOne(
  { nombre: "Ana Gómez" },
  {
    $push: {
      contactos: {
        tipo: "linkedin",
        valor: "linkedin.com/in/anagomez"
      }
    }
  }
);
```

## 5. Eliminar datos anidados

```javascript
// Eliminar todo el documento
db.usuarios.deleteOne({ nombre: "Ana Gómez" });

// Eliminar solo un contacto del array
db.usuarios.updateOne(
  { nombre: "Ana Gómez" },
  { $pull: { contactos: { tipo: "email" } } }
);
```

## 6. Validación de documentos anidados

```javascript
db.createCollection("clientes", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["nombre", "direccion"],
      properties: {
        nombre: { bsonType: "string" },
        direccion: {
          bsonType: "object",
          required: ["ciudad", "pais"],
          properties: {
            ciudad: { bsonType: "string" },
            pais: { bsonType: "string" }
          }
        }
      }
    }
  }
});
```

## 7. Consultas avanzadas

```javascript
// Elemento específico en array
db.productos.find({
  reviews: { $elemMatch: { usuario: "clienteA", calificacion: { $gte: 4 } } }
});
```

## 8. Agregación y desenrollado de arrays

```javascript
db.productos.aggregate([
  { $unwind: "$reviews" },
  { $match: { "reviews.calificacion": { $gte: 4 } } },
  { $group: {
    _id: "$nombre",
    promedio: { $avg: "$reviews.calificacion" }
  }}
]);
```

## 9. Control de acceso y seguridad

- Limita qué campos pueden ver los usuarios usando proyecciones.
- Usa roles en MongoDB para restringir escritura/lectura por colección.

```bash
db.createUser({
  user: "lector",
  pwd: "123456",
  roles: [{ role: "read", db: "miDB" }]
});
```

## 10. Buenas prácticas

✅ Usa anidación cuando:
- Los datos están fuertemente relacionados.
- No crecen indefinidamente.

❌ Evita anidación cuando:
- El array puede volverse muy grande.
- La relación entre los datos no es tan directa.

## 11. Errores comunes

- ❌ Crear arrays gigantes: afecta el rendimiento.
- ❌ Consultas sin índices en campos anidados.
- ✅ Solución: crear índices anidados:

```javascript
db.usuarios.createIndex({ "direccion.ciudad": 1 });
```

## 12. Upserts y `$addToSet` para evitar duplicados

```javascript
// Upsert
db.usuarios.updateOne(
  { nombre: "Luis" },
  { $set: { "direccion.ciudad": "Barranquilla" } },
  { upsert: true }
);

// No duplicar en arrays
db.usuarios.updateOne(
  { nombre: "Luis" },
  {
    $addToSet: {
      contactos: { tipo: "email", valor: "luis@correo.com" }
    }
  }
);
```

## 13. $lookup con documentos anidados

```javascript
db.ordenes.aggregate([
  {
    $lookup: {
      from: "usuarios",
      localField: "usuario_id",
      foreignField: "_id",
      as: "info_usuario"
    }
  },
  { $unwind: "$info_usuario" },
  {
    $project: {
      numero_orden: 1,
      "info_usuario.nombre": 1,
      "info_usuario.direccion.ciudad": 1
    }
  }
]);
```

## 14. Consideraciones de rendimiento

- Tamaño máximo de documento: **16MB**
- Máximo 100 niveles de anidación
- Usa proyecciones para evitar transferir todo el documento

---

## Conclusión

Los documentos anidados son potentes y flexibles, ideales para representar relaciones uno-a-uno y uno-a-muchos. Sin embargo, requieren modelado cuidadoso para mantener el rendimiento, la escalabilidad y la facilidad de mantenimiento.