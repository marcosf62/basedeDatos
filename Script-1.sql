-- Un scipt que inserte un registro en la tabla factura
INSERT INTO detalle_factura (id_ventas, id_producto, cantidad, precio_unitario)
VALUES (6, 4, 8, 450.75)

-- Un scrpt que obtenga el id Máximo O ultimo de la tabla factura
SELECT @id := MAX(id)FROM detalle_factura df ;