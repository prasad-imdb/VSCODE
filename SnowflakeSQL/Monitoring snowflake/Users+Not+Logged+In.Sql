// Retrieve users who never logged in
Show Users;

// Return all users who have not logged in after 60 days of account creation
// We are using what is called a table literal. These appear in the From clause of a query
// and return a set of 0 or more rows. 
// We're also using a function named Result_Scan which returns the result set of a previous command as if the
// result was a table.This is normally used with Show or Describe commands.
Select * 
From Table(Result_Scan(Last_Query_Id()))
Where "last_success_login" IS NULL
And DateDiff('Day',"created_on",Current_Date) > 60;

// Retrieve 'stale' users. These would be users who have not logged in within some
// threshold period of days
Show Users;

Select * 
From Table(Result_Scan(Last_Query_Id()))
Where DateDiff('Day',"last_success_login",Current_Date) > 60;
