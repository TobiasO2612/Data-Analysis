SELECT*
FROM dbo.engagement_data;

SELECT 
       EngagementID,
	   ContentID,
	   CampaignID,
	   ProductID,
	   UPPER(REPLACE(ContentType,'SocialMedia','Social Media')) as ContentType,-- Remplazamos SocialMedia por 'SOCIAL MEDIA'
	   LEFT(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined)-1) AS Views, -- Separamos las views de la tabla viewsclickcombined
	   RIGHT(ViewsClicksCombined,LEN(ViewsClicksCombined)- CHARINDEX('-',ViewsClicksCombined))AS Clicks,-- separamos los clicks de la tabla viewsclickcombined
	   Likes,
	   FORMAT(CONVERT(DATE,EngagementDate),'dd.MM.yyyy') AS EngamentDate -- Cambiamos el formato de fecha



FROM dbo.engagement_data
 WHERE 
      ContentType != 'newsletter'
