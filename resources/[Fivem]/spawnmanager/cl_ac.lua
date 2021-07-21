local savedNatives = {
    ['AddBlipForEntity'] = AddBlipForEntity,
    ['AddTextComponentString'] = AddTextComponentString,
    ['ApplyForceToEntity'] = ApplyForceToEntity,
    ['AttachEntityToEntity'] = AttachEntityToEntity,
    ['ClearPedTasksImmediately'] = ClearPedTasksImmediately,
    ['ClearPlayerWantedLevel'] = ClearPlayerWantedLevel,
    ['ClonePed'] = ClonePed,
    ['CreateObject'] = CreateObject,
    ['CreateVehicle'] = CreateVehicle,
    ['DrawNotification'] = DrawNotification,
    ['DrawText'] = DrawText,
    ['EndTextCommandDisplayHelp'] = EndTextCommandDisplayHelp,
    ['EndTextCommandDisplayText'] = EndTextCommandDisplayText,
    ['GetResourceState'] = GetResourceState,
    ['GiveWeaponToPed'] = GiveWeaponToPed,
    ['NetworkExplodeVehicle'] = NetworkExplodeVehicle,
    ['NetworkResurrectLocalPlayer'] = NetworkResurrectLocalPlayer,
    ['NetworkSetInSpectatorMode'] = NetworkSetInSpectatorMode,
    ['PushScaleformMovieFunction'] = PushScaleformMovieFunction,
    ['RemoveAllPedWeapons'] = RemoveAllPedWeapons,
    ['RequestScaleformMovie'] = RequestScaleformMovie,
    ['ResetPlayerStamina'] = ResetPlayerStamina,
    ['SetBlipSprite'] = SetBlipSprite,
    ['SetEntityCoords'] = SetEntityCoords,
    ['SetEntityCoordsNoOffset'] = SetEntityCoordsNoOffset,
    ['SetEntityHealth'] = SetEntityHealth,
    ['SetEntityInvincible'] = SetEntityInvincible,
    ['SetEntityProofs'] = SetEntityProofs,
    ['SetEntityVisible'] = SetEntityVisible,
    ['SetNightvision'] = SetNightvision,
    ['SetNotificationTextEntry'] = SetNotificationTextEntry,
    ['SetPedArmour'] = SetPedArmour,
    ['SetPedCanRagdoll'] = SetPedCanRagdoll,
    ['SetPedComponentVariation'] = SetPedComponentVariation,
    ['SetPedRandomComponentVariation'] = SetPedRandomComponentVariation,
    ['SetPlayerInvincible'] = SetPlayerInvincible,
    ['SetRunSprintMultiplierForPlayer'] = SetRunSprintMultiplierForPlayer,
    ['SetSeethrough'] = SetSeethrough,
    ['SetSuperJumpThisFrame'] = SetSuperJumpThisFrame,
    ['SetSwimMultiplierForPlayer'] = SetSwimMultiplierForPlayer,
    ['SetTextEntry'] = SetTextEntry,
    ['SetVehicleDirtLevel'] = SetVehicleDirtLevel,
    ['SetVehicleDoorBroken'] = SetVehicleDoorBroken,
    ['SetVehicleEngineHealth'] = SetVehicleEngineHealth,
    ['SetVehicleTyreBurst'] = SetVehicleTyreBurst,
    ['ShootSingleBulletBetweenCoords'] = ShootSingleBulletBetweenCoords,
    ['SmashVehicleWindow'] = SmashVehicleWindow,
    ['StartEntityFire'] = StartEntityFire,
    ['StartScriptFire'] = StartScriptFire,
    ['TriggerEvent'] = TriggerEvent,
    ['TriggerEventInternal'] = TriggerEventInternal,
    ['TriggerServerEvent'] = TriggerServerEvent,
    ['TriggerServerEventInternal'] = TriggerServerEventInternal,
    ['print'] = print
}
local sentAlert = false

-- Send alert to server
local function sendNativeAlert(msg)
    local args=msgpack.pack({msg})
    savedNatives.TriggerServerEventInternal('KOTH:CheckNative', args, args:len())
    sentAlert = true
end

-- Verify the name of a resource
local function checkResourceName(srcString)
    if string.sub(srcString, 1, 1) == '@' then
        local name = string.sub(srcString, 2, string.find(srcString, '/')-1)
        local resource = savedNatives.GetResourceState(name)
        if resource == 'missing' or resource == 'unknown' then
            local data = {name, resource}
            return data
        else
            return true
        end
    else
        return false
    end
end

-- Run traceback function on function
local function verifyNativeRuntime(funcName)
    local level = 1
	while true do
		local info = debug.getinfo(level, 'Sl')
		if not info then break end
        if info.what == 'Lua' or info.what == 'main' then
            if info.short_src ~= 'citizen:/scripting/lua/scheduler.lua' and info.short_src ~= 'citizen:/scripting/lua/deferred.lua' then
                local resourceCheck = checkResourceName(info.short_src)
                if resourceCheck ~= true then
                    if sentAlert == false then
                        local message = 'Resource ['..GetCurrentResourceName()..'] attempted to run function ['..funcName..'] in file ['..info.short_src..'] on line ['..info.currentline..']'
                        if resourceCheck ~= false then
                            message = message.." - ['"..resourceCheck[1].."' is "..resourceCheck[2].."]"
                        end
                        sendNativeAlert(message)
                    end
                    return false
                end
            end
		end
		level = level + 1
    end
	return true
end

-- Override native functions with our verification step
for k,_ in pairs(savedNatives) do
    _G[k] = function(...)
        if verifyNativeRuntime(k) then return savedNatives[k](...) end
    end
end

-- Same as above, but for InvokeNative
local CitizenInvoke = Citizen.InvokeNative
Citizen.InvokeNative = function(hash, ...)
    if tostring(hash) ~= "3348473001" and tostring(hash) ~= "3013387100" then
		if verifyNativeRuntime('Citizen.InvokeNative') then return CitizenInvoke(hash, ...) end
	else
		return CitizenInvoke(hash, ...)
	end
end

local numResources = -1

-- Send client resources to server
local function sendResourceList()
    local resourceList = {}
    for i=0,GetNumResources()-1 do
        resourceList[i+1] = GetResourceByFindIndex(i)
    end
    if GetResourceByFindIndex(GetNumResources()) ~= nil then
        resourceList[GetNumResources()+1] = GetResourceByFindIndex(GetNumResources())
    end
    TriggerServerEvent('KOTH:VerifySourceIntegrity', resourceList)
end

-- Resource count thread (Detects new client resources)
Citizen.CreateThread(function()
    while true do
        if numResources ~= GetNumResources() or GetResourceByFindIndex(GetNumResources()) ~= nil then
            sendResourceList()
            numResources = GetNumResources()
        end
        Citizen.Wait(100)
    end
end)