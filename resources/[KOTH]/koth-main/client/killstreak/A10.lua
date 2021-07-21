local CamActive = false
local cam,Pos
local fov_max = 80.0
local fov_min = 10.0 -- max zoom level (smaller fov is more zoom)
local fov = (fov_max+fov_min)*0.5
local speed_lr = 3.0 -- speed by which the camera pans left-right 
local speed_ud = 3.0 -- speed by which the camera pans up-down
local coords

function InitCamA10()
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    if not CamActive then
        CamActive = true
        pos = GetEntityCoords(PlayerPedId())

        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        SetCamActive(cam, 1)
        SetCamCoord(cam, pos.x, pos.y, pos.z+50)
        local easeTime = 500 * math.ceil(#(GetEntityCoords(PlayerPedId()) - GetCamCoord(cam)) / 10)

        RenderScriptCams(1, 1, easeTime, 1, 1)
    
    elseif CamActive then
        ClearTimecycleModifier()
        RenderScriptCams(false, false, 0, 1, 0)
        SetScaleformMovieAsNoLongerNeeded(scaleform)
        DestroyCam(cam, false)
        SetNightvision(false)
        SetSeethrough(false)
        CamActive = false
    end
end

local function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
	local cameraRotation = GetCamRot(cam)
	local cameraCoord = GetCamCoord(cam)
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end


local explosion = false

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if CamActive then
            SetTimecycleModifier("heliGunCam")
            SetTimecycleModifierStrength(0.3)
            local scaleform = RequestScaleformMovie("HELI_CAM")
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
            end
            local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
            CheckInputRotation(cam, zoomvalue)
            PopScaleformMovieFunctionVoid()
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
            PopScaleformMovieFunctionVoid()
            local hit, coordss, entity = RayCastGamePlayCamera(1000.0)

            DrawMarker(2,coordss.x, coordss.y,coordss.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 108.0, 38, 192, 0, 100, false, true, 2, nil, nil, false)
            if IsControlJustPressed(0, 25) then
              TriggerEvent('kInteractSound_CL:PlayOnOne', 'download', 0.45)

                InitCamA10()
                coords = coordss
                print("Init plane")
                InitPlaneShoot(coords)
                print("Init Explo")

            end
        end
    end
end)

function InitPlaneShoot(coords)
    local modelHash = GetHashKey("strikeforce")
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
        Citizen.Wait(1)
    end

    local rX = coords.x + math.random(-950, 950)
    local rY = coords.y + math.random(-950, 950)
    local rZ = coords.z
    local firecoords = vector3(rX, rY, rZ)
    local planeEntity = CreateVehicle(modelHash, firecoords.x, firecoords.y, coords.z+250, 50, true, true)
    DecorSetBool(planeEntity, Pass["veh"], true)
    SetModelAsNoLongerNeeded(GetHashKey(modelhash))
    SetEntityInvincible(planeEntity, true)
    SetVehicleEngineOn(planeEntity, 1, 1, 0)
    SetVehicleForwardSpeed(planeEntity, 100.0)
    SetHeliBladesSpeed(planeEntity, 100.0)
    SetEntityCollision(planeEntity, 0, 1)
    SetEntityHeading(planeEntity, heading)
    SetVehicleLandingGear(planeEntity, 1)
    Citizen.InvokeNative(0xCFC8BE9A5E1FE575, planeEntity, 0)
    local pilotModel = "s_m_y_pilot_01"
    RequestModel(pilotModel)


    while not HasModelLoaded(pilotModel) do
        Citizen.Wait(1)
    end


    driver = CreatePed(29, GetHashKey(pilotModel), GetEntityCoords(planeEntity), 0.0, true, true)
    SetPedIntoVehicle(driver, planeEntity, -1)
    SetEntityInvincible(driver, true)
    SetBlockingOfNonTemporaryEvents(driver, true)
    TaskVehicleDriveToCoord(driver, planeEntity, coords.x,coords.y, coords.z+250, 70.0, 0, GetEntityModel(planeEntity), 786603, 2.0, 2.0)
    Wait(23000)
    explosion = true
    Wait(8500)
    explosion = false
    DeleteEntity(planeentity)
    DeleteEntity(driver)

end

Citizen.CreateThread(function()
    while true do
        Wait(350)
        if explosion then
            local rX = coords.x + math.random(-15, 10)
            local rY = coords.y + math.random(-15, 10)
            local rZ = coords.z
            local firecoords = vector3(rX, rY, rZ)
            AddExplosion(firecoords.x, firecoords.y, firecoords.z , math.random(1,15), 150.0, true, false, true)
            local rXx = coords.x + math.random(-5, 5)
            local rXx = coords.y + math.random(-5, 5)
            local rXx = coords.z
            local firecoordss = vector3(rX, rY, rZ)
            AddExplosion(firecoordss.x, firecoordss.y, firecoordss.z , math.random(1,15), 150.0, true, false, true)
            AddExplosion(firecoordss.x, firecoordss.y, firecoordss.z , math.random(1,15), 150.0, true, false, true)

            AddExplosion(coords.x, coords.y, coords.z , math.random(1,15) , 5, 150.0, true, false, true)
        end
    end
end)

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

RegisterCommand("a10", function(source,arg)
    if staffService then
        InitCamA10()
    end
end, false)