---------------USERS and ROLE Creation----------------------
create or replace role HUMAN_RESOURCE;
create or replace role TECHNOLOGY;
create or replace role MARKETING;

create or replace user john password = 'temp123' default_Role = 'HUMAN_RESOURCE';
grant role HUMAN_RESOURCE to user john;

create or replace user bill password = 'temp123' default_Role = 'MARKETING';
grant role MARKETING to user bill;

create or replace user tony password = 'temp123' default_Role = 'TECHNOLOGY';
grant role MARKETING to user tony;

----------------------------------DB and TABLE Creation-----------------

create or replace table DB.TEST.employees(employee_id number,
                     empl_join_date date,
                     dept varchar(10),
                     salary number,
                     manager_id number);
                     
insert into employees values(1,'2014-10-01','HR',40000,4),
                                 (2,'2014-09-01','Tech',50000,9),
                                 (3,'2018-09-01','Marketing',30000,5),
                                 (4,'2017-09-01','HR',10000,5),
                                 (5,'2019-09-01','HR',35000,9),
                                 (6,'2015-09-01','Tech',90000,4),
                                 (7,'2016-09-01','Marketing',20000,1);

create or replace table managers(manager_id number, 
                                                manager_role_name varchar,
                                                manager_role_alias varchar);
                      
insert into managers values(1,'MARKETING','MARKETING'),
                            (4,'TECHNOLOGY','TECH'),
                            (4,'HUMAN_RESOURCE','HR'),
                            (5,'MARKETING','MARKETING'),
                            (5,'HUMAN_RESOURCE','HR'),
                            (9,'TECHNOLOGY','TECH'),
                            (9,'HUMAN_RESOURCE','HR');


SELECT * FROM DB.TEST.EMPLOYEES;
SELECT * FROM DB.TEST.MANAGERS;
                            
grant usage on warehouse compute_Wh to role HUMAN_RESOURCE;
grant usage on warehouse compute_Wh to role TECHNOLOGY;
grant usage on warehouse compute_Wh to role MARKETING;

grant usage on database DB to role HUMAN_RESOURCE;
grant usage on database DB to role TECHNOLOGY;
grant usage on database DB to role MARKETING;

grant usage on schema TEST to role HUMAN_RESOURCE;
grant usage on schema TEST to role TECHNOLOGY;
grant usage on schema TEST to role MARKETING;

-------------------------------CREATE A VIEW ------------------------------------------------
select current_role();

create or replace secure view vw_employee as
select e.*
from "EMPLOYEES" e
where upper(e.DEPT) in (select upper(manager_role_alias)
               from "MANAGERS" m
               where upper(manager_role_name) = upper(current_role()));
               

              
grant select on view "VW_EMPLOYEE" to role HUMAN_RESOURCE;
grant select on view "VW_EMPLOYEE" to role TECHNOLOGY;
grant select on view "VW_EMPLOYEE" to role MARKETING;

---------------------------------------------------------------
use role marketing;
use database DB;
use schema TEST;

select * from VW_EMPLOYEE;

-- Verify the rows for HUMAN_RESOURCE role
use role HUMAN_RESOURCE;

use database DB;
use schema TEST;

select * from VW_EMPLOYEE;

-- Verify the rows for TECHNOLOGY role
use role TECHNOLOGY;

use database DB;
use schema TEST;

select * from VW_EMPLOYEE;