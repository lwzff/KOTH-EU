RegisterCommand("pos", function(source, args, rawcommand)
    local pos = GetEntityCoords(PlayerPedId())
    local heanding = GetEntityHeading(PlayerPedId())
    TriggerServerEvent("SendCoord", "{ pos = "..pos..", heading = "..heanding.."}")
end, false)

RegisterCommand("car", function(source, args, rawcommand)
    if staffService then
        local pos = GetEntityCoords(PlayerPedId())
        local heanding = GetEntityHeading(PlayerPedId())
        local car = args[1]
        if car ~= nil then
            local modelHash = GetHashKey(car)
            RequestModel(modelHash)


            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
            veh = CreateVehicle(modelHash,pos, heading, true, true)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerServerEvent("Returnvehicleidserver",Pass["veh"], veh)
            DecorSetBool(veh, Pass["veh"], true)
        end
    end
end, false)

RegisterCommand("revive",function(source, args)
    if staffService then
        if args[1] == nil then
            TriggerEvent("core:ResetDeathStatus", true)
        else
            TriggerServerEvent("core:ResetDeathStatus", tonumber(args[1]), true)
        end
    end
end)


RegisterCommand("kick",function(source, args)
    if staffService then
        if args[1] ~= nil then
            TriggerServerEvent("KOTH-ADMIBKICK", tonumber(args[1]), args[2])
        end
    end
end)
--RegisterCommand("giveweapon", function(source, args, rawcommand)
--    local weapon = args[1]
--    if weapon ~= nil then
--        local modelHash = GetHashKey(weapon)
--        amrs = GiveWeaponToPed(PlayerPedId(), modelHash, 50000, true, true)
--        DecorSetBool(amrs, Pass["weapon"], true)
--        print(amrs)
--
--    end
--end, false)

function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
end

RegisterCommand("addmoney", function(source, args, rawcommand)
    if staffService then
        local ammount = args[1]
        if ammount ~= nil then
            TriggerServerEvent("Koth-addmoney", Pass["tokenserver"],tonumber(args[1]))
        end
    end
end, false)
    

RegisterCommand("addmxp", function(source, args, rawcommand)
    if staffService then
        local ammount = args[1]
        if ammount ~= nil then
            TriggerServerEvent("Koth-addlevel",GetPlayerServerId(PlayerId()), Pass["tokenserverlvel"],tonumber(args[1]))
        end
    end
end, false)

RegisterCommand("tpto", function(source, args, rawcommand)
    if staffService then
        local waypointHandle = GetFirstBlipInfoId(8)

        if DoesBlipExist(waypointHandle) then
            Citizen.CreateThread(function()
                local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
                local foundGround, zCoords, zPos = false, -500.0, 0.0
        
                while not foundGround do
                    zCoords = zCoords + 10.0
                    RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
                    Citizen.Wait(0)
                    foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)
        
                    if not foundGround and zCoords >= 2000.0 then
                        foundGround = true
                    end
                end
        
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords.x, waypointCoords.y, zPos)
            end)
        end 
    end   
end, false)

function Utils()
        -- Remove Vehicle Rewards
        DisablePlayerVehicleRewards(PlayerId())
        -- Disable Wanted Level
        SetMaxWantedLevel(0)
        -- Disable GTA Stamina
        RestorePlayerStamina(PlayerId(), 1.0)
        --Disable all NPC Peds
        SetPedDensityMultiplierThisFrame(0.0)
        SetVehicleDensityMultiplierThisFrame(0.0)
        SetRandomVehicleDensityMultiplierThisFrame(0.0)
        SetRandomBoats(false)
        SetRandomTrains(false)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
    SetParkedVehicleDensityMultiplierThisFrame(0.0)
    SetSomeVehicleDensityMultiplierThisFrame(0.0)
    ---- Disable GTA Health Regen
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    ---- Disabling unused HUD components
    HideHudComponentThisFrame(3) -- CASH
    HideHudComponentThisFrame(4) -- MP_CASH
    HideHudComponentThisFrame(6) -- VEHICLE_NAME
    HideHudComponentThisFrame(7) -- AREA_NAME
    HideHudComponentThisFrame(8) -- VEHICLE_CLASS
    HideHudComponentThisFrame(9) -- STREET_NAME
    HideHudComponentThisFrame(19) -- WEAPON_WHEEL
    SetPlayerCanDoDriveBy(PlayerPedId(), true)
    --HideHudComponentThisFrame(20)
    DisplayAmmoThisFrame(true)
    ------ Disabling controls
    DisableControlAction(0, 157, true)
    DisableControlAction(0, 158, true)
    DisableControlAction(0, 183, true)
    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
        DisablePlayerFiring(PlayerId(), true)
        DisableControlAction(0, 140, true)
    end
    if IsPedArmed(PlayerPedId(), 6) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
    end
    if not END then
        NetworkOverrideClockTime(12, 0, 0)
        SetWeatherTypeNowPersist("EXTRASUNNY")

    elseif END then
        NetworkOverrideClockTime(0, 0, 0)
        SetWeatherTypeNowPersist("EXTRASUNNY")
    end
    --if weaponsReceived then
    --    for class,data in pairs(KOTH.Weapons) do
    --        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(class) and (data.reticle == 0 or data.reticle == '0') then
    --            HideHudComponentThisFrame(14) -- RETICLE
    --        end
    --    end
    --    if IsPedInAnyVehicle(PlayerPedId(), true) and GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) ~= GetHashKey('Rhino') and GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) ~= GetHashKey('Buzzard') and GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) ~= GetHashKey('Hunter') then
    --        HideHudComponentThisFrame(14) -- RETICLE
    --    end
    --end
end


Citizen.CreateThread(function()
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE") -- Stop ambient city sounds
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetTalkerProximity(20.0)
    --compass.show = true
    while true do
        Citizen.Wait(1)
        Utils()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = GetPlayerPed(-1)

        if IsPedArmed(ped, 4) then
            local _,weapon = GetCurrentPedWeapon(ped, 1)
            local ammoTotal = GetAmmoInPedWeapon(ped, weapon)
            local _,ammoClip = GetAmmoInClip(ped, weapon)
            local ammoRemaining = '/'..math.floor(ammoTotal - ammoClip)

            if GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_flaregun') and GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_dbshotgun') and GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_musket') and GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_rpg') and GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_grenadelauncher') and GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_firework') and GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_hominglauncher') and GetSelectedPedWeapon(ped) ~= GetHashKey('weapon_marksmanpistol') then
                if ammoClip <= 10 then ammoClip = math.floor(ammoClip - 1) end
            end

        end
    end
end)