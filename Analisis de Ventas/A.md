# 📊 Análisis de Ventas con SQL y Power BI

Este proyecto tiene como objetivo analizar datos de ventas, productos, precios y categorías utilizando **SQL** para la extracción y transformación de datos, y **Power BI** para la visualización interactiva y el análisis de los resultados.

---

## 🧠 Objetivos del Proyecto

- Obtener insights relevantes sobre el comportamiento de ventas.
- Identificar productos más vendidos y menos vendidos.
- Evaluar el impacto del precio en las ventas.
- Analizar el rendimiento por categoría de producto.
- Facilitar la toma de decisiones basada en datos visuales.

---

## 🔧 Herramientas Utilizadas

- **SQL (MySQL / PostgreSQL / SQL Server)**: Para consultas, limpieza y modelado de datos.
- **Power BI**: Para crear dashboards visuales interactivos.
- **Excel / CSV** *(opcional)*: Como fuente de datos o para transformación previa.

---

## 🗃️ Estructura de los Datos

Las principales tablas utilizadas en el análisis son:

- `ventas`: Contiene información de transacciones, fechas y cantidades vendidas.
- `productos`: Detalles del producto como nombre, ID y precio.
- `categorias`: Clasificación de productos.
- `clientes` *(opcional)*: Segmentación por tipo de cliente o región.

---

## 🧾 Consultas SQL Destacadas

Algunas consultas clave incluyen:

- Total de ventas por mes:
  ```sql
  SELECT MONTH(fecha_venta) AS mes, SUM(monto) AS total_ventas
  FROM ventas
  GROUP BY mes
  ORDER BY mes;
