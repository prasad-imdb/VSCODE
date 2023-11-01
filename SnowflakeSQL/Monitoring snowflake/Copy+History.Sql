/*
    This view can be used to query Snowflake data loading history for the last 365 days. The view displays load activity for both COPY INTO <table> 
    statements and continuous data loading using Snowpipe. This view is different than the Load_History view in that it avoids the 10,000 row limitation 
    of the Load_History.
*/

Select
    File_Name,                                      -- Name of the source file
    Stage_Location,                                 -- Name of the stage where the source file is located
    Row_Count,                                      -- Number of rows loaded from the source
    Row_Parsed,                                     -- Number of rows parsed from the source file. This could be NULL for an in progress transfer.
    Pipe_Catalog_Name as Pipe_Database_Name,        -- Database name containing the pipe
    Pipe_Schema_Name,                               -- Schema name containing the pipe
    Pipe_Name,                                      -- Name of the pipe
    Pipe_Received_Time,                             -- Date and time when the Insert request for the file loaded through the pipe was received
    Table_Catalog_Name as Target_Database_Name,     -- Target database name
    Table_Schema_Name as Target_Schema_Name,        -- Target schema name
    Table_Name as Target_Table_Name,                -- Target table name
    Last_Load_Time                                  -- UTC Date and time of the load record. For bulk data loads, this is the time when the file started loading. 
                                                    -- For Snowpipe, this is the time when the file finished loading.
    Error_Count,                                    -- Number of error rows in the source file
    Error_Limit,                                    -- The limit that, when reached, the process is aborted
    First_Error_Message,                            -- First error in the source file
    First_Error_Line_Number,                        -- Line number of the first error
    First_Error_Character_Pos,                      -- Position of the first error character
    First_Error_Column_Name,                        -- Column name of the first error
    Status                                          -- This could be Loaded, Load Failed or Partially Loaded
From Snowflake.Account_Usage.Copy_History
Where LEN(Pipe_Name) > 0;