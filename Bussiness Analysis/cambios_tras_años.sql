--Veamos el total de ventas por año y la cantidad de clientes
SELECT 
YEAR(order_date)AS year_order,
SUM (sales_amount)AS total_ventas,
COUNT(DISTINCT customer_key) as cantidad_clientes
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

-- Ahora veamos cual es el mes que tiene menos ventas de cada año
SELECT 
YEAR(order_date)AS year_order,
MONTH(order_date) AS month_order,
SUM (sales_amount)AS total_ventas,
COUNT(DISTINCT customer_key) as cantidad_clientes
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY YEAR(order_date),MONTH(order_date)
