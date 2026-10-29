# RetailPro - Módulo 4: Consultas SQL de negocio

## Objetivo

Este archivo contiene cuatro consultas SQL sobre `Ventas\_Tech\_DB` para obtener métricas comerciales a partir de la tabla `ventas`.

## Descripción de las consultas

1. **Resumen ejecutivo mensual:** agrupa por año y mes y calcula facturación (`SUM`), cantidad de registros de venta (`COUNT`) y ticket promedio (`AVG`).
2. **Ranking de productos:** agrupa por `id\_producto`, suma unidades y facturación, ordena de mayor a menor y muestra los cinco primeros mediante `TOP 5`.
3. **Clientes recurrentes:** agrupa por `id\_cliente`, calcula la cantidad de registros de venta y el total gastado, y usa `HAVING COUNT(\*) > 1` para conservar clientes con más de un registro.
4. **Comparación mensual:** usa una CTE llamada `ventas\_mensuales` para calcular la facturación mensual y `CASE WHEN` para compararla con el promedio mensual general.

## Cálculo de facturación

En las consultas, el importe facturado se calcula como `cantidad \* precio\_unitario`. `SUM` suma esos importes según el mes, producto o cliente.

## Hallazgos y limitaciones

Los hallazgos comentados al final del SQL corresponden a los 10 registros de ejemplo del Módulo 3. Si los datos se modificaron, hay que ejecutar nuevamente las consultas y actualizar los hallazgos.

Los registros de ejemplo corresponden solo a marzo de 2024. Por eso, la consulta 4 devuelve un solo mes y todavía no permite comparar meses entre sí. Para analizar variaciones mensuales se necesitan ventas de varios meses.

