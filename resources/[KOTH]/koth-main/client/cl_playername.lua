local teams = {
    [1] = 28,
    [2] = 40,
    [3] = 18
}

local vehList = {
    blips = {
        ['car'] = 225,
        ['motor'] = 348,
        ['boat'] = 427,
        ['heli'] = 422,
        ['plane'] = 423,
        ['cycle'] = 559,

        ['tank'] = 421,
        ['dune'] = 561,
        ['truck'] = 67,
        ['sport'] = 596,
        ['techLight'] = 426,
        ['apc'] = 558,
        ['techFull'] = 601,

        ['attack'] = 576,
        ['vtol'] = 589
    },
    models = {
        [GetHashKey('rhino')] = 'tank',
        [GetHashKey('dune3')] = 'dune',
        [GetHashKey('barracks')] = 'truck',
        [GetHashKey('dukes2')] = 'sport',
        [GetHashKey('technical')] = 'techLight',
        [GetHashKey('apc')] = 'apc',
        [GetHashKey('barrage')] = 'techFull',
        [GetHashKey('tampa3')] = 'sport',

        [GetHashKey('hunter')] = 'attack',
        [GetHashKey('avenger')] = 'vtol',
        [GetHashKey('OSPREY')] = 'vtol'
    }
}

InfoTeam = {}
local playerBlips = {}
local playerTags = {}


RegisterNetEvent("UpdateInfoClient")
AddEventHandler("UpdateInfoClient",function(team)
    InfoTeam = team
end)

function table.contains(table, element)
    for k,_ in pairs(table) do
        if k == element then
            return true
        end
    end
    return false
end

function checkVehType(class, model)
    if table.contains(vehList.models, model) then
        return vehList.blips[vehList.models[model]]
    elseif class >= 1 and class <= 21 and class ~= 8 and class ~= 14 and class ~= 15 and class ~= 16 and class ~= 13 then
        return vehList.blips['car']
    elseif class == 8 then
        return vehList.blips['motor']
    elseif class == 14 then
        return vehList.blips['boat']
    elseif class == 15 then
        return vehList.blips['heli']
    elseif class == 16 then
        return vehList.blips['plane']
    elseif class == 13 then
        return vehList.blips['cycle']
    else
        return nil
    end
end

local gamerTags = {}

function updatePlayerNames()
    SetTimeout(0, updatePlayerNames)

    if KOTH.TeamID == 0 then 
        return 
    end

    for z = 1, 12 do
        EnableDispatchService(z, false)
    end
    local localCoords = GetEntityCoords(PlayerPedId())

            local memberList = {}

                    -- Update Player Blips

            if KOTH.TeamID == -1 then
                memberList = GetActivePlayers()
            elseif KOTH.TeamID == 0 then
                memberList = GetActivePlayers()

            elseif InfoTeam[KOTH.TeamID] then
                memberList = InfoTeam[KOTH.TeamID].members
            end


            if staffService then
                for _, v in pairs(GetActivePlayers()) do
                    

                    local otherPed = GetPlayerPed(v)
                    local pCoords = GetEntityCoords(PlayerPedId())
                    if otherPed ~= PlayerPedId() then
                        if #(pCoords - GetEntityCoords(otherPed, false)) < 180.0 then
                            gamerTags[v] = CreateFakeMpGamerTag(otherPed," ["..GetPlayerServerId(v).."] "..GetPlayerName(v).."("..GetEntityHealth(otherPed)..")", false, false, "", 0)
                            SetMpGamerTagVisibility(gamerTags[v], 2, true)
                            SetMpGamerTagHealthBarColour(gamerTags[v], 0)
                            SetMpGamerTagName(gamerTags[v]," ["..GetPlayerServerId(v).."] "..GetPlayerName(v).."("..GetEntityHealth(otherPed)..")")
                            if NetworkIsPlayerTalking(v) then
                                SetMpGamerTagVisibility(gamerTags[v], 16, 1)
                            else
                                SetMpGamerTagVisibility(gamerTags[v], 16, 0)
                            end
                        else
                            RemoveMpGamerTag(gamerTags[v])
                            gamerTags[v] = nil
                        end
                    end
                end
            elseif not staffService then
                for key,playerID in pairs(memberList) do
                    local nameTag = ''..playerID.name..''
                    local serverID = playerID.id
                    
                    player = GetPlayerFromServerId(serverID)
                    local ped1 = GetPlayerPed(player)
                    local blip = GetBlipFromEntity(ped1)
                    --if ped1 and ped1 ~= GetPlayerPed(-1) then
                        local headId = CreateFakeMpGamerTag(ped1, "["..GetPlayerServerId(player).."] - "..GetPlayerName(player).."", false, false, '', false)
        
                        SetMpGamerTagAlpha(headId, 0,255)
                        SetMpGamerTagAlpha(headId, 7, 255)
                        SetMpGamerTagAlpha(headId, 4, 255)
                        SetMpGamerTagVisibility(headId, 0, true)
                        SetMpGamerTagVisibility(headId, 7, true)
                        SetMpGamerTagVisibility(headId, 4, NetworkIsPlayerTalking(player))
        
                        if NetworkIsPlayerTalking(player) then
                            SetMpGamerTagColour(headId, 0, 211)
                            SetMpGamerTagColour(headId, 4, 211)
                        else
                            SetMpGamerTagColour(headId, 0, teams[KOTH.TeamID])
                            SetMpGamerTagColour(headId, 4, teams[KOTH.TeamID])
                        end
        
                        playerTags[serverID] = headId

                        if not DoesBlipExist(blip) then
                            blip = AddBlipForEntity(ped1)
                            playerBlips[serverID] = blip
                            SetBlipSprite(blip, 1)
                            ShowHeadingIndicatorOnBlip(blip, true)
                        else
                            local veh = GetVehiclePedIsIn(ped1, false)
                            local blipSprite = GetBlipSprite(blip)
        
                            if IsEntityDead(ped1) then
                                -- Dead Player
                                if blipSprite ~= 274 then
                                    SetBlipSprite(blip, 274)
                                    ShowHeadingIndicatorOnBlip(blip, true)
                                    HideNumberOnBlip(blip)
                                end
                            elseif veh then
                                local vehClass = GetVehicleClass(veh)
                                local vehModel = GetEntityModel(veh)
                                local blipSNum = checkVehType(vehClass, vehModel)
        
                                if blipSNum then
                                    if blipSprite ~= blipSNum then
                                        SetBlipSprite(blip, blipSNum)
                                        ShowHeadingIndicatorOnBlip(blip, true)
                                    end
                                else
                                    if blipSprite ~= 1 then
                                        SetBlipSprite(blip, 1)
                                        ShowHeadingIndicatorOnBlip(blip, true)
                                        HideNumberOnBlip(blip)
                                    end
                                end
        
                                local passengers = GetVehicleNumberOfPassengers(veh)
        
                                if passengers then
                                    if not IsVehicleSeatFree(veh, -1) then
                                        passengers = passengers + 1
                                    end
        
                                    if IsPedInVehicle(ped1, veh, false) then
                                        ShowNumberOnBlip(blip, passengers)
                                    else
                                        HideNumberOnBlip(blip)
                                    end
                                else
                                    HideNumberOnBlip(blip)
                                end
                            else
                                HideNumberOnBlip(blip)
        
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    ShowHeadingIndicatorOnBlip(blip, true)
                                    HideNumberOnBlip(blip)
                                end
                            end
        
                            SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                            SetBlipNameToPlayerName(blip, player)
                            SetBlipScale(blip, 0.8)
                            SetBlipCategory(blip, 7)
                            SetBlipAlpha(blip, 255)
                        end
                    --end
                end
            end
   --    end
   -- end
