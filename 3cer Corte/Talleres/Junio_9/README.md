# Base de Datos de Operadores Lógicos y Relacionales en MongoDB

Este proyecto proporciona una base de datos MongoDB con dos colecciones que contienen descripciones detalladas, estructuras y ejemplos de operadores **lógicos** y **relacionales**. Ideal para propósitos educativos, referencias de desarrollo o documentación técnica.

## Archivos Incluidos

- `Ologicos.js`: Contiene operadores lógicos (`AND`, `OR`, `NOT`, `NOR`)
- `Orelacionales.js`: Contiene operadores relacionales (`EQ`, `GT`, `GTE`, `IN`, `LT`, `LTE`, `NE`, `NIN`)

---

## 📦 Requisitos

- MongoDB instalado y ejecutándose (local o en Atlas)
- Mongo Shell (MongoSH)
- Editor de código (opcional)

---

## 🏗️ Estructura del Proyecto

Cada archivo declara objetos con la siguiente estructura:

```js
var OL1 = {
  operador: "AND", // Nombre del operador
  descripcion: "Descripción completa de su función",
  estructura: "Ejemplo de sintaxis en MongoDB",
  ejemplo: "Consulta real ejecutable en MongoDB"
}
```

Estas estructuras se insertan en colecciones dentro de una base de datos MongoDB.

---

## 🚀 Implementación paso a paso

### 1. Iniciar Mongo Shell

```bash
mongosh
```

### 2. Seleccionar la base de datos

```js
use operadores
```

### 3. Insertar los documentos

#### Operadores Lógicos

```js
// Copiar contenido desde Ologicos.js y pegar en la terminal
db.OL.insertMany([OL1, OL2, OL3, OL4])
```

#### Operadores Relacionales

```js
// Copiar contenido desde Orelacionales.js y pegar en la terminal
db.OR.insertMany([OR1, OR2, OR3, OR4, OR5, OR6, OR7, OR8])
```

---

## 🔍 Consultas Básicas

### Visualizar todos los operadores

```js
db.OL.find()  // Lógicos
db.OR.find()  // Relacionales
```

### Buscar un operador específico

#### Lógicos:

```js
db.OL.find({ operador: "AND" })
db.OL.find({ operador: "NOT" })
db.OL.find({ operador: "NOR" })
db.OL.find({ operador: "OR" })
```

#### Relacionales:

```js
db.OR.find({ operador: "EQ" })
db.OR.find({ operador: "GT" })
db.OR.find({ operador: "IN" })
// etc.
```

---

## 📘 Descripción de Operadores

### 🧠 Lógicos (`db.OL`)

| Operador | Descripción breve | Ejemplo |
|----------|-------------------|---------|
| AND      | Devuelve `true` si ambas condiciones son verdaderas. | `{ $and: [cond1, cond2] }` |
| OR       | Devuelve `true` si al menos una condición es verdadera. | `{ $or: [cond1, cond2] }` |
| NOT      | Invierte la lógica de la condición. | `{ field: { $not: { $gt: value } } }` |
| NOR      | Devuelve `true` si todas las condiciones son falsas. | `{ $nor: [cond1, cond2] }` |

### 📊 Relacionales (`db.OR`)

| Operador | Descripción breve | Ejemplo |
|----------|-------------------|---------|
| EQ       | Igual a. | `{ qty: { $eq: 20 } }` |
| NE       | No igual a. | `{ qty: { $ne: 20 } }` |
| GT       | Mayor que. | `{ qty: { $gt: 20 } }` |
| GTE      | Mayor o igual que. | `{ qty: { $gte: 20 } }` |
| LT       | Menor que. | `{ qty: { $lt: 20 } }` |
| LTE      | Menor o igual que. | `{ qty: { $lte: 20 } }` |
| IN       | Incluido en lista. | `{ qty: { $in: [5, 15] } }` |
| NIN      | No incluido en lista. | `{ qty: { $nin: [5, 15] } }` |

---

## 🎯 Casos de Uso

- **Educación**: Útil para enseñar operadores de MongoDB a estudiantes de bases de datos.
- **Referencia rápida**: Como diccionario técnico para consultas complejas.
- **Integración en herramientas**: Puede ser extendido a APIs RESTful, interfaces gráficas o proyectos en Node.js.

---

## 🛠️ Recomendaciones

- Puedes adaptar la colección `OL` y `OR` a otras bases de datos si exportas los documentos como JSON.
- Añade campos como `categoria`, `nivel_dificultad`, `tags` si deseas mejorar la estructura para aprendizaje adaptativo.
- Integra esta base con frontends como Vue/React para una interfaz de consulta interactiva.

---

## 📁 Extensión del Proyecto

- Crear una colección `Ejercicios` con problemas prácticos por operador.
- Conectar con MongoDB Atlas para acceso en la nube.
- Automatizar la inserción con scripts Node.js.

---

## 📬 Contacto

Este proyecto fue creado como guía y base de referencia para el aprendizaje de operadores MongoDB. Puedes adaptarlo y reutilizarlo en tus propios proyectos educativos o de desarrollo.