local mapBlips = {}
local zoneArea
local zoneBlip
PosZone = nil
PosBaseBle = nil
PosBaseRou = nil
PosBaseVer = nil
Possss = nil
centerPos = nil

TriggerServerEvent("MapPositon")
RegisterNetEvent("MapPosition")
AddEventHandler("MapPosition", function(map)
    print("Zone Generate Client")
    Possss = map
    PosZone = map.poscombat
    PosBaseBle = map.posBaseBleu
    PosBaseRou = map.posBaseRouge
    PosBaseVer = map.posBaseVert
end)

Citizen.CreateThread(function()
    TriggerServerEvent("AddClientServerCode")

    while PosBaseVer == nil and Pass == nil do
        TriggerServerEvent("MapPositon")
        Wait(1)
    end
    Wait(800)
    GetZone()
    --startCamera()
end)
function GetZone()
    mapBlips = {}
    zoneArea = nil
    zoneBlip = nil
    zoneArea = AddBlipForRadius(PosZone.x,PosZone.y,PosZone.z, 270.0)
    zoneBlip = AddBlipForCoord(PosZone.x,PosZone.y,PosZone.z)
    SetBlipSprite(zoneArea, 9)
    SetBlipColour(zoneArea, 4)
    SetBlipAlpha(zoneArea, 95)
    SetBlipSprite(zoneBlip, 176)
    SetBlipColour(zoneBlip, 4)
    SetBlipAlpha(zoneBlip, 400)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Zone de combat")
    EndTextCommandSetBlipName(zoneBlip)
    table.insert(mapBlips, zoneArea)
end

local ZoNeCo = false
local Teamssss = nil
RegisterNetEvent("SetZoneOwner")
AddEventHandler("SetZoneOwner", function(teamid)
    if teamid == teamplayers then
        return
    else
        Teamssss = teamid

        if teamid and teamid ~= -2 then
            SetBlipColour(zoneArea, Teams[teamid].colour)
            SetBlipColour(zoneBlip, Teams[teamid].colour)  
        elseif teamid and teamid == -2 then -- if zone is contested
            SetBlipColour(zoneArea, 5)
            SetBlipColour(zoneBlip, 5)
        else 
            SetBlipColour(zoneArea, 4)
            SetBlipColour(zoneBlip, 4)
        end
    end
end)

