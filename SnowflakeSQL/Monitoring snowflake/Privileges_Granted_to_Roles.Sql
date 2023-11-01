// The Grants_To_Roles view can be used to query access control privileges that have been granted to a
// role.
//
// Complete list of privileges: https://docs.snowflake.com/en/user-guide/security-access-control-privileges.html

Select 
    Created_On,
    Modified_On,
    Privilege,              -- The type of privilege assigned to the role
    Granted_On,             -- The scope (object) of the privilege
    Name as Object_Name,    -- Object name
    Table_Catalog,          -- Database name
    Table_Schema,           -- Schema name
    Granted_To,             -- This will always be 'ROLE' in this view
    Grantee_Name,           -- The name of the role to which the privilege was granted
    Grant_Option,           -- If this is true, the role can grant the privilege to other roles
    Granted_By              -- The name of the role that granted the privilege
From Snowflake.Account_Usage.Grants_To_Roles
Where Deleted_On IS NULL And Created_On = :daterange