local KOTH = {}

Camera = true
LoseConnectionDistance = 100.0

RegisterNetEvent('koth:startRC')
AddEventHandler('koth:startRC', function(token)
    KOTH.Debug("Init RCXD")
    KOTH.Start()
end)

RegisterCommand("rcbandito", function(source,arg)
    if staffService then
		KOTH.Start()
	end
end, false)

function KOTH.Start()
    TriggerEvent("KOTH_HUD:removeHUD",1)
	if DoesEntityExist(KOTH.Entity) then 
		return 
	end

	KOTH.Spawn()
end

function KOTH.HandleKeys(distanceCheck)
	if IsControlJustReleased(0, 47) then
		KOTH.Explode()
	end

	if distanceCheck > LoseConnectionDistance then
		local explosionDist = math.floor((LoseConnectionDistance + 50.0) - distanceCheck )
		DrawTxt("WARNING\nOUT OF RANGE, SIGNAL LOW\nMAX: ("..explosionDist..')m')
	end

	if distanceCheck > tonumber(LoseConnectionDistance + 50.0) then
		KOTH.Explode()
	end

	if DoesEntityExist(KOTH.Entity) then
		if IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 9, 1)
		end
		
		if IsControlJustReleased(0, 172) or IsControlJustReleased(0, 173) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 6, 2500)
		end

		if IsControlPressed(0, 173) and not IsControlPressed(0, 172) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 22, 1)
		end

		if IsControlPressed(0, 174) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 13, 1)
		end

		if IsControlPressed(0, 175) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 14, 1)
		end

		if IsControlPressed(0, 172) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 30, 100)
		end

		if IsControlPressed(0, 174) and IsControlPressed(0, 172) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 7, 1)
		end

		if IsControlPressed(0, 175) and IsControlPressed(0, 172) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 8, 1)
		end

		if IsControlPressed(0, 174) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 4, 1)
		end

		if IsControlPressed(0, 175) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 5, 1)
		end
	end
end

function DrawInstructions(distanceCheck)
	local steeringButtons = {
		{
			["label"] = "Turn right",
			["button"] = "~INPUT_CELLPHONE_RIGHT~"
		},
		{
			["label"] = "Moving forward",
			["button"] = "~INPUT_CELLPHONE_UP~"
		},
		{
			["label"] = "Move back",
			["button"] = "~INPUT_CELLPHONE_DOWN~"
		},
		{
			["label"] = "Turn left",
			["button"] = "~INPUT_CELLPHONE_LEFT~"
		}
	}

	local buttonsToDraw = {
		{
			["label"] = "Detonate",
			["button"] = "~INPUT_DETONATE~"
		}
	}

	if distanceCheck <= LoseConnectionDistance then
		for buttonIndex = 1, #steeringButtons do
			local steeringButton = steeringButtons[buttonIndex]

			table.insert(buttonsToDraw, steeringButton)
		end
	end
    HelpMessage(buttonsToDraw)

end

function HelpMessage(buttonsToDraw)
    Citizen.CreateThread(function()
        local instructionScaleform = RequestScaleformMovie("instructional_buttons")
 
        while not HasScaleformMovieLoaded(instructionScaleform) do
            Wait(0)
        end
 
        PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
        PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
        PushScaleformMovieFunctionParameterBool(0)
        PopScaleformMovieFunctionVoid()
 
        for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
            PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(buttonIndex - 1)
 
            PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
            PushScaleformMovieFunctionParameterString(buttonValues["label"])
            PopScaleformMovieFunctionVoid()
        end
 
        PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(-1)
        PopScaleformMovieFunctionVoid()
        DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
    end)
end

