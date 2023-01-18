----- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
----- Framework: Nik - Shahriar Nikkhah               Date: 2022-09-21	Time: 23:04
----- Author:    Enzo - Parsa Bahrami                 Date: 2023-01-09	Time: 22:27
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


-----************************************************************************************ 
----- Primary Tests/Evaluation
-----************************************************************************************ 
SHOW SCHEMAS;


-----************************************************************************************ 
----- Cleanup
-----************************************************************************************ 
-- DROP SCHEMA IF EXISTS SMA_CLIENT;


-----************************************************************************************ 
----- Extra Settings
-----************************************************************************************ 


---************************************************************************************ 
--- Create object (Table/View/uSP/...)
---************************************************************************************ 
CREATE SCHEMA SMA_CLIENT;


---************************************************************************************ 
--- Test
---************************************************************************************     
--SHOW WAREHOUSES;
SHOW SCHEMAS;
