local Open = false
local color1 = false
local Color2 = false
local possiblecolor = false
local NotOpen = false

local PlayerInfo = {}
local PlayerStat = {}
local ColorPrimary = {}
local ColorSecondary = {}
local possibleWeapon = false
local ComposentWeaponSaved = {}
local hud = false
RegisterNetEvent("SendUtis")
AddEventHandler("SendUtis",function(info)
    PlayerInfo = info
end)

playerss = {
    {
        name = nil,
        kills = 0,
        assist = 0,
        death = 0,
        money = 0,
        xp = 0
    }
}
RegisterNetEvent("KOTH-HUD:OPEN")
AddEventHandler("KOTH-HUD:OPEN",function(player)
    for k,v in pairs(player) do
        if GetPlayerServerId(PlayerId()) == v.id then
            playerss[1].kills = v.kill
            playerss[1].death = v.death
            playerss[1].money = v.money
            playerss[1].xp = v.score
        end
    end
end)
RMenu.Add("menu_state", "menu_state_main", RageUI.CreateMenu("Player Info","Get your stats",10,222))
RMenu:Get('menu_state', 'menu_state_main'):SetRectangleBanner(22,18,18,65);
RMenu:Get('menu_state', 'menu_state_main').Closed = function() Open = false  NotOpen = false end;

RMenu.Add("menu_state", "menu_state_stat", RageUI.CreateSubMenu(RMenu:Get('menu_state', 'menu_state_main'),"Player Info","Get your stats"))
RMenu:Get('menu_state', 'menu_state_stat').Closable = false
RMenu:Get('menu_state', 'menu_state_stat').Closed = function() Open = false NotOpen = false end;

RMenu.Add("menu_state", "menu_state_weapon", RageUI.CreateSubMenu(RMenu:Get('menu_state', 'menu_state_main'),"Weapons Accessories","Weapons Accessories"))
RMenu:Get('menu_state', 'menu_state_weapon').Closable = false
RMenu:Get('menu_state', 'menu_state_weapon').Closed = function() Open = false NotOpen = false end;

RMenu.Add("menu_state", "menu_state_car", RageUI.CreateSubMenu(RMenu:Get('menu_state', 'menu_state_main'),"Car Custom","Car Custom"))
RMenu:Get('menu_state', 'menu_state_car').Closable = false
RMenu:Get('menu_state', 'menu_state_car').Closed = function() Open = false NotOpen = false end;

Citizen.CreateThread(function()
    Wait(1000)
    for k,v in ipairs(Colors) do
        RMenu.Add('menu_state', v.value, RageUI.CreateSubMenu(RMenu:Get('menu_state', 'menu_state_car'),"Car Custom","Car Custom"))
        RMenu:Get('menu_state', v.value).Closed = function()
        end
    end
end)


local Pourcent = 0.0
local LoadInfo = 0

