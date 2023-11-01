// Testing the ILIKE function which is a combination of UPPER and LIKE. 

Create or Replace Table Temp_Table AS
Select 'Hello World' as Some_String
UNION ALL
Select 'hello world' as Some_String
UNION ALL
Select 'HELLO WORLD' as Some_String;

Select * From Temp_Table;

Select * From Lab1.Public.Temp_Table Where Some_String LIKE 'Hello%';

Select * From Lab1.Public.Temp_Table Where Some_String ILIKE 'Hello%';