--Citizen.CreateThread(function()
--    while true do
--        if #TeamPoints == 100 then
--        end
--        Wait(5000)
--    end
--end)

local vert = 50.0
local teamEnd = ""

function startVictoireCamera()
    local cam1Pos = vector3(PosZone.x + 50.0 + 50.0, PosZone.y, PosZone.z + vert)
    local cam2Pos = vector3(PosZone.x, PosZone.y + 50.0 + 50.0, PosZone.z + vert)
    local cam3Pos = vector3(PosZone.x - 50.0 + 50.0, PosZone.y, PosZone.z + vert)
    local cam4Pos = vector3(PosZone.x, PosZone.y - 50.0 + 50.0, PosZone.z + vert)

    DisplayRadar(false)
    DestroyAllCams(true)
    SetFocusArea(PosZone.x - 50.0 + 50.0, PosZone.y, PosZone.z + vert)
    local cam1 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cam1Pos.x, cam1Pos.y, cam1Pos.z, 0.0, 0.0, 0.0, 50.0, false, 0.0)
    local cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cam2Pos.x, cam2Pos.y, cam2Pos.z, 0.0, 0.0, 0.0, 50.0, false, 0.0)
    local cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cam3Pos.x, cam3Pos.y, cam3Pos.z, 0.0, 0.0, 0.0, 50.0, false, 0.0)
    local cam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cam4Pos.x, cam4Pos.y, cam4Pos.z, 0.0, 0.0, 0.0, 50.0, false, 0.0)
    SetCamActive(cam1, true)
    RenderScriptCams(true, false, 2000, true, true)
    PointCamAtCoord(cam1, PosZone.x, PosZone.y, PosZone.z)
    PointCamAtCoord(cam2, PosZone.x, PosZone.y, PosZone.z)
    PointCamAtCoord(cam3, PosZone.x, PosZone.y, PosZone.z)
    PointCamAtCoord(cam4, PosZone.x, PosZone.y, PosZone.z)
    -- RequestCollisionAtCoord(PosZone.x, PosZone.y, PosZone.z)
    NewLoadSceneStart(PosZone.x, PosZone.y, PosZone.z, PosZone.x, PosZone.y, PosZone.z, 50.0, 0);

    Citizen.CreateThread(function()
        while true do
            SetCamActiveWithInterp(cam2, cam1, 30000, true, true)
            Citizen.Wait(30100)
            SetCamActiveWithInterp(cam3, cam2, 30000, true, true)
            Citizen.Wait(30100)
            SetCamActiveWithInterp(cam4, cam3, 30000, true, true)
            Citizen.Wait(30100)
            SetCamActiveWithInterp(cam1, cam4, 30000, true, true)
            Citizen.Wait(30100)
        end
    end)
end

displayDoneMission = false
str = "End Game"
END = false
local rt = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

RegisterNetEvent("KothEndMatch")
AddEventHandler("KothEndMatch", function(Victoire,teamwin)
    TriggerEvent("KOTH_HUD:removeHUD",1)
    END = true
    if Victoire then
        teamEnd = teamwin
        startVictoireCamera()
        SetWeatherTypePersist('EXTRASUNNY')
        SetWeatherTypeNow('EXTRASUNNY')
        SetWeatherTypeNowPersist('EXTRASUNNY')
        if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
            RequestNamedPtfxAsset("scr_indep_fireworks")
            while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
               Wait(10)
            end
        end
        
        Citizen.CreateThread(function()
            while true do 
                local rX = PosZone.x + math.random(-75, 75)
                local rY = PosZone.y + math.random(-75, 75)
                local rZ = PosZone.z
                local firecoords = vector3(rX, rY, rZ)

                UseParticleFxAssetNextCall("scr_indep_fireworks")
                StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

                Wait(200)
            end
        end)
        Wait(10000)
        displayDoneMission = true
    else
        teamEnd = teamwin
        startVictoireCamera()
        SetWeatherTypePersist('EXTRASUNNY')
        SetWeatherTypeNow('EXTRASUNNY')
        SetWeatherTypeNowPersist('EXTRASUNNY')
        if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
            RequestNamedPtfxAsset("scr_indep_fireworks")
            while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
               Wait(10)
            end
        end
        
        Citizen.CreateThread(function()
            while true do 
                local rX = PosZone.x + math.random(-75, 75)
                local rY = PosZone.y + math.random(-75, 75)
                local rZ = PosZone.z
                local firecoords = vector3(rX, rY, rZ)

                UseParticleFxAssetNextCall("scr_indep_fireworks")
                StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

                Wait(200)
            end
        end)
        Wait(10000)
        displayDoneMission = true
    end
end)

Citizen.CreateThread(function()
	while true do
		if displayDoneMission then
			StartScreenEffect("SuccessTrevor",  2500,  false)
			curMsg = "SHOW_MISSION_PASSED_MESSAGE"
			SetAudioFlag("AvoidMissionCompleteDelay", true)
			PlayMissionCompleteAudio("FRANKLIN_BIG_01")
			Citizen.Wait(3000)
			StopScreenEffect()
			curMsg = "TRANSITION_OUT"
			PushScaleformMovieFunction(rt, "TRANSITION_OUT")
			PopScaleformMovieFunction()
			Citizen.Wait(10000)
			displayDoneMission = false
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		if(HasScaleformMovieLoaded(rt) and displayDoneMission)then
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(19)
			HideHudAndRadarThisFrame()

			if (curMsg == "SHOW_MISSION_PASSED_MESSAGE") then
			
			PushScaleformMovieFunction(rt, curMsg)
 
            ---BeginScaleformMovieMethod(rt, 'SHOW_SHARD_WASTED_MP_MESSAGE')
            PushScaleformMovieMethodParameterString(str)
            PushScaleformMovieMethodParameterString("Victory of "..teamEnd)
            EndScaleformMovieMethod()
			--BeginTextComponent("STRING")
			--AddTextComponentString(str)
			--EndTextComponent()
			--BeginTextComponent("STRING")
			--AddTextComponentString("Gain: "..gain.."$")
			--EndTextComponent()

			PushScaleformMovieFunctionParameterInt(145)
			PushScaleformMovieFunctionParameterBool(false)
			PushScaleformMovieFunctionParameterInt(1)
			PushScaleformMovieFunctionParameterBool(true)
			PushScaleformMovieFunctionParameterInt(69)

			PopScaleformMovieFunctionVoid()

			Citizen.InvokeNative(0x61bb1d9b3a95d802, 1)
			end
			
			DrawScaleformMovieFullscreen(rt, 255, 255, 255, 255)
		end
    end
end)
