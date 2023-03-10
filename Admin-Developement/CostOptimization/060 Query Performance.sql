
SELECT TOP 1000 * FROM SNOWFLAKE.ACCOUNT_USAGE.SESSIONS 
WHERE 1 = 1 
AND SESSION_ID <> CURRENT_SESSION()
ORDER BY CREATED_ON DESC;


--Total jobs executed in your account (month-to-date):

SELECT COUNT(*) AS NUMBER_OF_JOBS
FROM QUERY_HISTORY
WHERE START_TIME >= DATE_TRUNC(MONTH, CURRENT_DATE);

--TOTAL QUERY JOBS EXECUTED BY EACH WAREHOUSE IN YOUR ACCOUNT (MONTH-TO-DATE):
SELECT  IFF(WAREHOUSE_NAME IS NULL, 'INTERNAL <Cloud Services>' , WAREHOUSE_NAME) AS WAREHOUSE_NAME  
    ,   COUNT(*) AS NUMBER_OF_JOBS
FROM QUERY_HISTORY
WHERE START_TIME >= DATE_TRUNC(MONTH, CURRENT_DATE)
GROUP BY 1
ORDER BY 2 DESC;


--Average query execution time by user (month-to-date):


--Average query execution time by query type and warehouse size (month-to-date):
SELECT QUERY_TYPE,
       WAREHOUSE_SIZE,
       AVG(EXECUTION_TIME) AS AVERAGE_EXECUTION_TIME
FROM QUERY_HISTORY
WHERE START_TIME >= DATE_TRUNC(MONTH, CURRENT_DATE)
GROUP BY 1,2
ORDER BY 3 DESC;



SELECT L.USER_NAME,
       L.EVENT_TIMESTAMP AS LOGIN_TIME,
       L.CLIENT_IP,
       L.REPORTED_CLIENT_TYPE,
       L.FIRST_AUTHENTICATION_FACTOR,
       L.SECOND_AUTHENTICATION_FACTOR,
       COUNT(Q.QUERY_ID)
FROM SNOWFLAKE.ACCOUNT_USAGE.LOGIN_HISTORY L
JOIN SNOWFLAKE.ACCOUNT_USAGE.SESSIONS S ON L.EVENT_ID = S.LOGIN_EVENT_ID
JOIN SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY Q ON Q.SESSION_ID = S.SESSION_ID
GROUP BY 1,2,3,4,5,6
ORDER BY L.USER_NAME, LOGIN_TIME DESC
;


