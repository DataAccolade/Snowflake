# Snowflake Naming Convention
## Snowflake Naming Convention

### Snowflake Inner Objects' Naming Conventions

Data Accolade has created an excel file that contains Snowflake naming convention on the mentioned snowflake objects.
- Virtual Warehouse
- Database
- Schema
- Tables
- Views
- Storage
- File Format
- Sequence
- Procedure
- Function
- Pipe
- Stream
- Task

### Excel's Columns Description
A consistency definition is applied for each column within all excel worksheets. Each row within a worksheet may have a different function applied on the naming convention. For example, some names may need to be in lower-case form or another example is that some names can not have a "-" or "_".
| Excel Column | Header definitions | Header Description                      |
|--------------|--------------------|-----------------------------------------|
| A            | Object Name        | Name of the Snowflake objects (For example, Tables, DB, Virtual Warehouse, Function, Pipe, etc…) |
| C            | Snow Convention    | Post name of the Snowflake object, this will always be concated to the start of the string name, except VWH and DB names (For example: "P_" in the P_pipename) |
| D            | Prefix             | Prefix name within the object name |
| E            | PostFix            | Postfix name within the object name |
| F            | Name               | Object Name |
| G            | Suggested Name (Group 1) | First suggested name (generally with dash and underscore) |
| H            | Suggested Name (Group 2) | Second suggested name (generally without dash or underscore) |
| I            | Description              | More information about the object |


### How To Use Or Modify
In this section we are explaining how to use one of the excel sheets, the same logic can be used for other sheets.
- **`Step 1`**: Download the Excel file on your desktop
- **`Step 2`**: Select the desired sheet, in this example we are using the sheet "Table - View - Storage".
In this sheet, the list of schemas, tables, views, and storages can be defined.
- **`Step 3`**: Pick the right name for your objects. In this example, we are selecting the word "Client" for the table object. (See columns F in all excel sheets)
- **`Step 4`**: Apply a Postfix and/or a Prefix if required.
(See column D and C in all excel sheets)
Note: Clients' naming convention and your internal naming convention can be combined using columns D & E.
- **`Step 5`**: The best practice is not to change column C which contains the Snowflake naming convention as a prefix or a postfix. 
- **`Step 6`**: Use only one of the suggested names in your codes/scripts (Column G or H)
- **`Step 7`**: To add more objects within the excel file, you may add a new row to the excel sheet.
For example, 


### Like to have the Code?
- Download the script/code/file? Click [here](https://github.com/DataAccolade/Snowflake/raw/main/Snowflake%20Naming%20Convention/SnowflakeNamingConvention.xlsx)        and have fun!

## LICNESE
[MIT](/LICENSE)


