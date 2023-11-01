// This query will retrieve all currently running queries that have execeeded a certain amount of time using the Query_History table function
Select 
    Query_Id,
    Query_Text,
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
    DateDiff(Second, Start_Time, Current_Timestamp) as Total_Elasped_Time_In_Seconds,
    Bytes_Scanned,
    Rows_Produced,
    Compilation_Time,
    Execution_Time,
    Transaction_Blocked_Time
From Table(Snowflake.Information_Schema.Query_History())
Where 
    Execution_Status ilike 'RUNNING' And 
    DateDiff(Second, Start_Time, Current_Timestamp) >= 10;