# 🧠 Business Data Analysis con SQL

Este proyecto presenta un análisis de datos empresariales utilizando **SQL** aplicado a diferentes áreas clave del negocio como ventas, productos y clientes. 
El análisis abarca múltiples técnicas avanzadas como **CTEs**, **window functions**, **joins**, **subqueries**, manejo de **datos nulos**, **fechas** y **agrupaciones**, 
permitiendo obtener insights estratégicos.

---
## 📌 Herramientas y técnicas utilizadas

- ✅ Common Table Expressions (CTEs)
- ✅ Window Functions (`ROW_NUMBER()`, `RANK()`, `LEAD()`, `LAG()`, etc.)
- ✅ Subqueries.
- ✅ Joins (LEFT)
- ✅ Funciones de agregación (`SUM()`, `AVG()`, `COUNT()`, etc.)
- ✅ Agrupaciones (`GROUP BY`)
- ✅ Manejo de fechas (`DATE_TRUNC`, `DATEDIFF`, etc.)
- ✅ Manejo de datos nulos (`NULLIF`, `IS NOT NULL`, etc.)

---
## 📈 1. Análisis de cambios a lo largo del tiempo:
- En este primer paso lo que realizamos fue analizar el total de ventas anuales y mensuales ademas de la cantidad de clientes.
## 📊 2. Análisis acumulativo:
-  Lo que hicimos fue calcular el total de ventas por mes.
-  Incremento de ventas a traves de los años
-  Precio promedio por venta
  Tecnicas:'DATE_TRUNC','SUM','AVG'
##🚀 3. Análisis de rendimiento:
- Analizamos el rendimiento Anual de los productos
  Tecnicas: 'SUM','LAG','LEFT JOIN','CASE WHEN'
## 🧩 4. Análisis de parte a todo
- Porcentaje de ventas totales por categoria de producto
## 🧵 5. Segmentación de datos
- Agrupamos los productos por rango de costo y cuantos productos tenemos en cada rango.
- Agrupamos a los clientes en tres categorías según su comportamiento de gasto.
##🧑‍💼 6. Reporte de clientes
Reporte detallado por cliente, incluyendo compras totales, última compra, y promedio por transacción.
##📦 7. Reporte de productos
Análisis de rendimiento de productos: ventas totales, unidades vendidas, rotación, productos más y menos vendidos.



