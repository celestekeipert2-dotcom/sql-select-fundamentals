/*
Proyecto: RetailPro
Entrega: Módulo 4 - Consultas SQL de negocio
Motor: Microsoft SQL Server
Base de datos: Ventas_Tech_DB
*/

USE Ventas_Tech_DB;
GO

-- CONSULTA 1: Resumen ejecutivo mensual
SELECT
    YEAR(fecha_venta) AS anio,
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;
GO

-- CONSULTA 2: Ranking de los 5 productos con mayor facturación
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
GO

-- CONSULTA 3: Clientes recurrentes
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC, total_gastado DESC;
GO

-- CONSULTA 4: Facturación mensual comparada con el promedio mensual general
-- La CTE calcula primero la facturación de cada mes.
-- Luego CASE WHEN compara cada mes con el promedio de esos meses.
WITH ventas_mensuales AS (
    SELECT
        YEAR(fecha_venta) AS anio,
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS facturacion
    FROM ventas
    GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
)
SELECT
    anio,
    mes,
    facturacion,
    CASE
        WHEN facturacion >= (
            SELECT AVG(facturacion)
            FROM ventas_mensuales
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS evaluacion_promedio
FROM ventas_mensuales
ORDER BY anio, mes;
GO

-- HALLAZGOS INICIALES
-- Estos hallazgos corresponden a los 10 registros de ejemplo del Módulo 3.
-- Si los datos cambiaron, volver a ejecutar las consultas y actualizarlos.
-- 1. La facturación total de los 10 registros es $6.444.
-- 2. El producto id_producto 1 genera $3.600 de facturación con 3 unidades.
-- 3. Los 5 clientes tienen 2 registros de venta cada uno en los datos de ejemplo.
--
-- Nota: todos los registros de ejemplo son de marzo de 2024. Por eso la
-- consulta 4 devuelve un solo mes y no permite comparar tendencias mensuales.
-- Para un análisis mensual útil se necesitan ventas de varios meses.