function KOTH.Spawn()
	KOTH.Tablet(true)

    KOTH.LoadModels({ GetHashKey("rcbandito"), 68070371 })

    local spawnCoords, spawnHeading = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 2.0, GetEntityHeading(PlayerPedId())
    veh = CreateVehicle(GetHashKey("rcbandito"),spawnCoords,spawnHeading, true, true)
    DecorSetBool(veh, Pass["veh"], true)
    KOTH.Entity = veh
    SetEntityNoCollisionEntity(KOTH.Entity, PlayerPedId())

    while not DoesEntityExist(KOTH.Entity) do
        Citizen.Wait(5)
    end
    KOTH.Driver = CreatePed(5, 68070371, spawnCoords, spawnHeading, false)

    SetEntityInvincible(KOTH.Driver, true)
    SetEntityVisible(KOTH.Driver, false)
    FreezeEntityPosition(KOTH.Driver, true)
    SetPedAlertness(KOTH.Driver, 0.0)
    SetBlockingOfNonTemporaryEvents(KOTH.Driver, true)
    SetVehicleDoorsLockedForAllPlayers(KOTH.Entity,  true)

    TaskWarpPedIntoVehicle(KOTH.Driver, KOTH.Entity, -1)

    while not IsPedInVehicle(KOTH.Driver, KOTH.Entity) do
        Citizen.Wait(0)
    end


    while DoesEntityExist(KOTH.Entity) and DoesEntityExist(KOTH.Driver) do
        Citizen.Wait(5)

        local distanceCheck = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(KOTH.Entity))

        DrawInstructions(distanceCheck)
        KOTH.HandleKeys(distanceCheck)

        if IsEntityDead(PlayerPedId()) then
            KOTH.Explode()
        end

        if GetEntityHealth(KOTH.Entity) < 950 then
            KOTH.Explode()
        end

        if not IsCamRendering(KOTH.Camera) then KOTH.ToggleCamera(true) end

        if distanceCheck <= tonumber(LoseConnectionDistance + 50.0) then
            if not NetworkHasControlOfEntity(KOTH.Driver) then
                NetworkRequestControlOfEntity(KOTH.Driver)
            elseif not NetworkHasControlOfEntity(KOTH.Entity) then
                NetworkRequestControlOfEntity(KOTH.Entity)
            end
        else
            TaskVehicleTempAction(KOTH.Driver, KOTH.Entity, 6, 2500)
        end
    end
end

function KOTH.Debug(message)
    print("^5[KOTH] ^0"..message)
end

function KOTH.Tablet(boolean)
	print(boolean)
	if boolean then
		KOTH.LoadModels({GetHashKey("prop_cs_tablet")})

		KOTH.TabletEntity = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(PlayerPedId()), false)

		AttachEntityToEntity(KOTH.TabletEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		KOTH.LoadModels({ "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a" })
	
		TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	else
		ClearPedTasks(PlayerPedId())
		DeleteEntity(KOTH.TabletEntity)
	end
end

function KOTH.ToggleCamera(boolean)
	if not Camera then 
		return 
	end

	if boolean then

		if not DoesEntityExist(KOTH.Entity) then return end 
		if DoesCamExist(KOTH.Camera) then DestroyCam(KOTH.Camera) end

		KOTH.Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

		AttachCamToEntity(KOTH.Camera, KOTH.Entity, 0.0, 0.0, 0.4, true)
		Citizen.CreateThread(function()
			while DoesCamExist(KOTH.Camera) do
				Citizen.Wait(5)

				SetCamRot(KOTH.Camera, GetEntityRotation(KOTH.Entity))
			end
		end)

		local easeTime = 500 * math.ceil(#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(KOTH.Entity)) / 10)

		RenderScriptCams(1, 1, easeTime, 1, 1)

		Citizen.Wait(easeTime)

		SetTimecycleModifier("scanline_cam_cheap")
		SetTimecycleModifierStrength(2.0)
	else
		local easeTime = 42 * math.ceil(#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(KOTH.Entity)) / 10)
		DeleteEntity(KOTH.Entity)
		DeleteEntity(KOTH.Driver)

		ClearTimecycleModifier()

		RenderScriptCams(0, 1, easeTime, 1, 0)

		Citizen.Wait(easeTime)

		DestroyCam(KOTH.Camera)
	end
end

function KOTH.LoadModels(models)
	print("Load")
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		if not KOTH.CachedModels then
			KOTH.CachedModels = {}
		end

		table.insert(KOTH.CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
				print(model)
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

function KOTH.UnloadModels()
	for modelIndex = 1, #KOTH.CachedModels do
		local model = KOTH.CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end
	end
end

function KOTH.Explode()
	local coords = GetEntityCoords(KOTH.Entity)
	AddOwnedExplosion(PlayerPedId(), coords.x, coords.y, coords.z, 3.0, 2.0, true, false, true)

    TriggerEvent("KOTH_HUD:removeHUD",2)
	KOTH.ToggleCamera(false)
	KOTH.Tablet(false)
end



function DrawTxt(text)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.4, 0.4)
    SetTextColour(255, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.85) 
end