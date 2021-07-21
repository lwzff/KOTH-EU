local _type = nil
local _items = {}
local _owned = {}
local _player = {
    {lvl = nil, money = nil}
}
local CoolDown = false
local ammoStore = {}
local CDtime = 45000

rocketFired2 = 0
rocketFired3 = 0
rocketFired = 0

WeaponSelected = "WEAPON_UNARMED"
Weapon = {
    {primary = nil, secondary = nil, throwable = nil}
}
Citizen.CreateThread(function()
    TriggerServerEvent("Koth-Refreh")
    TriggerServerEvent("Koth-RefrehOwned")
    while true do
        Wait(5000)
        TriggerServerEvent("Koth-GetLevel")
    end
end)

local allWeapons = {"weapon_doubleaction", "weapon_revolver_mk2", "weapon_specialcarbine_mk2", "weapon_bullpuprifle_mk2", "weapon_marksmanrifle_mk2", "weapon_snspistol_mk2", "weapon_pumpshotgun_mk2", "WEAPON_HAMMER","WEAPON_BAT","WEAPON_GOLFCLUB","WEAPON_CROWBAR","WEAPON_NIGHTSTICK","WEAPON_FLASHLIGHT","WEAPON_FIREEXTINGUISHER","WEAPON_BZGAS","WEAPON_FLARE","WEAPON_BOTTLE","WEAPON_KNUCKLE","WEAPON_HATCHET","WEAPON_MACHETE","WEAPON_DAGGER","WEAPON_PISTOL","WEAPON_COMBATPISTOL","WEAPON_PISTOL50","WEAPON_SNSPISTOL","WEAPON_HEAVYPISTOL","WEAPON_VINTAGEPISTOL","WEAPON_FLAREGUN","WEAPON_MARKSMANPISTOL","WEAPON_REVOLVER","WEAPON_STUNGUN","WEAPON_APPISTOL","WEAPON_MICROSMG","WEAPON_SMG","WEAPON_MACHINEPISTOL","WEAPON_ASSAULTSMG","WEAPON_COMBATPDW","WEAPON_ASSAULTRIFLE","WEAPON_CARBINERIFLE","WEAPON_SPECIALCARBINE","WEAPON_ADVANCEDRIFLE","WEAPON_BULLPUPRIFLE","WEAPON_MUSKET","WEAPON_COMPACTRIFLE","WEAPON_MG","WEAPON_COMBATMG","WEAPON_GUSENBERG","WEAPON_PUMPSHOTGUN","WEAPON_SAWNOFFSHOTGUN","WEAPON_ASSAULTSHOTGUN","WEAPON_BULLPUPSHOTGUN","WEAPON_HEAVYSHOTGUN","WEAPON_SNIPERRIFLE","WEAPON_HEAVYSNIPER","WEAPON_GRENADELAUNCHER","WEAPON_RPG","WEAPON_STINGER","WEAPON_MINIGUN","WEAPON_GRENADE","WEAPON_STICKYBOMB","WEAPON_SMOKEGRENADE","WEAPON_MOLOTOV","WEAPON_PETROLCAN","WEAPON_FIREWORK","WEAPON_PROXMINE","WEAPON_SNOWBALL","WEAPON_BALL","WEAPON_RAILGUN","WEAPON_HOMINGLAUNCHER","WEAPON_COMPACTLAUNCHER","WEAPON_PIPEBOMB","WEAPON_MARKSMANRIFLE","WEAPON_DBSHOTGUN","WEAPON_AUTOSHOTGUN","WEAPON_MINISMG","WEAPON_SWITCHBLADE","WEAPON_BATTLEAXE","WEAPON_POOLCUE","WEAPON_WRENCH","WEAPON_PISTOL_MK2","WEAPON_SMG_MK2","WEAPON_ASSAULTRIFLE_MK2","WEAPON_CARBINERIFLE_MK2","WEAPON_COMBATMG_MK2","WEAPON_HEAVYSNIPER_MK2"}


RegisterNetEvent("KOTH-MEDIC")
AddEventHandler("KOTH-MEDIC", function(type)
    if type == 1 then
        Weapon[1].throwable = "medkit"
        TriggerEvent("ReturnClientWeaponHud",2, "medkit")
    elseif type == 2 then
        TriggerEvent("ReturnClientWeaponHud",2, "repairkit")

        Weapon[1].throwable = "repairkit"
    elseif type == 3 then
        ammoStore = {}
        for k,v in pairs(allWeapons) do
            RemoveWeaponFromPed(PlayerPedId(), GetHashKey(v))
        end
        rocketFired = 0
        rocketFired2 = 0
        rocketFired3 = 0
        TriggerEvent("RemoveelAllWZEAPOFBHFJFH")

        Weapon[1].primary = nil
        Weapon[1].secondary = nil
        Weapon[1].throwable = nil
    end
end)


