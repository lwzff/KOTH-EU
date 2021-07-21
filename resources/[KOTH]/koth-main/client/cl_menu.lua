local co = false
local NotSpam = false
AddEventHandler('playerSpawned', function()
    if not co then
        TriggerEvent("KOTH_HUD:removeHUD",1)
        startCamera()
        showMainMenu()
        ClearPedBloodDamage(PlayerPedId())
        co = true
        TriggerEvent("core:ResetDeathStatus",true)
        TriggerServerEvent("GetUserBDD")
    else
        TriggerEvent("KOTH:ReturnBase")
        TriggerEvent("core:ResetDeathStatus", true)

        ClearPedBloodDamage(PlayerPedId())
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "koth-main" then
        Wait(1500)
        showMainMenu()
        startCamera()
        TriggerEvent("playerSpawned")
    end
end)


  
function showMainMenu()
    local data = {type = "show", one = "Opfor Team", two = "Independent", three = "Blufor Team"}
    SendNUIMessage(data)
    SetNuiFocus(true, true)
end

function hideMainMenu()
    local data = {type = "hide"}
    SendNUIMessage(data)
    SetNuiFocus(false, false)

end

RegisterNetEvent("KOTH-TeamFull")
AddEventHandler("KOTH-TeamFull", function(team)
    local send = {
        type = "teamfull",
        fullteam = team
    }
    NotSpam = false
    SendNUIMessage(send)
end)

RegisterNUICallback('selectTeam', function(data, cb)
    local selectedTeam = data.selectedTeam

    if not NotSpam then
        TriggerServerEvent("Koth-SelectTeam", selectedTeam)
        NotSpam = true
    end
    
    cb({ok = true})
end)