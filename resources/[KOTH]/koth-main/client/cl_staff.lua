staffService = false
local isSubMenu = {[false] = { RightLabel = "~b~Éxecuter ~s~→→" },[true] = { RightLabel = "~s~→→" }}
local invisible = false
local Noclip = false
local NoClipSpeed =  1.0
local countmin = 0
local countmax = 100

local SpawnCarBlue = {}
local SpawnCarGreen = {}
local SpawnCarRed = {}

Citizen.CreateThread(function()
    TriggerServerEvent("KOTH-CanUse")
end)

RegisterNetEvent("KOTH-CanUse")
AddEventHandler("KOTH-CanUse", function(ok, rank, license)
    if ok then InitialAdmin(rank,license) end
end)
local qty = {}


local function GetPedShot(ped)
    if DoesEntityExist(ped) then
		local mugshot = RegisterPedheadshot(ped)

		while not IsPedheadshotReady(mugshot) do
			Citizen.Wait(0)
		end

		return mugshot, GetPedheadshotTxdString(mugshot)
	end
end

local acce = {}
local NotSpamming = {}
function GetAccessoireValues()
    local accessorie = {
       -- {label = "gilet pare-balle 1", 		item = "bproof_1", 		max = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 9) - 1,								min = 0,},
		{label = "gilet pare-balle 2", o = "bproof_1",		item = "bproof_2", 	color = true,c=1,	max = GetNumberOfPedTextureVariations(GetPlayerPed(-1), 9, GetPedTextureVariation(GetPlayerPed(-1), 9)) - 1,			min = 0,},
    }
    acce = accessorie
end

local function ShowAdvenced(title, subject, msg, icon, iconType, hudColorIndex)
	AddTextEntry('esxAdvancedNotification', msg)
	BeginTextCommandThefeedPost('esxAdvancedNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(icon, icon, false, iconType, title, subject)
	EndTextCommandThefeedPostTicker(false, false)
end

local function mug(title, subject, msg)
    local mugshot, mugshotStr = GetPedShot(PlayerPedId())
    ShowAdvenced(title, subject, msg, mugshotStr, 1)
    UnregisterPedheadshot(mugshot)
end

local function initializeInvis()
    Citizen.CreateThread(function()
        while invisible and staffService do
            SetEntityVisible(GetPlayerPed(-1), 0, 0)
            NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 1)
            Citizen.Wait(1)
        end
    end)
end


local function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(GetPlayerPed(-1))
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end

local function initializeNoclip()
    Citizen.CreateThread(function()
        while NoClip and staffService do
            HideHudComponentThisFrame(19)
            local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local camCoords = getCamDirection()
            SetEntityVelocity(GetPlayerPed(-1), 0.01, 0.01, 0.01)
            SetEntityCollision(GetPlayerPed(-1), 0, 1)

            if IsControlPressed(0, 32) then
                pCoords = pCoords + (NoClipSpeed * camCoords)
            end

            if IsControlPressed(0, 269) then
                pCoords = pCoords - (NoClipSpeed * camCoords)
            end

            if IsControlPressed(1, 15) then
                NoClipSpeed = NoClipSpeed + 0.5
            end
            if IsControlPressed(1, 14) then
                NoClipSpeed = NoClipSpeed - 1.0
                if NoClipSpeed < 0 then
                    NoClipSpeed = 0
                end
            end
            SetEntityCoordsNoOffset(GetPlayerPed(-1), pCoords, true, true, true)
            Citizen.Wait(0)
        end
    end)
end

local players = {}
RegisterNetEvent("core:pList")
AddEventHandler("core:pList", function(list)
    players = list
    print("Players list loaded")
end)

local index = {}
local comp = {}

Citizen.CreateThread(function()
    GetAccessoireValues()

end)

local ZoneCreate = {
    name = "",
    poscombat = nil,
    posBaseBleu = nil,
    posweaponshopB = nil,
    posvoitureshopB = nil,
    posBaseVert = nil,
    posweaponshopG = nil,
    posvoitureshopG = nil,  
    posBaseRouge = nil,
    posweaponshopR = nil,
    posvoitureshopR = nil,
    heandingR = nil,
    heandingB = nil,
    heandingG = nil
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000*1.5)
		for theveh in EnumerateVehicles() do
            if (not IsPedAPlayer(GetPedInVehicleSeat(theveh, -1))) then
            	if GetEntityModel(theveh) ~= GetHashKey('rcbandito') then
					Citizen.SetTimeout(60000, function()
						if (not IsPedAPlayer(GetPedInVehicleSeat(theveh, -1))) then
							SetEntityAsMissionEntity(theveh, false, false)
							DeleteEntity(theveh)
						end
					end)
	            end
            end
		end
	end
