SET MyCurrentSession = (SELECT CURRENT_SESSION()); -- This is my current Session ID that needed to be filtered out the queries
--SET MyCurrentSession = 0;
--SELECT CURRENT_SESSION() INTO :MyCurrentSession; -- This is my current Session ID that needed to be filtered out the queries


WITH WAREHOUSE_SIZE AS
(
     SELECT WAREHOUSE_SIZE, NODES
       FROM (
              SELECT 'X-SMALL' AS WAREHOUSE_SIZE, 1 AS NODES
              UNION ALL
              SELECT 'SMALL' AS WAREHOUSE_SIZE, 2 AS NODES
              UNION ALL
              SELECT 'MEDIUM' AS WAREHOUSE_SIZE, 4 AS NODES
              UNION ALL
              SELECT 'LARGE' AS WAREHOUSE_SIZE, 8 AS NODES
              UNION ALL
              SELECT 'X-LARGE' AS WAREHOUSE_SIZE, 16 AS NODES
              UNION ALL
              SELECT '2X-LARGE' AS WAREHOUSE_SIZE, 32 AS NODES
              UNION ALL
              SELECT '3X-LARGE' AS WAREHOUSE_SIZE, 64 AS NODES
              UNION ALL
              SELECT '4X-LARGE' AS WAREHOUSE_SIZE, 128 AS NODES
            )
),
QUERY_HISTORY AS
(
     SELECT QH.QUERY_ID
           ,QH.QUERY_TEXT
           ,QH.USER_NAME
           ,QH.ROLE_NAME
           ,QH.EXECUTION_TIME
           ,(QUEUED_PROVISIONING_TIME + QUEUED_REPAIR_TIME + QUEUED_OVERLOAD_TIME) AS QUEUED_TIME
           ,QH.WAREHOUSE_SIZE      
      FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY QH
     WHERE START_TIME > DATEADD(month,-2,CURRENT_TIMESTAMP())
        AND SESSION_ID <> $MyCurrentSession
)

SELECT QH.QUERY_ID
      ,'https://' || current_account() || '.snowflakecomputing.com/console#/monitoring/queries/detail?queryId='||QH.QUERY_ID AS QU
      ,QH.QUERY_TEXT
      ,QH.USER_NAME
      ,QH.ROLE_NAME
      ,QH.EXECUTION_TIME as EXECUTION_TIME_MILLISECONDS
      ,(QH.EXECUTION_TIME/(1000)) as EXECUTION_TIME_SECONDS
      ,(QH.EXECUTION_TIME/(1000*60)) AS EXECUTION_TIME_MINUTES
      ,(QH.EXECUTION_TIME/(1000*60*60)) AS EXECUTION_TIME_HOURS
      ,WS.WAREHOUSE_SIZE
      ,WS.NODES
      ,QH.QUEUED_TIME
      ,(QH.EXECUTION_TIME/(1000*60*60))*WS.NODES as RELATIVE_PERFORMANCE_COST

FROM QUERY_HISTORY QH
JOIN WAREHOUSE_SIZE WS ON WS.WAREHOUSE_SIZE = upper(QH.WAREHOUSE_SIZE)
ORDER BY RELATIVE_PERFORMANCE_COST DESC
LIMIT 200
;

SHOW DATABASES;
SHOW WAREHOUSES;


SET DBName = 'SNOWFLAKE';
SET WHName = 'COMPUTE_WH'; 

SET UserName = 'DAC';
SET StartTime = '2023-02-01 09:58:12';
SET LimitedRow = 1000;

SELECT CURRENT_SESSION();
-------------------------------------------------------------------------------------------------------
SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_WAREHOUSE (WAREHOUSE_NAME => $WHName , END_TIME_RANGE_START => to_timestamp_ltz($StartTime) , RESULT_LIMIT => $LimitedRow))  --  returns queries executed by a specified warehouse within a specified time range.
WHERE 1 = 1 
AND SESSION_ID <> CURRENT_SESSION()
--AND DATABASE_NAME = $DBName
ORDER BY start_time DESC;

--- CLoud Service Used
SELECT  TO_DATE(START_TIME) AS "Day Date" 
    ,   DATABASE_NAME, WAREHOUSE_NAME, WAREHOUSE_SIZE, EXECUTION_STATUS
    ,  QUERY_TYPE
    ,  SUM(CREDITS_USED_CLOUD_SERVICES) AS "Sum of CREDITS_USED_CLOUD_SERVICES"
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_WAREHOUSE (WAREHOUSE_NAME => $WHName , END_TIME_RANGE_START => to_timestamp_ltz($StartTime) , RESULT_LIMIT => $LimitedRow))  --  returns queries executed by a specified warehouse within a specified time range.
WHERE 1 = 1 
AND SESSION_ID <> CURRENT_SESSION()
--AND DATABASE_NAME = $DBName
GROUP BY TO_DATE(START_TIME) 
    ,    DATABASE_NAME, WAREHOUSE_NAME, WAREHOUSE_SIZE, EXECUTION_STATUS
    ,  QUERY_TYPE
