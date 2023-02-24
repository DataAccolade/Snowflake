----- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
----- Framework: Nik - Shahriar Nikkhah               Date: 2022-09-21	Time: 23:04
----- Author:    Enzo - Parsa Bahrami                 Date: 2023-01-09	Time: 21:51
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
--USE WAREHOUSE "SF_DSDA_ENG_WH";


-----************************************************************************************ 
----- Primary Tests/Evaluation
-----************************************************************************************ 
SHOW WAREHOUSES;
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_LOAD_HISTORY;

-----************************************************************************************ 
----- Cleanup
-----************************************************************************************ 
-- DROP WAREHOUSE IF EXISTS SF_DSDA_ENG_WH;


-----************************************************************************************ 
----- Extra Settings
-----************************************************************************************ 


---************************************************************************************ 
--- Create object (Table/View/uSP/...)
---************************************************************************************ 
CREATE WAREHOUSE SF_DSDA_ENG_WH WITH
	WAREHOUSE_TYPE = STANDARD
	WAREHOUSE_SIZE = 'X-SMALL'
	AUTO_SUSPEND = 180
	AUTO_RESUME = TRUE
	INITIALLY_SUSPENDED = TRUE;


---************************************************************************************ 
--- Test
---************************************************************************************     
SHOW WAREHOUSES;
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_LOAD_HISTORY;

