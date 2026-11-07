# RetailPro — Pre-entrega 5: Consultas con JOINs

## Título
**Cruzando tablas para enriquecer el análisis**

## Objetivo

En esta entrega se combinan las tablas del proyecto RetailPro para obtener información más completa sobre las ventas. Las consultas permiten relacionar cada operación con sus datos descriptivos, identificar clientes y productos sin ventas y comparar la facturación de dos períodos.

La vista enriquecida de ventas podrá utilizarse como fuente de datos para el dashboard de Power BI que se desarrollará en el Módulo 7.

## Modelo de datos utilizado

Se mantiene el esquema de cuatro tablas desarrollado en el Módulo 3:

- **clientes:** contiene los datos de los clientes, incluyendo nombre, email, ciudad y fecha de registro.
- **productos:** contiene la información de los productos y su categoría.
- **categorias:** contiene la descripción de las categorías de productos.
- **ventas:** registra las operaciones e incluye el cliente, el producto, la cantidad, el precio unitario y la fecha de venta.

Relaciones entre tablas:

- `ventas.id_cliente` referencia `clientes.id_cliente`.
- `ventas.id_producto` referencia `productos.id_producto`.
- `productos.id_categoria` referencia `categorias.id_categoria`.

La columna `ciudad` de la tabla `clientes` aporta una dimensión geográfica que permite agrupar o filtrar los resultados. Por este motivo, no fue necesario agregar una tabla geográfica adicional.

## Consultas desarrolladas

### Consulta 1 — Vista base del proyecto (`INNER JOIN`)

Se relacionan las tablas `ventas`, `clientes`, `productos` y `categorias` mediante `INNER JOIN`.

La consulta devuelve, en una misma fila, la fecha de venta, la identificación y los datos descriptivos del cliente, la ciudad, el producto, su categoría, la cantidad, el precio unitario y el total de la operación.

El total de cada venta se calcula multiplicando:

`cantidad * precio_unitario`

Esta consulta permite contar con una vista enriquecida para posteriores análisis en Power BI.

**Hallazgo:** los 10 registros de ejemplo quedan relacionados con su cliente, producto y categoría. La ciudad del cliente permite incorporar una dimensión geográfica al análisis.

### Consulta 2 — Clientes sin ventas (`LEFT JOIN`)

Se utiliza `LEFT JOIN` entre `clientes` y `ventas` para conservar todos los clientes registrados. La condición `WHERE v.id_venta IS NULL` permite identificar aquellos que no tienen ninguna venta asociada.

La consulta muestra el nombre, email y fecha de registro de los clientes sin compras.

**Hallazgo:** en los datos de ejemplo no aparecen clientes sin ventas. Los 5 clientes registrados tienen al menos una compra, por lo que no se identifican casos para una acción de reactivación por parte del área de CRM.

### Consulta 3 — Productos sin ventas (`LEFT JOIN`)

Se utiliza `LEFT JOIN` entre `productos` y `ventas` para conservar todos los productos del catálogo. Con `WHERE v.id_venta IS NULL` se identifican los productos que no tienen ventas registradas. También se incorpora la tabla `categorias` para mostrar el nombre de la categoría correspondiente.

La consulta devuelve el nombre del producto, su categoría y su precio.

**Hallazgo:** en los datos de ejemplo no aparecen productos sin ventas. Los 6 productos del catálogo registran al menos una venta, por lo que no se identifican artículos sin movimiento para revisar desde el área de Producto.

### Consulta 4 — Consolidado por canal (`UNION ALL`)

Se utiliza una expresión `WITH` para crear una consulta intermedia llamada `por_canal`. Dentro de ella se combinan dos `SELECT` mediante `UNION ALL`. Cada consulta asigna una etiqueta de texto fija a las ventas de uno de los períodos analizados.

Luego, la consulta externa agrupa los registros por `canal` y calcula la facturación total de cada período mediante `SUM(total)`.

**Criterio utilizado:** se dividieron las ventas de marzo de 2024 en dos períodos:

- Primer período: del 5 al 10 de marzo de 2024.
- Segundo período: del 11 al 15 de marzo de 2024.

Las etiquetas se generan dentro de cada `SELECT`, tal como solicita la consigna. No se consulta una columna de canal en las tablas.

**Justificación del criterio:** el ejemplo visto en clase separaba las ventas según si `id_cliente` era `NULL` o `NOT NULL`. En el modelo de RetailPro, las ventas tienen un cliente asociado, por lo que ese criterio no permite formar dos grupos útiles con los datos disponibles. Además, la tabla `ventas` no contiene información sobre canales comerciales reales. La consigna permite utilizar períodos como criterio alternativo; por eso se eligieron dos períodos de marzo y se identificó cada uno con una etiqueta fija.

**Hallazgo:** el primer período (05/03 al 10/03) registró una facturación de **$3.620**, mientras que el segundo período (11/03 al 15/03) alcanzó **$2.824**. El primer período generó **$796 más** de facturación que el segundo. Esta comparación corresponde a períodos temporales y no permite concluir qué canal comercial vende más.

## Herramientas y ejecución

El script está desarrollado para **Microsoft SQL Server** y se ejecuta desde **SQL Server Management Studio (SSMS)**.

Pasos para ejecutarlo:

1. Abrir SQL Server Management Studio.
2. Conectarse al servidor donde se encuentra la base `Ventas_Tech_DB`.
3. Abrir el archivo `m5_consultas_joins.sql`.
4. Ejecutar el script completo con **Execute** o presionando `F5`.
5. Revisar los resultados de cada consulta en la pestaña **Results**.

## Consideraciones

Los hallazgos indicados corresponden a los registros de ejemplo cargados en el Módulo 3. Si se modificaron o agregaron datos, es necesario volver a ejecutar las consultas y actualizar los hallazgos según los resultados obtenidos.

La consulta 4 utiliza `UNION ALL` para conservar todas las filas de ambos conjuntos. Las dos consultas que se combinan devuelven la misma cantidad de columnas, en el mismo orden y con tipos de datos compatibles.