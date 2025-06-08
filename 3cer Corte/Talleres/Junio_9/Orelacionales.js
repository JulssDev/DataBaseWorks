// Declaracion de Documentos:
var OR1={
    operador: "EQ",
    descripcion: "Se usa para buscar coincidencias con documentos en los que el valor de un campo es igual a un valor especificado. ",
    estructura: "{ <field>: { $eq: <value> } }",
    ejemplo: "db.inventory.find( { qty: { $eq: 20 } } )"
}

var OR2={
    operador: "GT",
    descripcion: "Se utiliza para seleccionar documentos donde el valor de un campo es mayor que un valor especificado. ",
    estructura: "{ field: { $gt: value } }",
    ejemplo: "db.inventory.find( { quantity: { $gt: 20 } } )"
}

var OR3={
    operador: "GTE",
    descripcion: "Sirve para seleccionar documentos en los que el valor de un campo especificado es mayor o igual que un valor determinado. ",
    estructura: "{ field: { $gte: value } }",
    ejemplo: "db.inventory.find( { quantity: { $gte: 20 } } )"
}

var OR4={
    operador: "IN",
    descripcion: "Se utiliza para seleccionar documentos donde el valor de un campo es igual a cualquiera de los valores especificados en un array. ",
    estructura: "{ field: { $in: [<value1>, <value2>, ... <valueN> ] } }",
    ejemplo: "db.inventory.find( { quantity: { $in: [ 5, 15 ] } }, { _id: 0 } )"
}

var OR5={
    operador: "LT",
    descripcion: "Se utiliza para filtrar documentos en una colección, seleccionando solo aquellos donde el valor de un campo específico es menor que un valor determinado. ",
    estructura: "{ field: { $lt: value } }",
    ejemplo: "db.inventory.find( { quantity: { $lt: 20 } } )"
}

var OR6={
    operador: "LTE",
    descripcion: "Es un operador de comparación que se utiliza para seleccionar documentos donde el valor de un campo es menor o igual que un valor especificado. ",
    estructura: "{ field: { $lte: value } }",
    ejemplo: "db.inventory.find( { quantity: { $lte: 20 } } )"
}

var OR7={
    operador: "NE",
    descripcion: "Se utiliza para seleccionar documentos donde el valor de un campo no es igual a un valor específico. ",
    estructura: "{ field: { $ne: value } }",
    ejemplo: "db.inventory.find( { quantity: { $ne: 20 } } )"
}

var OR8={
    operador: "NIN",
    descripcion: "Se utiliza para seleccionar documentos en los que el valor de un campo no coincide con ninguno de los valores especificados en un array. ",
    estructura: "{ field: { $nin: [ <value1>, <value2> ... <valueN> ] } }",
    ejemplo: "db.inventory.find( { quantity: { $nin: [ 5, 15 ] } }, { _id: 0 } )"
}

// Instrucciones dentro de MongoDB (Seguir linea por linea):
/* MongoSH: 
    - use operadores
    - (EN ESTA PARTE INTRODUCIREMOS LOS DOCUMENTOS YA DECLARADOS ANTERIORMENTE)
    - db.OR.insertMany([OR1, OR2, OR3, OR4, OR5, OR6, OR7, OR8])
    - db.OR.find() (PUEDES USAR ESTA LINEA DE CODIGO PARA VERIFICAR QUE SE HAYAN AGREGADO LOS DOCUMENTOS CORRECTAMENTE)
*/

// Puedes usar las siguientes lineas de codigo para ver cada uno de los operadores.
/* MongoSH:
    - AND:
        - db.OR.find(
            {operador: 'AND'}
        )
    - NOT:
        - db.OR.find(
            {operador: 'NOT'}
        )
    - NOR:
        - db.OR.find(
            {operador: 'NOR'}
        )
    - OR:
        - db.OR.find(
            {operador: 'OR'}
        )
*/