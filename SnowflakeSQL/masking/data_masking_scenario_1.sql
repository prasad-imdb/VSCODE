### Execute these queries 

    # Create data base DEMO_DB_OWNER

    USE ROLE ACCOUNTADMIN;

    CREATE DATABASE DEMO_DB_OWNER;
    
    GRANT CREATE MASKING POLICY ON SCHEMA PUBLIC TO ROLE SYSADMIN;

    # Create role SANDBOX

    create role sandbox;

    # Create user

    create user developer password='abc123' default_role = sandbox must_change_password = false;

    # Grant usage access on database.

    GRANT USAGE ON DATABSE DEMO_DB_OWNER TO ROLE SYSADMIN;
    GRANT USAGE ON DATABSE DEMO_DB_OWNER TO ROLE SANDBOX;

    # Create masking policy.
    
    USE ROLE SYSADMIN;

    CREATE MASKING POLICY DEMO_DB_OWNER.PUBLIC.EMPLOYEE_SSN_MASK_1 AS (VAL STRING) RETURNS STRING ->
      CASE
        WHEN CURRENT_ROLE() IN ('SANDBOX') THEN VAL
        ELSE '******'
      END;


    # Create sample table to apply masking

    USE ROLE SYSADMIN;
    
    CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.SSN2( SSN_NUMBER STRING MASKING POLICY DEMO_DB_OWNER.PUBLIC.EMPLOYEE_SSN_MASK_1,SSN_NUMBER2 STRING)

    INSERT INTO SSN2(SSN_NUMBER,SSN_NUMBER2)
    SELECT C_PHONE,C_PHONE FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF10000.CUSTOMER;
    
    GRANT SELECT ON DEMO_DB.PUBLIC.SSN2 TO ROLE SANDBOX;




   












