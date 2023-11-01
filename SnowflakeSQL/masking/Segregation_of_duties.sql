/*** create role and user ********************/
/**** execute using security admin role ******/

//create role sandbox;
create role analyst;
create role contractor;
create role QA;

create user Mike password='abc123' default_role = analyst must_change_password = false;
create user john password='abc123' default_role = contractor must_change_password = false;
create user veer password='abc123' default_role = QA must_change_password = false;

create database PROD;
create schema trails;

grant usage on database prod to role security_officer;
grant usage on schema prod.trails to role security_officer;

grant usage on database prod to role analyst;
grant usage on schema prod.trails to role analyst;

grant usage on database prod to role contractor;
grant usage on schema prod.trails to role contractor;

grant usage on database prod to role QA;
grant usage on schema prod.trails to role QA;

grant select on all tables in schema mydb.myschema to role analyst;

grant all privileges on database prod to role security_officer;

grant select on all tables in schema prod.trails to role analyst;
grant select on all tables in schema prod.trails to role contractor;
grant select on all tables in schema prod.trails to role QA;

grant select on all tables in schema prod.trails to role security_officer;

grant role analyst to user mike;
grant role contractor to user veer;
grant role QA to user john;

Grant usage on warehouse compute_wh to role analyst
Grant usage on warehouse compute_wh to role contractor
Grant usage on warehouse compute_wh to role QA



create table PATIENT ( Patient_name varchar, dob date , Diagnosis varchar , Adr_line_1 varchar , Adr_line_2 varchar 
                     
                       ,city varchar , zip number, state varchar, pos number , service_start_date date
                      
                       ,service_end_date date ,provider_name varchar )
                       

select * from patient