end


AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        TriggerEvent("KOTH:ClearAllBlips")
    end
end)

RegisterNetEvent("KOTH:ClearAllBlips")
AddEventHandler("KOTH:ClearAllBlips", function()
    for _,blip in pairs(playerBlips) do
        RemoveBlip(blip)
    end
    playerBlips = {}

    for _,tag in pairs(playerTags) do
        SetMpGamerTagVisibility(tag, 0, false)
    end
    playerTags = {}
end)

RegisterNetEvent("KOTH:ClearPlayerBlip")
AddEventHandler("KOTH:ClearPlayerBlip", function(serverID)
    if playerBlips[serverID] then
        RemoveBlip(playerBlips[serverID])
        playerBlips[serverID] = nil
    end

    if playerTags[serverID] then
        SetMpGamerTagVisibility(playerTags[serverID], 0, false)
        playerTags[serverID] = nil
    end
end)

--RegisterNetEvent('koth:adminnames')
--AddEventHandler('koth:adminnames', function()
--    adminColours = not adminColours
--end)

-- Disable blind fire
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsPedInCover(ped, 1) and not IsPedAimingFromCover(ped, 1) then 
            DisableControlAction(2, 24, true) 
            DisableControlAction(2, 142, true)
            DisableControlAction(2, 257, true)
        end        
    end
end)


--[[
    for key,playerID in pairs(memberList) do
        --if ped1 and ped1 ~= GetPlayerPed(-1) then
            local headIde = CreateFakeMpGamerTag(ped1, "["..GetPlayerServerId(player).."] - "..GetPlayerName(player).."", false, false, '', false)

            SetMpGamerTagAlpha(headIde, 0, 255)
            SetMpGamerTagAlpha(headIde, 4, 255)
            SetMpGamerTagVisibility(headIde, 0, true)
            --SetMpGamerTagVisibility(headId, 4, NetworkIsPlayerTalking(player))
       -- end
    end
    playerTags = {}
--]]
-- run this function every frame
SetTimeout(0, updatePlayerNames)

Citizen.CreateThread(function()
    while true do
        Wait(15000)
        for _, v in pairs(gamerTags) do
            RemoveMpGamerTag(v)
            gamerTags[v] = nil
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        N_0x4757f00bc6323cfe(-1553120962, 0.0) 
        Wait(0)
    end
end)

function Remove()
    for _, v in pairs(gamerTags) do
        RemoveMpGamerTag(v)
        gamerTags[v] = nil
    end
end
