GRANT SELECT ON SCHEMA AM90005814 TO _SYS_REPO WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE, DROP, ALTER, CREATE ANY, INDEX ON SCHEMA SUPPORTTOOLS_RT TO _SYS_REPO WITH GRANT OPTION;





select * from T where contains(column1, 'dog OR cat', EXACT)
select * from T where contains(column1, 'catz', FUZZY(0.8))
select * from T where contains(column1, 'catz', LINGUISTIC)
select * from T where CONTAINS( (column1,column2,column3), 'cats OR dogz', FUZZY(0.7))
select * from T where CONTAINS( (column1,column2,column3), 'cats OR dogz', FUZZY(0.7))


**AUTO GANERATED COLUMNS
ALTER table "MORE2"."fact_table" ADD (DATE_ORDER DATE GENERATED ALWAYS AS (TO_DATE('2015-03-21','YYYY-MM-DD')));



****SEQUENCE******
DIMSALESPEOPLE Columnname SUPPORT (ROW Table)

CREATE SEQUENCE MORE2.SEQ1 START WITH 1
create column store table DIMSALESPEOPLECOLUMN (column table)

INSERT INTO "MORE2"."DIMSALESPEOPLECOLUMN"
SELECT "MORE2"."SEQ1".NEXTVAL,"MORE2"."DIMSALESPEOPLE".SUPPORT FROM "MORE2"."DIMSALESPEOPLE"


**********************Delete duplicate rows**************************
CREATE COLUMN TABLE "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT1" 
LIKE "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT"; 

SELECT DISTINCT *
FROM "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT"

INTO "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT1";

 

DELETE FROM "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT";

INSERT INTO "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT" 
SELECT * FROM "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT1";

DROP TABLE "SM_ZTABL"."ASRH.db::ERROR_TC_SCM_INVENTORYCOUNT1";

*********************************************************

-- inner join
-- returns results only where the join condition is true
set schema "PRASADKUMAR_BODDU";
select s.*,p.* 
from "FactInternetSales" s
inner join "DimProduct" p on s."ProductKey" = p."ProductKey"

-- left join
-- returns all rows from sales, regardless of the join condition
select distinct *
from "FactInternetSales" s
left join "DimProduct" p on s."ProductKey" = p."ProductKey"
order by 1

-- add filter conditions to join
select *
from "FactInternetSales" s
inner join "DimProduct" p 
	on	s."ProductKey" = p."ProductKey"
	and	p."StartDate" > '2013-01-01'

Running Total/Rolling Sum

SELECT   "SalesOrderNumber"
         ,"OrderDate"
         ,"SalesAmount"
         ,SUM("SalesAmount") OVER(PARTITION BY "OrderDate" ORDER BY "SalesOrderNumber") "RunningTotal"
from "PRASADKUMAR_BODDU"."FactInternetSales" T1
ORDER BY "SalesOrderNumber"
         ,"SalesAmount"
-----------------------------------------------------------------

-- basic filter with WHERE
-- get sales of a specific product only
SELECT *
FROM "FactInternetSales" s
INNER JOIN "DimProduct" p ON s."ProductKey" = p."ProductKey"
WHERE p."EnglishProductName" = 'Road-650 Black, 62'


-- non-equi-filters
-- get all orders for 2013
SELECT s."ProductKey",p."ProductKey"
FROM "FactInternetSales" s
INNER JOIN "DimProduct" p ON substr(to_nvarchar(s."ProductKey"),2,2) = p."ProductKey"
WHERE	s."OrderDate" >= '2013-01-01'
AND		s."OrderDate" <= '2013-12-31'

-- also can use "between" for dates
SELECT *
FROM "FactInternetSales" s
INNER JOIN "DimProduct" p ON s."ProductKey"= p."ProductKey"
WHERE s."OrderDate" BETWEEN '2013-01-01' AND '2013-12-31';

-- filter for multiple values using IN
SELECT *
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE p.EnglishProductName in( 
		'Mountain-400-W Silver, 38',
		'Mountain-400-W Silver, 40',
		'Mountain-400-W Silver, 42',
		'Mountain-400-W Silver, 46')


-- find all current and future matches with LIKE
SELECT *
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE p.EnglishProductName LIKE 'Mountain%' --put % where you want wildcard

---------------------------------------------------------------------

SET SCHEMA "PRASADKUMAR_BODDU";

select "OrderDate", sum("SalesAmount")
from "FactInternetSales"
group by "OrderDate"
order by "OrderDate"

