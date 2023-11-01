// Queries that required scanning more than 90% of total partitions

Select 
    Query_Text,
    Database_Name,
    Schema_Name,
    User_Name,
    Partitions_Scanned,
    Partitions_Total
From Snowflake.Account_Usage.Query_History
Where 
    Partitions_Scanned >= Partitions_Total And Partitions_Total > 0
Order By Partitions_Total Desc;

// Repeat Queries

Select
    Query_Text,
    (Sum(Execution_Time) / 60000) as Total_Execution_Time_In_Seconds,
    Count(*) as Execution_Count
From Snowflake.Account_Usage.Query_History
Where Execution_Status = 'SUCCESS' And Start_Time = :daterange
Group By Query_Text
Having Count(*) > 1
Order By Total_Execution_Time_In_Seconds Desc;