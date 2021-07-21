local vert = 50.0


function startCamera()
    local cam1Pos = vector3(PosZone.x + 450.0 + 50.0, PosZone.y, PosZone.z + vert)
    local cam2Pos = vector3(PosZone.x, PosZone.y + 450.0 + 50.0, PosZone.z + vert)
    local cam3Pos = vector3(PosZone.x - 450.0 + 50.0, PosZone.y, PosZone.z + vert)
    local cam4Pos = vector3(PosZone.x, PosZone.y - 450.0 + 50.0, PosZone.z + vert)

    DisplayRadar(false)
    DestroyAllCams(true)
    SetFocusArea(PosZone.x - 450.0 + 50.0, PosZone.y, PosZone.z + vert)
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

function endCamera()
    DisplayRadar(true)
    RenderScriptCams(false, false, 2000, true, true)
    DestroyAllCams(true)
end