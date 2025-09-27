-- Una Vista que muestre todos los clientes Activos
CREATE OR REPLACE VIEW personas_activas AS
SELECT DISTINCT p.*
FROM persona p
INNER JOIN factura f ON f.id_persona = p.id
WHERE f.estado = 'ACTIVA';

-- Una Vista que muestre los resumenes de venta mensualmente. (solo facturas que no fueron anuladas)
CREATE OR REPLACE VIEW resumen_mensual AS
SELECT YEAR(fecha) AS anio, MONTH(fecha) AS mes, SUM(total) AS total_mes
FROM factura
WHERE estado = 'ACTIVA'
GROUP BY YEAR(fecha), MONTH(fecha);

-- Una vista que muestre las localidades solo de argentina
CREATE OR REPLACE VIEW localidades_argentina AS
SELECT l.*
FROM localidad l
INNER JOIN provincia p ON l.id_provincia = p.id
INNER JOIN pais pa ON p.id_pais = pa.id
WHERE pa.nombre = 'Argentina';

-- Una Vista que de los articulos mas vendidos y que genere un nuevo campo con la leyenda "Producto Top" cuando la cantidades vendidas superen a 50 por mes. En caso de ser menor la leyenda debe ser "Producto Standar"
CREATE OR REPLACE VIEW articulos_top AS
SELECT p.nombre, SUM(d.cantidad) AS cantidad_vendida,
IF(SUM(d.cantidad) > 50, 'Producto Top', 'Producto Standar') AS categoria
FROM detalle_factura d
INNER JOIN productos p ON d.id_producto=p.id
INNER JOIN factura f ON f.id=d.id_factura
WHERE f.estado='ACTIVA'
GROUP BY p.nombre, YEAR(f.fecha), MONTH(f.fecha);

-- Una vista que muestre la mayor venta del mes.

CREATE OR REPLACE VIEW venta_del_mes AS
SELECT id, fecha, total
FROM factura
WHERE estado='ACTIVA'
AND MONTH(fecha)=MONTH(NOW())
AND total=(SELECT MAX(total)
FROM factura
WHERE MONTH(fecha)=MONTH(NOW()) AND estado='ACTIVA'
);

-- Una vista que muestre la menor  venta del mes.

CREATE OR REPLACE VIEW menor_venta_del_mes AS
SELECT id, fecha, total
FROM factura
WHERE estado='ACTIVA'
AND MONTH(fecha)=MONTH(NOW())
AND total=(SELECT MIN(total)
FROM factura
WHERE MONTH(fecha)=MONTH(NOW()) AND estado='ACTIVA'
);


