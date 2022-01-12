# pe-core
## THIS IS NOT A FULL FRAMEWORK!
This **purely** exist as a way to insert identifier data when a player joins a server. Strictly to provide compatability with [NPWD](https://github.com/project-error/npwd) for those who use menu based servers and don't want to add unnecessary frameworks to store identifiers.

### Dependencies
While this is a simple resource, it does require a single depency as found below:

- [oxmysql](https://github.com/overextended/oxmysql)

### Setting Your Database
You're welcome to change the database name found within the `pe-core.sql`, but be sure to update your `server.cfg` too. 

To maintian customability, the `sv_config.lua` contains configuration for database querries:

- `Database.identifierType`
    - Default Value = `'license'`
    - We recomend not changing this but you can use any of the following: `steam`, `license`, `xbl`, `ip`, `discord` and `live`.
- `Database.identifierColumn`
    - Column where the identifier is stored. This is unique to each player.
- `Database.playerTable`
    - Table where anything pertaining to the player is stored. 

**Note:** If you change anything within the `sv_config` related to database information you'll need to adjust the `pe-core.sql` to reflect these changes.

#### Steps
1. Ensure you have installed the dependencies correctly.
2. Ensure you have a connection string listed within your `server.cfg`. If you don't you will need to add it to your `server.cfg`. It will look something like this with information changed:

```
set mysql_connection_string "mysql://root:12345@localhost/pe-core?charset=utf8mb4"
```

3. Run the `pe-core.sql`

### NPWD Integration

Alter your [config.json](https://github.com/project-error/npwd/blob/master/config.json) to match the following:
```json
  "general": {
    "useResourceIntegration": true,
    "toggleKey": "f1",
    "toggleCommand": "phone"
  },
  "database": {
    "useIdentifierPrefix": true,
    "playerTable": "users",
    "identifierColumn": "identifier",
    "identifierType": "license",
    "profileQueries": true,
    "phoneNumberColumn": "phone_number"
  },
```

### Debug Mode
This strictly controls the prints you recieve within the server console. The level ranges from 0 to 3.

You can use it by doing:
```lua
Utils.Debug('error'--[[the debug class]], "hello"--[[message]])
```
Configuration is as followed:
- `Debug.debugLevel`
    - Default value = 1
    - 0 = Disabled (Not Recomended)
    - 1 = Only errors
    - 2 = Errors and Success
    - 3 = Errors, Success and Informs (Everything)
- Debug Classes:
    - `"Error"`
    - `"Success"`
    - `"Inform"`
- Debug Colors:
    - `"^0"` = White
    - `"^1"` = Red
    - `"^2"` = Green
    - `"^3"` = Yellow
    - `"4"` = Blue
    - `"^5"` = Light Blue
    - `"^6"` = Purple
    - `"^7"` = Default
    - `"^8"` = Dark Red
    - `"^9"` = Dark Blue
