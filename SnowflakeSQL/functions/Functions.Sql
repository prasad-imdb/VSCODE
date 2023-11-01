// Retrieve all functions in the database
SELECT *
FROM information_schema.functions
ORDER BY function_schema,function_name;