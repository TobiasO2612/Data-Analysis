/*
=====================================================
Reporte Cliente
=====================================================
Propósito:
     -Este informe consolida métricas clave y comportamientos de los clientes.

Aspectos Destacados:
       1.Reúne campos esenciales como nombres, edades y detalles de transacciones.
       2.Segmenta a los clientes en categorías (VIP, Regular, Nuevo) y por grupos de edad.
       3.Agrega métricas a nivel cliente:
            Total de pedidos
            Total de ventas
            Cantidad total comprada
            Total de productos
            Antigüedad (en meses)
       4.Calcula indicadores clave (KPIs):
           Recencia (meses desde el último pedido)
           Valor promedio por orden
           Gasto mensual promedio
*/
CREATE VIEW gold.customer_report AS
WITH base_query AS(
--1) 
SELECT
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ',c.last_name) AS customer_name,
DATEDIFF(YEAR,c.birthdate,GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key=f.customer_key
WHERE order_date IS NOT NULL)

,customer_aggregations AS(
--2)Agregaciones por cliente: resume las métricas clave a nivel de cliente.
SELECT
customer_key,
customer_number,
customer_name,
age,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT order_number) as total_orders,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT product_key) AS total_products,
MAX(order_date) AS last_order_date,
DATEDIFF(MONTH,MIN(order_date),MAX(order_Date)) AS antiguedad
FROM base_query
GROUP BY 
       customer_key,
       customer_number,
       customer_name,
	   age
)
SELECT 
customer_key,
customer_number,
customer_name,
age,
antiguedad,
CASE WHEN age <20 THEN 'menos de 20'
     WHEN age BETWEEN 20 AND 50 THEN '20-50'
	 ELSE 'Arriba de 50'
END rango_edad,
CASE WHEN antiguedad>12 AND total_sales>5000 THEN 'VIP'
     WHEN antiguedad>=12 AND total_sales <=5000 THEN 'Regular'
	 ELSE 'Nuevo'
END categoria,
last_order_date,
DATEDIFF(MONTH,last_order_date,GETDATE()) AS recency,
total_sales,
total_orders,
--Valor promedio por orden
CASE WHEN total_orders=0 THEN 0
     ELSE total_sales/total_orders
END AS avg_order_values,
--Promedio mesual gastado
CASE WHEN antiguedad=0 THEN total_sales
     ELSE total_sales/antiguedad
END as avg_monthly_spend,
total_products,
total_quantity
FROM customer_aggregations
