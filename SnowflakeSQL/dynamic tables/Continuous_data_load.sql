-- Create integration object

create or replace storage integration Snowflake_Obj
type = external_stage
storage_provider = s3
enabled = true
storage_aws_role_arn = 'arn:aws:iam::917077600714:role/snowflake'
storage_allowed_locations = ('s3://snowpipe-demo2/');

desc integration Snowflake_Obj;

-- Create file format
  
create or replace file format csv_file_format
type = csv field_delimiter = ',' skip_header = 1 null_if = ('NULL', 'null') empty_field_as_null = true; 
  
-- Create stage

create or replace stage snow_stage
storage_integration = Snowflake_Obj
url = 's3://snowpipe-demo2/'
file_format = csv_file_format;

-- Create snowflake table

create or replace transient table parking  -- NJ_parking --LC_parking --NY_parking
(
Summons_Number	 Number	,
Plate_ID	Varchar	,
Registration_State	 Varchar	,
Plate_Type	 Varchar	,
Issue_Date	DATE	,
Violation_Code	 Number	,
Vehicle_Body_Type	 Varchar	,
Vehicle_Make	 Varchar	,
Issuing_Agency	 Varchar	,
Street_Code1	 Number	,
Street_Code2	 Number	,
Street_Code3	 Number	,
Vehicle_Expiration_Date	 Number	,
Violation_Location	 Varchar	,
Violation_Precinct	 Number	,
Issuer_Precinct	 Number	,
Issuer_Code	 Number	,
Issuer_Command	 Varchar	,
Issuer_Squad	 Varchar	,
Violation_Time	 Varchar	,
Time_First_Observed	 Varchar	,
Violation_County	 Varchar	,
Violation_In_Front_Of_Or_Opposite	 Varchar	,
House_Number	 Varchar	,
Street_Name	 Varchar	,
Intersecting_Street	 Varchar	,
Date_First_Observed	 Number	,
Law_Section	 Number	,
Sub_Division	 Varchar	,
Violation_Legal_Code	 Varchar	,
Days_Parking_In_Effect	 Varchar	,
From_Hours_In_Effect	 Varchar	,
To_Hours_In_Effect	 Varchar	,
Vehicle_Color	 Varchar	,
Unregistered_Vehicle	 Varchar	,
Vehicle_Year	 Number	,
Meter_Number	 Varchar	,
Feet_From_Curb	 Number	,
Violation_Post_Code	 Varchar	,
Violation_Description	 Varchar	,
No_Standing_or_Stopping_Violation	 Varchar	,
Hydrant_Violation	 Varchar	,
Double_Parking_Violation	 Varchar ,
Latitude  Varchar,
Longitude Varchar,
Community_Board  Varchar,
Community_Council  Varchar, 
Census_Tract  Varchar,
BIN  Varchar,
BBL  Varchar,
NTA  Varchar

);

-- Create snowflake tables to load data for LC and NJ cities.

create or replace transient table LC_parking_t like PARKING;

create or replace transient table NJ_parking_t like PARKING;


-- Create snowpipe to continuously load data.
  
create or replace pipe demo_db.public.snowpipe auto_ingest=true as
    copy into demo_db.public.parking
    from @demo_db.public.snow_stage/parking_data/
    ON_ERROR='CONTINUE'
    file_format = (type = 'csv',error_on_column_count_mismatch=false);
       
show pipes; 
show tasks;

/*select SYSTEM$PIPE_STATUS('snowpipe')

select * from table(validate_pipe_load(
  pipe_name=>'DEMO_DB.PUBLIC.snowpipe',
  start_time=>dateadd(hour, -4, current_timestamp())));
  
select * from table(validate_pipe_load(
  pipe_name=>'DEMO_DB.PUBLIC.snowpipe'));
  
select * from table(validate_pipe_load(
  pipe_name=>'demo_db.PUBLIC.snowpipe',
  start_time=to_date(current_timestamp())))*/
  

alter pipe SNOWPIPE refresh;


-- Create stream object to capture changes in NY table. 
 
create or replace  stream LC_parking on table demo_db.public.parking; 

create or replace  stream NJ_parking on table demo_db.public.parking; 

-- Create task to capture only LC city data

CREATE OR REPLACE TASK DEMO_DB.PUBLIC.LC_parking
  WAREHOUSE = compute_wh
  SCHEDULE = '1 minute'
WHEN
  SYSTEM$STREAM_HAS_DATA('LC_parking')
AS
INSERT INTO snowpipe.public.LC_parking_t
SELECT * FROM DEMO_DB.PUBLIC.parking WHERE Registration_State='LC';

ALTER TASK LC_parking RESUME;

-- Create task to capture only NJ city data

CREATE OR REPLACE TASK DEMO_DB.PUBLIC.NJ_parking
  WAREHOUSE = compute_wh
  SCHEDULE = '1 minute'
WHEN
  SYSTEM$STREAM_HAS_DATA('NJ_parking')
AS
INSERT INTO demo_db.public.NJ_parking_t
SELECT * FROM parking WHERE Registration_State='NJ';

ALTER TASK NJ_PARKING RESUME;

CREATE OR REPLACE TASK DEMO_DB.PUBLIC.REFRESH_PIPE
  WAREHOUSE = compute_wh
  SCHEDULE = '1 minute'
AS
alter pipe demo_db.public.SNOWPIPE refresh;

ALTER TASK DEMO_DB.PUBLIC.REFRESH_PIPE RESUME;