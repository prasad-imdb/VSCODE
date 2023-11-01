WITH Ticket_Paid As
(
    Select 
        SS_Ticket_Number as Ticket_Number,
        SUM(SS_NET_Paid) as Net_Paid
    From Store_Sales ss
        Inner Join Date_Dim d On ss.SS_Sold_Date_Sk = d.D_Date_SK
    Where d.D_Date = '1999-04-12'
    Group By SS_Ticket_Number
)

Select
    Ticket_Number,
    Net_Paid as Current_Paid_Amount,
    LEAD(Net_Paid) OVER (Order By Ticket_Number) as Next_Paid_Amount,
    (Next_Paid_Amount - Net_Paid) as Paid_Difference
From Ticket_Paid;
Order By Ticket_Number;