ORDER BY 1 DESC, 2 DESC, 3 , 4 , 5;

-------------------------------------------------------------------------------------------------------

SELECT * 
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER (USER_NAME => $UserName , END_TIME_RANGE_START => to_timestamp_ltz($StartTime) , RESULT_LIMIT => $LimitedRow))       --  returns queries submitted by a specified user within a specified time range.
WHERE  1 = 1 
AND SESSION_ID <> CURRENT_SESSION()
AND DATABASE_NAME = $DBName
--AND QUERY_ID = '01aa21d5-0000-892e-0000-00019ab6615d'
ORDER BY start_time DESC;

SELECT * 
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_SESSION ( END_TIME_RANGE_START => to_timestamp_ltz($StartTime) , RESULT_LIMIT => $LimitedRow))    --  returns queries within a specified session and time range.
WHERE  1 = 1 
AND SESSION_ID <> CURRENT_SESSION()
AND DATABASE_NAME = $DBName
--AND WAREHOUSE_NAME = $WHName 
--AND USER_NAME = $UserName
--AND QUERY_ID = '01aa21d5-0000-892e-0000-00019ab6615d'
ORDER BY start_time DESC;

SELECT * 
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY ( END_TIME_RANGE_START => to_timestamp_ltz($StartTime) , RESULT_LIMIT => $LimitedRow))    --  returns queries within a specified session and time range.
WHERE  1 = 1 
AND SESSION_ID <> CURRENT_SESSION()
AND DATABASE_NAME = $DBName
--AND WAREHOUSE_NAME = $WHName 
--AND USER_NAME = $UserName
--AND QUERY_ID = '01aa21d5-0000-892e-0000-00019ab6615d'
ORDER BY start_time DESC;

SELECT * FROM ACCOUNT_USAGE.QUERY_HISTORY               --  returns queries within a specified time range.
WHERE  1 = 1 
AND SESSION_ID <> CURRENT_SESSION()
--AND DATABASE_NAME = $DBName
--AND WAREHOUSE_NAME = $WHName 
AND USER_NAME = $UserName
--AND QUERY_ID = '01aa21d5-0000-892e-0000-00019ab6615d'
ORDER BY start_time DESC
LIMIT $LimitedRow;



------ METERING HISTORY
-- https://docs.snowflake.com/en/sql-reference/account-usage/metering_history
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.METERING_HISTORY;
--  https://docs.snowflake.com/en/sql-reference/account-usage/metering_daily_history
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.METERING_DAILY_HISTORY;



----- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
----- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
SELECT * FROM SNOWFLAKE.ORGANIZATION_USAGE.RATE_SHEET_DAILY ORDER BY DATE DESC;
SELECT * FROM SNOWFLAKE.ORGANIZATION_USAGE.USAGE_IN_CURRENCY_DAILY ORDER BY USAGE_DATE DESC;   -- [USAGE] is = WAREHOUSE_METERING_HISTORY.CREDIT_USED_COMPUTE
SELECT * FROM SNOWFLAKE.ORGANIZATION_USAGE.METERING_DAILY_HISTORY;
--- 1 - COMPUTE
SELECT * FROM SNOWFLAKE.ORGANIZATION_USAGE.WAREHOUSE_METERING_HISTORY ORDER BY START_TIME DESC; --- Critical field CREDITS_USED_CLOUD_SERVICES find RATIO

--- 2 - Cloud services

--- 3 - Storage
SELECT * FROM SNOWFLAKE.ORGANIZATION_USAGE.STORAGE_DAILY_HISTORY ORDER BY USAGE_DATE DESC;
SELECT * FROM SNOWFLAKE.ORGANIZATION_USAGE.STAGE_STORAGE_USAGE_HISTORY ORDER BY USAGE_DATE DESC;
--- 9 - SNOWFLAKE --adj for incl cloud services



--- 99 - Other cost Measures
---This is for FORCASTING budgetting -- see 400$ limitation from SNOWFLAKE
SELECT * FROM SNOWFLAKE.ORGANIZATION_USAGE.REMAINING_BALANCE_DAILY ORDER BY DATE DESC;



-- https://docs.snowflake.com/en/sql-reference/functions/warehouse_metering_history
-- https://community.snowflake.com/s/article/Understanding-Your-Snowflake-Utilization-Part-1-Warehouse-Profiling
-- https://medium.com/snowflake/snowflake-warehouse-load-and-metering-analysis-f900e5448c8a
-- https://developers.thoughtspot.com/codespot/snowflake-performance-consumption-tml-block
-- https://www.linkedin.com/pulse/reporting-snowflake-part-2-sample-cost-usage-report-krzysztofek/