inBase = false
Citizen.CreateThread(function()
    Wait(2500)
    while true do
        Wait(1)
        local pPedCoords = GetEntityCoords(PlayerPedId())
        if KOTH.TeamID == 1 then
            local shopcar = GetDistanceBetweenCoords(pPedCoords , Possss.posvoitureshopR, true)
            if shopcar <= 3.0 then
                Help("Press on ~INPUT_CONTEXT~ to open Shop")
                if IsControlJustPressed(0, 51) then
                    TriggerEvent("KOTH-OpenShop", Pass["shop"], "vehicule")
                end
            end

            local shopweapon = GetDistanceBetweenCoords(pPedCoords , Possss.posweaponshopR, true)
            if shopweapon <= 3.0 then
                Help("Press on ~INPUT_CONTEXT~ to open Shop")
                if IsControlJustPressed(0, 51) then
                    TriggerEvent("KOTH-OpenShop", Pass["shop"], "weapon", "redfor")
                end
            end

            local base = GetDistanceBetweenCoords(pPedCoords,  PosBaseRou, true)

            if base <= 150.0 then
                inBase = true
            else
                inBase = false
            end
        elseif KOTH.TeamID == 2 then
            local shopcar = GetDistanceBetweenCoords(pPedCoords,  Possss.posvoitureshopB, true)
            if shopcar <= 3.0 then
                Help("Press on ~INPUT_CONTEXT~ to open Shop")
                if IsControlJustPressed(0, 51) then
                    TriggerEvent("KOTH-OpenShop", Pass["shop"], "vehicule")
                end
            end

            local shopweapon = GetDistanceBetweenCoords(pPedCoords , Possss.posweaponshopB, true)
            if shopweapon <= 3.0 then
                Help("Press on ~INPUT_CONTEXT~ to open Shop")
                if IsControlJustPressed(0, 51) then
                    TriggerEvent("KOTH-OpenShop", Pass["shop"], "weapon", "blufor")
                end
            end

            local base = GetDistanceBetweenCoords(pPedCoords,  PosBaseBle, true)

            if base <= 150.0 then
                inBase = true
            else
                inBase = false
            end
        elseif KOTH.TeamID == 3 then
            local shopcar = GetDistanceBetweenCoords(pPedCoords,  Possss.posvoitureshopG, true)
            if shopcar <= 3.0 then
                Help("Press on ~INPUT_CONTEXT~ to open Shop")
                if IsControlJustPressed(0, 51) then
                    TriggerEvent("KOTH-OpenShop", Pass["shop"], "vehicule")
                end
            end

            local shopweapon = GetDistanceBetweenCoords(pPedCoords, Possss.posweaponshopG, true)
            if shopweapon <= 3.0 then
                Help("Press on ~INPUT_CONTEXT~ to open Shop")
                if IsControlJustPressed(0, 51) then
                    TriggerEvent("KOTH-OpenShop", Pass["shop"], "weapon","independant")
                end
            end

            local base = GetDistanceBetweenCoords(pPedCoords,  PosBaseVer, true)
            if base <= 150.0 then
                inBase = true
            else
                inBase = false
            end
        end
        if inBase then
            local ped = PlayerPedId()

            --for vehicle in EnumerateVehicles() do
            --    if DoesEntityExist(vehicle) then
            --        SetEntityNoCollisionEntity(vehicle, vehicle, true)
            --        SetEntityNoCollisionEntity(vehicle, ped, true)
--
            --        if IsPedInAnyVehicle(ped) then
            --            SetEntityNoCollisionEntity(GetVehiclePedIsIn(ped), vehicle, true)
            --        end
            --    end
            --end
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                Help("Press ~INPUT_CONTEXT~ to repair car")
                --local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                --SetEntityCollision(veh,true, 50.0)
                if IsControlJustPressed(1, 51) then 
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    local ServerID = GetPlayerServerId(NetworkGetEntityOwner(veh))
                    TriggerServerEvent("KothRepaireCar", VehToNet(veh), ServerID)
                end
            end
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.48) SetPlayerInvincible(PlayerId(), true) DisablePlayerFiring(PlayerId(), true) 
        else 
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0) SetPlayerInvincible(PlayerId(), false)
        end
    end
end)


local passenger_store = 0
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)

        if not isPlayerInZone and antiDupe then 
            antiDupe = false 
        end

        if IsPedInAnyVehicle(ped, true) then
            local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
            local passengerData = {}
            for i =- 1, maxSeats do
                if GetPedInVehicleSeat(vehicle, i) ~= 0 then
                    local ped = GetPedInVehicleSeat(vehicle, i)
                    local driver = false
                    if i == -1 then 
                        driver = true 
                    end
                    if NetworkGetPlayerIndexFromPed(ped) then
                        table.insert(passengerData, { driver = driver, name = GetPlayerName(NetworkGetPlayerIndexFromPed(ped)) })
                    else
                        table.insert(passengerData, { driver = driver, name = "N/A" })
                    end
                end
            end
            TriggerEvent('koth-hud:SetVehicleData', passengerData)
        end
        if vehicle ~= 0 and ped == GetPedInVehicleSeat(vehicle, -1) then
            local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle) - 1
            local carrier = 0
            for i = 0, maxSeats do 
                if GetPedInVehicleSeat(vehicle, i) ~= 0 then
                    carrier = tonumber(carrier + 1)
                end
            end
			if inBase then
                passenger_store = carrier
			end
            if passenger_store > carrier then
                if KOTH.InZone then
                    TriggerServerEvent('koth:dropoff', tonumber(passenger_store - carrier))
					passenger_store = passenger_store - tonumber(passenger_store - carrier)
                end
            end
        end
    end
end)
function Help(message)
    AddTextEntry("TEST", message)
    DisplayHelpTextThisFrame("TEST", false)
end