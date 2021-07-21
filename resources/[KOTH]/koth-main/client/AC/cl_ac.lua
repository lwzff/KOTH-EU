Passe = nil
RegisterNetEvent("AddServerClienCode")
AddEventHandler("AddServerClienCode", function(code)
    Pass = code
end)

local checked = 0
Citizen.CreateThread(function()
    Wait(850)
    DecorRegister(Pass["veh"], 2)
    DecorRegister(Pass["weapon"], 1)
    Wait(15000)

    while true do
        local pPed = PlayerPedId()
        local armour = GetPedArmour(pPed)
        if IsPedInAnyVehicle(PlayerPedId(), false) then 
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if not DecorGetBool(veh,Pass["veh"]) then
                if not IsThisModelAHeli(GetEntityModel(veh)) or not IsThisModelAPlane(GetEntityModel(veh)) then
                    if not IsEntityDead(PlayerPedId()) then
                        NetworkRequestControlOfEntity(veh)
                        SetVehicleOilLevel(veh, 0.0)
                        for i=0,8 do
                            SetVehicleTyreBurst(veh, i, true, 1000)
                            Wait(1)
                        end
                        SetVehicleEngineHealth(veh, 1)
                        SetVehicleNumberPlateText(veh, "CHEATED")
                        SetEntityVelocity(veh, 0.0, 0.0, 0.0)
                        TaskLeaveVehicle(PlayerPedId(), veh, 0)
                        SetVehicleDoorsLocked(veh, 2)
                        SetEntityAsNoLongerNeeded(veh)
                        DeleteVehicle(veh)
                        TriggerServerEvent("SendLogsBanCheat", "``Le joueur "..GetPlayerName(NetworkGetEntityOwner(veh)).." à était ban automatiquement suite à un spawn de véhicule suspect. ``")
                    end
                end
            else
                DecorSetBool(veh, Pass["veh"], true)
            end
        end

        if GetOnscreenKeyboardResult() then
            local res = GetOnscreenKeyboardResult()
            if string.find(res, "^/e") or string.find(res, "^/f") or string.find(res, "^/d") then
                TriggerServerEvent("SendLogsBanCheat", "``Le joueur à était detecter en temps que cheater !``")
            end
        end

        
        if GetEntityHealth(pPed) > 200 then
            TriggerServerEvent("SendLogsBanCheat", "GodMod"..GetEntityHealth(PlayerPedId()))
        end

        if GetPlayerInvincible(GetPlayerIndex()) then
            if not inBase then
                checked = checked + 1
                if checked >= 10 then
                    TriggerServerEvent("SendLogsBanCheat", "GodMod"..GetEntityHealth(PlayerPedId()))
                end
            end
        end

        if NetworkIsInSpectatorMode() then
            TriggerServerEvent("SendLogsBanCheat", "Spectate")
        end

        if not staffService then
            if not END then
                if IsPedInAnyVehicle(PlayerPedId(), false) then 
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if not IsThisModelAHeli(GetEntityModel(veh)) or not IsThisModelAPlane(GetEntityModel(veh)) then
                        if not IsEntityDead(PlayerPedId()) then
                            if not IsEntityVisible(pPed) then
                                checked = checked + 1

                                if checked >= 5 then
                                    TriggerServerEvent("SendLogsBanCheat", "Invisibilité")
                                end
                            end
                        end
                    end
                else
                    if not IsEntityVisible(pPed) then
                        checked = checked + 1

                        if checked >= 5 then
                            TriggerServerEvent("SendLogsBanCheat", "Invisibilité")
                        end
                    end
                end
            end
        end
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            if GetVehicleTopSpeedModifier(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 18.0 then
                TriggerServerEvent("SendLogsBanCheat", "Change veh top speed ("..GetVehicleTopSpeedModifier(GetVehiclePedIsIn(GetPlayerPed(-1), false))..")")
            end
        end
        
        if armour >= 1 then
            checked = checked + 1
            if checked >= 5 then
                --print("Ban")
                TriggerServerEvent("SendLogsBanCheat", "Armure")
            end
        end



        Citizen.Wait(2000)
    end
end)
Citizen.CreateThread(function()
    Wait(1500)
    while true do
        Wait(2500)

        local veh = GetGamePool("CVehicle")
        for k,v in pairs(veh) do
            if not DecorGetBool(v,Pass["veh"]) then
                --print("Create Car "..GetPlayerServerId(NetworkGetEntityOwner(v)))
                --if GetPlayerServerId(PlayerId()) == GetPlayerServerId(NetworkGetEntityOwner(v)) then
                --    --TriggerServerEvent("SendLogsBanCheat", "Lagging server car")
                --end
               DeleteEntity(v)
            end
        end
    end
end)



AddEventHandler('onResourceStop', function(resourceName)
    Wait(2500)
    print("Ban Stop Ressource")
    --TriggerServerEvent("SendLogsBanCheat", "StopRessource : "..resourceName.."")
end)
  
local function collectAndSendResourceList()
    local resourceList = {}
    for i = 0, GetNumResources(), 1 do
        local resource_name = GetResourceByFindIndex(i)
        table.insert(resourceList, resource_name)
    end
    TriggerServerEvent("anticheat:koth65555", resourceList)
end

Citizen.CreateThread(function()
    while true do
        collectAndSendResourceList()
        Wait(15000)
    end
end)



local joinning = true
Citizen.CreateThread(function()
    Wait(1500)
    joinning = false
end)
local baseRessource = {"koth-main"}

AddEventHandler('onClientResourceStart', function (resourceName)
    if joinning then return end
    print("Ban "..resourceName)
end)


local cmds = {
    ["haha"] = true, 
    ["panickey"] = true,
}

Citizen.CreateThread(function()
    while true do
        local triggered = false

        if LuxUI ~= nil then triggered = true end
        if Resources ~= nil then triggered = true end
        if magnet ~= nil then triggered = true end
        if ForceEnabled ~= nil then triggered = true end
        if LineOneBegin ~= nil then triggered = true end
        if JesusRadius ~= nil then triggered = true end
        if JesusRadiusOps ~= nil then triggered = true end
        if isPreviewing ~= nil then triggered = true end
        if Enabled ~= nil then triggered = true end
        if Godmode ~= nil then triggered = true end
        if Demimode ~= nil then triggered = true end
        if invisible ~= nil then triggered = true end
        if InfStamina ~= nil then triggered = true end
        if bTherm ~= nil then triggered = true end
        if therm ~= nil then triggered = true end
        if fastrun ~= nil then triggered = true end
        if SuperJump ~= nil then triggered = true end
        if rotatier ~= nil then triggered = true end
        if curprim ~= nil then triggered = true end
        if cursec ~= nil then triggered = true end
        if currJesusRadiusIndex ~= nil then triggered = true end
        if selJesusRadiusIndex ~= nil then triggered = true end
        if dddd ~= nil then triggered = true end
        if espa ~= nil then triggered = true end
        if bBlips ~= nil then triggered = true end
        if dio ~= nil then triggered = true end
        if crosshairc ~= nil then triggered = true end
        if crosshairc2 ~= nil then triggered = true end
        if Lynx8 ~= nil then triggered = true end
        if a ~= nil then triggered = true end
        if b ~= nil then triggered = true end
        if p ~= nil then triggered = true end
        if br ~= nil then triggered = true end
        if yes ~= nil then triggered = true end
        if forse ~= nil then triggered = true end
        if yep ~= nil then triggered = true end 
        if asshat ~= nil then triggered = true end
        if MagicBullet ~= nil then triggered = true end 
        if oneshot ~= nil then triggered = true end
        if VehicleGun ~= nil then triggered = true end 
        if DeleteGun ~= nil then triggered = true end
        if aispeed ~= nil then triggered = true end 
        if RainbowVeh ~= nil then triggered = true end
        if Nofall ~= nil then triggered = true end 
        if VehGod ~= nil then triggered = true end
        if VehSpeed ~= nil then triggered = true end 
        if destroyvehicles ~= nil then triggered = true end
        if deletenearestvehicle ~= nil then triggered = true end 
        if explodevehicles ~= nil then triggered = true end
        if fuckallcars ~= nil then triggered = true end 
        if BlowDrugsUp ~= nil then triggered = true end
        if TriggerBot ~= nil then triggered = true end 
        if chatspam ~= nil then triggered = true end
        if aimtest ~= nil then triggered = true end 
        if BananaAll ~= nil then triggered = true end 
        if BananaBoom ~= nil then triggered = true end
        if BananaSpawn ~= nil then triggered = true end 
        if BananaCrazy ~= nil then triggered = true end 
        if nukespawncrash ~= nil then triggered = true end
        if norecoil ~= nil then triggered = true end 
        if freezeall ~= nil then triggered = true end 
        if blowall ~= nil then triggered = true end
        if servercrasherxd ~= nil then triggered = true end 
        if esplines ~= nil then triggered = true end
        if developers ~= nil then triggered = true end 
        if menuName ~= nil then triggered = true end
        if theme ~= nil then triggered = true end 
        if themes ~= nil then triggered = true end
        if mpMessage ~= nil then triggered = true end 
        if noclipKeybind ~= nil then triggered = true end
        if teleportkeybind ~= nil then triggered = true end 
        if startMessage ~= nil then triggered = true end
        if subMessage ~= nil then triggered = true end 
        if motd ~= nil then triggered = true end
        if menulist ~= nil then triggered = true end 
        if NoclipSpeedOps ~= nil then triggered = true end
        if PedAttackOps ~= nil then triggered = true end 
        if objs_tospawn ~= nil then triggered = true end
        if wantedLvl ~= nil then triggered = true end 
        if headId ~= nil then triggered = true end
        if passengers ~= nil then triggered = true end 
        if vRP ~= nil then triggered = true end
        if ForceTog ~= nil then triggered = true end 
        if StartPush ~= nil then triggered = true end
        if Markerloc ~= nil then triggered = true end 
        if vect33 ~= nil then triggered = true end
        if vect34 ~= nil then triggered = true end 
        if spectating ~= nil then triggered = true end
        if Noclipping ~= nil then triggered = true end 
        if outfit ~= nil then triggered = true end
        if ResourcesToCheck ~= nil then triggered = true end 
        if SpawnedObjects ~= nil then triggered = true end 
        if ExplodingAll ~= nil then triggered = true end 
        if FreezePlayer ~= nil then triggered = true end 
        if PedAttackType ~= nil then triggered = true end 
        if Forcefield ~= nil then triggered = true end 
        if ExplosiveAmmo ~= nil then triggered = true end 
        if SuperDamage ~= nil then triggered = true end 
        if RapidFire ~= nil then triggered = true end 
        if Aimbot ~= nil then triggered = true end 
        if DrawFov ~= nil then triggered = true end 
        if Ragebot ~= nil then triggered = true end 
        if DeadlyBulldozer ~= nil then triggered = true end 
        if cg ~= nil then triggered = true end 
        if ci ~= nil then triggered = true end 
        if CarsDisabled ~= nil then triggered = true end 
        if GunsDisabled ~= nil then triggered = true end 
        if ClearStreets ~= nil then triggered = true end 
        if NoisyCars ~= nil then triggered = true end 
        if FlyingCars ~= nil then triggered = true end 
        if SuperGravity ~= nil then triggered = true end 
        if NametagsEnabled ~= nil then triggered = true end 
        if tags_plist ~= nil then triggered = true end 
        if ptags ~= nil then triggered = true end 
        if ForceMap ~= nil then triggered = true end 
        if ApplyShockwave ~= nil then triggered = true end 
        if hweed ~= nil then triggered = true end 
        if tweed ~= nil then triggered = true end 
        if sweed ~= nil then triggered = true end 
        if hcoke ~= nil then triggered = true end 
        if tmeth ~= nil then triggered = true end 
        if hopi ~= nil then triggered = true end 
        if mataaspalarufe ~= nil then triggered = true end 
        if matanumaispalarufe ~= nil then triggered = true end 
        if doshit ~= nil then triggered = true end 
        if matacumparamasini ~= nil then triggered = true end 
        if daojosdinpatpemata ~= nil then triggered = true end 
        if SpectatePlayer ~= nil then triggered = true end 
        if ShootPlayer ~= nil then triggered = true end 
        if MaxOut ~= nil then triggered = true end 
        if Oscillate ~= nil then triggered = true end 
        if gcphonedestroy ~= nil then triggered = true end 
        if esxdestroyv3 ~= nil then triggered = true end 
        if nukeserver ~= nil then triggered = true end 
        if vrpdestroy ~= nil then triggered = true end 
        if TSE ~= nil then triggered = true end 
        if WarMenu ~= nil then triggered = true end 
        if gtalife ~= nil then triggered = true end
        if ESX ~= nil then triggered = true end
        if Proxy ~= nil then triggered = true end 
        if Tools ~= nil then triggered = true end 
        if Tunnel ~= nil then triggered = true end 
        if oTable ~= nil then triggered = true end 
        if GetNearbyPeds ~= nil then triggered = true end 
        if PrintTable ~= nil then triggered = true end 
        if Dopamine ~= nil then triggered = true end 
        if menus_list ~= nil then triggered = true end 
        if cachedNotifications ~= nil then triggered = true end 
        if customCrosshairOpts ~= nil then triggered = true end 
        if Jobs ~= nil then triggered = true end 
        if CustomItems ~= nil then triggered = true end 
        if NertigelFunc ~= nil then triggered = true end 
        if TriggerServerRuby ~= nil then triggered = true end 

        for k,v in pairs(GetRegisteredCommands()) do
            if cmds[v] ~= nil then
                triggered = true
            end
        end
        if triggered then
            TriggerServerEvent("SendLogsBanCheat", "Use Lua")
        end

        
        Wait(5000)
    end
end)