end)
function GetClosestVehicle(coords)
	local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end


function ClosetVehWithDisplay()
    local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
    local vCoords = GetEntityCoords(veh)
    DrawMarker(2, vCoords.x, vCoords.y, vCoords.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
end

local function getDate()
    return os.date("*t", os.time()).day.."/"..os.date("*t", os.time()).month.."/"..os.date("*t", os.time()).year.." à "..os.date("*t", os.time()).hour.."h"..os.date("*t", os.time()).min
end
RegisterCommand("getitme",function()
    --Zone = Config
    --GetZone = Zone[math.random(1, #Zone)]
    --print("Name Server "..GetZone.name)
    print(getDate())
end, true)

function InitialAdmin(rank,license)
    
    local actualRankPermissions = {}
    staffRank = rank
    registerMenus()
    for perm,_ in pairs(Admin.functions) do
        actualRankPermissions[perm] = false
    end

    for _,perm in pairs(Admin.ranks[staffRank].permissions) do 
        actualRankPermissions[perm] = true
    end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if IsControlJustPressed(1, 344) then 

                RageUI.Visible(RMenu:Get('koth_admin', 'koth_admin_main'), true) 
            end
        end
    end)

    Citizen.CreateThread(function()
        TriggerEvent('skinchanger:getSkin', function(skin) lastSkin = skin end)
        TriggerEvent("skinchanger:getData", function(comp, max)
            for k,v in pairs(comp) do
                if v.value ~= 0 then
                    index[v.name] = v.value
                else
                    index[v.name] = 1
                end
                for i,value in pairs(max) do
                    if i == v.name then
                        comp[k].max = value
                        comp[k].table = {}
                        for i = 0, value do
                            table.insert(comp[k].table, i)
                        end
                        break
                    end
                end
            end
            while true do

            local menu = false
            RageUI.IsVisible(RMenu:Get("koth_admin",'koth_admin_main'),true,true,true,function()
                menu = true
                RageUI.Checkbox("Mode administration", nil, staffService, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    staffService = Checked;
                end, function()
                    staffService = true
                    TriggerEvent("KOTH:ClearAllBlips")
                    TriggerServerEvent("KOTH-ClearTeam",KOTH.TeamID)
                    Remove()
                    mug("Administration","~b~Statut du mode staff","Vous êtes désormais: ~g~en administration~s~.")
                    TriggerServerEvent("stafflog", true)
                end, function()
                    staffService = false
                    NoClip = false
                    ShowName = false
                    invisible = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    SetEntityCollision(GetPlayerPed(-1), 1, 1)
                    SetEntityVisible(GetPlayerPed(-1), 1, 0)
                    NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
                    TriggerServerEvent("KOTH-AddTeam",KOTH.TeamID)
                    TriggerServerEvent("stafflog", false)
                    Remove()
                    --for _,v in pairs(GetActivePlayers()) do
                    --    RemoveMpGamerTag(gamerTags[v])
                    --end
                    mug("Administration","~b~Statut du mode staff","Vous êtes désormais ~r~hors administration~s~.")
                end)

               -- if staffService then
                RageUI.Separator("↓↓ ~b~Mode administration ~w~↓↓")
                RageUI.ButtonWithStyle("Interactions personnelle", "Intéragir avec votre ped", { RightLabel = "→→" }, staffService == true, function()
                end, RMenu:Get('koth_admin', 'koth_admin_self'))
                RageUI.ButtonWithStyle("Interactions joueurs", "Intéragir avec les joueurs du serveur", { RightLabel = "→→" }, staffService == true, function(_,_,s)
                    if s then
                        TriggerServerEvent("core:pList")
                    end
                end, RMenu:Get('koth_admin', 'koth_admin_players'))
                RageUI.ButtonWithStyle("Interactions Vehicle", "Intéragir avec les véhicules", { RightLabel = "→→" }, staffService == true, function()
                end, RMenu:Get('koth_admin', 'koth_admin_car'))

                RageUI.ButtonWithStyle("Interactions Zone", "Crée une zone facilement", { RightLabel = "→→" }, staffService == true, function()
                end, RMenu:Get('koth_admin', 'koth_createzone'))
                
                RageUI.ButtonWithStyle("Skin Changer", "Intéragir avec votre skin", { RightLabel = "→→" }, staffService == true, function(_,_,s)
                    if s then
                        qty = {}
                        for i = 0,315 do
                            table.insert(qty,i)
                        end
                    end
                end, RMenu:Get('koth_admin', 'koth_admin_skinchanger'))
               -- end
            end, function()
            end, 1)

            RageUI.IsVisible(RMenu:Get("koth_admin",'koth_admin_players'),true,true,true,function()
                menu = true
                for k,v in ipairs(players) do 
                    RageUI.ButtonWithStyle("["..v.id.."] "..v.name, "Intéragir avec ce joueur", { RightLabel = "~b~Intéragir ~s~→→" }, true, function(_,a,s)
                        if s then
                            selected = v
                        end
                    end, RMenu:Get('koth_admin', 'koth_admin_players_interact'))
                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("koth_admin",'koth_admin_players_interact'),true,true,true,function()
                menu = true 
                for i = 1,#Admin.functions do
                    if Admin.functions[i].cat == "player" then
                        if Admin.functions[i].sep ~= nil then RageUI.Separator(Admin.functions[i].sep) end
                        RageUI.ButtonWithStyle(Admin.functions[i].label, "Appuyez pour faire cette action", isSubMenu[Admin.functions[i].toSub], actualRankPermissions[i] == true, function(_,a,s)
                            if s then
                                Admin.functions[i].press(selected)
                            end
                        end)
                    end
                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("koth_admin",'koth_admin_self'),true,true,true,function()
                menu = true 
                RageUI.Checkbox("NoClip", nil, NoClip, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    NoClip = Checked;
                end, function()
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    NoClip = true
                    invisible = true
                    initializeNoclip()
                    initializeInvis()
                end, function()
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    SetEntityCollision(GetPlayerPed(-1), 1, 1)
                    SetEntityVisible(GetPlayerPed(-1), 1, 0)
                    NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
                    invisible = false
                    NoClip = false
                end)

                RageUI.Checkbox("Invisibilité", nil, invisible, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    invisible = Checked;
                end, function()
                    invisible = true
                    initializeInvis()
                end, function()
                    invisible = false
                    SetEntityVisible(GetPlayerPed(-1), 1, 0)
                    NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
                end)
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("koth_admin",'koth_admin_skinchanger'),true,true,true,function()
                RageUI.ButtonWithStyle("Spawn avec le skin de base", nil, { RightLabel = "~b~Éxecuter ~s~→→" }, true, function(_,a,s)
                    if s then
                        TriggerEvent("skinchanger:change", "sex", "mp_m_freemode_01")                    
                    end
                end)

                --RageUI.Progress("test", countmin,countmax, "resr", 100, true, function(_,a,s)
                --    countmin = countmin + 0.5
                --    if countmin == 100 then
                --        RageUI.CloseAll()
                --    end
                --end)

                RageUI.Separator("↓ ~b~Skin Changer ~s~↓")

                for k,v in pairs(comp) do
                    RageUI.List(v.label, qty, index[v.name], nil, {}, true, function(Hovered, Active, Selected, Index)
                       index[v.name] = Index;
                    end, function(Index, CurrentItems)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            LastSkin = skin
                        end)
                        TriggerEvent('skinchanger:loadSkin', LastSkin)
                       TriggerEvent("skinchanger:change", v.name, Index - 1)
                    end)
                end



                for k,v in pairs(acce) do
                    RageUI.ButtonWithStyle(v.label, nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                        end
                    end, RMenu:Get('core', v.item.."1"))
                end
                
                RageUI.ButtonWithStyle("Save le skin sur discord", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerServerEvent("creator:SaveSkin", skin)
                            RageUI.CloseAll()
                        end)
                    end
                end)

            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("koth_admin",'koth_admin_car'),true,true,true,function()

                RageUI.ButtonWithStyle("Delete car", "Delete car", { RightBadge = RageUI.BadgeStyle.Car }, true, function(Hovered, Active, Selected)
                    if Active then 
                        ClosetVehWithDisplay() 
                        local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                    end
                    if Selected then
                        local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        TriggerServerEvent("DeleteEntity", VehToNet(veh))
                    end
                end)
            end, function()    
            end, 1)

            

            for k,v in pairs(acce) do
                RageUI.IsVisible(RMenu:Get('core', v.item.."1"), true, true, true, function()
                    for k,v in pairs(acce) do
                    if v.color ~= nil then
                        if v.label ~= "gilet pare-balle 1" then
                            for i = v.min, 15 do
                                RageUI.ButtonWithStyle("f", nil, { RightLabel = "" }, true, function(_,h,s)
                                    if s then
                                        TriggerEvent("skinchanger:change", v.item, i)

                                    end
                                if h then
                                        if NotSpamming[k] ~= i then
                                        TriggerEvent("skinchanger:change", v.item, i)
                                        NotSpamming[k] = i
                                        end
                                end
                                end) 
                                --if NotSpamming[k] == nil then NotSpamming[k] = i end
                                --RageUI.ButtonWithStyle(v.label.." "..i, nil, { RightLabel = "" }, true, function(_,h,s)
                                --    if s then
                                --        TriggerEvent("skinchanger:change", v.item, i)
                                --    end
                                --   if h then
                                --        if NotSpamming[k] ~= i then
                                --           TriggerEvent("skinchanger:change", v.item, i)
                                --           NotSpamming[k] = i
                                --        end
                                --   end
                                --end) 
                            end
                        end
                    else
                        
                            for i = v.min, v.max do
                                if NotSpamming[k] == nil then NotSpamming[k] = i end
                                RageUI.ButtonWithStyle(v.label.." "..i, nil, { RightLabel = "" }, true, function(_,h,s)
                                    if s then
                                        TriggerEvent("skinchanger:change", v.item, i)
                                    end
                                if h then
                                    if NotSpamming[k] ~= i then
                                        TriggerEvent("skinchanger:change", v.item, i)
                                        NotSpamming[k] = i
                                    end
                                end
                                end) 
                            end
                        
                    end
                end
                end, function()
                end)
            end

            
            RageUI.IsVisible(RMenu:Get("koth_admin",'koth_createzone'),true,true,true,function()
                RageUI.ButtonWithStyle("Nom de la Zone", nil, { RightLabel = ZoneCreate.name }, true, function(_,h,s)
                    if s then
                        local name = CustomStringStaff()
                        if name ~= nil then
                            ZoneCreate.name = tostring(name)
                        end
                    end
                end)

                RageUI.ButtonWithStyle("~b~Pos de la zone de combat", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        ZoneCreate.poscombat = Coords
                    end
                end)

                RageUI.ButtonWithStyle("~b~Pos de la base bleu", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        ZoneCreate.posBaseBleu = Coords
                    end
                end)
 
                RageUI.ButtonWithStyle("~b~Pos de la base bleu Weapon Shop", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        ZoneCreate.posweaponshopB = Coords
                    end
                end)

                RageUI.ButtonWithStyle("~b~Pos de la base bleu Voiture Shop", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        local HeandingCoords = GetEntityHeading(PlayerPedId())
                        ZoneCreate.heandingB = HeandingCoords
                        ZoneCreate.posvoitureshopB = Coords
                    end
                end)

                RageUI.ButtonWithStyle("~g~Pos de la base Vert", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        ZoneCreate.posBaseVert = Coords
                    end
                end)
 
                RageUI.ButtonWithStyle("~g~Pos de la base Vert Weapon Shop", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        ZoneCreate.posweaponshopG = Coords
                    end
                end)

                RageUI.ButtonWithStyle("~g~Pos de la base Vert Voiture Shop", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        local HeandingCoords = GetEntityHeading(PlayerPedId())
                        ZoneCreate.heandingG = HeandingCoords
                        ZoneCreate.posvoitureshopG = Coords
                    end
                end)

                RageUI.ButtonWithStyle("~r~Pos de la base Rouge", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        ZoneCreate.posBaseRouge = Coords
                    end
                end)
 
                RageUI.ButtonWithStyle("~r~Pos de la base Rouge Weapon Shop", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        ZoneCreate.posweaponshopR = Coords
                    end
                end)

                RageUI.ButtonWithStyle("~r~Pos de la base Rouge Voiture Shop", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        local Coords = GetEntityCoords(PlayerPedId())
                        local HeandingCoords = GetEntityHeading(PlayerPedId())
                        ZoneCreate.heandingR = HeandingCoords
                        ZoneCreate.posvoitureshopR = Coords
                    end
                end)

                RageUI.ButtonWithStyle("Validée la zone", nil, { RightLabel = "" }, true, function(_,h,s)
                    if s then
                        TriggerServerEvent("SendCoordsProps",ZoneCreate)
                    end
                end)
            end, function()
            end)
            Citizen.Wait(0)
            
        end
    end)

    end)
