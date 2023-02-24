SET DBName = 'SNOWFLAKE';
SET WHName = 'COMPUTE_WH'; 

SET UserName = 'DAC';
SET FromDate = '2023-02-01 00:00:00';
SET ToDate = '2023-02-28 23:59:59';
SET LimitedRow = 1000;

SET MyCurrentSession = (SELECT CURRENT_SESSION()); -- This is my current Session ID that needed to be filtered out the queries
SELECT CURRENT_SESSION();





--This query calculates virtual warehouse performance metrics such as throughput and latency
--for 15-minute time intervals over the course of one day.
--In the code sample below, replace CURRENT_WAREHOUSE() with 'MY_WH' to calculate metrics for a specific warehouse. In addition, change the time_from and time_to dates in the WITH clause.


--Analyze different statement types separately (e.g., SELECT statements independent of INSERT or DELETE or other statements).
--The NUMJOBS value represents the throughput for that time interval.
--The P50_TOTAL_DURATION (median) and P95_TOTAL_DURATION (peak) values represent latency.
--The SUM_TOTAL_DURATION is the sum of the SUM_<job_stage>_TIME values for the different job stages (COMPILATION_AND_SCHEDULING, QUEUED, BLOCKED, EXECUTION).
--Analyze the <job_stage>_RATIO values when the load (NUMJOBS) increases. Look for ratio changes or deviations from the average:
--If the COMPILATION_AND_SCHEDULING_RATIO is high, the warehouse might benefit from the high concurrency, low latency changes. These improvements are available in warehouses in all regions.
--If the QUEUED_RATIO is high, there might not be sufficient capacity in the warehouse. Add more clusters or increase the warehouse size.

-- See comment above
WITH
jobs AS (
SELECT
    QUERY_ID,
    TIME_SLICE(START_TIME::TIMESTAMP_NTZ, 15, 'minute','start') AS INTERVAL_START,
    $WHName,
    DATABASE_NAME,
    QUERY_TYPE,
    TOTAL_ELAPSED_TIME,
    COMPILATION_TIME AS COMPILATION_AND_SCHEDULING_TIME,
    (QUEUED_PROVISIONING_TIME + QUEUED_REPAIR_TIME + QUEUED_OVERLOAD_TIME) AS QUEUED_TIME,
    TRANSACTION_BLOCKED_TIME,
    EXECUTION_TIME
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY QH
WHERE 1 = 1
AND QH.WAREHOUSE_NAME = $WHName
AND START_TIME >= $FromDate
AND START_TIME <= $ToDate
AND EXECUTION_STATUS = 'SUCCESS'
AND QUERY_TYPE IN ('SELECT','UPDATE','INSERT','MERGE','DELETE')
),

interval_stats as (
SELECT  --- MUST ADD $WHName in this query  
    query_type,
    interval_start,
    count(distinct query_id)                                        as numjobs,
    median(total_elapsed_time)/1000                                 as p50_total_duration,
    (percentile_cont(0.95) within group (order by total_elapsed_time))/1000 as p95_total_duration,
    sum(total_elapsed_time)/1000                                    as sum_total_duration,
    sum(compilation_and_scheduling_time)/1000                       as sum_compilation_and_scheduling_time,
    sum(queued_time)/1000                                           as sum_queued_time,
    sum(transaction_blocked_time)/1000                              as sum_transaction_blocked_time,
    sum(execution_time)/1000                                        as sum_execution_time,
    round(sum_compilation_and_scheduling_time/sum_total_duration,2) as compilation_and_scheduling_ratio,
    round(sum_queued_time/sum_total_duration,2)                     as queued_ratio,
    round(sum_transaction_blocked_time/sum_total_duration,2)        as blocked_ratio,
    round(sum_execution_time/sum_total_duration,2)                  as execution_ratio,
    round(sum_total_duration/numjobs,2)                             as total_duration_perjob,
    round(sum_compilation_and_scheduling_time/numjobs,2)            as compilation_and_scheduling_perjob,
    round(sum_queued_time/numjobs,2)                                as queued_perjob,
    round(sum_transaction_blocked_time/numjobs,2)                   as blocked_perjob,
    round(sum_execution_time/numjobs,2)                             as execution_perjob
from jobs
group by 1,2
order by 1,2
)
select * from interval_stats;


-------------------------------------------------------------------------------------------------------
--Warehouse Credit Usage
--Credits used by each warehouse in your account (month-to-date):
select warehouse_name,
       sum(credits_used) as total_credits_used
from SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
where start_time >= date_trunc(month, current_date)
group by 1
order by 2 desc;


--Credits used over time by each warehouse in your account (month-to-date):
select start_time::date as usage_date,
       warehouse_name,
       sum(credits_used) as total_credits_used
from SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
where start_time >= date_trunc(month, current_date)
group by 1,2
order by 2,1;

