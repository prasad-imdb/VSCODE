-- Assume role ANALYST
use role ANALYST;
use database DEMO_DB;
use schema PUBLIC;

use role ACCOUNTADMIN;

show views;

select get_ddl('VIEW','SECURE_VW_CUSTOMERS');
select get_ddl('VIEW','VW_CUSTOMERS');

-- Focus on below points
// By running, SHOW VIEWS command, ANALYST role does not have access to SECURE VIEW definition
// Looking at the Query profile, we can clearly observe that SECURE views does not evaluate 
//        the user query before authentication of the role/user
// Functions like GET_DDL does not work on secure views (except view owners)