-- simple aggregations
-- Use additional aggregations to understand more about product sales such as distribution of sales etc..
SELECT 
		cat."EnglishProductCategoryName" "Category"
    ,	sub."EnglishProductSubcategoryName" "SubCategory"
	,	count(*) "Count" -- How many sales where there?
	,	sum(s."SalesAmount") "Sales" -- How much sales did we have?
    ,	avg(s."SalesAmount") "Avg_SalesAmount" -- What was the Avg sale amount?
    ,	min(s."SalesAmount") "Min_SaleAmount" -- What was the Min sale amount?
    ,	max(s."SalesAmount") "Max_SaleAmount" -- What was the Max sale amount
FROM "FactInternetSales" s
LEFT JOIN "DimProduct" p ON s."ProductKey" = p."ProductKey"
LEFT JOIN "DimProductSubcategory" sub ON p."ProductSubcategoryKey" = sub."ProductSubcategoryKey"
LEFT JOIN "DimProductCategory" cat ON sub."ProductCategoryKey" = cat."ProductCategoryKey"
-- must use group by in order for aggregation to work properly
GROUP BY
		cat."EnglishProductCategoryName" -- column aliases aren't allowed
    ,	sub."EnglishProductSubcategoryName"
ORDER BY
		cat."EnglishProductCategoryName"
	,	sub."EnglishProductSubcategoryName"

-- filter to 2013 with WHERE
SELECT 
		YEAR(s.OrderDate) 'Year'
	,	cat.EnglishProductCategoryName 'Category'
    ,	sub.EnglishProductSubcategoryName 'SubCategory'	
	,	count(1) 'Count' -- use 1 instead of a field for faster performance
	,	sum(s.SalesAmount) 'Sales'
    ,	avg(s.SalesAmount) 'Avg_Quantity'
    ,	min(s.SalesAmount) 'Min_SaleAmount'
    ,	max(s.SalesAmount) 'Max_SaleAmount'

FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
INNER JOIN DimProductSubcategory sub ON p.ProductSubcategoryKey = sub.ProductSubcategoryKey
INNER JOIN DimProductCategory cat ON sub.ProductCategoryKey = cat.ProductCategoryKey
-- filter
WHERE YEAR(s.OrderDate) = 2013 --use date function to parse year
-- must use group by in order for aggregation to work properly
GROUP BY
		YEAR(s.OrderDate)
	,	cat.EnglishProductCategoryName -- column aliases aren't allowed
    ,	sub.EnglishProductSubcategoryName
ORDER BY
		cat.EnglishProductCategoryName
	,	sub.EnglishProductSubcategoryName

-- Only show products in 2013 that sold more than $1M USD
SELECT 
		cat.EnglishProductCategoryName 'Category'
    ,	sub.EnglishProductSubcategoryName 'SubCategory'	
	,	count(1) 'Count' -- use 1 instead of a field for faster performance
	,	sum(s.SalesAmount) 'Sales'
    ,	avg(s.SalesAmount) 'Avg_Quantity'
    ,	min(s.SalesAmount) 'Min_SaleAmount'
    ,	max(s.SalesAmount) 'Max_SaleAmount'
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
INNER JOIN DimProductSubcategory sub ON p.ProductSubcategoryKey = sub.ProductSubcategoryKey
INNER JOIN DimProductCategory cat ON sub.ProductCategoryKey = cat.ProductCategoryKey
-- filter
WHERE YEAR(s.OrderDate) = 2013 --use date function to parse year
-- must use group by in order for aggregation to work properly
GROUP BY
		cat.EnglishProductCategoryName -- column aliases aren't allowed
    ,	sub.EnglishProductSubcategoryName	
-- use HAVING to filter after the aggregate is computed
HAVING
		sum(s.SalesAmount) > 1000000
ORDER BY
		cat.EnglishProductCategoryName
	,	sub.EnglishProductSubcategoryName

-------------------------------------------------------------

-- Employee Table
select *
from "PRASADKUMAR_BODDU"."DimEmployee"

-- Analyzing Employee Data
-- How many active employees did we have on Nov 13th, 2013?
SELECT COUNT(*)
FROM "PRASADKUMAR_BODDU"."DimEmployee" emp
WHERE "StartDate" <= '2013-01-01'
AND	(
		"EndDate" > '2013-01-01'
	OR
		"EndDate" IS NULL
	)

-- start with dates table
select top 100 *
from "PRASADKUMAR_BODDU"."DimDate"


