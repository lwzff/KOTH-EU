local cloths = nil
Class = nil
Citizen.CreateThread(function()
    TriggerServerEvent("KOTH:GetCloth")
end)

RegisterNetEvent("KOTH:GetCloth")
AddEventHandler("KOTH:GetCloth",function(cloth)
    cloths = cloth
end)

RegisterNetEvent("KOTH:ChangeClass")
AddEventHandler("KOTH:ChangeClass",function(class)
    GenerateOutfitClass(KOTH.TeamID,class)
end)

function GenerateOutfitNoClass(team)
    print("Generate Outfit")
    if team == 1 then
        if cloths ~= nil then
			for k,v in pairs(cloths) do
				if v.class == "opfor_infantry" then
                    TriggerEvent('skinchanger:loadSkin', json.decode(v.clothes))
				end
			end
        end
    elseif team == 2 then
        if cloths ~= nil then
			for k,v in pairs(cloths) do
				if v.class == "blufor_infantry" then
                    TriggerEvent('skinchanger:loadSkin', json.decode(v.clothes))
				end
			end
        end
    elseif team == 3 then
        if cloths ~= nil then
			for k,v in pairs(cloths) do
				if v.class == "indenpendant_infantry" then
                    TriggerEvent('skinchanger:loadSkin', json.decode(v.clothes))
				end
			end
        end
    end
end

function GenerateOutfitClass(team, class)
    if team == 1 then
        if cloths ~= nil then
			for k,v in pairs(cloths) do
				if v.class == "opfor_"..class then
                    TriggerEvent('skinchanger:loadSkin', json.decode(v.clothes))
				end
			end
        end
    elseif team == 2 then
        if cloths ~= nil then
			for k,v in pairs(cloths) do
				if v.class == "blufor_"..class then
                    TriggerEvent('skinchanger:loadSkin', json.decode(v.clothes))
				end
			end
        end
    elseif team == 3 then
        if cloths ~= nil then
			for k,v in pairs(cloths) do
				if v.class == "indenpendant_"..class then
                    TriggerEvent('skinchanger:loadSkin', json.decode(v.clothes))
				end
			end
        end
    end
    Class = class
    --if Class == "medic" then
    --    AddMedicRevive()
    --end
end

function draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.4, 0.7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local TeamMember = {}
local isReviving = false
local ReviveDead = false
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if Class == "medic" then
            TeamMember = InfoTeam[KOTH.TeamID].members
            for k,playerID in pairs(TeamMember) do
                local serverID = playerID.id
                local player = GetPlayerFromServerId(serverID)
                local ped1 = GetPlayerPed(player)
                local pCoords = GetEntityCoords(PlayerPedId())
                if not IsEntityDead(GetPlayerPed(-1)) then
                    if ped1 and ped1 ~= GetPlayerPed(-1) then
                        if IsEntityDead(ped1) then
                            if #(pCoords - GetEntityCoords(ped1, false)) < 3.5 then
                                local entityCoords = GetEntityCoords(ped1, false)
                                if not isReviving then
                                    draw3DText(entityCoords.x, entityCoords.y, entityCoords.z+1.5, "Press E to revive")
                                    if IsControlJustReleased(1, 38) and not isReviving then -- E
                                        ReviveDead = true
                                        RequestAnimDict("mini@cpr@char_a@cpr_str")
                                        while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
                                            Wait(0)
                                        end
                                        TaskPlayAnim(PlayerPedId(),"mini@cpr@char_a@cpr_str", "cpr_pumpchest", 1.0,-1.0, 24000, 1, 1)
                                        Citizen.Wait(5000)
                                        ClearPedTasks(PlayerPedId())
                                        isReviving = true
                                        if ReviveDead then
                                            TriggerServerEvent('core:ResetDeathStatus', playerID.id, true)
                                            TriggerServerEvent("KOTH-REVIVEMEDICHERRE", Pass["tokenserver"],2)
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    ReviveDead = false
                end
            end
        end
    end
end)

RegisterNetEvent("KOTH:ENDGAMEXPAND")
AddEventHandler("KOTH:ENDGAMEXPAND", function(data,type)
    if data == Pass["tokenserver"] then
        TriggerServerEvent("KOTH:ENDGAMEXPAND", Pass["tokenserver"], type)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if isReviving then
            Citizen.SetTimeout(35000, function()
                isReviving = false
            end)
        end
    end
end)
