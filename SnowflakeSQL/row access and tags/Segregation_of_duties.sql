use role sysadmin;
drop table claims.pharmacy.patient;

use role securityadmin;
create role etl_dev;
grant role etl_dev to role securityadmin;

use role sysadmin;
grant usage on database claims to role etl_dev;
grant usage on schema pharmacy to role etl_dev;
grant all privileges on schema pharmacy to role etl_dev;
grant all on all tables in schema pharmacy to role etl_dev;
grant usage on warehouse compute_wh to role etl_dev;
grant operate on warehouse compute_wh to role etl_dev;


use role etl_dev;
use database claims;
use schema pharmacy;

create table patient
(
Name varchar,
age integer,
icdcode varchar,
zip_code varchar,
city varchar,
provider_name varchar

)
insert into patient
values('john','12','E910','49715','Michigan','CVS Health Corp'),
('Simon','25','F00','43009','Ohio','McKesson Corp'),
('Mike','58','W13','61727','Illinois','Cigna Corp'),
('Andrew','32','J09','39425','Mississipp','UnitedHealth Group Inc'),
('Brian','40','H03','39425','Mississipp','UnitedHealth Group Inc'),
('David','37','F70','63013','Beaufort','UnitedHealth Group Inc'),
('Dom','23','H60','63013','Beaufort','UnitedHealth Group Inc'),
('Jack','30','H30','46030','Indiana','Cigna Corp'),
('Doli','35','E65','64722','Amoret','Cigna Corp'),
('Padma','50','O81.0','64722','Amoret','Cigna Corp');

use role etl_dev;
grant select on table patient to role uhg;

/****************************************************************************************/
use role sysadmin;
create database Governance;
create schema row_access_policy;

use role securityadmin;
create role policyadmin;

grant role policyadmin to role securityadmin;

use role sysadmin;
grant usage on database governance to role policyadmin;
grant usage on schema row_access_policy to role policyadmin;
grant usage on warehouse compute_wh to role policyadmin;
grant operate on warehouse compute_wh to role policyadmin;
grant all privileges on schema governance.row_access_policy to role policyadmin;
use role etl_dev;
grant all privileges on table claims.pharmacy.patient to role policyadmin;



use role policyadmin;

create or replace row access policy governance.row_access_policy.patient_policy as (icdcode varchar) returns boolean ->
      CASE WHEN 'SYSADMIN'=current_role() THEN TRUE ELSE
                                                    CASE WHEN icdcode='F70' THEN FALSE ELSE TRUE END
                                                    END
;


alter table claims.pharmacy.patient add row access policy governance.row_access_policy.patient_policy on (icdcode);
alter table claims.pharmacy.patient add row access policy governance.row_access_policy.patient_policy on (icdcode,zip_code);
alter table claims.pharmacy.patient drop row access policy governance.row_access_policy.patient_policy;


