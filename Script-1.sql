-- Un scipt que inserte un registro en la tabla factura
INSERT INTO factura (fecha, total, id_persona, id_empleado, estado) 
VALUES (NOW(), 0, 3, 4, 'ACTIVA');

-- Un scrpt que obtenga el id Máximo O ultimo de la tabla factura
SELECT @id_max_factura := MAX(id)FROM factura;

-- Un script que inserte registros en la tabla detalle_factura usando el id obtenido en el script anterior.
INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario)
VALUES 
(@id_max_factura, 8, 2, 30),
(@id_max_factura, 10, 2, 18);;

-- Un script que obtenga la suma*producto de las cantidades y precios de los registros insertados en el punto anterior.
SELECT SUM(cantidad * precio_unitario ) AS total_factura
FROM detalle_factura
WHERE id_factura  = @id_max_factura;

-- Un script que actualice la tabla factura campo (Total) con el monto obtenido del script anterior
UPDATE factura
SET total = (
    SELECT SUM(cantidad * precio_unitario)
    FROM detalle_factura
    WHERE id_factura = @id_max_factura
)
WHERE id = @id_max_factura;

-- Un script con el resultado de lo vendido  por cada articulo de las facturas que no esten anuladas.
SELECT 
    p.nombre AS articulo,
    SUM(d.cantidad * d.precio_unitario) AS total_vendido
FROM 
    detalle_factura d
INNER JOIN 
    productos p ON d.id_producto = p.id
INNER JOIN 
    factura f ON d.id_factura = f.id
WHERE 
    f.estado = 'ACTIVA'
GROUP BY 
    p.nombre
ORDER BY 
    total_vendido DESC;	
