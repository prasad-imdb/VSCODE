// ListAgg example

Select c.C_Birth_Year, ListAgg(c.C_Last_Name,' | ') Within Group (Order By ss.SS_List_Price Desc) as Last_Name
From Store_Sales ss
    Inner Join Customer c On ss.SS_Customer_SK = c.C_Customer_SK
    Inner Join Item i ON i.I_Item_SK = ss.SS_Item_SK
    Inner Join Date_Dim d On d.D_Date_SK = ss.SS_Sold_Date_Sk
Where i.I_Class = 'sailing' And d.D_Date = '1999-01-06' And ss.SS_List_Price >= 100 And SS_Quantity >= 90 And c.C_BIRTH_YEAR <= 1931
Group By c.C_Birth_Year
Order By c.C_Birth_Year
