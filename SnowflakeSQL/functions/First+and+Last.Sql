// Determine the first and last ticket number of each day in April, 1999, for each item brand

Select Distinct
    d.D_Date,
    i.I_Brand,
    FIRST_VALUE(ss.SS_Ticket_Number) OVER (Partition By d.D_Date, i.I_Brand Order By ss.SS_Ticket_Number) as First_Ticket_Number,
    LAST_VALUE(ss.SS_Ticket_Number) OVER (Partition By d.D_Date, i.I_Brand Order By ss.SS_Ticket_Number) as Last_Ticket_Number
From Store_Sales ss
    Inner Join Date_Dim d On d.D_Date_Sk = ss.SS_Sold_Date_Sk
    Inner Join Item i on i.I_Item_Sk = ss.SS_Item_Sk
Where d.D_Year = 1999 And d.D_MOY = 4
Order By d.D_Date, i.I_Brand;

/*
FIRST_VALUE( <expr> ) [ { IGNORE | RESPECT } NULLS ]
                      OVER ( [ PARTITION BY <expr1> ] ORDER BY <expr2>  [ { ASC | DESC } ] [ <window_frame> ] )
*/                      