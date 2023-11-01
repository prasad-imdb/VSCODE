// Determine a login failure rate for each user who has logged into the account
// The Login_History table function can be used to query login attempts by Snowflake users

Select
    Event_Timestamp,                -- Time of the login
    Event_Id,                       -- Unique Id of the login
    Event_Type,                     -- This will usually always be "LOGIN"
    User_Name,                      -- User attempting the login
    Client_Ip,                      -- IP address of the login attempt
    Reported_Client_Type,           -- Type of client software attempting the login such as JDBC_Driver, ODBC_Driver etc.
    Reported_Client_Version,        -- Version of the client software
    First_Authentication_Factor,    -- Method used to authenticate the user
    Second_Authentication_Factor,   -- The second factor, if using multi factor authentication
    Is_Success,                     -- Indicates the status of the login attempt
    Error_Code,                     -- Error code in the event of an unsuccessful login attempt
    Error_Message                   -- Error message in the event of an unsuccessful login attempt    
From Snowflake.Account_Usage.Login_History;

// Determine all unique error messages
Select 
    Error_Message, 
    Count(*) as Error_Count
From Snowflake.Account_Usage.Login_History
Where Is_Success ilike 'No'
Group By Error_Message;

// Determine failure login rate
Select
    User_Name,
    Sum(Iff(Is_Success = 'NO', 1, 0)) as Failed_Count,
    Count(*) as Login_Count,
    Failed_Count / Login_Count as login_failure_rate
From Snowflake.Account_Usage.Login_History
Where
    Event_Timestamp = :daterange
Group By 1
Order By 4 Desc;