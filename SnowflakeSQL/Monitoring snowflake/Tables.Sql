/*
    The following queries use the Tables view of the Account_Usage schema to generate table information
*/

Select
    Table_Name,                         -- Table name
    Table_Schema,                       -- Table name
    Table_Catalog as Table_Database,    -- Database name
    Table_Owner,                        -- Name of the role (not user) that owns the table
    Table_Type,                         -- The could be base, temporary or a view
    Is_Transient,                       -- Is the table a transient table
    Clustering_Key,                     -- The column(s) or expression(s) that comprise the clustering key
    Row_Count,                          -- Row count
    Bytes,                              -- Byte count of the table
    Retention_Time,                     -- Retention time for time travel
    Created as Created_Timestamp,       -- Created timestamp
    Last_Altered as Modified_Timestamp, -- Last modified timestamp
    Comment,                            -- Column comments
    Deleted as Deleted_Timestamp        -- Deleted timestamp
From Snowflake.Account_Usage.Tables;

// Find all deleted tables
Select 
    Table_Name,                         -- Table name
    Table_Schema,                       -- Table name
    Table_Catalog as Table_Database,    -- Database name
    Table_Owner,                        -- Name of the role (not user) that owns the table
    Table_Type,                         -- The could be base, temporary or a view
    Is_Transient,                       -- Is the table a transient table
    Clustering_Key,                     -- The column(s) or expression(s) that comprise the clustering key
    Row_Count,                          -- Row count
    Bytes,                              -- Byte count of the table
    Retention_Time,                     -- Retention time for time travel
    Date(Created),                      -- Created timestamp
    Date(Last_Altered),                 -- Last modified timestamp
    Comment,                            -- Column comments
    Date(Deleted) as Deleted_Timestamp  -- Deleted timestamp
From Snowflake.Account_Usage.Tables
Where Deleted IS NOT NULL;

// Find the total storage in bytes of all tables (maybe)
Select 
    Table_Catalog as Table_Database,    -- Database name
    Sum(Bytes)                          -- As total storage (?)
From Snowflake.Account_Usage.Tables
Where Deleted IS NOT NULL
Group By Table_Catalog;

// This query uses the Table_Storage_Metrics view to get a more accurate assessment of storage requirements.
Select
    Table_Catalog as Table_Database,
    Table_Schema,
    Table_Name,
    Is_Transient,
    Active_Bytes,               -- Bytes owned by this table that are in the active state for the table
    Time_Travel_Bytes,          -- Bytes owned by this table that are in the Time Travel state for the table.
    Failsafe_Bytes,             -- Bytes owned by this table that are in the Fail-safe state for the table.
    Retained_For_Clone_Bytes,   -- Bytes owned by this table that are retained after deletion because they are referenced by one or more clones of this table.
    Table_Created,
    Table_Dropped
From Snowflake.Account_Usage.Table_Storage_Metrics;

// Another view you can use which displays average daily data storage. This includes data in internal stages.
Select
    Usage_Date,
    Storage_Bytes,      -- Number of bytes of table storage
    Stage_Bytes,        -- Number of bytes of storage used by filed in all internal stages.
    Failsafe_Bytes
From Snowflake.Account_Usage.Storage_Usage
Order By Usage_Date Desc;