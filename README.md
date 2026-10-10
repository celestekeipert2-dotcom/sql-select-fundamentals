
# TechStore - Consultas básicas SELECT

## Objetivo

Este repositorio contiene tres consultas SQL para explorar la tabla `sales`, seleccionar columnas específicas y presentar los datos con nombres comprensibles para el equipo de finanzas.

## 1. ¿Por qué es una mala práctica usar SELECT * en producción?

El uso de `SELECT *` puede generar varios problemas:

- **Rendimiento:** solicita todas las columnas, incluso aquellas que no se necesitan. Esto puede aumentar la cantidad de datos transferidos y los recursos utilizados.
- **Mantenibilidad:** si la estructura de la tabla cambia, la consulta puede devolver columnas adicionales o resultados inesperados.
- **Seguridad:** puede exponer información que el usuario de la consulta no necesita consultar.

Por ejemplo, si finanzas solo necesita el identificador del cliente, el producto y el importe, es preferible escribir:

```sql
SELECT customer_id, product_id, total_amount
FROM sales;
```

Así, la consulta devuelve únicamente la información requerida.

## 2. ¿Por qué son importantes los alias para un stakeholder no técnico?

Los alias permiten reemplazar los nombres técnicos de las columnas por etiquetas más fáciles de interpretar. Esto facilita la lectura de reportes y la comunicación entre el equipo de datos y las áreas de negocio.

Por ejemplo:

```sql
SELECT total_amount AS monto_total
FROM sales;
```

En el resultado, la columna aparecerá como `monto_total` en lugar de `total_amount`. De esta manera, una persona del área de finanzas puede comprender más fácilmente qué representa el dato, sin necesidad de conocer los nombres originales de la base de datos.

## Contenido del repositorio

- `consultas_basicas.sql`: contiene las tres consultas SQL del ejercicio.
- `README.md`: documenta el objetivo y las decisiones tomadas.
