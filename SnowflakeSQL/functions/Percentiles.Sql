// A simple example
Create or Replace Table Percentile(group_col int, value decimal(10,2));
Insert Into Percentile (group_col, value) values
    (0,  0),
    (0, 10),
    (0, 20),
    (0, 30),
    (0, 40),
    (1, 10),
    (1, 20),
    (2, 10),
    (2, 20),
    (2, 25),
    (2, 30),
    (3, 60);

Select group_col, percentile_cont(0.25) within group (Order By value) 
From Percentile 
Group By group_col
Order By group_col;


// A little more realistic example. For each category what sales value represents the 95th percentile
// of sales
With Sales As
(
  Select 
      i.I_Category as Category,
      d.D_Date as Date_Of_Sale,
      SUM(ss.SS_Sales_Price) as Total_Daily_Sales
  From Store_Sales ss
      Inner Join Date_Dim d ON D.D_Date_Sk = ss.SS_Sold_Date_Sk
      Inner Join Item i on i.I_ITEM_SK = ss.SS_Item_SK
  Where d.D_Year = 1999
  Group By d.D_Date, i.I_Category
)

// A similar query with quite different results
Select Distinct
    Category,
    percentile_cont(.95) within group (order By Total_Daily_Sales) over (Partition By Category) as p95
From Sales
Order By Category;

// The same example using percentile_disc (discrete)
With Sales As
(
  Select 
      i.I_Category as Category,
      d.D_Date as Date_Of_Sale,
      SUM(ss.SS_Sales_Price) as Total_Daily_Sales
  From Store_Sales ss
      Inner Join Date_Dim d ON D.D_Date_Sk = ss.SS_Sold_Date_Sk
      Inner Join Item i on i.I_ITEM_SK = ss.SS_Item_SK
  Where d.D_Year = 1999
  Group By d.D_Date, i.I_Category
)

// A similar query with quite different results
Select Distinct
    Category,
    percentile_disc(.95) within group (order By Total_Daily_Sales) over (Partition By Category) as p95
From Sales
Order By Category;

