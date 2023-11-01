/*
    This view displays a row for each database defined in your account.
*/

Select 
    Database_Name,
    Database_Owner,
    Is_Transient,
    Created,
    Last_Altered,
    Deleted,
    Retention_Time  -- For time travel
From Snowflake.Account_Usage.Databases;