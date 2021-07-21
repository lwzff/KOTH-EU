GamerTagVeh = {}
GamerTagWeapon = {}

function InitProps()
    if Possss.heandingR ~= nil then
        print("Inot Props In Zone")

        if KOTH.TeamID == 1 then
            local prop = GetHashKey('prop_car_battery_01')

            local heandingR = Possss.heandingR
            local ped = CreatePed(4, LoadModel("s_m_y_armymech_01"), Possss.posvoitureshopR.x, Possss.posvoitureshopR.y ,Possss.posvoitureshopR.z-0.98, heandingR, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedDiesWhenInjured(ped, false)
            SetPedCanPlayAmbientAnims(ped, true)
            SetPedCanRagdollFromPlayerImpact(ped, false)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)

            GamerTagVeh = CreateFakeMpGamerTag(ped," Press E to open the shop Car", false, false, "", 0)
            

            SetMpGamerTagColour(GamerTagVeh, 0, 18)

            local x1,y1,z1 = table.unpack(GetOffsetFromEntityInWorldCoords(ped,2.0, -2.5, 0.0))
            local veh = CreateVehicle(LoadModel("insurgent3"), x1, y1, z1-1.20, heandingR, false, false)
            DecorSetBool(veh, Pass["veh"], true)
            SetEntityCoords(PlayerPedId(), x1,y1,z1)
            SetVehicleDoorsLocked(veh, 2)
            SetEntityInvincible(veh, true)
            FreezeEntityPosition(veh, true)
            SetVehicleCanBeLockedOn(veh, false, false)

            
            local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(ped, -1.0, -1.5, 0.0))
            local obj = CreateObject(prop, x2, y2, z2-0.98, false, true, true)
            SetEntityInvincible(obj, true)
            FreezeEntityPosition(obj, true)

            --Weapon--
            local propTherm = GetHashKey('hei_prop_heist_thermite_case')
            local propCase = GetHashKey('p_gcase_s')
            local propTbl = GetHashKey('prop_table_03')   
            local ped2 = CreatePed(4, LoadModel("s_m_y_armymech_01"), Possss.posweaponshopR.x, Possss.posweaponshopR.y ,Possss.posweaponshopR.z-0.98,heandingR, false, true)
            SetBlockingOfNonTemporaryEvents(ped2, true)
            SetPedDiesWhenInjured(ped2, false)
            SetPedCanPlayAmbientAnims(ped2, true)
            SetPedCanRagdollFromPlayerImpact(ped2, false)
            SetEntityInvincible(ped2, true)
            FreezeEntityPosition(ped2, true)
            
            GamerTagWeapon = CreateFakeMpGamerTag(ped2," Press E to open the shop Weapon", false, false, "", 0)
            
            SetMpGamerTagColour(GamerTagWeapon, 0, 18)
            local x1,y1,z1 = table.unpack(GetOffsetFromEntityInWorldCoords(ped2, 0.0, 1.0, 0.0))
            local tblObj = CreateObject(propTbl, x1, y1, Possss.posweaponshopR.z-0.98, false, true, true)
            FreezeEntityPosition(tblObj, true)
            SetEntityRotation(tblObj, 0.0, 0.0, heandingR, 0, true)
            SetEntityInvincible(tblObj, true)
    
            local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(tblObj, 0.3, 0.0, 0.4))
            local caseObj = CreateObject(propCase, x2, y2, z2, false, true, true)
            SetEntityRotation(caseObj, 0.0, 0.0,heandingR-160.0, 0, true)
            SetEntityInvincible(caseObj, true)
    
            local x3,y3,z3 = table.unpack(GetOffsetFromEntityInWorldCoords(tblObj, -0.5, 0.0, 0.4))
            local thermObj = CreateObject(propTherm, x3, y3, z3, false, true, true)
            SetEntityRotation(thermObj, 0.0, 0.0, heandingR, 0, true)
            SetEntityInvincible(thermObj, true)

        elseif KOTH.TeamID == 2 then
            local prop = GetHashKey('prop_car_battery_01')

            local heandingB = Possss.heandingB
            local ped = CreatePed(4, LoadModel("s_m_y_armymech_01"), Possss.posvoitureshopB.x, Possss.posvoitureshopB.y ,Possss.posvoitureshopB.z-0.98, heandingB, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedDiesWhenInjured(ped, false)
            SetPedCanPlayAmbientAnims(ped, true)
            SetPedCanRagdollFromPlayerImpact(ped, false)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)

            GamerTagVeh = CreateFakeMpGamerTag(ped," Press E to open the shop car", false, false, "", 0)
            

            SetMpGamerTagColour(GamerTagVeh, 0, 18)

            local x1,y1,z1 = table.unpack(GetOffsetFromEntityInWorldCoords(ped,2.0, -2.5, 0.0))
            local veh = CreateVehicle(LoadModel("insurgent3"), x1, y1, z1-1.20, heandingB, false, false)
            DecorSetBool(veh, Pass["veh"], true)
            SetEntityCoords(PlayerPedId(), x1,y1,z1)
            SetVehicleDoorsLocked(veh, 2)
            SetEntityInvincible(veh, true)
            FreezeEntityPosition(veh, true)
            SetVehicleCanBeLockedOn(veh, false, false)

            
            local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(ped, -1.0, -1.5, 0.0))
            local obj = CreateObject(prop, x2, y2, z2-0.98, false, true, true)
            SetEntityInvincible(obj, true)
            FreezeEntityPosition(obj, true)

            --Weapon--
            local propTherm = GetHashKey('hei_prop_heist_thermite_case')
            local propCase = GetHashKey('p_gcase_s')
            local propTbl = GetHashKey('prop_table_03')   
            local ped2 = CreatePed(4, LoadModel("s_m_y_armymech_01"), Possss.posweaponshopB.x, Possss.posweaponshopB.y ,Possss.posweaponshopB.z-0.98,heandingB, false, true)
            SetBlockingOfNonTemporaryEvents(ped2, true)
            SetPedDiesWhenInjured(ped2, false)
            SetPedCanPlayAmbientAnims(ped2, true)
            SetPedCanRagdollFromPlayerImpact(ped2, false)
            SetEntityInvincible(ped2, true)
            FreezeEntityPosition(ped2, true)
            
            GamerTagWeapon = CreateFakeMpGamerTag(ped2," Press E to open the shop car", false, false, "", 0)
            

            SetMpGamerTagColour(GamerTagWeapon, 0, 18)
            local x1,y1,z1 = table.unpack(GetOffsetFromEntityInWorldCoords(ped2, 0.0, 1.0, 0.0))
            local tblObj = CreateObject(propTbl, x1, y1, Possss.posweaponshopB.z-0.98, false, true, true)
            FreezeEntityPosition(tblObj, true)
            SetEntityRotation(tblObj, 0.0, 0.0, heandingB, 0, true)
            SetEntityInvincible(tblObj, true)
    
            local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(tblObj, 0.3, 0.0, 0.4))
            local caseObj = CreateObject(propCase, x2, y2, z2, false, true, true)
            SetEntityRotation(caseObj, 0.0, 0.0,heandingB-160.0, 0, true)
            SetEntityInvincible(caseObj, true)
    
            local x3,y3,z3 = table.unpack(GetOffsetFromEntityInWorldCoords(tblObj, -0.5, 0.0, 0.4))
            local thermObj = CreateObject(propTherm, x3, y3, z3, false, true, true)
            SetEntityRotation(thermObj, 0.0, 0.0, heandingB, 0, true)
            SetEntityInvincible(thermObj, true)
        elseif KOTH.TeamID == 3 then
            local prop = GetHashKey('prop_car_battery_01')

            local heandingG = Possss.heandingG
            local ped = CreatePed(4, LoadModel("s_m_y_armymech_01"), Possss.posvoitureshopG.x, Possss.posvoitureshopG.y ,Possss.posvoitureshopG.z-0.98, heandingG, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedDiesWhenInjured(ped, false)
            SetPedCanPlayAmbientAnims(ped, true)
            SetPedCanRagdollFromPlayerImpact(ped, false)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)

            GamerTagVeh = CreateFakeMpGamerTag(ped," Press E to open the shop car", false, false, "", 0)
            
            SetMpGamerTagColour(GamerTagVeh, 0, 18)

            local x1,y1,z1 = table.unpack(GetOffsetFromEntityInWorldCoords(ped,2.0, -2.5, 0.0))
            local veh = CreateVehicle(LoadModel("insurgent3"), x1, y1, z1-1.20, heandingG, false, false)
            DecorSetBool(veh, Pass["veh"], true)
            SetEntityCoords(PlayerPedId(), x1,y1,z1)
            SetVehicleDoorsLocked(veh, 2)
            SetEntityInvincible(veh, true)
            FreezeEntityPosition(veh, true)
            SetVehicleCanBeLockedOn(veh, false, false)

            
            local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(ped, -1.0, -1.5, 0.0))
            local obj = CreateObject(prop, x2, y2, z2-0.98, false, true, true)
            SetEntityInvincible(obj, true)
            FreezeEntityPosition(obj, true)

            --Weapon--
            local propTherm = GetHashKey('hei_prop_heist_thermite_case')
            local propCase = GetHashKey('p_gcase_s')
            local propTbl = GetHashKey('prop_table_03')   
            local ped2 = CreatePed(4, LoadModel("s_m_y_armymech_01"), Possss.posweaponshopG.x, Possss.posweaponshopG.y ,Possss.posweaponshopG.z-0.98,heandingG, false, true)
            SetBlockingOfNonTemporaryEvents(ped2, true)
            SetPedDiesWhenInjured(ped2, false)
            SetPedCanPlayAmbientAnims(ped2, true)
            SetPedCanRagdollFromPlayerImpact(ped2, false)
            SetEntityInvincible(ped2, true)
            FreezeEntityPosition(ped2, true)
            
            GamerTagWeapon = CreateFakeMpGamerTag(ped2," Press E to open the shop car", false, false, "", 0)
            
            SetMpGamerTagColour(GamerTagWeapon, 0, 18)

            local x1,y1,z1 = table.unpack(GetOffsetFromEntityInWorldCoords(ped2, 0.0, 1.0, 0.0))
            local tblObj = CreateObject(propTbl, x1, y1, Possss.posweaponshopG.z-0.98, false, true, true)
            FreezeEntityPosition(tblObj, true)
            SetEntityRotation(tblObj, 0.0, 0.0, heandingG, 0, true)
            SetEntityInvincible(tblObj, true)
    
            local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(tblObj, 0.3, 0.0, 0.4))
            local caseObj = CreateObject(propCase, x2, y2, z2, false, true, true)
            SetEntityRotation(caseObj, 0.0, 0.0,heandingG-160.0, 0, true)
            SetEntityInvincible(caseObj, true)
    
            local x3,y3,z3 = table.unpack(GetOffsetFromEntityInWorldCoords(tblObj, -0.5, 0.0, 0.4))
            local thermObj = CreateObject(propTherm, x3, y3, z3, false, true, true)
            SetEntityRotation(thermObj, 0.0, 0.0, heandingG, 0, true)
            SetEntityInvincible(thermObj, true)

        end
    end
end

function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(1)
    end
    return model
end