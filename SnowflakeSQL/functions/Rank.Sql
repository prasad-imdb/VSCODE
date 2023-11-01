// Create a query that generates the top 10 brands based on total quantity sold
With Quantity_Ordered As
(
    Select 
        i.I_Brand,
        SUM(ss.SS_Quantity) As Total_Quantity
    From Store_Sales ss
        Inner Join Item i ON SS.SS_Item_Sk = i.I_Item_Sk
    Group By i.I_Brand
),

Ranked As
(
    Select *,
        RANK() OVER (ORDER BY Total_Quantity Desc) as Total_Quantity_Rank
    From Quantity_Ordered    
)

Select *
From Ranked
Where Total_Quantity_Rank <= 10