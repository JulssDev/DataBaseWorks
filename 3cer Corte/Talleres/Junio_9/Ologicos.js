// Declaracion de Documentos:
var OL1={
    operador: "AND",
    descripcion: "Operador lógico que devuelve true si ambas expresiones que conecta son true. En caso contrario, devuelve false. Se usa para combinar condiciones y tomar decisiones basadas en la lógica. ",
    estructura: "{ $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }",
    ejemplo: "db.inventory.find( { $and: [ { price: { $ne: 1.99 } }, { price: { $exists: true } } ] } )"
}

var OL2={
    operador: "NOT",
    descripcion: "Se usa para negar una expresión booleana. En otras palabras, si una expresión booleana es True, not la convierte en False, y si es False, la convierte en True. ",
    estructura: "{ field: { $not: { <operator-expression> } } }",
    ejemplo: "db.inventory.find( { price: { $not: { $gt: 1.99 } } } )"
}

var OL3={
    operador: "NOR",
    descripcion: "Es un operador lógico que devuelve True (verdadero) solo si todas las entradas son False (falsas). En otras palabras, si alguna de las entradas es True, la salida de NOR es False. ",
    estructura: "{ $nor: [ { <expression1> }, { <expression2> }, ...  { <expressionN> } ] }",
    ejemplo: "db.inventory.find( { $nor: [ { price: 1.99 }, { sale: true } ]  } )"
}

var OL4={
    operador: "OR",
    descripcion: "Sirve para evaluar si al menos uno de los operandos es verdadero. Si alguna de las expresiones evaluadas es verdadera, el resultado de la operación OR también será verdadero. De lo contrario, si todas las expresiones son falsas, el resultado será falso. ",
    estructura: "{ $or: [ { <expression1> }, { <expression2> }, ... , { <expressionN> } ] }",
    ejemplo: "db.inventory.find( { $or: [ { quantity: { $lt: 20 } }, { price: 10 } ] } )"
}

// Instrucciones dentro de MongoDB (Seguir linea por linea):
/* MongoSH: 
    - use operadores
    - (EN ESTA PARTE INTRODUCIREMOS LOS DOCUMENTOS YA DECLARADOS ANTERIORMENTE)
    - db.OL.insertMany([OL1, OL2, OL3, OL4])
    - db.OL.find() (PUEDES USAR ESTA LINEA DE CODIGO PARA VERIFICAR QUE SE HAYAN AGREGADO LOS DOCUMENTOS CORRECTAMENTE)
*/

// Puedes usar las siguientes lineas de codigo para ver cada uno de los operadores.
/* MongoSH:
    - AND:
        - db.OL.find(
            {operador: 'AND'}
        )
    - NOT:
        - db.OL.find(
            {operador: 'NOT'}
        )
    - NOR:
        - db.OL.find(
            {operador: 'NOR'}
        )
    - OR:
        - db.OL.find(
            {operador: 'OR'}
        )
*/
