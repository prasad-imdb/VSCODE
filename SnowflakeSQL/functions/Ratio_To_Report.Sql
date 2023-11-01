WITH Source_Data As
(
    Select
        d.D_DOM as Day_Of_Month,
        SUM(SS_Sales_Price) as Daily_Sales_Total
    From Store_Sales ss
        Inner Join Date_Dim d ON d.D_Date_SK = ss.SS_Sold_Date_Sk
    Where d.D_Year = 1999 And d.D_MOY = 4
    Group By d.D_DOM
)

Select
    Day_Of_Month,
    Daily_Sales_Total,
    Ratio_To_Report(Daily_Sales_Total) OVER () * 100.0 as Percent_of_Total
From Source_Data
Order By Day_Of_Month;