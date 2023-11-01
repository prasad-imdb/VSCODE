/*
    This query shows a breakdown of the total credits per month by type of credit consumption:

    Warehouses:  Credits used by compute resources
    Pipes:  Credits used by the near real time loading facility, Snowpipe
    View:  Credits used to refresh Materialized Views
    Clustering:  Credits used by the automatic clustering mechanism
    Reader:  Credits used by Reader Accounts which is typically used to share access to data
*/

Select 
    To_Char(Usage_Date,'YYYYMM') As Year_Month, 
    Sum(Decode(Service_Type, 'WAREHOUSE_METERING', Credits_Billed)) as Warehouse_Credits,
    Sum(Decode(Service_Type, 'PIPE', Credits_Billed)) as Pipe_Credits,
    Sum(Decode(Service_Type,'MATERIALIZED_VIEW', Credits_Billed)) as View_Credits,
    Sum(Decode(Service_Type,'AUTO_CLUSTERING', Credits_Billed)) as Clustering_Credits,
    Sum(Decode(Service_Type,'WAREHOUSE_METERING_READER', Credits_Billed)) as Reader_Credits,
    Sum(Credits_Billed) as Total_Billed_Credits
From Snowflake.Account_Usage.Metering_Daily_History
Where Usage_Date = :daterange
Group By To_Char(Usage_Date,'YYYYMM')
Order By 1;

// View all the columns in the view
Select *
From Snowflake.Account_Usage.Metering_Daily_History;

// Credit consumption broken down by hour
Select 
    To_Char(Start_Time,'HH24') As Hour,      
    Sum(Credits_Used)
From Snowflake.Account_Usage.Warehouse_Metering_History
Where Start_Time = :daterange
Group By To_Char(Start_Time,'HH24') 
Order By 1;

// Credits consumed by warehouse
Select 
    Warehouse_Name, 
    Sum(Credits_Used) as Credits_Used
From Snowflake.Account_Usage.Warehouse_Metering_History
Group By Warehouse_Name
Order By 2 desc;
