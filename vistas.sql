-- Una Vista que muestre todos los clientes Activos

CREATE OR REPLACE VIEW clientes_activos AS
SELECT *
FROM cliente
WHERE activo = 1;