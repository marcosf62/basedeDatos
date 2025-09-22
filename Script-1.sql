-- Un scipt que inserte un registro en la tabla factura
INSERT INTO ventas (fecha, total, id_persona, id_empleado, estado)
VALUES (NOW(),60, 2, 3, 'ACTIVA' );

-- Un scrpt que obtenga el id Máximo O ultimo de la tabla factura
SELECT @id_max_ventas := MAX(id)FROM ventas ;

-- Un script que inserte registros en la tabla detalle_factura usando el id obtenido en el script anterior.
INSERT INTO detalle_factura (id_venta, id_producto, cantidad, precio)
VALUES
(@id_max_ventas, 1, 2, 150.00);