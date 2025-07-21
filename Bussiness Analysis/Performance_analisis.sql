--Analizar la performance anual de los prodcutos comparando sus ventas promedios con las ventas en años anteriores
WITH yearly_product_sales AS(
SELECT
YEAR(s.order_date) AS order_year,
SUM(s.sales_amount) AS current_sales,
p.product_name 
FROM gold.dim_products p
LEFT JOIN gold.fact_sales s 
on p.product_key=s.product_key
WHERE s.order_date IS NOT NULL
GROUP BY p.product_name,
YEAR(s.order_date)
)
SELECT
order_year,
product_name,
current_sales,
AVG(current_sales) OVER(PARTITION BY product_name) as avg_sales,
current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name)<0 THEN 'Debajo del promedio'
     WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name)>0 THEN 'Encima del promedio'
	 ELSE 'AVG'
END avg_change,
--Analisis año tras año
LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) as py_sales,
current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS diferencia_py,
CASE WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year)<0 THEN 'Bajaron'
     WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name)>0 THEN 'Subieron'
	 ELSE 'No change'
END py_change
FROM yearly_product_sales
ORDER BY product_name,order_year
