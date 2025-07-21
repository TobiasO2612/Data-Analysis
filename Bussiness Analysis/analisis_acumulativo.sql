--Calcular total ventas por mes y el total de ventas a traves del tiempo
SELECT 
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS running_total_sales
FROM
(
SELECT 
 DATETRUNC(MONTH,order_date) AS order_date,
 SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
) t

-- En total_sales estamos viendo la cantidad de ventas que tuvimos por cada mes
-- Y en running_total_sales veremos como se van añadiendo las ventas por mes de cada año.
-- Es decir que desde el mes 1 al mes 12 del 2011 veremos las ventas mensuales y ademas las ventas totales durante el año
-- Pero unna vez llegado al año 2012 esto comenzará desde la cantidad de ventas del mes 1 del 2012

--Si buscamos analizar el incremento de las ventas a traves de los años podemos hacerlo de la siguiente manera

SELECT 
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM
(
SELECT 
 DATETRUNC(YEAR,order_date) AS order_date,
 SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
) t

--Si queremos agregar a nuestra tabla cual es el precio promedio de cada venta podemos agregar otra window function con avg

SELECT 
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) as avg_sales_price
FROM
(
SELECT 
 DATETRUNC(YEAR,order_date) AS order_date,
 SUM(sales_amount) as total_sales,
 AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
) t
-- Con esto podemos ver cual es el precio promedio de las ventas que tenemos 