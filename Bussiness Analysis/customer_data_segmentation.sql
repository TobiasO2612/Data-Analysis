--Agrupa a los clientes en tres categorías según su comportamiento de gasto:
--VIP: al menos 12 meses de historial y gastos superiores a $5000
--Regular: al menos 12 meses de historial pero con gastos de $5000 o menos
--Nuevo: antigüedad menor a 12 meses
-- Y encontrar la cantidad total de clientes de cada grupo

WITH gastos_clientes AS(
SELECT 
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(MONTH,MIN(order_date),Max(order_Date)) AS antigüedad
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key=c.customer_key
GROUP BY c.customer_key
)
SELECT
categoria,
COUNT(customer_key) AS cantidad_clientes
FROM(
SELECT 
customer_key,
CASE WHEN antigüedad>12 AND total_spending>5000 THEN 'VIP'
     WHEN antigüedad>=12 AND total_spending <=5000 THEN 'Regular'
	 ELSE 'Nuevo'
END categoria
FROM gastos_clientes) t
GROUP BY categoria
ORDER BY cantidad_clientes


