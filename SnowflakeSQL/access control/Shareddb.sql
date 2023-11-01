--Other schema objects

use role sysadmin;

create or replace database shareddb;

grant usage on database shareddb to role schemaadmin WITH GRANT OPTION;
GRANT create schema on database shareddb to role schemaadmin;


-- create schema using schemaadmin.

use role schemaadmin;

use database shareddb;

create or replace transient schema fileformat with managed access;
create or replace schema functions  with managed access;
create or replace transient schema procedures with managed access;
create or replace transient schema stages with managed access;

-- Create required child roles under schemaadmin.

use role securityadmin;

create or replace role format_r;
grant role format_r to role schemaadmin;

create or replace role func_r;
grant role func_r to role schemaadmin;

create or replace role proc_r;
grant role proc_r to role schemaadmin;

create or replace role stages_r;
grant role stages_r to role schemaadmin;


--
use role schemaadmin;

grant usage on database shareddb to role func_r;
grant usage on schema shareddb.functions to role func_r;

grant usage on database shareddb to role proc_r;
grant usage on schema shareddb.procedures to role proc_r;

grant usage on database shareddb to role format_r;
grant usage on schema shareddb.fileformat to role format_r;

grant usage on database shareddb to role stages_r;
grant usage on schema shareddb.stages to role stages_r;


grant role func_r to role developer;
grant role proc_r to role developer;
grant role format_r to role developer;
grant role stages_r to role developer;


use role developer;
