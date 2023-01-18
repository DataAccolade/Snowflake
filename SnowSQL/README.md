## Frameworks
We have prepared frameworks for each of the Snowflake objects below.
- Database
- Warehouse
- Schema
- Table
- View
- SP-SQL
- SP-Python

*Note: SP stands for Stored Procedure.*

Scripts are written in a block format as mentioned.
1. Primary Tests/Evaluation
2. Cleanup
3. Extra Settings
4. Create object (Table/View/uSP/...)
5. Test

Lets go through each one of them one by one.

The blocks included in the Table script are used as an example.

1. Primary Tests/Evaluation
`-----************************************************************************************ 
----- Primary Tests/Evaluation
-----************************************************************************************ 
--SELECT * FROM INFORMATION_SCHEMA.TABLE_STORAGE_METRICS WHERE TABLE_DROPPED IS NULL AND TABLE_NAME = 'CLIENT';
--SELECT * FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'CLIENT' ORDER BY ORDINAL_POSITION;
--SELECT TOP 1000 * FROM SMA_CLIENT.CLIENT;`
2. Cleanup
3. Extra Settings
4. Create object (Table/View/uSP/...)
5. Test


[LICENSE](/LICENSE)
