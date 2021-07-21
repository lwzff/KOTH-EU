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
local selfTable = {}
local showScore = false
local scoreboardOn = false
local teams = false 
RegisterNetEvent("Koth-Team")
AddEventHandler("Koth-Team",function(team)
    teams = true
    --print("Event Team")
end)
Citizen.CreateThread(function()
    Wait(250)
    while true do
       -- if teams then
            TriggerServerEvent("KOTH-HUD:Update")
        --end
        Wait(1000)
    end
end)

local count = false
RegisterNetEvent("KOTH-HUD:OPEN")
AddEventHandler("KOTH-HUD:OPEN",function(palyers)
    for k,v in pairs(palyers) do
        if GetPlayerServerId(PlayerId()) == v.id then
            playerss[1].name = GetPlayerName(PlayerId())
            playerss[1].kills = v.kill
            playerss[1].death = v.death
            playerss[1].money = v.money
            playerss[1].xp = v.score
            selfTable = playerss[1]
        end
    end
    if count then
        --SendNUIMessage({players = palyers, update = true})
        exports['koth-ui']:SendUIMessage({eventName = "updateScoreboard", players = palyers, selfTable = selfTable})
    else
        Wait(250)
        count = true
        --SendNUIMessage({players = palyers})
        exports['koth-ui']:SendUIMessage({eventName = "updateScoreboard", players = palyers, selfTable = selfTable})
    end
end)

Citizen.CreateThread(function()
    Wait(1000)
        --SendNUIMessage({rank = Ranks})
    
    scoreboardOn = false
    showScore = true
    while true do
        Citizen.Wait(0)
        if not scoreboardOn then
            if IsControlPressed(0, 211) and showScore and GetLastInputMethod(0) then -- Scoreboard
               -- SendNUIMessage({stats = playerss})
                exports['koth-ui']:SendUIMessage({eventName = "displayScoreboard"})--type = "open"

                scoreboardOn = true
                while scoreboardOn do
                    Citizen.Wait(0)
                    if not IsControlPressed(0, 211) then
                        scoreboardOn = false
                        exports['koth-ui']:SendUIMessage({eventName = "hideScoreboard"})--type = "close"
                    end
                end
            end    
        end
    end
end)