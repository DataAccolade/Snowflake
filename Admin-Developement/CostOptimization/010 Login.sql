
USE DATABASE SNOWFLAKE_SAMPLE_DATA;

SHOW WAREHOUSES; -- Check the [State] column to see if WH is STARTED 

--ALTER WAREHOUSE "COMPUTE_WH" RESUME; -- Check the [State] column to see if WH is SUSPENDED 

USE WAREHOUSE "COMPUTE_WH";

SHOW SCHEMAS;

USE SCHEMA TPCH_SF10;

