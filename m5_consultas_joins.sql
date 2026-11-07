/*
RetailPro - Modulo 5: Consultas con JOINs
Motor: Microsoft SQL Server
Base: Ventas_Tech_DB
La consulta 4 utiliza dos periodos como origenes simulados; no son canales reales.
*/
USE Ventas_Tech_DB;
GO

-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Proposito: enriquecer cada venta con cliente, producto, categoria y ciudad.
SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;

-- Hallazgo: los 10 registros de ejemplo se enriquecen con cliente, producto,
-- categoria y ciudad. La ciudad permite segmentar el analisis geografico.
GO

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Proposito: detectar clientes registrados sin compras para que CRM los contacte.
SELECT c.nombre, c.email, c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: ninguno de los 5 clientes de ejemplo aparece sin ventas.
-- Para CRM, todos los clientes registrados tienen al menos una compra.
GO

-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Proposito: detectar productos sin movimiento para que Producto revise el catalogo.
SELECT p.nombre_producto, cat.nombre_categoria, p.precio
FROM productos AS p
LEFT JOIN ventas AS v ON p.id_producto = v.id_producto
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;

-- Hallazgo: ninguno de los 6 productos de ejemplo aparece sin ventas.
-- Todo el catalogo tuvo movimiento dentro de los registros disponibles.
GO

-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: comparar la cantidad de ventas y la facturación de dos períodos.

WITH por_canal AS (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Primer período' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Segundo período' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-11' AND '2024-03-15'
)
SELECT
    canal,
    SUM(total) AS total_canal
FROM por_canal
GROUP BY canal;

-- Hallazgo: el primer período (05/03 al 10/03) registró una facturación
-- de $3.620, mientras que el segundo (11/03 al 15/03) alcanzó $2.824.
-- El primer período generó $796 más de facturación que el segundo.

-- Criterio utilizado: se dividieron las ventas en dos períodos de marzo
-- para comparar su facturación. No se utilizó el criterio del ejemplo
-- visto en clase (id_cliente IS NULL / IS NOT NULL), porque en nuestro
-- modelo todas las ventas tienen un cliente asociado. Tampoco contamos
-- con una columna que identifique canales comerciales reales.