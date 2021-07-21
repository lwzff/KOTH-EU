function CreateCarShop(car)
    local pos1 
    local heading
    if KOTH.TeamID == 1 then
        pos1 = Possss.spawncarRouge
    elseif KOTH.TeamID == 2 then
        pos1 = Possss.spawncarBleu
    elseif KOTH.TeamID == 3 then
        pos1 = Possss.spawncarVert
    end

    local spawnPointss, SpawPoint = GetAvailableVehicleSpawnPoint(pos1)

    --if not IsAnyVehicleNearPoint(SpawPoint.pos, SpawPoint.heading) then
        local modelHash = GetHashKey(car)
        RequestModel(modelHash)
    
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
        veh = CreateVehicle(modelHash,SpawPoint.pos, SpawPoint.heading, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        DecorSetBool(veh, Pass["veh"], true)
    --end
end

function GetAvailableVehicleSpawnPoint(post)
	local spawnPoints = post
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if not IsAnyVehicleNearPoint(spawnPoints[i].pos, 5.0) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
    --print(spawnPoints[i])
		return true, foundSpawnPoint
	else
		return false
	end
end

RegisterNetEvent("koth-main:createcar")
AddEventHandler("koth-main:createcar",function(token,car)
    if token == Pass["createcar"] then
        CreateCarShop(car)
        --print("Create Car")
    end
end)

function SpawnCarPoint(point)
    if not IsAnyVehicleNearPoint(point.x,point.y, point.z, 15.0) then
        return true, point
    end
end

