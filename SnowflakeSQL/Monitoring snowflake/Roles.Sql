// Generate a list of active Roles
Select
    Created_On,
    Name as Role_Name,
    Comment
From Snowflake.Account_Usage.Roles
Where DELETED_ON IS NULL

// Generate a list of deleted Roles
Select
    Created_On,
    Deleted_On,
    Name as Role_Name,
    Comment
From Snowflake.Account_Usage.Roles
Where DELETED_ON IS NOT NULL