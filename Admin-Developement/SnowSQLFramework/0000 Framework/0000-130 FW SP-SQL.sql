----- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
----- Framework: Nik - Shahriar Nikkhah               Date: 2022-09-21	Time: 23:04
----- Author:    Enzo - Parsa Bahrami                 Date: 2023-01-09	Time: 21:46
----- 
----- Input :
----- 
----- Output :
----- 
----- Description : 
----- 
----- Benchmark : 
----- 
----- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
----- Revision History : For the next section please add : Your name , Date , what was modified or added.
----- 					 Add reference number or reference an emails subject.
----- 
----- 
----- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-----   This script is intended only as a supplement to demos and lectures
-----   given by "Nik - Shahriar Nikkhah" and/or "Enzo - Parsa Bahrami"
-----   
-----   THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
-----   ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
-----   TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, NON-INFRINGMENT AND/OR FITNESS FOR A
-----   PARTICULAR PURPOSE.
----- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
USE DATABASE dataaccolade;
USE WAREHOUSE "SF_DSDA_ENG_WH";
USE SCHEMA SMA_CLIENT;


-----************************************************************************************ 
----- Primary Tests/Evaluation
-----************************************************************************************ 
--SELECT * FROM INFORMATION_SCHEMA.TABLE_STORAGE_METRICS WHERE TABLE_DROPPED IS NULL AND TABLE_NAME = 'CLIENT';
--SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SV_CLIENT' ORDER BY ORDINAL_POSITION;
--SELECT * FROM INFORMATION_SCHEMA.PROCEDURES

--SHOW TABLES;
--SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TABLES;
--SHOW VIEWS;
--SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.VIEWS;
--SHOW COLUMNS;
--SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.COLUMNS;
--SHOW PROCEDURES;
--SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.PROCEDURES;


-----************************************************************************************ 
----- Cleanup
-----************************************************************************************ 
--D-ROP PROCEDURE IF EXISTS SMA_CLIENT.PR_CLIENT();

-----************************************************************************************ 
----- Extra Settings
-----************************************************************************************ 


---************************************************************************************ 
--- Create object (Table/View/uSP/...)
---************************************************************************************ 
CREATE OR REPLACE PROCEDURE SMA_CLIENT.PR_CLIENT()
  RETURN TABLE()
  LANGUAGE sql
  AS
  $$
    ---------------------------------------------------------------------
    --- Main Business Data Fields
    ---------------------------------------------------------------------    
    DECLARE
        res resultset default (SELECT * FROM  SMA_CLIENT.SV_CLIENT);
    DEGIN
        RETURN table(res);
    END;
  $$
  ;

---************************************************************************************ 
--- Test
---************************************************************************************     
--SELECT * FROM INFORMATION_SCHEMA.TABLE_STORAGE_METRICS WHERE TABLE_DROPPED IS NULL AND TABLE_NAME = 'CLIENT';
CALL SMA_CLIENT.PR_CLIENT();
SHOW PROCEDURES;
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.PROCEDURES;
