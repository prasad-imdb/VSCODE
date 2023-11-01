// This query returns the top 25 longest running queries given a defined time period
Select
    Query_Id,
    Query_Text,
    (Execution_Time / 60000) as Execution_Time_Seconds,
    Database_Name,
    Schema_Name,
    Query_Type,
    Session_Id,
    User_Name,
    Role_Name,
    Warehouse_Name,
    Warehouse_Size,
    Warehouse_Type,
    Cluster_Number,
    Query_Tag,
    Execution_Status,
    Error_Code,
    Error_Message,
    Start_Time,
    End_Time,
    Bytes_Scanned,
    Rows_Produced,
    Compilation_Time,
    Execution_Time,
    Transaction_Blocked_Time
From Snowflake.Account_Usage.Query_History
Where Execution_Status = 'SUCCESS' And Error_Code IS NULL And Start_Time = :daterange
Order By Execution_Time desc
limit 25;