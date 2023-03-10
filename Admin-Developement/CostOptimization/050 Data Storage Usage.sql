SELECT * FROM STORAGE_USAGE;

-- Billable terabytes stored in your account over time:
SELECT DATE_TRUNC(MONTH, USAGE_DATE) AS USAGE_MONTH
    ,   AVG(STORAGE_BYTES + STAGE_BYTES + FAILSAFE_BYTES) / POWER(1024, 2) AS BILLABLE_MB
    ,   AVG(STORAGE_BYTES + STAGE_BYTES + FAILSAFE_BYTES) / POWER(1024, 3) AS BILLABLE_GB
    ,   AVG(STORAGE_BYTES + STAGE_BYTES + FAILSAFE_BYTES) / POWER(1024, 4) AS BILLABLE_TB
FROM STORAGE_USAGE
GROUP BY 1
ORDER BY 1;


SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.STAGE_STORAGE_USAGE_HISTORY;