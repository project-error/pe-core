local playerSpawned = false

RegisterNetEvent('pe-core:spawnPlayer')
AddEventHandler('pe-core:spawnPlayer', function(posX, posY, posZ, Heading, Model)
    repeat exports.spawnmanager:spawnPlayer({
        x           = posX,
        y           = posY, 
        z           = posZ,
        heading     = Heading,
        model       = Model,
        skipFade    = false
    }, function(spawn)
        if spawn ~= nil then
            playerSpawned = true
            print('Spawned player')
        else
            print('ERROR: Failed to spawn!')
        end
    end)
    Wait(500)
    until playerSpawned
end)