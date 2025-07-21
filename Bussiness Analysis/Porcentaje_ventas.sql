--Porcentaje de ventas totales por categoria. 
WITH ventas AS(
SELECT
category,
SUM(sales_amount) AS total_sales_category
FROM gold.dim_products p
LEFT JOIN gold.fact_sales s ON
p.product_key=s.product_key
WHERE category IS NOT NULL
AND sales_amount IS NOT NULL
GROUP BY category
)
SELECT 
category,
total_sales_category,
SUM(total_sales_category) OVER() ventas_totales,
CONCAT(ROUND(CAST(total_sales_category AS FLOAT)/SUM(total_sales_category) OVER()*100,2),'%') AS porcentaje_ventas
FROM ventas
ORDER BY total_sales_category DESC

