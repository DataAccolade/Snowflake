# Naming Convention
## Naming Covention for Snowflake

### TEMPLATES BY OBJECT TYPES
- [Virtual Warehouse](Virtual%20Warehouse/README.md)
- [Database](Database/README.md)
- [Schema](Schema/README.md)
- [Tables](Tables/README.md)
- [Views](Views/README.md)
- [Storage](Storage/README.md)
- [File Format](File%20Format/README.md)
- [Sequence](Sequence/README.md)
- [Procedure](Procedure/README.md)
- [Function](Function/README.md)
- [Pipe](Pipe/README.md)
- [Stream](Stream/README.md)
- [Task](Task/README.md)

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
- Step 1 (*Mandatory*): Always change the Object names (See columns F in all excel sheets)
- Step 2 (*Do one of the following*):
    - Example 1: Only change/Add the Prefix and Postfix names of the object names (See column D and C in all excel sheets)
    - Change all columns in all excel sheets (Column C, D, E, F)
- Use: Use only one of the suggested names in your codes/scripts (Column G or H)

## LICNESE
[MIT](/LICENSE)


