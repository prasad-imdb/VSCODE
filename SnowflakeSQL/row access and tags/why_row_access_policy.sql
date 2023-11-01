/************* Why row access policy *******************/
Use role sysadmin;
use database claims;
use schema pharmacy;

create or replace secure view patient_vw
as
select * from patient 
where 'SYSADMIN'=current_role() or 1= case when icdcode='F70' then 0 else 1 end 

grant select on patient_vw to role UHG

--- View is a object by itself. You have to manage access to it separately.
--- Rule is not tied to table. Hence sensitive data can be exposed.
--- As rules becomes complex , view logic will be complex.

use role UHG;
use database claims;
use schema pharmacy;

select * from patient;


