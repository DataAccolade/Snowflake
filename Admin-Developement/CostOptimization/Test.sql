--- Billing ******************
SELECT * FROM WAREHOUSE_METERING_HISTORY;  -- Return the hourly credit usage for warehouses


select warehouse_name,
       sum(credits_used) as total_credits_used
from warehouse_metering_history
where start_time >= date_trunc(month, current_date)
group by 1
order by 2 desc;

-- ****** Usage for cloud services is charged only if the daily consumption of cloud services exceeds 10%
-- ****** of the daily usage of virtual warehouses.


--https://docs.snowflake.com/en/sql-reference/account-usage.html
select date_trunc(month, usage_date) as usage_month
  , avg(storage_bytes + stage_bytes + failsafe_bytes) / power(1024, 4) as billable_tb
from storage_usage
group by 1
order by 1;




select l.user_name,
       l.event_timestamp as login_time,
       l.client_ip,
       l.reported_client_type, --- IF JAVASCRIPT_DRIVER then it is "VISUAL STUDIO CODE"
       l.first_authentication_factor,
       l.second_authentication_factor,
       count(q.query_id)
from snowflake.account_usage.login_history l
join snowflake.account_usage.sessions s on l.event_id = s.login_event_id
join snowflake.account_usage.query_history q on q.session_id = s.session_id
group by 1,2,3,4,5,6
order by l.user_name
;