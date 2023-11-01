With CTE
As
(
  -- Anchor member
  Select 
    Grantee_Name as User_Name, 
    Role as Role_Name,
    '' as Privilege
  From Snowflake.Account_Usage.Grants_To_Users 
  Where Deleted_On is null
  
  Union All
  
  -- Recursive member
  Select 
    CTE.User_Name, 
    G.Name as Role_Name,
    G.Privilege
  From CTE
    Join Snowflake.Account_Usage.Grants_To_Roles G On CTE.Role_Name = G.Grantee_Name
  Where 
    G.Privilege = 'USAGE'
    And G.Granted_To = 'ROLE'
    And G.Granted_On = 'ROLE'
    And G.Deleted_On IS NULL
)

Select Distinct 
    User_Name, 
    Role_Name,
    Privilege
From CTE
Order By User_Name, Role_Name;