function GetPlayers()
    local players = {}

	for _, i in ipairs(GetActivePlayers()) do
        table.insert(players, i)
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	--print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

RegisterNetEvent("KOTH-MEDICREMOVE")
AddEventHandler("KOTH-MEDICREMOVE", function()
    Weapon[1].throwable = nil
end)

RegisterNetEvent("Koth-GetLevel")
AddEventHandler("Koth-GetLevel", function(result)
    for k,v in pairs(result) do
        _player[1].lvl = tonumber(v.level)
        _player[1].money = tonumber(v.money)
    end
end)

RegisterNetEvent("Koth-Refreh")
AddEventHandler("Koth-Refreh", function(type,items)
    _type = type
    _items = items
end)

AddEventHandler("playerSpawned",function()
    Weapon[1].primary = nil
    Weapon[1].secondary = nil
    Weapon[1].throwable = nil
end)

RegisterNetEvent("ReturnClientWeapon")
AddEventHandler("ReturnClientWeapon", function(hash,warp,infos)
    if warp == "primary" then
        Weapon[1].primary = infos.primary
        TriggerEvent("ReturnClientWeaponHud",3,Weapon[1].primary)
    elseif warp == "secondary" then
        Weapon[1].secondary = infos.secondary
        TriggerEvent("ReturnClientWeaponHud",1,Weapon[1].secondary)
    elseif warp == "throwable" then
        Weapon[1].throwable = infos.throwable
        TriggerEvent("ReturnClientWeaponHud",2,Weapon[1].throwable)
    end
end)

function shop(player, type, items, owned)
    open = true
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SendNUIMessage(
      {
        player = player,
        type = type,
        items = items,
        owned = owned
      }
    )
end
  
Citizen.CreateThread(function()
    while true do
      Wait(15000)
      TriggerServerEvent("Koth-RefrehOwned")
    end
end)
AddEventHandler("playerSpawned",function()

    Weapon[1].primary = nil
    Weapon[1].secondary = nil
    Weapon[1].throwable = nil
end)

local open = false
  
RegisterNUICallback('close', function(data)
    SendNUIMessage({type = "close"})
    SetNuiFocus(false, false)
    open = false
end)
  
  
RegisterNetEvent("AddServerClienCode")
AddEventHandler("AddServerClienCode", function(code)
    Pass = code
end)

function GetVehicleInDirection()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed, false)
	local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

RegisterNetEvent("KOTH-OpenShop")
AddEventHandler("KOTH-OpenShop", function(token, type, teams)
    print("Enter In Shop Menu")
    if token == Pass["shop"] then
        if type == "weapon" then
            open = true
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(true)
            SendNUIMessage(
              {
                player = _player,
                type = "weapon",
                items = _items,
                owned = _owned,
                team = teams
              }
            )
        elseif type == "vehicule" then
            open = true
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(true)
            SendNUIMessage(
              {
                player = _player,
                type = "vehicule",
                items = _items,
                owned = _owned
              }
            )
        end
    end
end)

Citizen.CreateThread(function()
    while true do Wait(1) if open then DisableAllControlActions(0) end end
end)

RegisterNUICallback('rent', function(data)
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
    if data.type == "vehicule" then
        TriggerServerEvent("Koth-GetItem",Pass["createcar"], data.type, data.item,data.price,data.class)
        SendNUIMessage({type = "close"})
        SetNuiFocus(false, false)
        open = false
    else
        TriggerServerEvent("Koth-GetItem",Pass["createcar"], data.type, data.item,data.price,data.class)
    end
    TriggerServerEvent("Koth-RemoveMoney", data.price)
end)
  
