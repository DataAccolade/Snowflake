----- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
----- Framework: Nik - Shahriar Nikkhah               Date: 2022-09-21	Time: 23:04
----- Author:    Enzo - Parsa Bahrami                 Date: 2023-01-09	Time: 22:34
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
--USE SCHEMA "PUBLIC";

-----************************************************************************************ 
----- Primary Tests/Evaluation
-----************************************************************************************ 
--SELECT * FROM INFORMATION_SCHEMA.TABLE_STORAGE_METRICS WHERE TABLE_DROPPED IS NULL AND TABLE_NAME = 'CLIENT';
--SELECT * FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'CLIENT' ORDER BY ORDINAL_POSITION;
--SELECT TOP 1000 * FROM SMA_CLIENT.CLIENT;
--SHOW TABLES;
--SHOW COLUMNS;
--T--RUNCATE TABLE SMA_CLIENT.CLIENT;
--D--ELETE FROM SMA_CLIENT.CLIENT WHERE "" = '1' and "" = '';


-----************************************************************************************ 
----- Cleanup
-----************************************************************************************ 
--D--ROP TABLE IF EXISTS SMA_CLIENT.CLIENT;

-----************************************************************************************ 
----- Extra Settings
-----************************************************************************************ 


---************************************************************************************ 
--- Create object (Table/View/uSP/...)
---************************************************************************************ 
CREATE TABLE SMA_CLIENT.CLIENT (
	---------------------------------------------------------------------
	--- Internal fields
	---------------------------------------------------------------------
		idf_CLIENT				smallint		NOT NULL    identity(1,1)	
	--,	idf_GroupRun			smallint			NULL --to be tested --> constraint "DF__SMA_CLIENT__CLIENT__idf_GroupRun"				default 1
	--,	idf_SequanceGroupRun	smallint			NULL --to be tested --> constraint "DF__SMA_CLIENT__CLIENT__idf_SequanceGroupRun"		default 1
    ---------------------------------------------------------------------
	--- Main Business Data Fields
	---------------------------------------------------------------------    
    ,   BusinessField1			int				NOT NULL
    ,   BusinessField2			text				NULL    default ('')
    ,   BusinessField3 			varchar(100)	
	,   BusinessField4			text(100)	

    ---------------------------------------------------------------------
	--- More internal fields
	---------------------------------------------------------------------
	,	idf_Source				varchar(100)    NOT NULL --to be tested --> CONSTRAINT [DF__SMA_CLIENT__CLIENT__idf_Source]	DEFAULT ('')
	,	idf_ModifiedDate		timestamp_ntz	NOT NULL --to be tested --> CONSTRAINT [DF__SMA_CLIENT__CLIENT__idf_ModifiedDate]	DEFAULT (getdate())
);

---************************************************************************************ 
--- Create keys (PK , Index, Default value), NOT FK
---************************************************************************************ 
--SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS ORDER BY TABLE_CATALOG , TABLE_SCHEMA , TABLE_NAME , CONSTRAINT_TYPE DESC;
--SHOW IMPORTED KEYS IN SMA_CLIENT.CLIENT;

--- Internal Data keys --- --- ---
ALTER TABLE SMA_CLIENT.CLIENT ADD CONSTRAINT PK__SMA_CLIENT__CLIENT__idf_CLIENT PRIMARY KEY (idf_CLIENT);
--???? ALTER TABLE SMA_CLIENT.CLIENT ADD CONSTRAINT UINDX__SMA_CLIENT__CLIENT__BizField1 PARAMETERS (BizField1);
-- ?????alter table SMA_CLIENT.CLIENT alter COLUMN BizField1 SET DEFAULT 1;

--- Business keys --- --- ---
--alter table SMA_CLIENT.CLIENT add constraint uindx__PUBLIC_CLIENT__?????? unique (??????);


---************************************************************************************ 
--- Test
---************************************************************************************     
SELECT * FROM INFORMATION_SCHEMA.TABLE_STORAGE_METRICS WHERE TABLE_DROPPED IS NULL AND TABLE_NAME = 'CLIENT';
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'SMA_CLIENT' AND TABLE_NAME = 'CLIENT' ORDER BY TABLE_SCHEMA, TABLE_NAME, ORDINAL_POSITION;
SELECT * FROM SMA_CLIENT.CLIENT;
SHOW TABLES;
SHOW COLUMNS;