end

function CustomStringStaff()
    local txt = nil
    AddTextEntry("CREATOR_TXT", "Entrez votre texte.")
    DisplayOnscreenKeyboard(1, "CREATOR_TXT", '', "", '', '', '', 255)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        txt = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return txt
end

function registerMenus()
    RMenu.Add("koth_admin", "koth_admin_main", RageUI.CreateMenu("Menu d'administration","Rang: "..Admin.ranks[staffRank].color..Admin.ranks[staffRank].label))
    RMenu:Get('koth_admin', 'koth_admin_main').Closed = function()end

    RMenu.Add("koth_admin", "koth_admin_players", RageUI.CreateSubMenu(RMenu:Get('koth_admin', 'koth_admin_main'), "Menu d'administration","Rang: "..Admin.ranks[staffRank].color..Admin.ranks[staffRank].label))
    RMenu:Get('koth_admin', 'koth_admin_players').Closed = function()end

    RMenu.Add("koth_admin", "koth_admin_car", RageUI.CreateSubMenu(RMenu:Get('koth_admin', 'koth_admin_main'), "Menu d'administration","Rang: "..Admin.ranks[staffRank].color..Admin.ranks[staffRank].label))
    RMenu:Get('koth_admin', 'koth_admin_car').Closed = function()end

    RMenu.Add("koth_admin", "koth_admin_players_interact", RageUI.CreateSubMenu(RMenu:Get('koth_admin', 'koth_admin_players'), "Menu d'administration","Rang: "..Admin.ranks[staffRank].color..Admin.ranks[staffRank].label))
    RMenu:Get('koth_admin', 'koth_admin_players_interact').Closed = function()end

    RMenu.Add("koth_admin", "koth_admin_self", RageUI.CreateSubMenu(RMenu:Get('koth_admin', 'koth_admin_main'), "Menu d'administration","Rang: "..Admin.ranks[staffRank].color..Admin.ranks[staffRank].label))
    RMenu:Get('koth_admin', 'koth_admin_self').Closed = function()end

    RMenu.Add("koth_admin", "koth_createzone", RageUI.CreateSubMenu(RMenu:Get('koth_admin', 'koth_admin_main'), "Menu d'administration","Rang: "..Admin.ranks[staffRank].color..Admin.ranks[staffRank].label))
    RMenu:Get('koth_admin', 'koth_createzone').Closed = function()end

    
    RMenu.Add("koth_admin", "koth_admin_skinchanger", RageUI.CreateSubMenu(RMenu:Get('koth_admin', 'koth_admin_main'), "Menu d'administration","Rang: "..Admin.ranks[staffRank].color..Admin.ranks[staffRank].label))
    RMenu:Get('koth_admin', 'koth_admin_skinchanger').Closed = function()end

    for k,v in pairs(acce) do
        RMenu.Add('core', v.item.."1", RageUI.CreateSubMenu(RMenu:Get("koth_admin", "koth_admin_skinchanger"), "Création", "Gilet"))
        RMenu:Get('core', v.item.."1").Closed = function()end
    end
end

RegisterNetEvent("koth-b:bring")
AddEventHandler("koth-b:bring", function(pos)
    SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z, false, false, false, false)
end)

RegisterNetEvent("koth:goto")
AddEventHandler("koth:goto", function(coords)
    local pPed = PlayerPedId()
    SetEntityCoordsNoOffset(pPed, coords, 0.0, 0.0, 0.0)
end)



local Ran = false

-- Wait until client is loaded into the map
AddEventHandler("playerSpawned", function ()
	-- If not already ran
	if not Ran then
		-- Close loading screen resource
		ShutdownLoadingScreenNui()
		-- Set as ran
		Ran = true
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(60000*5)
        if staffService then
            TriggerServerEvent("KOTH-AdminGet", Pass["tokenserver"])
        end
    end
end)