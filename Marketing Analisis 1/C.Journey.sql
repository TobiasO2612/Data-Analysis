SELECT *
FROM dbo.customer_journey;

WITH duplicaterecords AS (
    SELECT 
	      JourneyID,
		  CustomerID,
		  ProductID,
		  VisitDate,
		  Stage,
		  Action,
		  Duration,
		  ROW_NUMBER() OVER(PARTITION BY CustomerID,ProductID,VisitDate,Stage,Action
		  ORDER BY JourneyID) AS row_num
	
	FROM dbo.customer_journey)

SELECT *
FROM duplicaterecords
WHERE row_num >1
ORDER BY JourneyID;

SELECT 
      JourneyID,
	  CustomerID,
	  ProductID,
	  VisitDate,
	  Stage,
	  Action,
	  COALESCE(Duration,avg_Duration) as Duration
FROM 
    (
	   SELECT
	         JourneyID,
			 CustomerID,
			 ProductID,
			 VisitDate,
			 UPPER(Stage) AS Stage,
			 Action,
			 Duration,
			 AVG(Duration) OVER (Partition by visitdate) as avg_Duration,

			 ROW_NUMBER() OVER( PARTITION BY CustomerID,ProductID,VisitDate,UPPER(Stage),Action 
					  ORDER BY JourneyID) AS row_num
		FROM dbo.customer_journey) AS subquery

WHERE row_num=1 ;


	      
		  

