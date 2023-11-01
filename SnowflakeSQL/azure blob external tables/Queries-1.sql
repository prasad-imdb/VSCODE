// Create a weather database
create or replace database weather;

// Use the database we just created
use database weather;
use schema public;

// Create an external stage, which is required for an external table. This is an Azure storage account so we
// need to make sure our URL prefix is correct
create or replace stage weather_data
URL = 'azure://snowflakeudemycourses.blob.core.windows.net/weather-data/';

// Create the external table
create or replace external table weather_data_json
    file_format = (type=json)
    with location = @weather_data
    auto_refresh = true;
    
// Let's see what's in our weather data stage
list @weather_data;
    
// Refresh the external table
alter external table weather_data_json refresh;
    
// Let's test the external table
select * from weather_data_json

// At the moment, this weather data is not all that useful to users because it's
// in a JSON format. Let's create something more friendly.
create or replace external table weather_data
(
    file_name string as (metadata$filename::string),
    city_name string as (value:city.name::string),
    country string as (value:city.country::string),
    time_raw integer as (value:time::integer),
    time timestamp as (value:time::timestamp)
)
with location = @weather_data
file_format = (type = json);

select * From weather_data

create or replace materialized view weather_data_view
as
select * From weather_data

select * from weather_data_view


