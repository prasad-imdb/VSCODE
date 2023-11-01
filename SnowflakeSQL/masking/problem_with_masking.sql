create or replace masking policy diagnosis_code_mask_by_date as (val varchar,service_date date) returns string ->
  case when current_role() in ('ANALYST','CONTRACTOR') then 
        case when val in ('G9382','O312','O3120','O3120X1','7681','39791') then  NULL
         else
            case when val in ('S55091D', 'S82421H', 'S37828D', 'J239', 'R019') then substring(val,1,3)
             else
                case when val in ('Y09', 'Y09', 'V3101', 'V3101', '79913', 'Y389X1A', 'E9688') then '00'
                 else
                   val
                    end
               end
           end      
    else
      val
     
  end;