function InitPlayerMenu()
    print("Player menu")
    if Open then print("Menu Open") end

    if not Open then
        Open = true
        Citizen.CreateThread(function()
            while Open do
                RageUI.IsVisible(RMenu:Get("menu_state",'menu_state_main'),true,true,true,function()
                    if LoadInfo == 0 then 
                        for k,v in pairs(PlayerInfo) do
                            RageUI.Separator("Id Shop : ~b~"..v.id)
                            RageUI.Separator("Id Server : ~b~"..GetPlayerServerId(PlayerId()))
                            RageUI.Separator("Your Status : ~b~"..v.type)
                            RageUI.Separator("Player Name : ~b~"..GetPlayerName(PlayerId()))
                        end
                        RageUI.Checkbox("Disable / Enable HUD", nil, hud, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                            hud = Checked;
                        end, function()
                            hud = true
                            TriggerEvent("KOTH_HUD:removeHUD",1)

                        end, function()
                            hud = false
                            TriggerEvent("KOTH_HUD:removeHUD",2)
                        end)
                        RageUI.Separator("~b~↓                ↓")
                        RageUI.ButtonWithStyle("See your stats", nil, {RightLabel = "📈 ~b~→→"}, true, function(_,_,s)
                            if s then
                                LoadInfo = 1
                            end
                        end)

                        RageUI.ButtonWithStyle("Custom your weapon", nil, {RightLabel = "🔫 ~b~→→"},IsPedArmed(PlayerPedId(), 7), function(_,_,s)
                            if s then
                            end
                        end, RMenu:Get('menu_state', 'menu_state_weapon'))

                        
                        RageUI.ButtonWithStyle("Custom your car", nil, {RightLabel = "🚘 ~b~→→"},IsPedInAnyVehicle(PlayerPedId(), false), function(_,_,s)
                        end, RMenu:Get('menu_state', 'menu_state_car'))
                    elseif LoadInfo == 1 then
                        RageUI.PercentagePanel(Pourcent or 0.0, "Loading your stats . . . (" .. math.floor(Pourcent*100) .. "%)", "", "",  function(Hovered, Active, Percent)
                            if Pourcent < 1.0 then
                                Pourcent = Pourcent + 0.004
                            else
                                LoadInfo = 0
                                Pourcent = 0.0
                                RageUI.CloseAll()
                                RageUI.Visible(RMenu:Get('menu_state', 'menu_state_stat'), true)
                            end
                        end)
                    end
                end, function()
                end)
                
                RageUI.IsVisible(RMenu:Get("menu_state",'menu_state_stat'),true,true,true,function()
                    for k,v in pairs(playerss) do
                        RageUI.Separator("⚔ - Kill : ~b~"..v.kills)
                        RageUI.Separator("💀 - Death : ~b~"..v.death)
                        RageUI.Separator("🏅 - Xp : ~b~"..v.xp)
                        RageUI.Separator("💵 - Money : ~b~"..v.money.." ~g~$")
                        if v.kills ~= 0 and v.death ~= 0 then
                            RageUI.Separator("🛡 - Ratio : ~o~"..string.format("%.2f", v.kills/v.death))
                        else
                            RageUI.Separator("🛡 - Ratio : ~o~ 0")
                        end
                    end
                    RageUI.Separator("~b~↓                ↓")

                    RageUI.ButtonWithStyle("~r~Go Back", nil, {RightLabel = "~b~→→"}, true, function(_,_,s)
                        if s then
                            LoadInfo = 0
                        end
                    end, RMenu:Get('menu_state', 'menu_state_main'))
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get("menu_state",'menu_state_weapon'),true,true,true,function()
                    local _,getWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)

                    if json.encode(ComposentWeaponSaved) == "[]" then
                        messages = "~r~You have not component registered"
                        possibleWeapon = false
                    else
                        possibleWeapon = true
                        messages = "~g~Activate save component"
                    end
                    RageUI.ButtonWithStyle(messages, nil, {RightLabel = "150 $~b~→→"}, possibleWeapon, function(_,_,s)
                        if s then
                            if json.encode(ComposentWeaponSaved) ~= "[]" then
                                for k,v in pairs(ComposentWeaponSaved) do
                                    if not HasPedGotWeaponComponent(PlayerPedId(), getWeapon, v) then
                                        GiveWeaponComponentToPed(PlayerPedId(), getWeapon, v)
                                        TriggerServerEvent("Koth-RemoveMoney", 150)
                                    end                              
                                end
                            end
                        end
                    end)

                    RageUI.Separator("~b~↓                ↓")

                    for k,v in pairs(WeaponHashKey) do
                        if DoesWeaponTakeWeaponComponent(getWeapon, v) then
                            RageUI.ButtonWithStyle(GetNameOfComposent(k), nil, {RightLabel = "~b~ 50 $ →→"}, true, function(_,_,s)
                                if s then
                                    if HasPedGotWeaponComponent(PlayerPedId(), getWeapon, v) then
                                        RemoveWeaponComponentFromPed(PlayerPedId(), getWeapon, v)
                                    else
                                        table.insert(ComposentWeaponSaved, v)
                                        GiveWeaponComponentToPed(PlayerPedId(), getWeapon, v)
                                        TriggerServerEvent("Koth-RemoveMoney", 50)
                                    end
                                end
                            end)
                        end
                    end
                    RageUI.Separator("~b~↓                ↓")

                    RageUI.ButtonWithStyle("~r~Go Back", nil, {RightLabel = "~b~→→"}, true, function(_,_,s)
                        if s then
                            LoadInfo = 0
                        end
                    end, RMenu:Get('menu_state', 'menu_state_main'))
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get("menu_state",'menu_state_car'),true,true,true,function()

                    if json.encode(ColorPrimary) == "[]" then
                        message = "~r~You have no colors registered"
                        possiblecolor = false
                    else
                        possiblecolor = true
                        message = "~g~Apply saved colors"
                    end
                    RageUI.ButtonWithStyle(message, nil, {RightLabel = "🎨 ~b~→→"}, possiblecolor, function(_,_,s)
                        if s then
                            local pPed = GetPlayerPed(-1)
                            local pVeh = GetVehiclePedIsIn(pPed, 0)
                            if json.encode(ColorPrimary) ~= "[]" then
                                SetVehicleProperties(pVeh, ColorPrimary)
                                UpdateVehProps()
                            end
                            if json.encode(ColorSecondary) ~= "[]" then
                                SetVehicleProperties(pVeh, ColorSecondary)
                                UpdateVehProps()
                            end
                        end
                    end)
                    RageUI.Separator("~b~↓                ↓")

                    RageUI.ButtonWithStyle("~r~Go Back", nil, {RightLabel = "~b~→→"}, true, function(_,_,s)
                        if s then
                            LoadInfo = 0
                        end
                    end, RMenu:Get('menu_state', 'menu_state_main'))
                    RageUI.Separator("~b~↓                ↓")

                    RageUI.Checkbox("~b~Color Secondary", nil, color1, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        color1 = Checked;
                    end, function()
                        color1 = true
                    end, function()
                        color1 = false
                    end)
                    for k,v in ipairs(Colors) do
                        RageUI.ButtonWithStyle(v.label, nil, { RightLabel = "🎨 ~b~→→" }, true, function(_,_,s)
                            if s then
                                if not color1 then
                                    PaintType = 2
                                elseif color1 then
                                    PaintType = 3
                                end
                            end
                        end, RMenu:Get('menu_state', v.value))
                    end
                    RageUI.Separator("~b~↓                ↓")

                    RageUI.ButtonWithStyle("~r~Go Back", nil, {RightLabel = "~b~→→"}, true, function(_,_,s)
                        if s then
                            LoadInfo = 0
                        end
                    end, RMenu:Get('menu_state', 'menu_state_main'))
                end, function()
                end)

                for k,v in ipairs(Colors) do
                    RageUI.IsVisible(RMenu:Get('menu_state', v.value), true, true, true, function()
                        local pPed = GetPlayerPed(-1)
                        local pVeh = GetVehiclePedIsIn(pPed, 0)
                        local colors = GetColors(v.value)
                        for _,i in pairs(colors) do
                            RageUI.ButtonWithStyle(i.label, nil, { RightLabel = "🎨 ~b~→→" }, true, function(_,a,s)
                                if a then
                                    if PaintType == 1 then
                                        SetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1), 0), {pearlescentColor = i.index})
                                    elseif PaintType == 2 then
                                        SetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1)), {color1 = i.index})
                                    elseif PaintType == 3 then
                                        SetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1)), {color2 = i.index})
                                    elseif PaintType == 4 then
                                        SetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1)), {wheelColor = i.index})
                                    end
                                end
                                if s then
                                    if PaintType == 2 then
                                        ColorPrimary = {}
                                        ColorPrimary = {color1 = i.index}
                                        SetVehicleProperties(pVeh, {color1 = i.index})
                                        UpdateVehProps()
                                    elseif PaintType == 3 then
                                        ColorSecondary = {}
                                        ColorSecondary = {color2 = i.index}
                                        SetVehicleProperties(pVeh, {color2 = i.index})
                                        UpdateVehProps()
                                    end
                                end
                            end)
                        end
                    end, function()    
                    end, 1)
                end
                Wait(0)
            end
        end)
    end
end

function GetNameOfComposent(hash)
    local name = WeaponHashText[hash]
    return name
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 166) then
            if not NotOpen then
                print("Enter Menu Player Stats Load")
                InitPlayerMenu()
                RageUI.Visible(RMenu:Get('menu_state', 'menu_state_main'), true)
                NotOpen = true
            end
        end
        Wait(0)
    end
end)