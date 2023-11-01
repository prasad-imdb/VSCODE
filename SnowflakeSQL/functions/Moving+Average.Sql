With Sales AS
(
  Select 
      d.D_DOM as Day_Of_Month,
      SUM(ss.SS_Sales_Price) as Total_Daily_Sales
  From Store_Sales ss
      Inner Join Date_Dim d ON D.D_Date_Sk = ss.SS_Sold_Date_Sk
  Where d.D_Year = 1999 And d.D_MOY = 4
  Group By d.D_DOM    
)

Select 
    Day_Of_Month,
    Total_Daily_Sales,
    Avg(Total_Daily_Sales) OVER (Order By Day_Of_Month rows between 3 preceding and current row) as Moving_Average
From Sales
Order By Day_Of_Month