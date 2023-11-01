/*
    This view, Data_Transfer_History is used to query the history of data transferred from Snowflake tables into a different cloud storage provider’s network.
    For example, from Snowflake on AWS to Google Cloud Platform and/or a different geographical region. The function returns the history 
    for the entire Snowflake account.
*/    

Select 
    Start_Time,         -- Start time of the transfer
    End_Time,           -- End time of the transfer
    Source_Cloud,       -- Cloud provider where the data transfer originated. This could be AWS, Google Cloud Platform or Microsoft Azure
    Source_Region,      -- Region where the data transfer originated
    Target_Cloud,       -- Cloud provider where the data transfer ended. This could be AWS, Google Cloud Platform or Microsoft Azure
    Target_Region,      -- Region where the data transfer ended
    Bytes_Transferred,  -- Number of bytes transferred during the start and end time
    Transfer_Type       -- The type of transfer, which can be Copy, Replication, External_Function
From Snowflake.Account_Usage.Data_Transfer_History
Where Start_Time = :daterange
Order By Start_Time Desc