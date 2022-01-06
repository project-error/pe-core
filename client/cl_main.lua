CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
            TriggerServerEvent('pe-core:onPlayerJoined')
			break
		end
	end
end)