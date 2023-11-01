/*
    ALL [ PRIVILEGES ] / All / Grants all the privileges for the specified object type.
    APPLY MASKING POLICY / Global / Grants ability to set a Column-level Security masking policy on a table or view column.
    APPLY ROW ACCESS POLICY / Global / Grants ability to add and drop a Row-level Security row access policy on a table or view.
    APPLY TAG / Global / Grants the ability to add or drop a tag on a Snowflake object.
    ATTACH POLICY / Global / Grants ability to activate a network policy by associating it with your account.
    CREATE <object_type> / Global , Database , Schema / Grants ability to create an object of <object_type> (e.g. CREATE TABLE grants the ability to create a table within a                schema).
    CREATE ACCOUNT / Global / Grants ability to create managed accounts; currently applies only to data providers creating reader accounts for sharing data with consumers.
    CREATE SHARE / Global / Grants ability to create shares; applies to data providers for sharing data with other accounts.
    DELETE / Table / Grants ability to execute a DELETE command on the table.
    EXECUTE TASK / Global / Grants ability to run any tasks owned by the role.
    IMPORT SHARE / Global / Grants ability to view shares shared with your account and create databases from the shares; applies to data consumers.
    OVERRIDE SHARE RESTRICTIONS / Global /
        Grants ability to set value for the SHARE_RESTRICTIONS parameter which enables a Business Critical provider account to add a consumer account (with Non-Business Critical         edition) to a share. For more details, see Enabling Sharing from a Business Critical Account to a non-Business Critical Account.
    IMPORTED PRIVILEGES / Database, Data Exchange / Grants ability to enable roles other than the owning role to access a shared database or manage a Snowflake Data Marketplace /         Data Exchange.
    INSERT / Table / Grants ability to execute an INSERT command on the table.
    MANAGE GRANTS / Global / Grants ability to grant or revoke privileges on any object as if the invoking role were the owner of the object.
    MODIFY / Resource Monitor , Warehouse , Data Exchange Listing , Database , Schema / Grants ability to change the settings or properties of an object (e.g. on a virtual               warehouse, provides the ability to change the size of a virtual warehouse).
    MONITOR / User , Resource Monitor , Warehouse , Database , Schema, Task / Grants ability to see details within an object (e.g. queries and usage within a warehouse).
    MONITOR EXECUTION / Global / Grants ability to monitor pipes (Snowpipe) or tasks in the account.
    MONITOR USAGE / Global / Grants ability to monitor account-level usage and historical information for databases and warehouses; for more details, see Enabling Non-Account             Administrators to Monitor Usage and Billing History in the Classic Web Interface. Additionally grants ability to view managed accounts using SHOW MANAGED ACCOUNTS.
    OPERATE / Warehouse , Task / Grants ability to start, stop, suspend, or resume a virtual warehouse. Grants ability to suspend or resume a task.
    OWNERSHIP / All / Grants ability to delete, alter, and grant or revoke access to an object. Required to rename an object. OWNERSHIP is a special privilege on an object that            is automatically granted to the role that created the object, but can also be transferred using the GRANT OWNERSHIP command to a different role by the owning role (or            any role with the MANAGE GRANTS privilege).
    REFERENCES / Table , External table, View / Grants ability to view the structure of an object (but not the data). For tables, the privilege also grants the ability to                  reference the object as the unique/primary key table for a foreign key constraint.
    SELECT / Table , External table, View, Stream / Grants ability to execute a SELECT statement on the table/view.
    TRUNCATE / Table / Grants ability to execute a TRUNCATE TABLE command on the table.
    UPDATE / Table / Grants ability to execute an UPDATE command on the table.
    USAGE / Warehouse , Data Exchange Listing , Database , Schema / Allows usage of the object
*/

Select
    Grantor,            -- Role which granted the privilege
    Grantee,            -- Role to whom the privilege was granted
    Object_Catalog,     -- Database containing the object on which the privilege is granted
    Object_Schema,      -- Database containing the object on which the privilege is granted
    Object_Name,        -- Name of the object on which the privilege is granted
    Object_Type,        -- Type of the object on which the privilege is granted
    Privilege_Type,     -- Type of the granted privilege
    Is_Grantable,       -- Determines if the privilege was granted using the WITH GRANT OPTION
    Created             -- Creation time
From Information_Schema.Object_Privileges;