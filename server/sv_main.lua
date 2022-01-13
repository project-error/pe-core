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
    MySQL.single('SELECT * FROM ?? WHERE ?? = ?', {Database.playerTable, Database.identifierColumn, identifier}, function(result)
        if result then
            if GetResourceState('npwd') == 'started' then
                Utils.Debug('inform', 'NPWD enabled. Triggering server export ^2[npwd:newPlayer]^5.')
                exports.npwd:newPlayer({ 
                    source 		= playerId, 
                    identifier 	= identifier,
                    phoneNumber     = result.phone_number
				})
            end
            TriggerEvent('pe-core:playerLoaded', playerId, identifier)
        else
            if GetResourceState('npwd') == 'started' then
                Utils.Debug('inform', "Identifier ["..identifier.."] doesn't exist into the database.")
                Utils.Debug('inform', "Inserting identifier ["..identifier.."] into the database.")
                local phoneNumber = exports.npwd:generatePhoneNumber()
                MySQL.insert('INSERT INTO ?? (??,??) VALUES (?,?)', {Database.playerTable, Database.identifierColumn, 'phone_number', identifier, phoneNumber}, function(character_id)
                    Utils.Debug('inform', "Inserted player into the database: {\n Identifier ["..identifier.."] \n Character ID ["..character_id.."] \n}")
                    exports.npwd:newPlayer({ 
                        source      = playerId, 
                        identifier 	= identifier,
                        phoneNumber = phoneNumber
                    })
                end)
            end
            TriggerEvent('pe-core:playerLoaded', playerId, identifier)
        end
    end)
end)

AddEventHandler('pe-core:playerLoaded', function(playerId, identifier)
    local player = Player(playerId)
    local position = json.decode(Config.defaultSpawn)

    player.state:set('loaded', true, false)
    Utils.Debug('success', "Player ["..playerId.."] has been loaded.")
    if Config.useSpawn then
        TriggerClientEvent('pe-core:spawnPlayer', playerId, position.x, position.y, position.z, position.w, Config.defaultModel)
    end
end)
