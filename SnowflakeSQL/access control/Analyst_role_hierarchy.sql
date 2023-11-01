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

