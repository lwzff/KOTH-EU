IsPlayerDead1 = false
IsPlayerDead2 = false
local Notif = false
local FullLife = false
KillByPed = 0


RegisterCommand("kill", function(source,arg)
    if staffService then
        KillByPed = 15
        Notif = true
        Wait(5000)
        Notif = false
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Wait(1)

        if KillByPed >= 5 and not IsPlayerDead1 then
                TriggerEvent("KOTH:RightNotification",-1,-1 , "Kill Streak Activate 5 kill")

            if IsDisabledControlJustPressed(0, 164) then
                if GetEntityHealth(PlayerPedId()) == 200 then
                    TriggerEvent("KOTH:CenterNotification","You have full life !")
                else
                    TriggerEvent("KOTH:RightNotification",-1,-1,"Load Health ...")
                    InitHealth()
                    IsPlayerDead1 = true
                end
            end
        end
        if KillByPed >= 10 and not IsPlayerDead2 then
                TriggerEvent("KOTH:RightNotification",-1,-1 , "Kill Streak Activate 10 kill")

            if IsDisabledControlJustPressed(0, 165) then
                TriggerEvent("KOTH:RightNotification",-1,-1 , "RC-XD deployed")
                TriggerEvent("koth:startRC")
                IsPlayerDead2 = true
            end
        end
    end
end)

function InitHealth()
    Citizen.SetTimeout(1000, function()
        if GetEntityHealth(PlayerPedId()) ~= 200 then
            if not FullLife then
                SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 5)
                InitHealth()
            end
        else
            FullLife = false
        end
    end,false)
end