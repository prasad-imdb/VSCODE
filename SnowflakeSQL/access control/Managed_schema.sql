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