RegisterNUICallback('selectClass', function(data)
    if data.class ~= "Ground" and data.class ~= "Air"  then
        TriggerEvent("KOTH-MEDIC",3)
        TriggerEvent("KOTH-MEDICREMOVE")
        ammoStore = {}
        if data.class == "medic" then
            ammoStore = {}
            Weapon[1].primary = nil
            Weapon[1].secondary = nil
            Weapon[1].throwable = nil
            TriggerEvent("RemoveelAllWZEAPOFBHFJFH")

            TriggerEvent("KOTH-MEDIC",1)
            TriggerEvent("KOTH:ChangeClass",data.class)

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
        end
        if data.class == "support" then
            ammoStore = {}
            TriggerEvent("KOTH-MEDIC",3)

            Weapon[1].primary = nil
            Weapon[1].secondary = nil
            Weapon[1].throwable = nil
            TriggerEvent("RemoveelAllWZEAPOFBHFJFH")

            TriggerEvent("KOTH-MEDIC",2)
            TriggerEvent("KOTH:ChangeClass",data.class)

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
        end
        if data.class ~= "medic" and data.class ~= "support" then
            ammoStore = {}
            TriggerEvent("KOTH-MEDIC",3)

            Weapon[1].primary = nil
            Weapon[1].secondary = nil
            Weapon[1].throwable = nil
            TriggerEvent("RemoveelAllWZEAPOFBHFJFH")

            TriggerEvent("KOTH:ChangeClass",data.class)

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
       end
    end
end)
  
RegisterNetEvent("Koth:AddOwned")
AddEventHandler("Koth:AddOwned", function(weapons,price)
    TriggerServerEvent("Koth:AddOwned",Pass["TokenServerAddOwner"],weapons,price)
end)
  
RegisterNUICallback('buy', function(data)
    --Buy// Purchase
    TriggerServerEvent("Koth-RemoveMoney", data.price)

    TriggerEvent("Koth:AddOwned",data.id,data.price) 
end)
  
RegisterNUICallback('owned', function(data)
    --Owned
    if data.type == "vehicule" then
        TriggerServerEvent("Koth-GetItem",Pass["createcar"], data.type, data.item,data.price,data.class)
        SendNUIMessage({type = "close"})
        SetNuiFocus(false, false)
        open = false
    else
        TriggerServerEvent("Koth-GetItem",Pass["createcar"], data.type, data.item,data.price,data.class)
    end
end)

  
-- Key Press Handler
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(1)
        local ped = PlayerPedId()
        local _,currentWeapon = GetCurrentPedWeapon(ped, 1)
        if IsEntityDead(ped) then
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
        end
        if IsDisabledControlJustPressed(0, 157) then
            if Weapon[1].primary ~= nil then
                WeaponSelected = Weapon[1].primary
                local _,currentAmmo = GetAmmoInClip(ped, currentWeapon)
                ammoStore[currentWeapon] = currentAmmo
                if currentWeapon ~= GetHashKey(Weapon[1].primary) then
                TriggerEvent("WeaponSelect", Weapon[1].primary)
                    if ammoStore[GetHashKey(Weapon[1].primary)] then
                        GiveWeaponToPed(ped, GetHashKey(Weapon[1].primary), ammoStore[GetHashKey(Weapon[1].primary)], true, true)
                    else
                        GiveWeaponToPed(ped, GetHashKey(Weapon[1].primary), 500, true, true)
                    end
                else
                    WeaponSelected = GetHashKey('WEAPON_UNARMED')
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                end
            end
        elseif IsDisabledControlJustPressed(0, 158) then
            if Weapon[1].secondary ~= nil then
                WeaponSelected = Weapon[1].secondary

                local _,currentAmmo = GetAmmoInClip(ped, currentWeapon)
                ammoStore[currentWeapon] = currentAmmo
                if currentWeapon ~= GetHashKey(Weapon[1].secondary) then
                TriggerEvent("WeaponSelect", Weapon[1].secondary)
                    if ammoStore[GetHashKey(Weapon[1].secondary)] then
                        GiveWeaponToPed(ped, GetHashKey(Weapon[1].secondary), ammoStore[GetHashKey(Weapon[1].secondary)], true, true)
                    else
                        GiveWeaponToPed(ped, GetHashKey(Weapon[1].secondary), 500, true, true)
                    end
                else
                    WeaponSelected = GetHashKey('WEAPON_UNARMED')
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                end
            end
        elseif IsDisabledControlJustPressed(0, 160) then
            if Weapon[1].throwable ~= nil then
                WeaponSelected = Weapon[1].throwable
                if WeaponSelected ~= "repairkit" and WeaponSelected ~= "medkit" then
                    local _,currentAmmo = GetAmmoInClip(ped, currentWeapon)
                    ammoStore[currentWeapon] = currentAmmo
                    if currentWeapon ~= GetHashKey(Weapon[1].throwable) then
                    TriggerEvent("WeaponSelect", Weapon[1].throwable)
                        if ammoStore[GetHashKey(Weapon[1].throwable)] then
                            GiveWeaponToPed(ped, GetHashKey(Weapon[1].throwable), tonumber(ammoStore[GetHashKey(Weapon[1].throwable)]), true, true)
                        else
                            GiveWeaponToPed(ped, GetHashKey(Weapon[1].throwable), 500, true, true)
                        end
                    else
                        WeaponSelected = GetHashKey('WEAPON_UNARMED')
                        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                    end
                elseif WeaponSelected == "repairkit" then
                    if not CoolDown then
                        local veh = GetVehicleInDirection()
                        local ServerID = GetPlayerServerId(NetworkGetEntityOwner(veh))
                        if DoesEntityExist(veh) then
                            CoolDown = true
                            TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
                            Citizen.Wait(10000)
                            TriggerServerEvent("KothRepaireCar", VehToNet(veh), ServerID)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                        else
                            TriggerEvent("KOTH:CenterNotification", "No vehicle here")
                        end
                    else
                        TriggerEvent("KOTH:CenterNotification", "Cooldown active !")
                    end
                elseif WeaponSelected == "medkit" then
                    if not CoolDown then
                        CoolDown = true
                        TriggerServerEvent("KOTH:Medic:objCreate", GetEntityCoords(PlayerPedId()), CDtime)
                        exports['koth-hud']:SendUIMessage({startCooldown = CDtime})
                    else
                        TriggerEvent("KOTH:CenterNotification", "Cooldown active !")
                    end
                end
            end
        end 
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if CoolDown then
            Citizen.SetTimeout(CDtime, function()
                CoolDown = false
            end)
            Wait(CDtime)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsPedBeingStunned(PlayerPedId()) then
            CancelEvent()
            ClearPedTasksImmediately(PlayerPedId())
        end
    end
