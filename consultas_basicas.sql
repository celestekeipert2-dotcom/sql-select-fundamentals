
-- ==========================================
-- TechStore - Consultas Básicas SELECT
-- Autor: Celeste Keipert
-- Fecha: 10/10/2026
-- ==========================================

-- Consulta 1: Exploración general de la tabla sales
-- SELECT * permite explorar rápidamente todas las columnas.
-- En producción conviene seleccionar solo las necesarias
-- para mejorar la eficiencia y facilitar el mantenimiento.

SELECT *
FROM sales;


-- Consulta 2: Selección de columnas específicas para finanzas
-- Se seleccionan únicamente los datos solicitados.

SELECT customer_id, product_id, total_amount
FROM sales;


-- Consulta 3: Selección con alias en español para stakeholders
-- Los alias permiten presentar nombres más comprensibles
-- para usuarios que no conocen la estructura técnica.

SELECT
    order_date AS fecha_pedido,
    product_name AS nombre_producto,
    quantity AS cantidad_unidades
FROM sales;
