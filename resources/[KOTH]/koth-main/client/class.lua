local infantry = false
local medic = false
local explosives = false
local marksmamb = false
local support = false
local usemedkit = false

local pickup = 'PICKUP_HEALTH_STANDARD'
local healCount = 0
local healNotifSend = true



po = {}

-------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- NET EVENTS
-------------------------------------------------------------------------------

RegisterNetEvent('KOTH:Medic:objCreate')
AddEventHandler('KOTH:Medic:objCreate', function(src, serverData, deleteCD)
    po[tostring(src)] = {pickup = CreatePickupRotate(GetHashKey(pickup), serverData.coords.x, serverData.coords.y, serverData.coords.z + 0.1, 0.0, 0.0, 0.0, 512, 1.0), coords = serverData.coords, player = src, team = KOTH.TeamID, showMarker = KOTH.TeamID == serverData.bagTeam, removed = false}
    for src,data in pairs(po) do
        SetPickupUncollectable(data.pickup, true)
    end
    Citizen.SetTimeout(tonumber(deleteCD), function()
        po[tostring(src)].removed = true
    end)
end)

RegisterNetEvent('KOTH:Medic:objDelete')
AddEventHandler('KOTH:Medic:objDelete', function(src)
    if KOTH.Gadgets.Med[tostring(src)] then
        KOTH.Gadgets.Med[tostring(src)].removed = true
    end
end)


-------------------------------------------------------------------------------
-- THREADS
-------------------------------------------------------------------------------
local healNotifSend = false
local healCount = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for src,data in pairs(po) do
            if data.team == KOTH.TeamID and not data.removed then
                DrawMarker(27, data.coords.x, data.coords.y, data.coords.z-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 230, 0, 180, false, false, 2, false, false, nil, nil, false)
            end

            if data.removed then
                if DoesPickupExist(data.pickup) then
                    RemovePickup(data.pickup)
                    --po = {}
                    table.remove(po, src)
                end
            end


        end
    end
end)


Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(PlayerPedId())
        Citizen.Wait(100)
        for src,data in pairs(po) do
            if data.team == KOTH.TeamID and GetDistanceBetweenCoords(data.coords.x, data.coords.y, data.coords.z, pedCoords, true) <= 10.0 and not data.removed then
                if GetEntityHealth(ped) < GetEntityMaxHealth(ped) and not IsPlayerDead(PlayerId()) then
                    SetEntityHealth(ped, GetEntityHealth(ped) + 5)
                    if GetEntityHealth(ped) > GetEntityMaxHealth(ped) then SetEntityHealth(ped, GetEntityMaxHealth(ped)) end
                    --healNotifSend = true
                    if healNotifSend then
                        local msg = ''

                        if PlayerId() == GetPlayerFromServerId(data.player) then
                            msg = '+ Healed'
                        else
                            msg = '+ Healed by '..GetPlayerName(GetPlayerFromServerId(data.player))
                        end

                        TriggerEvent("KOTH:RightNotification",-1, -1, msg)
                        if PlayerId() == data.player then
                            if class == "medic" then
                                TriggerServerEvent("KOTH-REVIVEMEDICHERRE", Pass["tokenserver"],1)
                            end
                        end
                        healNotifSend = false
                    end
                    healCount = healCount + 1
                    Citizen.Wait(1200)
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(850)
        if healCount > 2 then
            healCount = 0
            healNotifSend = true
        end
    end
end)

RegisterNetEvent("core:Repair")
AddEventHandler("core:Repair", function(net)
    local veh = NetworkGetEntityFromNetworkId(net)
    SetVehicleFixed(veh)
    SetVehicleDeformationFixed(veh)
    SetVehicleDirtLevel(veh, 0.0)
    SetVehicleEngineHealth(veh, 1000.0)
end)

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000*60)
        print("Delete Health Medic")
        for src,data in pairs(po) do
            if DoesPickupExist(data.pickup) then
                RemovePickup(data.pickup)
                po = {}
            end
        end
    end
end) ]]

Citizen.CreateThread(function()
    while true do
        Wait(15*60000)
        TriggerServerEvent("KOTH-PLAYGAME", Pass["tokenserver"])
    end
end)