SHOW OBJECTS LIKE '%Sales%' IN ACCOUNT;

SHOW COLUMNS Like '%Vendor%' IN ACCOUNT;

-- You will need to select a database and warehouse for this query
SELECT col.table_schema,
       col.table_name,
       col.ordinal_position as col_id,
       col.column_name,
       col.data_type
FROM information_schema.columns col
JOIN information_schema.tables tab ON 
    tab.table_schema = col.table_schema
    AND tab.table_name = col.table_name
    AND tab.table_type = 'BASE TABLE'
WHERE col.data_type IN ('DATE', 'TIME', 'TIMESTAMP_LTZ',
                        'TIMESTAMP_NTZ', 'TIMESTAMP_TZ')
      AND col.table_schema != 'INFORMATION_SCHEMA'
ORDER BY col.table_schema,
         col.table_name;


