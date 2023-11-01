// Note: This function does not work on shared objects
//
// You can use this function on:
// Databases, Schemas, Tables, External Tables, Views, Streams, Tasks, Sequences, File Formats
// Pipes, UDFs, Stored Procedures and Policies
//
// External tables are not supported

Select GET_DDL('table', 'Sales');

Select GET_DDL('database', 'Udemy')

/* The full Syntax looks like this. Note that you can have the function use fully qualified names.

GET_DDL( '<object_type>' , '[<namespace>.]<object_name>' [ , <use_fully_qualified_names_for_recreated_objects> ] )

*/