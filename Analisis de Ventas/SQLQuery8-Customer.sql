SELECT 
  [CustomerKey]
      --,[GeographyKey]
      --,[CustomerAlternateKey]
      --,[Title]

      ,[FirstName] AS [First Name]
      --,[MiddleName]
      ,[LastName] AS [Last Name]

      --,[NameStyle]
      --,[BirthDate]
      --,[MaritalStatus]
      --,[Suffix]

        ,CASE gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender

      --,[EmailAddress]
      --,[YearlyIncome]
      --,[TotalChildren]
      --,[NumberChildrenAtHome]
      --,[EnglishEducation]
      --,[SpanishEducation]
      --,[FrenchEducation]
      --,[EnglishOccupation]
      --,[SpanishOccupation]
      --,[FrenchOccupation]
      --,[HouseOwnerFlag]
      --,[NumberCarsOwned]
      --,[AddressLine1]
      --,[AddressLine2]
      --,[Phone]
      ,[DateFirstPurchase]
      --,[CommuteDistance]
	  ,g.city as [Customer City]

  FROM [AdventureWorksDW2022].[dbo].[DimCustomer]
   LEFT JOIN dbo.DimGeography AS g ON  g.GeographyKey = dbo.DimCustomer.GeographyKey

  
