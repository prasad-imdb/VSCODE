// Capture the list of users in the account using the Users view in Account_Usage
//
// Note: The first time Snowsight is accessed in an account, Snowflake creates an internal WORKSHEETS_APP_USER user to support the 
//       web interface. This user is used to cache query results in an internal stage in your account.
Select 
    Name,
    Created_On,
    Deleted_On,
    Login_Name,
    Display_Name,
    First_Name,
    Last_Name,
    Email,
    Comment,
    Disabled,
    Must_Change_Password,   -- Specifies whether the user is forced to change their password on their next login.
    Snowflake_Lock,         -- Specifies whether a temporary lock has been placed on the user’s account.
    Default_Warehouse,      -- Specifies the virtual warehouse that is active by default for the user’s session upon login.
    Default_Namespace,      -- Specifies the namespace, database and schema, that is active by default for the user’s session upon login
    Default_Role,           -- Specifies the role that is active by default for the user’s session upon login.
    Ext_Authn_Duo,          -- If true the user is using MFA. Cannot be set directly.
    Ext_Authn_uid,          -- MFA user Id
    Last_Success_Login,     
    Expires_At,             -- Date and time the account expires
    Locked_Until_Time,      -- Specifies the number of minutes until the temporary lock on the user login is cleared
    Has_Password,           -- Specifies whether a password was created for the user
    Has_Rsa_Public_Key      -- Specifies whether RSA public key used for key pair authentication has been set up for the user
From Snowflake.Account_Usage.Users;

// List all current (non-deleted) users
Show Users;

// Describe the user and display what all the columns mean
Describe User RandyMinder;

