// https://docs.snowflake.com/en/sql-reference/functions-date-time.html#label-supported-date-time-parts

// The date_trunc function trucates the target date to the nearest part specified as the first parameter and returns a date
Select date_trunc('Quarter',convert_timezone('America/Detroit', current_timestamp()));
Select date_trunc('Hour',convert_timezone('America/Detroit', current_timestamp()));

// The date_part function returns an integer value
Select date_part('Quarter',convert_timezone('America/Detroit', current_timestamp()));
Select date_part('Hour',convert_timezone('America/Detroit', current_timestamp()));

// The extract function is 100% equivalent to date_part
Select extract('Quarter',convert_timezone('America/Detroit', current_timestamp()));
Select extract('Month',convert_timezone('America/Detroit', current_timestamp()));
