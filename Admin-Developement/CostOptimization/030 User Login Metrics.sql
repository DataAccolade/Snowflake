--- https://docs.snowflake.com/en/sql-reference/account-usage.html#examples-user-login-metrics


-- List of failed login by user:
SELECT TO_VARCHAR(EVENT_TIMESTAMP, 'yyyy-MM') AS YearMonth , * 
FROM    LOGIN_HISTORY 
WHERE ERROR_CODE <> 0 OR ERROR_MESSAGE IS NOT NULL OR IS_SUCCESS = 'NO'
ORDER BY EVENT_TIMESTAMP DESC
LIMIT 1000;

-- Average number of seconds between failed login attempts by user (month-to-date):
SELECT USER_NAME,
       COUNT(*) AS FAILED_LOGINS,
       AVG(SECONDS_BETWEEN_LOGIN_ATTEMPTS) AS AVERAGE_SECONDS_BETWEEN_LOGIN_ATTEMPTS
FROM (
      SELECT USER_NAME,
             TIMEDIFF(SECONDS, EVENT_TIMESTAMP, LEAD(EVENT_TIMESTAMP)
                 OVER(PARTITION BY USER_NAME ORDER BY EVENT_TIMESTAMP)) AS SECONDS_BETWEEN_LOGIN_ATTEMPTS
      FROM LOGIN_HISTORY
      WHERE EVENT_TIMESTAMP > date_trunc(month, current_date)
      AND IS_SUCCESS = 'NO'
     )
GROUP BY 1
ORDER BY 3;

--Failed logins by user and connecting client (month-to-date):
SELECT  TO_VARCHAR(EVENT_TIMESTAMP, 'yyyy-MM') AS MonthToDate 
    ,   REPORTED_CLIENT_TYPE
    ,   USER_NAME
    ,   SUM(IFF(IS_SUCCESS = 'NO', 1, 0)) AS FAILED_LOGINS
    ,   COUNT(*) AS LOGINS
    ,   SUM(IFF(IS_SUCCESS = 'NO', 1, 0)) / NULLIF(COUNT(*), 0) AS LOGIN_FAILURE_RATE
FROM LOGIN_HISTORY
WHERE EVENT_TIMESTAMP > DATE_TRUNC(month, current_date) --- MonthToDate
GROUP BY MonthToDate, REPORTED_CLIENT_TYPE, USER_NAME
ORDER BY 5 DESC;


-- TO DO or FIND
-- USER by DW
-- USER by DB
-- USER by Query