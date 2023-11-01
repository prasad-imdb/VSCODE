/*
    We will be using the Warehouse_Events_History view for these queries. This view returns the events that have been triggered for the 
    single-cluster and multi-cluster warehouses in your account in the last 365 days.

    Supported events include:
        Creating, dropping, or altering a warehouse, including resizing the warehouse
        Resuming or suspending a warehouse
        Resuming, suspending, or resizing a cluster in a warehouse (single-cluster and multi-cluster warehouses)
        Stopping or starting additional clusters in a warehouse (multi-cluster warehouses only).    
*/

// List anytime a warehouse cluster spins up or down
Select
    Timestamp,          -- Timestamp of the event
    Warehouse_Name,     -- Warehouse name
    Cluster_Number,     -- Only valid if a specific cluster was involved. If all clusters were involved, nothing is returned.
    Event_Name,         -- The name of the event that caused the cluster change
    Event_Reason,       -- The cause of the event
    Event_State,        -- The state of the event (Started, Completed, Partially_Completed)
    User_Name,          -- The name of the user initiating the event
    Role_Name,          -- Active role at the time of the event
    Query_Id            -- Internal Query Id used to change the cluster.
From Snowflake.Account_Usage.Warehouse_Events_History
Where Event_Name ilike 'SpinUp_Cluster' Or Event_Name ilike 'Spindown Cluster' And Date(Timestamp) = :daterange;

// List anytime a warehouse multi-cluster spins up or down
Select 
    Timestamp,          -- Timestamp of the event
    Warehouse_Name,     -- Warehouse name
    Cluster_Number,     -- Only valid if a specific cluster was involved. If all clusters were involved, nothing is returned.
    Event_Name,         -- The name of the event that caused the cluster change
    Event_Reason,       -- The cause of the event
    Event_State,        -- The state of the event (Started, Completed, Partially_Completed)
    User_Name,          -- The name of the user initiating the event
    Role_Name,          -- Active role at the time of the event
    Query_Id            -- Internal Query Id used to change the cluster.
From Snowflake.Account_Usage.Warehouse_Events_History
Where Event_Reason ilike 'MultiCluster_Spinup' Or Event_Reason ilike 'MultiCluster_Spindown' And Date(Timestamp) = :daterange;

// List anytime a warehouse was resized
Select 
    Timestamp,          -- Timestamp of the event
    Warehouse_Name,     -- Warehouse name
    Cluster_Number,     -- Only valid if a specific cluster was involved. If all clusters were involved, nothing is returned.
    Event_Name,         -- The name of the event that caused the cluster change
    Event_Reason,       -- The cause of the event
    Event_State,        -- The state of the event (Started, Completed, Partially_Completed)
    User_Name,          -- The name of the user initiating the event
    Role_Name,          -- Active role at the time of the event
    Query_Id            -- Internal Query Id used to change the cluster.
From Snowflake.Account_Usage.Warehouse_Events_History
Where Event_Reason ilike 'Warehouse_Resize' And Date(Timestamp) = :daterange;

// List anytime a warehouse was suspended because of a resource monitor
Select 
    Timestamp,          -- Timestamp of the event
    Warehouse_Name,     -- Warehouse name
    Cluster_Number,     -- Only valid if a specific cluster was involved. If all clusters were involved, nothing is returned.
    Event_Name,         -- The name of the event that caused the cluster change
    Event_Reason,       -- The cause of the event
    Event_State,        -- The state of the event (Started, Completed, Partially_Completed)
    User_Name,          -- The name of the user initiating the event
    Role_Name,          -- Active role at the time of the event
    Query_Id            -- Internal Query Id used to change the cluster.
From Snowflake.Account_Usage.Warehouse_Events_History
Where Event_Reason ilike 'Resource_Monitor_Suspend' And Date(Timestamp) = :daterange;

// List anytime a suspended warehouse was resumed
Select 
    Timestamp,          -- Timestamp of the event
    Warehouse_Name,     -- Warehouse name
    Cluster_Number,     -- Only valid if a specific cluster was involved. If all clusters were involved, nothing is returned.
    Event_Name,         -- The name of the event that caused the cluster change
    Event_Reason,       -- The cause of the event
    Event_State,        -- The state of the event (Started, Completed, Partially_Completed)
    User_Name,          -- The name of the user initiating the event
    Role_Name,          -- Active role at the time of the event
    Query_Id            -- Internal Query Id used to change the cluster.
From Snowflake.Account_Usage.Warehouse_Events_History
Where Event_Reason ilike 'Warehouse_Resume' And Date(Timestamp) = :daterange;