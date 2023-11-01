// The Warehouse_Load_History view can be used to analyze the workload on your warehouses within a specified date range.
// Note: Load history is shown in 5-minute intervals.

// Retrieve information about the workload on each warehouse. 
Select 
    Start_Time,
    End_Time,
    Warehouse_Name,
    Avg_Running,        -- Average number of queries executed      
    Avg_Queued_Load,    -- Average number of queries queued because warehouse was overloaded
    Avg_Blocked         -- Average number of queries blcoked by a transaction lock
From Snowflake.Account_Usage.Warehouse_Load_History
Where Start_Time = :daterange
Order By Warehouse_Name, Start_Time Desc;