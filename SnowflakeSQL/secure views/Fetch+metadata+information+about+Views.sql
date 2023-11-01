-- Check if a existing view is a secure view
select table_catalog, table_schema, table_name, is_secure from demo_db.information_schema.views where table_name like '%ORDERS%';
select * from demo_db.information_schema.views where table_name like '%CUSTOMERS%';

select table_catalog, table_schema, table_name, is_secure from snowflake.account_usage.views where table_name like '%ORDERS%';
select * from snowflake.account_usage.views where table_name like '%ORDERS%';



-- drop materialized and non-materialized views
show views;

drop view VW_ORDERS;
drop materialized view MVW_ORDERS;
drop materialized view MVW_TOP_ORDERS;
drop materialized view MVW_TOP_NEW_ORDERS;
drop materialized view MVW_CLUSTERED_ORDERS;