// Average query execution time by role

Select
    Role_Name,
    Avg(Execution_Time) / 1000 as Average_Execution_Time,
    Count(*) as Query_Count
From Snowflake.Account_Usage.Query_History
Where Start_Time = :daterange
Group By Role_Name
Order By Role_Name, Average_Execution_Time Desc; 