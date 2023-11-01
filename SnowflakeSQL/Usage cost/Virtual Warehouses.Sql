// Retrieve the current warehouse for the session
SELECT CURRENT_WAREHOUSE();

// Alter the default warehouse for a particular user
ALTER USER RandyMinder SET DEFAULT_WAREHOUSE = 'Compute_XSmall';

// Retrieve all my warehouses
SHOW WAREHOUSES;
DESCRIBE WAREHOUSE Compute_XSmall;

// Create a warehouse. Of course, warehouses can also be created in the Web UI. But, when doing so,
// you are limited to an auto suspend minimum time of 5 minutes.
CREATE OR REPLACE WAREHOUSE Compute_Small
    WITH WAREHOUSE_SIZE = 'SMALL'
    MIN_CLUSTER_COUNT = 1
    MAX_CLUSTER_COUNT = 1
    AUTO_SUSPEND = 10  // Seconds
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    SCALING_POLICY = ECONOMY
    -- RESOURCE_MONITOR = <Monitor>
    COMMENT = 'A small virtual warehouse'
;

/* Additional object parameters for creating a warehouse
objectParams ::=
  MAX_CONCURRENCY_LEVEL = <num>
  STATEMENT_QUEUED_TIMEOUT_IN_SECONDS = <num>
  STATEMENT_TIMEOUT_IN_SECONDS = <num>
*/

// Alter the auto suspend on a warehouse
ALTER WAREHOUSE IF EXISTS Compute_Small Set Auto_Suspend = 15 // Seconds