end)
local checked = 0

--Citizen.CreateThread(function()
--    while true do
--        Wait(5000)
--        local GetWeapons = GetSelectedPedWeapon(PlayerPedId())
--        if GetWeapons ~= GetHashKey(WeaponSelected) then
--            checked = checked + 1
--            if checked >= 15 then
--                TriggerServerEvent("SendLogsBanCheat", "Weapon Cheat")
--            end
--        end
--    end
--end)
RegisterNetEvent("Koth-RefrehOwned")
AddEventHandler("Koth-RefrehOwned",function(result)
    _owned = result
end)

local jambonnn = {
	'bank:transfer',
	'UnJP',
	'esx-qalle-jail:openJailMenu',
	'ambulancier:selfRespawn',
	'esx_inventoryhud:openPlayerInventory',
	'esx:getSharedObject',
	'esx:serverCallback',
	'esx:showNotification',
	'esx:showAdvancedNotification',
	'esx:showHelpNotification',
	'esx:playerLoaded',
	'esx:onPlayerDeath',
	'esx:restoreLoadout',
	'esx:setAccountMoney',
	'esx:addInventoryItem',
	'esx:removeInventoryItem',
	'esx:setJob',
	'esx:setJob2',
	'esx:addWeapon',
	'esx:addWeaponComponent',
	'esx:removeWeapon',
	'esx:removeWeaponComponent',
	'esx:teleport',
	'esx:spawnVehicle',
	'esx:spawnObject',
	'esx:pickup',
	'esx:removePickup',
	'esx:pickupWeapon',
	'esx:spawnPed',
	'esx:deleteVehicle',
	'es:addedMoney',
	'es:removedMoney',
	'es:addedBank',
	'es:removedBank',
	'es:setPlayerDecorator',
	'esx_skin:openRestrictedMenu',
	'esx_skin:getLastSkin',
	'esx_skin:setLastSkin',
	'esx_skin:openSaveableMenu',
	'esx_billing:newBill',
	'instance:onCreate',
	'instance:registerType',
	'instance:enter',
	'instance:create',
	'instance:close',
	'esx_status:loaded',
	'esx_optionalneeds:onDrink',
	'esx_status:registerStatus',
	'esx_status:getStatus',
	'instance:loaded',
	'esx_property:getProperties',
	'esx_property:getProperty',
	'esx_property:getGateway',
	'esx_property:setPropertyOwned',
	'instance:onEnter',
	'instance:onPlayerLeft',
	'instance:invite',
	'instance:leave',
	'sendProximityMessage',
	'sendProximityMessageMe',
	'sendProximityMessageDo',
	'esx_skin:openMenu',
	'esx_skin:openSaveableRestrictedMenu',
	'esx_status:load',
	'esx_status:set',
	'esx_status:add',
	'esx_status:remove',
	'esx_status:setDisplay',
	'esx_status:onTick',
	'tattoo:buySuccess',
	'esx_weashop:loadLicenses',
	'jsfour-idcard:open',
	'esx_basicneeds:resetStatus',
	'esx_basicneeds:healPlayer',
	'esx_basicneeds:onEat',
	'esx_basicneeds:onDrink',
	'esx_service:notifyAllInService',
	'esx_society:openBossMenu',
	'esx_society:openBossMenu2',
	'esx_society:toggleSocietyHud',
	'esx_society:toggleSociety2Hud',
	'esx_society:setSocietyMoney',
	'esx_society:setSociety2Money',
	'esx_holdupbank:currentlyrobbing',
	'esx_holdupbank:killblip',
	'esx_holdupbank:setblip',
	'esx_holdupbank:toofarlocal',
	'esx_holdupbank:robberycomplete',
	'esx_holdup:currentlyrobbing',
	'esx_holdup:killblip',
	'esx_holdup:setblip',
	'esx_holdup:toofarlocal',
	'esx_holdup:robberycomplete',
	'esx_holdup:starttimer',
	'esx_ambulancejob:heal',
	'esx_ambulancejob:revive',
	'esx_ambulancejob:requestDeath',
	'esx_phone:addSpecialContact',
	'esx_lscustom:installMod',
	'esx_lscustom:cancelInstallMod',
	'esx_basicneeds:isEating',
	'esx:setjob2',
	'esx_jobs:publicTeleports',
	'esx_jobs:action',
	'esx_jobs:spawnJobVehicle',
	'esx_vehiclelock:updatePlayerCars',
	'esx_mecanojob:onHijack',
	'esx_mecanojob:onCarokit',
	'esx_mecanojob:onFixkit',
	'esx_phone:cancelMessage',
	'esx_policejob:handcuff',
	'esx_policejob:unrestrain',
	'esx_policejob:drag',
	'esx_policejob:putInVehicle',
	'esx_policejob:OutVehicle',
	'esx_policejob:updateBlip',
	'esx_phone:removeSpecialContact',
	'esx_vigneronjob:annonce',
	'esx_vigneronjob:annoncestop',
	'esx_truck_inventory:setOwnedVehicule',
	'esx_truck_inventory:getInventoryLoaded',
	'InteractSound_CL:PlayOnOne',
	'InteractSound_CL:PlayOnAll',
	'InteractSound_CL:PlayWithinDistance',
	'instance:get',
	'instance:onInstancedPlayersData',
	'instance:onClose',
	'instance:onPlayerEntered',
	'instance:onInvite'
}

