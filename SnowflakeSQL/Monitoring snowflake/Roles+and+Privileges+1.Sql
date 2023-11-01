// Use a Common Table Expression to generate a list of all privileges granted to roles and then all roles granted
// to users.

// We have dealt with the Grants_To_Roles view already
With All_Roles_And_Privileges AS
(
  Select 
    Created_On,                 -- When was the role + privilege created?
    Modified_On,                -- When was the role + privilege last modifed?
    Privilege,                  -- What is the privilege?
    Granted_On,                 -- What object was the role + privilege granted on?
    Table_Catalog,              -- Associated database name
    Table_Schema,               -- Associated schema name
    Granted_To,                 -- What was the role + privilege granted to
    Grantee_Name as Role_Name,  -- What role was the role + privilege granted to
    Deleted_On                  -- When was this row deleted?
  From Snowflake.Account_Usage.Grants_To_Roles
),

// Here we are using the Grants_To_Users view. Note that the Snowflake documentation says this view shows
// all privileges granted to a user. This is not quite right. This displays all roles granted to users.
Roles_Assigned_To_Users AS
(
    Select
        Created_On,                 -- When was the role assigned to the user?
        Deleted_On,                 -- When was this role deleted?
        Role as Role_Name,          -- Role name
        Granted_To,                 -- What was the role assigned to?
        Grantee_Name as User_Name,  -- Name of user the role was assigned to
        Granted_By                  -- Which role granted this?
    From Snowflake.Account_Usage.Grants_To_Users
)

Select t.*, t2.User_Name
From All_Roles_And_Privileges t
    Left Join Roles_Assigned_To_Users t2 On t.Role_Name = t2.Role_Name
Where t.Deleted_On IS NULL And t2.Deleted_On IS NULL;