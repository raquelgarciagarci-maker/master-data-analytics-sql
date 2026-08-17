# master-data-analytics-sql

<img width="1781" height="1264" alt="Esquema_BBDD_Sakila" src="https://github.com/user-attachments/assets/58e7b1a5-f44d-42cd-a150-061e60df301e" />

Ejercicios de SQL sobre la base de datos Sakila - Máster Data Analytics


# Proyecto SQL - Base de Datos Sakila

##  Resumen del proyecto

Este proyecto consiste en la resolución de 63 ejercicios de SQL sobre la base de datos **Sakila**, que simula el funcionamiento de una tienda de alquiler de películas (clientes, actores, películas, categorías, inventario, alquileres y pagos).

El objetivo ha sido practicar y consolidar los conceptos fundamentales de SQL trabajados durante el Máster en Data Analytics de Power Business School, progresando desde consultas básicas de filtrado hasta consultas más avanzadas con múltiples tablas relacionadas, subconsultas y objetos reutilizables como vistas y tablas temporales.

Entre los conceptos aplicados se incluyen:

- Filtros (`WHERE`), ordenación (`ORDER BY`) y funciones de agregación (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `STDDEV`, `VARIANCE`)
- Agrupaciones con `GROUP BY` y `HAVING`
- Los cuatro tipos de `JOIN`: `INNER`, `LEFT`, `FULL` y `CROSS`
- Subconsultas, tanto simples como correlacionadas
- CTEs (`WITH`)
- Creación de vistas (`CREATE VIEW`) y tablas temporales (`CREATE TEMPORARY TABLE`)
- Manejo de tipos de fecha y hora (`timestamp`, `interval`)

Todas las consultas se encuentran en el archivo [`Data_Project_LogicaConsultasSQL.sql`](./Data_Project_LogicaConsultasSQL.sql), donde cada ejercicio incluye el enunciado como comentario y, en los casos donde la solución no era evidente a simple vista (por ejemplo, la elección entre `INNER JOIN` y `LEFT JOIN`, o el uso de una subconsulta), una breve explicación del razonamiento seguido.

##  Herramientas utilizadas

- **PostgreSQL** -  motor de base de datos utilizado para ejecutar las consultas.
- **DBeaver** - cliente SQL gráfico usado para conectar con la base de datos, importar el dump de Sakila y ejecutar y depurar las consultas.
- **Sakila** - base de datos de ejemplo (adaptada a PostgreSQL) sobre la que se han realizado todos los ejercicios.
- **Git / GitHub** - control de versiones y publicación del proyecto.

##  Autora

Raquel García García - [LinkedIn](https://linkedin.com/in/raquel-g-a64784159)
