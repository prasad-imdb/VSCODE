// Retrieve users who never logged in
SHOW USERS;

SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))
WHERE "last_success_login" IS NULL
AND DATEDIFF('Day',"created_on",CURRENT_DATE) > 60;

// Retrieve 'stale' users. These would be users who have not logged in within some
// threshold period of days
SHOW USERS;

SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))
WHERE DATEDIFF('Day',"last_success_login",CURRENT_DATE) > 60;
