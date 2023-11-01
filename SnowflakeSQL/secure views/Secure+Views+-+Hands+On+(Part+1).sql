-------------------- SECURE VIEWS --------------------
-- When regular/normal view is created, there are chances that users may be able to verify some values in underlying data table

-- Check different values for ORDERPRIORITY column available in Orders table
select top 100 * from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF10"."CUSTOMER";
select distinct C_MKTSEGMENT from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF10"."CUSTOMER";
create or replace table CUSTOMERS as select * from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF10"."CUSTOMER";

select distinct C_MKTSEGMENT from "DEMO_DB"."PUBLIC"."CUSTOMERS";

-- C_MKTSEGMENT
MACHINERY
FURNITURE
HOUSEHOLD
AUTOMOBILE
BUILDING;

-- Create Regular/Normal View using a filter on C_MKTSEGMENT column
create or replace view DEMO_DB.PUBLIC.VW_CUSTOMERS as
select C_NAME, C_ACCTBAL, C_NATIONKEY, C_MKTSEGMENT
from "DEMO_DB"."PUBLIC"."CUSTOMERS"
where C_MKTSEGMENT = 'FURNITURE';

-- Create Secure View
create or replace SECURE view DEMO_DB.PUBLIC.SECURE_VW_CUSTOMERS as
select C_NAME, C_ACCTBAL, C_NATIONKEY, C_MKTSEGMENT
from "DEMO_DB"."PUBLIC"."CUSTOMERS"
where C_MKTSEGMENT = 'FURNITURE';

-- Lets create a custom role 'ANALYST' which should not have access to the underlying data
create or replace role analyst;

-- Grant privileges of database, schema and views to ANALYST role
grant usage on database demo_db to role ANALYST;
grant usage on schema demo_db.public to role ANALYST;
grant select on demo_db.public.VW_CUSTOMERS to role ANALYST;
grant select on demo_db.public.SECURE_VW_CUSTOMERS to role ANALYST;
grant role ANALYST to user kashishgakkar;

-- Also, provide access to a warehouse
grant usage on warehouse compute_wh to role ANALYST;

-- Query on regular view using ACCOUNTADMIN and ANALYST roles - Look at the differences
-- ACCOUNTADMIN is the owner of views
-- ANALYST is the user of views which does not have access to underlying data
select *
from DEMO_DB.PUBLIC.VW_CUSTOMERS
where 1/iff(upper(C_MKTSEGMENT) = 'MACHINERY', 0, 1) = 1;

-- Query on secure view using ANALYST role
select *
from DEMO_DB.PUBLIC.SECURE_VW_CUSTOMERS
where 1/iff(upper(C_MKTSEGMENT) = 'MACHINERY', 0, 1) = 1;