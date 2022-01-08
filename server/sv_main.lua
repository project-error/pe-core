AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local identifier = Utils.getPlayerIdentifier(source, Database.identifierType)
	deferrals.defer()

    Wait(0)

    if identifier then
        deferrals.done()
    else
        deferrals.done('Identifier not found.')
    end
end)

RegisterNetEvent('pe-core:onPlayerJoined')
AddEventHandler('pe-core:onPlayerJoined', function()
    local playerId <const> = source
    local identifier = Utils.getPlayerIdentifier(playerId, Database.identifierType)

    if not identifier then 
        DropPlayer(playerId, "An error occured while trying to join the server. \n Identifier "..Database.identifierType.."not found. \n Please try again later.")
        Utils.Debug('error', "Player ["..playerId.."] has been kicked due to missing Identifier "..Database.identifierType.."")
        return 
    end
    Utils.Debug('success', "Player ["..playerId.."] has joined the server.")
    MySQL.scalar('SELECT 1 FROM ?? WHERE ?? = ?', {Database.playerTable, Database.identifierColumn, identifier}, function(result)
        if result then
            TriggerEvent('pe-core:playerLoaded', playerId, identifier)
        else
            Utils.Debug('inform', "Identifier ["..identifier.."] doesn't exist into the database.")
            Utils.Debug('inform', "Inserting identifier ["..identifier.."] into the database.")
            MySQL.insert('INSERT INTO ?? (??) VALUES (?)', {Database.playerTable, Database.identifierColumn, identifier}, function(character_id)
                Utils.Debug('inform', "Inserted player into the database: {\n Identifier ["..identifier.."] \n Character ID ["..character_id.."] \n}")
                TriggerEvent('pe-core:playerLoaded', playerId, identifier)
            end)
        end
    end)
end)

AddEventHandler('pe-core:playerLoaded', function(playerId, identifier)
    local player = Player(playerId)

    player.state:set('loaded', true, false)
    Utils.Debug('success', "Player ["..playerId.."] has been loaded.")
end)