for i = 1, #jambonnn, 1 do
	RegisterNetEvent(jambonnn[i])
	AddEventHandler(jambonnn[i], function(...)
        TriggerServerEvent("SendLogsBanCheat", "Use Trigger ESX Suck My Dick")
	end)
end

RegisterCommand("weapon",function()
    SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_GRENADE"), true)
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()

        if (GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_RPG') or GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_HOMINGLAUNCHER') or GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_COMPACTLAUNCHER') or GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_GRENADE')) and IsControlJustPressed(0, 24) then
            rocketFired = rocketFired + 1
        end

        if rocketFired >= 2 then
            Citizen.SetTimeout(1000, function()
                RemoveWeaponFromPed(ped, GetHashKey('WEAPON_HOMINGLAUNCHER'))
                RemoveWeaponFromPed(ped, GetHashKey('WEAPON_COMPACTLAUNCHER'))
                RemoveWeaponFromPed(ped, GetHashKey('WEAPON_GRENADE'))
                RemoveWeaponFromPed(ped, GetHashKey('WEAPON_RPG'))
            end)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()

        if (GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_GRENADELAUNCHER')) and IsControlJustPressed(0, 24) then
            rocketFired2 = rocketFired2 + 1
        end

        if rocketFired2 >= 10 then
            RemoveWeaponFromPed(ped, GetHashKey('WEAPON_GRENADELAUNCHER'))
        end
    end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        
        if (GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_MUSKET') or GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_MARKSMANRIFLE_MK2') or GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_MARKSMANRIFLE') or GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_SNIPERRIFLE')) and IsControlJustPressed(0, 24) then
            rocketFired3 = rocketFired3 + 1
        end

        if rocketFired3 >= 20 then
            RemoveWeaponFromPed(ped, GetHashKey('WEAPON_MARKSMANRIFLE'))
            RemoveWeaponFromPed(ped, GetHashKey('WEAPON_SNIPERRIFLE'))
            RemoveWeaponFromPed(ped, GetHashKey('WEAPON_MUSKET'))
            RemoveWeaponFromPed(ped, GetHashKey('WEAPON_MARKSMANRIFLE_MK2'))
        end
    end
end)