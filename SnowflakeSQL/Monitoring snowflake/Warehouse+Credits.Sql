// The Warehouse_Metering_History view is used to return the hourly credit usage for on or more warehouses in your account, for a specified date range.

Select 
    Start_Time,                                             -- Beginning of the hour in which the warehouse usage took place
    End_Time,                                               -- End of the hour in which the warehouse usage took place
    Warehouse_Name,                                         -- Warehouse name
    Credits_Used as Credits_Billed,                         -- Credits billed for the hour
    Credits_Used_Compute as Credits_Used,                   -- Credits used for the hour
    Credits_Used_Cloud_Services as Credits_Cloud_Services   -- Cloud service credits consumed for the hour
From Snowflake.Account_Usage.Warehouse_Metering_History
Order By Start_Time;


// Monthly credits used by warehouse
Select 
    Concat(Cast(Date_Part(Year, Start_Time) as String), '-', LPad(CAST(Date_Part(Month, Start_Time) as String),2,'0')) as Period,
    Warehouse_Name,
    Sum(Credits_Used) as Monthly_Credits_Billed,
    Sum(Credits_Used_Compute) as Monthly_Credits_Used_Compute
From Snowflake.Account_Usage.Warehouse_Metering_History
Where Start_Time = :daterange
Group By 
    Date_Part(Year, Start_Time), 
    Date_Part(Month, Start_Time), 
    Warehouse_Name
Order By 
    Period, 
    Monthly_Credits_Billed Desc;



// Warehouse credits used compared to average
Select
    Warehouse_Name,
    Date(Start_Time) as Date,
    Sum(Credits_Used) as Current_Credits_Billed,
    Avg(Sum(Credits_Used)) Over (Partition BY Warehouse_Name Order By DATE Rows 7 Preceding) AS Credits_Used_Average,
    (To_Numeric(Sum(Credits_Used)/Credits_Used_Average*100,10,2)-100)::Number AS Variance_To_Average    
From Snowflake.Account_Usage.Warehouse_Metering_History
Where Start_Time = :daterange And Warehouse_Name <> 'CLOUD_SERVICES_ONLY'
Group By
    Date,
    Warehouse_Name
Order By 
    Warehouse_Name,
    Variance_To_Average Desc;