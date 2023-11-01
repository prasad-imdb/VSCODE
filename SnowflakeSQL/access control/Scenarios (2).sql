-- Try to create database using a role and query data.

 -- level-1
 
  use role useradmin;

  grant role myrole to user pradeep; 

  use role securityadmin;

  grant role myrole to user pradeep; 
  
  use role myrole;
  
  --revoke role myrole from user pradeep;
  
-- Level 2  

  use role sysadmin;

  grant usage on warehouse mywarehouse to role myrole;
  
  GRANT OPERATE ON WAREHOUSE mywarehouse TO ROLE myrole;

  use role securityadmin;

  revoke usage on warehouse mywarehouse from role myrole;

  grant usage on warehouse mywarehouse to role myrole;

  use role sysadmin;

  revoke usage on warehouse mywarehouse from role myrole;



    use role myrole;

    SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER";

    show grants to role myrole;


    alter warehouse mywarehouse suspend;

    use role sysadmin;

    GRANT OPERATE ON WAREHOUSE mywarehouse TO ROLE myrole;

    use role myrole;

    alter warehouse mywarehouse suspend;

-- Level - 3

----Let's try to create database

  create or replace database mydb;

  ----- Give grant to create database.
  
  use role securityadmin;

  grant create database on account to role  myrole;
  --revoke create database on account from role myrole;

  use role sysadmin;

  grant create database on account to role  myrole;

  use role myrole;

  create or replace database mydb;


-- Level-4

use role sysadmin;

drop database mydb;

show grants to role sysadmin;

use role myrole;

show grants to role myrole;

drop database mydb;

create or replace database mydb;




grant role myrole to role sysadmin;


-- Level-5

grant create database on account to role  myrole;

use role myrole;

use database mydb;

  create or replace schema myschema;

    create or replace file format myfileformat;

    create or replace table mytable (a varchar , b varchar);

    create or replace stage mystage;

    CREATE OR REPLACE FUNCTION num_test(a double)
    RETURNS string
    LANGUAGE JAVASCRIPT
    AS
    $$
      return A;
    $$
    ;


    CREATE OR REPLACE PROCEDURE f(argument1 VARCHAR)
    RETURNS VARCHAR
    LANGUAGE JAVASCRIPT
    AS
    $$
    var local_variable1 = argument1;  // Incorrect
    var local_variable2 = ARGUMENT1;  // Correct
    $$;
  
  
  use role securityadmin;
  
  create or replace role myrole2;
  
  grant role myrole2 to user pradeep;
  
  use role myrole;
  
  grant usage on database mydb to role myrole2;
  grant usage on schema mydb.myschema to role myrole2;
  grant select on table mydb.myschema.mytable to role myrole2;
  
  use role myrole2;
  
  select * from mytable;
  

-- Managed schema

use role securityadmin;   

create or replace role myrole_ch1;

use role myrole_ch1;

--grant role myrole_ch1 to user pradeep;
--revoke role myrole_ch1 from user pradeep;
grant role myrole_ch1 to role myrole;
revoke role myrole_ch1 from role myrole;

use role sysadmin

alter schema mydb.myschema enable MANAGED ACCESS;

use role securityadmin;
grant  manage grants on account to role  sysadmin;
revoke manage grants on account from role  sysadmin;

use role myrole;

CREATE OR REPLACE SCHEMA MYSCHEMA2 WITH MANAGED ACCESS;

grant usage on database mydb to role myrole_ch1;
grant usage on schema mydb.myschema2 to role myrole_ch1;
grant all privileges on schema myschema2 to role myrole_ch1;



use role myrole_ch1;
use database mydb;
use schema myschema2;

create or replace table emp (a varchar);

drop table emp;

grant select on table mydb.myschema2.emp to role myrole2;

use role myrole;

grant select on table mydb.myschema2.emp to role myrole2;






