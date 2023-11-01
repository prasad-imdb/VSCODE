-- Funture grants on tables...

use role schemaadmin;
use schema staging;
    
    grant select , insert , delete , update , truncate on  FUTURE TABLES in schema salesdb.staging to role stg_rw;
    
    create or replace transient table stg_dpt_tbl (name varchar , dpt_nbr number );
    
use role stg_rw;
drop table stg_dpt_tbl;
select * from stg_dpt_tbl;

use role sysadmin;

  grant select , insert , update on  FUTURE TABLES in schema salesdb.target to role tgt_rw;
  
  
  
-- Grant schema creation permission to schemaadmin role.

use role sysadmin;

create or replace database salesdb;

grant usage on database salesdb to role schemaadmin WITH GRANT OPTION;
GRANT create schema on database salesdb to role schemaadmin;




USE ROLE SYSADMIN;
CREATE DATABASE ADMINTASKS


CREATE OR REPLACE PROCEDURE ADMINTASKS.PUBLIC.CREATE_DB(DATABASE_NAME VARCHAR)
RETURNS string
LANGUAGE JAVASCRIPT
execute as owner
AS
$$
var crtdb = "CREATE OR REPLACE DATABASE "+DATABASE_NAME+";"
var crtstmt = snowflake.createStatement(
          {
          sqlText: crtdb
          }
          );        
var result = crtstmt.execute();

var grtdb = "grant usage on database "+DATABASE_NAME+" to role schemaadmin WITH GRANT OPTION;"
var grtdbstmt = snowflake.createStatement(
          {
          sqlText: grtdb
          }
          );
          
var result1 = grtdbstmt.execute();
return "DATABASE: "+DATABASE_NAME+" SUCCESSFULLY CREATED AND USAGE ASSIGNED TO SCHEMAADMIN ROLE"
$$
;

CALL ADMINTASKS.PUBLIC.CREATE_DB('MKTDB');

grant usage on future databases to role schemaadmin;


