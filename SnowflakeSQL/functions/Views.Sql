SELECT
    table_catalog,
    table_schema,
    table_name,
    table_owner,
    view_definition,
    is_secure,
    created,
    last_altered,
    comment
FROM information_schema.views
-- WHERE table_schema != 'INFORMATION_SCHEMA'
ORDER BY table_schema, table_name;  