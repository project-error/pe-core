Utils = {}

Utils.Debug = function(class, message)
    if Debug.debugLevel >= 1 then
        if class == "error" and Debug.debugLevel >= 1 then
            print(Debug.errorDebugColor.."[ERROR]:".. message .. "^7")
        elseif class == "success" and Debug.debugLevel >= 2 then
            print(Debug.successDebugColor.."[SUCCESS]:".. message .. "^7")
        elseif class == "inform" and Debug.debugLevel == 3 then
            print(Debug.informDebugColor.."[INFO]:".. message .. "^7")
        elseif class == "dev" and Debug.debugLevel == 3 then
            print(Debug.devDebugColor.."[DEBUG]:".. message .. "^7")
        elseif class ~= "error" and class ~= "success" and class ~= "inform" then
            print("^1[ERROR]: Invalid Debug Class: ^0".. class .. "^1 Please use 'error', 'success' or 'inform'.^7")
        end
    end
end

Utils.getPlayerIdentifier = function(playerId, identifierType)
    local identifier
    for k, v in ipairs(GetPlayerIdentifiers(playerId)) do 
		if string.match(v, ""..identifierType..":") then
			identifier = v
			break
		end
    end
    return identifier
end