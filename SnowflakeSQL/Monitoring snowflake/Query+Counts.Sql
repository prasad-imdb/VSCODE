// This query generates total number of queries per month
Select 
    CONCAT(CAST(Date_Part(Year, Start_Time) as String), '-', LPAD(CAST(Date_Part(MONTH, Start_Time) as String),2,'0')) as Period,
    Count(*) as Number_Of_Queries
From Snowflake.Account_Usage.Query_History
Where Start_Time = :daterange
Group By Date_Part(Year, Start_Time), Date_Part(MONTH, Start_Time)
Order By Period;

// This query generates total number of queries per week
Select 
    CONCAT(CAST(Date_Part(Year, Start_Time) as String), '-', LPAD(CAST(Date_Part(WEEK, Start_Time) as String),2,'0')) as Period,
    Count(*) as Number_Of_Queries
From Snowflake.Account_Usage.Query_History
Where Start_Time = :daterange
Group By Date_Part(Year, Start_Time), Date_Part(WEEK, Start_Time)
Order By Period;

// Average query execution time per month
Select 
    CONCAT(CAST(Date_Part(Year, Start_Time) as String), '-', LPAD(CAST(Date_Part(MONTH, Start_Time) as String),2,'0')) as Period,
    Count(*) as Query_Count,
    AVG(Execution_Time) / 60000 as Average_Execution_Time_Seconds,
    SUM(Execution_Time) / 60000 as Sum_Execution_Time_Seconds
From Snowflake.Account_Usage.Query_History
Where Start_Time = :daterange
Group By Date_Part(Year, Start_Time), Date_Part(MONTH, Start_Time)
Order By Period;

// Calculate number of unique users issuing queries for a time period
Select 
    CONCAT(CAST(Date_Part(Year, Start_Time) as String), '-', LPAD(CAST(Date_Part(MONTH, Start_Time) as String),2,'0')) as Period,
    Count(Distinct(User_Name)) as Unique_Users
From Snowflake.Account_Usage.Query_History
Where Start_Time = :daterange
Group By Date_Part(Year, Start_Time), Date_Part(MONTH, Start_Time)
Order By Period;