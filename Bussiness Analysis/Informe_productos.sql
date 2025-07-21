/*
====================================================================================
Informe de Productos
====================================================================================
Propósito:
1).Reúne campos esenciales como nombre del producto, categoría, subcategoría y costo.
2).Segmenta los productos según los ingresos para identificar productos de alto rendimiento, rango medio o bajo rendimiento.
3).Agrega métricas a nivel de producto:
   Total de pedidos
   Total de ventas
   Cantidad vendida
   Total de clientes (únicos)
   Ciclo de vida del producto (en meses)

4).Calcula KPIs valiosos:
   Recencia (meses desde la última venta)
   Ingresos promedio por pedido (AOR - Average Order Revenue)
   Ingresos mensuales promedio*/

CREATE VIEW reporte_producto AS
   WITH cte AS(
   SELECT 
   s.order_number,
   s.order_date,
   s.customer_key,
   s.sales_amount,
   s.quantity,
   p.product_key,
   p.product_name,
   p.category,
   p.subcategory,
   p.cost
   FROM gold.fact_sales s
   LEFT JOIN gold.dim_products p ON
   p.product_key=s.product_key
   WHERE order_date IS NOT NULL)--Consideramos unicamente fechas validas

   --2)Agregación de productos: resume los principales KPIs a nivel de producto
,product_aggregations AS(
   SELECT 
   product_key,
   product_name,
   category,
   subcategory,
   cost,
   DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS antiguedad,
   MAX(order_date) AS ultima_venta,
   COUNT(DISTINCT order_number) AS total_ordenes,
   COUNT(DISTINCT customer_key) AS total_clientes,
   SUM (sales_amount) AS total_ventas,
   SUM(quantity) AS cantidad_total,
   ROUND(AVG(CAST(sales_amount AS FLOAT)/NULLIF(quantity,0)),1) AS precio_promedio_venta
   FROM cte

   GROUP BY 
     product_key,
	 product_name,
	 category,
	 subcategory,
	 cost)

  --3) Combinamos todos los resultados y agregamos nuestros KPis
   SELECT
     product_key,
	 product_name,
	 category,
	 subcategory,
	 cost,
	 ultima_venta,
	 DATEDIFF(MONTH,ultima_venta,GETDATE()) AS meses_ultima_venta,
	 CASE 
	     WHEN total_ventas > 50000 THEN 'Alto rendimiento'
		 WHEN total_ventas >=10000 THEN 'Medio rendimiento'
		 ELSE 'Bajo rendimiento'
	 END rendimiento_producto,
	 antiguedad,
	 total_ordenes,
	 total_ventas,
	 cantidad_total,
	 total_clientes,
	 precio_promedio_venta,
	 --Ingreso promedio
	 CASE
	     WHEN total_ventas=0 THEN 0
		 ELSE total_ventas/total_ordenes
	END AS ingreso_promedio_producto,

	--Ingreso promedio mensual
	CASE 
	    WHEN antiguedad=0 THEN total_ventas
		ELSE total_ventas/antiguedad
	END AS ingreso_promedio_mensual

   FROM product_aggregations
   

 