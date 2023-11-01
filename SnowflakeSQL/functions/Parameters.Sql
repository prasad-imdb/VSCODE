// Three types of Snowflake parameters:
// Account
// Session
// Object


Show Parameters in Account;
Show Parameters in User;
Show Parameters in Session;

// Change the timezone at the account level
Alter Account Set Timezone = 'America/Detroit';

// Should Snowflake about an in-progress query?
SHOW PARAMETERS LIKE '%ABORT_DETACHE%';

// How many seconds should Snowflake wait for acquiring a resource lock before timing out and aborting the query. 
// The default value is 12 hours
SHOW PARAMETERS LIKE '%LOCK_TIMEOUT%';

// Tells Snowflake ow lonog it should keep historical data available for time travel (1-90 days)
SHOW PARAMETERS LIKE '%DATA_RETENTION%';

// Should Snowflake use caching to return results
SHOW PARAMETERS LIKE '%USE_CACHED%';

// How long can a query run before Snowflake cancels it.
SHOW PARAMETERS LIKE '%STATEMENT_TIMEOUT%';

// How long can a query run before Snowflake cancels it.
SHOW PARAMETERS LIKE '%STATEMENT_QUEUED%';

// How many SQL statements can Snowflake run in parallel? 
SHOW PARAMETERS LIKE '%MAX_CONCURRENCY_LEVEL%';

// How should dates be displayed?
SHOW PARAMETERS LIKE '%DATE_OUTPUT_FORMAT%';

// Which network policy is in effect.
SHOW PARAMETERS LIKE '%NETWORK_POLICY%';

// How many rows to display in a result set?
SHOW PARAMETERS LIKE '%ROWS_PER%';

// How many rows to display in a result set?
SHOW PARAMETERS LIKE '%SAML%';



