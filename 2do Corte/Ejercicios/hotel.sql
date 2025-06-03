Table "HABITACION" {
  "hab_id" SERIAL [pk, increment]
  "hab_numero" VARCHAR [not null, unique]
  "hab_tipo" VARCHAR [not null]
  "hab_precio" NUMERIC [not null]
  "hab_estado" VARCHAR [not null] // disponible, ocupada, mantenimiento
}

Table "HUESPED" {
  "hue_id" SERIAL [pk, increment]
  "hue_nombre" VARCHAR [not null]
  "hue_apellido" VARCHAR [not null]
  "hue_documento" VARCHAR [not null, unique]
  "hue_telefono" VARCHAR
  "hue_email" VARCHAR
}

Table "RESERVA" {
  "res_id" SERIAL [pk, increment]
  "hue_id" INT [not null]
  "hab_id" INT [not null]
  "res_fecha_inicio" DATE [not null]
  "res_fecha_fin" DATE [not null]
  "res_estado" VARCHAR [not null] // confirmada, cancelada, completada
}

Table "PAGO" {
  "pag_id" SERIAL [pk, increment]
  "res_id" INT [not null]
  "pag_fecha" DATE [not null]
  "pag_monto" NUMERIC [not null]
  "pag_metodo" VARCHAR [not null] // efectivo, tarjeta, transferencia
}

// Relaciones
Ref: "RESERVA"."hue_id" > "HUESPED"."hue_id"
Ref: "RESERVA"."hab_id" > "HABITACION"."hab_id"
Ref: "PAGO"."res_id" > "RESERVA"."res_id"