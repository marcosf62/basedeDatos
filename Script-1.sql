-- Un scipt que inserte un registro en la tabla factura
INSERT INTO ventas (fecha, total, id_persona, id_empleado, estado)
VALUES (NOW(),60, 2, 3, 'ACTIVA' );

-- Un scrpt que obtenga el id Máximo O ultimo de la tabla factura
SELECT @id_max_ventas := MAX(id)FROM ventas ;

-- Un script que inserte registros en la tabla detalle_factura usando el id obtenido en el script anterior.
INSERT INTO detalle_factura (id_ventas, id_producto, cantidad, precio_unitario)
VALUES (@id_max_ventas, 8, 2, 30);

-- Un script que obtenga la suma*producto de las cantidades y precios de los registros insertados en el punto anterior.
SELECT SUM(cantidad * precio_unitario) AS monto_total
FROM detalle_factura
WHERE id_ventas  = @id_max_ventas; 

-- Un script que actualice la tabla factura campo (Total) con el monto obtenido del script anterior
UPDATE ventas v 
SET total = (
    SELECT SUM(cantidad * precio_unitario ) 
    FROM detalle_factura 
    WHERE id_ventas  = @id_max_factura
)
WHERE id = @id_max_factura;
