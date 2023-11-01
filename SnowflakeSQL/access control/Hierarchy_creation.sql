-- Form the hierarchy

use role securityadmin;

create or replace role schemaadmin;

grant role schemaadmin to role sysadmin;

//create or replace role managegrants;
//
//grant role managegrants to role sysadmin;
//
//drop role managegrants

--grant manage grants on database salesdb to role  managegrants;

-- Grant schema creation permission to schemaadmin role.

use role sysadmin;

create or replace database salesdb;

grant usage on database salesdb to role schemaadmin WITH GRANT OPTION;
GRANT create schema on database salesdb to role schemaadmin;



-- create schema using schemaadmin.

use role schemaadmin;

use database salesdb;

create or replace transient schema staging with managed access;

create or replace schema target  with managed access;

create or replace transient schema sandbox with managed access;


-- Create required child roles under schemaadmin.

use role securityadmin;

create or replace role stg_rw;

grant role stg_rw to role schemaadmin;

create or replace role tgt_rw;

grant role tgt_rw to role schemaadmin;

create or replace role sandbox_rwx;

grant role sandbox_rwx to role schemaadmin;

grant 

--
use role schemaadmin;

grant usage on database salesdb to role stg_rw;

grant usage on schema salesdb.staging to role stg_rw;

grant usage on database salesdb to role tgt_rw;

grant usage on schema salesdb.target to role tgt_rw;

grant usage on database salesdb to role sandbox_rwx;

grant usage on schema salesdb.target to role sandbox_rwx;



--grant usage,operate on warehouse mywarehouse to role schemaadmin;

-- create tables in staging.

use role schemaadmin;
use schema staging;

  create or replace transient table stg_emp_tbl (name varchar , age number );

  grant select , insert , delete , update , truncate on table stg_emp_tbl to role stg_rw ;

  use role stg_rw;
  use schema staging;
  
  select * from stg_emp_tbl;

  drop table stg_emp_tbl;
  
  

-- Create tables in tgt

use role schemaadmin;
use schema target;

  
  create or replace transient table tgt_emp_tbl (name varchar , age number );
  
  grant select , insert , update on  table tgt_emp_tbl  to role tgt_rw;
  
use role tgt_rw;


-- Grant all privileges on sandbox

use role schemaadmin;
use schema sandbox;
grant all privileges on schema sandbox to role sandbox_rwx;


-- create developer role.

use role securityadmin;

create or replace role developer;

grant role stg_rw to role developer;
grant role tgt_rw to role developer;
grant role sandbox_rwx to role developer;

grant role developer to role sysadmin;

grant usage on warehouse mywarehouse to role developer;

grant role developer to user pradeep;

use role developer;
use schema staging;

create table test_tbl (a varchar);

use schema target;

create table tgt_test_tbl(a varchar);

use schema sandbox;

create table dev_tbl (a varchar);

-- Create analyst role


use role securityadmin;

create role stg_r;
create role tgt_r;
create role analyst;

grant role stg_r to role schemaadmin;

grant role tgt_r to role schemaadmin;

grant role analyst to role sysadmin;

use role sysadmin;
grant usage  on database salesdb to role stg_r;
grant usage  on schema staging to role stg_r;
grant select on all tables in schema salesdb.staging to role stg_r;

grant usage  on database salesdb to role tgt_r;
grant usage  on schema target to role tgt_r;
grant select on all tables in schema salesdb.target to role tgt_r;


grant role stg_r to role analyst;
grant role tgt_r to role analyst;

use role analyst;

SELECT * FROM "SALESDB"."STAGING"."STG_EMP_TBL";

