-- Window Functions

-- Show each sales average for Group, Country, and Region all in one query
SELECT DISTINCT		
		t."SalesTerritoryGroup"
	,	t."SalesTerritoryCountry"
	,	t."SalesTerritoryRegion"
	,	AVG(s."SalesAmount") OVER(PARTITION BY t."SalesTerritoryGroup" ) as "GroupAvgSales"	
	,	AVG(s."SalesAmount") OVER(PARTITION BY t."SalesTerritoryCountry") as "CountryAvgSales"
	,	AVG(s."SalesAmount") OVER(PARTITION BY t."SalesTerritoryRegion" ) as "RegionAvgSales"	
	
FROM "FactInternetSales" s
JOIN "DimSalesTerritory" t ON
	s."SalesTerritoryKey" = t."SalesTerritoryKey"	
WHERE
		YEAR(s."OrderDate") = 2010
ORDER BY
		1,2,3