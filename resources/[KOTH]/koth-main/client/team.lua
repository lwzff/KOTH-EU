KOTH = {}
KOTH.Teams = {}
KOTH.InZone = false
KOTH.TeamID = 0
KOTH.Gadgets = {}
KOTH.Gadgets.Med = {}
KOTH.Gadgets.Sup = {}
curTeamPlayerIndex = {}

local function onGround(x,y,z) 
    local _,groundZ,_ = GetGroundZAndNormalFor_3dCoord(x,y,z)
    return vector3(x,y,groundZ+15)
end

RegisterNetEvent("Koth-Team")
AddEventHandler("Koth-Team", function(Team)
    TriggerEvent("KOTH_HUD:removeHUD",2)
    SetFocusEntity(GetPlayerPed(PlayerId()))

    endCamera()
        --Citizen.CreateThread(function()
		DoScreenFadeOut(500)
        hideMainMenu()
		while not IsScreenFadedOut() do
            
			Citizen.Wait(2000)
		end

		DoScreenFadeIn(1000)
	--end)
    curTeamPlayerIndex[GetPlayerServerId(PlayerId())] = true
    TriggerEvent("KOTH:ClearAllBlips")
    if Team == "Rouge" then
        KOTH.Teams = Team
        KOTH.TeamID = 1
        GenerateOutfitNoClass(KOTH.TeamID)
        InitProps()
        local zoneRouge = AddBlipForRadius(PosBaseRou.x,PosBaseRou.y,PosBaseRou.z, 150.0)
        local zoneBlipR = AddBlipForCoord(PosBaseRou.x,PosBaseRou.y,PosBaseRou.z)
        SetBlipSprite(zoneRouge, 9)
        SetBlipColour(zoneRouge, 59)
        SetBlipAlpha(zoneRouge, 95)
        SetBlipSprite(zoneBlipR, 176)
        SetBlipColour(zoneBlipR, 59)
        SetBlipAlpha(zoneBlipR, 400)
        SetBlipAsShortRange(zoneBlipR, true)
        local zoneBleu = AddBlipForRadius(PosBaseBle.x,PosBaseBle.y,PosBaseBle.z, 150.0)
        local zoneBlipB = AddBlipForCoord(PosBaseBle.x,PosBaseBle.y,PosBaseBle.z)
        SetBlipSprite(zoneBleu, 9)
        SetBlipColour(zoneBleu, 4)
        SetBlipAlpha(zoneBleu, 95)
        SetBlipSprite(zoneBlipB, 176)
        SetBlipColour(zoneBlipB, 4)
        SetBlipAsShortRange(zoneBlipB, true)
        SetBlipAlpha(zoneBlipB, 400)
        local zoneVer = AddBlipForRadius(PosBaseVer.x,PosBaseVer.y,PosBaseVer.z, 150.0)
        local zoneBlipV = AddBlipForCoord(PosBaseVer.x,PosBaseVer.y,PosBaseVer.z)
        SetBlipSprite(zoneVer, 9)
        SetBlipColour(zoneVer, 4)
        SetBlipAlpha(zoneVer, 95)
        SetBlipSprite(zoneBlipV, 176)
        SetBlipColour(zoneBlipV, 4)
        SetBlipAlpha(zoneBlipV, 400)
        SetBlipAsShortRange(zoneBlipV, true)
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityCoords(PlayerPedId(),PosBaseRou.x,PosBaseRou.y,PosBaseRou.z)
        Wait(150)
        SetEntityCoords(PlayerPedId(),PosBaseRou.x,PosBaseRou.y,PosBaseRou.z)
        FreezeEntityPosition(PlayerPedId(), false)

    elseif Team == "Bleu" then
        KOTH.Teams = Team
        KOTH.TeamID = 2
        GenerateOutfitNoClass(KOTH.TeamID)
        InitProps()
        local zoneBleu = AddBlipForRadius(PosBaseBle.x,PosBaseBle.y,PosBaseBle.z, 150.0)
        local zoneBlipB = AddBlipForCoord(PosBaseBle.x,PosBaseBle.y,PosBaseBle.z)
        SetBlipSprite(zoneBleu, 9)
        SetBlipColour(zoneBleu, 3)
        SetBlipAlpha(zoneBleu, 95)
        SetBlipSprite(zoneBlipB, 176)
        SetBlipColour(zoneBlipB, 3)
        SetBlipAsShortRange(zoneBlipB, true)
        SetBlipAlpha(zoneBlipB, 400)
        local zoneRouge = AddBlipForRadius(PosBaseRou.x,PosBaseRou.y,PosBaseRou.z, 150.0)
        local zoneBlipR = AddBlipForCoord(PosBaseRou.x,PosBaseRou.y,PosBaseRou.z)
        SetBlipSprite(zoneRouge, 9)
        SetBlipColour(zoneRouge, 4)
        SetBlipAlpha(zoneRouge, 95)
        SetBlipSprite(zoneBlipR, 176)
        SetBlipColour(zoneBlipR, 4)
        SetBlipAlpha(zoneBlipR, 400)
        SetBlipAsShortRange(zoneBlipR, true)
        local zoneVer = AddBlipForRadius(PosBaseVer.x,PosBaseVer.y,PosBaseVer.z, 150.0)
        local zoneBlipV = AddBlipForCoord(PosBaseVer.x,PosBaseVer.y,PosBaseVer.z)
        SetBlipSprite(zoneVer, 9)
        SetBlipColour(zoneVer, 4)
        SetBlipAlpha(zoneVer, 95)
        SetBlipSprite(zoneBlipV, 176)
        SetBlipColour(zoneBlipV, 4)
        SetBlipAlpha(zoneBlipV, 400)
        SetBlipAsShortRange(zoneBlipV, true)

        FreezeEntityPosition(PlayerPedId(), true)

        SetEntityCoords(PlayerPedId(),PosBaseBle.x,PosBaseBle.y,PosBaseBle.z)
        Wait(150)
        SetEntityCoords(PlayerPedId(),PosBaseBle.x,PosBaseBle.y,PosBaseBle.z)
        FreezeEntityPosition(PlayerPedId(), false)


    elseif Team == "Vert" then
        KOTH.Teams = Team
        KOTH.TeamID = 3
        GenerateOutfitNoClass(KOTH.TeamID)
        InitProps()
        local zoneVer = AddBlipForRadius(PosBaseVer.x,PosBaseVer.y,PosBaseVer.z, 150.0)
        local zoneBlipV = AddBlipForCoord(PosBaseVer.x,PosBaseVer.y,PosBaseVer.z)
        SetBlipSprite(zoneVer, 9)
        SetBlipColour(zoneVer, 2)
        SetBlipAlpha(zoneVer, 95)
        SetBlipSprite(zoneBlipV, 176)
        SetBlipColour(zoneBlipV, 2)
        SetBlipAlpha(zoneBlipV, 400)
        SetBlipAsShortRange(zoneBlipV, true)
        local zoneRouge = AddBlipForRadius(PosBaseRou.x,PosBaseRou.y,PosBaseRou.z, 150.0)
        local zoneBlipR = AddBlipForCoord(PosBaseRou.x,PosBaseRou.y,PosBaseRou.z)
        SetBlipSprite(zoneRouge, 9)
        SetBlipColour(zoneRouge, 4)
        SetBlipAlpha(zoneRouge, 95)
        SetBlipSprite(zoneBlipR, 176)
        SetBlipColour(zoneBlipR, 4)
        SetBlipAlpha(zoneBlipR, 400)
        SetBlipAsShortRange(zoneBlipR, true)
        local zoneBleu = AddBlipForRadius(PosBaseBle.x,PosBaseBle.y,PosBaseBle.z, 150.0)
        local zoneBlipB = AddBlipForCoord(PosBaseBle.x,PosBaseBle.y,PosBaseBle.z)
        SetBlipSprite(zoneBleu, 9)
        SetBlipColour(zoneBleu, 4)
        SetBlipAlpha(zoneBleu, 95)
        SetBlipSprite(zoneBlipB, 176)
        SetBlipColour(zoneBlipB, 4)
        SetBlipAsShortRange(zoneBlipB, true)
        SetBlipAlpha(zoneBlipB, 400)
        FreezeEntityPosition(PlayerPedId(), true)

        SetEntityCoords(PlayerPedId(),PosBaseVer.x,PosBaseVer.y,PosBaseVer.z)
        Wait(150)
        SetEntityCoords(PlayerPedId(),PosBaseVer.x,PosBaseVer.y,PosBaseVer.z)
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerEvent("KOTH_HUD:removeHUD",2)

    end
end)

