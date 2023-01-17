# Naming Convention
## Naming Covention for Snowflake

### TEMPLATES BY OBJECT TYPES
- [Virtual Warehouse](Virtual%20Warehouse)
- [Database](Database)
- [Schema](Schema)
- [Tables](Tables)
- [Views](Views)
- [Storage](Storage)
- [File Format](File%20Format)
- [Sequence](Sequence)
- [Procedure](Procedure)
- [Function](Function)
- [Pipe](Pipe)
- [Stream](Stream)
- [Task](Task)

### COlUMNS EXPLANATION
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


### HOW TO USE OR MODIFY
- Step 1: Clone or Download this repository
- Step 2: Go to one of the objects' folders
- Step 3: Open Excel file
- Step 4 (*Mandatory*): Always change the Object names (See columns F in all excel sheets)
- Step 5 (*Do one of the following*):
    - Example 1: Only change/Add the Prefix and Postfix names of the object names (See column D and C in all excel sheets)
    - Example 2: Change all columns in all excel sheets (Column C, D, E, F)
- Use: Use only one of the suggested names in your codes/scripts (Column G or H)

## LICNESE
[MIT](/LICENSE)