Citizen.CreateThread(function()
    -- Zone Checking Thread
    while true do
        Citizen.Wait(1500)
        if KOTH.Teams ~= 0 then
            local coords = GetEntityCoords(PlayerPedId(), true)
            local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, PosZone.x, PosZone.y, PosZone.z, false)

            if distance < 270.0 and not KOTH.InZone and not IsPlayerDead(PlayerId()) then
                TriggerServerEvent("PlayerEnteredKothZone",KOTH.TeamID)
                print("InZone")
                KOTH.InZone = true
            elseif (distance > 270.0 or IsPlayerDead(PlayerId())) and KOTH.InZone then
                TriggerServerEvent("PlayerLeftKothZone",KOTH.TeamID)
                print("ExitZone")
                KOTH.InZone = false
            end
        else
            Citizen.Wait(500)
        end
    end
end)



RegisterNetEvent("KOTH:ReturnBase")
AddEventHandler("KOTH:ReturnBase",function()
    GenerateOutfitNoClass(KOTH.TeamID)
    if KOTH.TeamID == 1 then
        SetEntityCoords(PlayerPedId(),PosBaseRou.x,PosBaseRou.y,PosBaseRou.z)
        Wait(150)
        SetEntityCoords(PlayerPedId(),PosBaseRou.x,PosBaseRou.y,PosBaseRou.z)
    elseif KOTH.TeamID == 2 then
        SetEntityCoords(PlayerPedId(),PosBaseBle.x,PosBaseBle.y,PosBaseBle.z)
        Wait(150)
        SetEntityCoords(PlayerPedId(),PosBaseBle.x,PosBaseBle.y,PosBaseBle.z)
    elseif KOTH.TeamID == 3 then
        SetEntityCoords(PlayerPedId(),PosBaseVer.x,PosBaseVer.y,PosBaseVer.z)
        Wait(150)
        SetEntityCoords(PlayerPedId(),PosBaseVer.x,PosBaseVer.y,PosBaseVer.z)
    end
end)

RegisterNetEvent("PlayerLeftKothServer")
AddEventHandler("PlayerLeftKothServer",function()
    print("Left Server")
    TriggerServerEvent("PlayerLeftKothServer",KOTH.TeamID)
end)

Teams = {
	{id = 1, name = "Red",colour = 1, spawncar = vector3(0,0,0)},
    {id = 2, name = "Blue",colour = 3, spawncar = vector3(0,0,0)}, 
	{id = 3, name = "Green", colour = 2, spawncar = vector3(0,0,0)},
}