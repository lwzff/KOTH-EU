local recoils = {
	[GetHashKey("weapon_microsmg")] = 0.35, -- MICRO SMG
	[GetHashKey("weapon_smg")] = 0.30, -- SMG
	[GetHashKey("weapon_assaultsmg")] = 0.25, -- ASSAULT SMG
	[GetHashKey("weapon_assaultrifle")] = 0.25, -- ASSAULT RIFLE
	[GetHashKey("weapon_carbinerifle")] = 0.23, -- CARBINE RIFLE
	[GetHashKey("weapon_pistol50")] = 3.20, -- CAL.50
	[GetHashKey("weapon_advancedrifle")] = 0.34, -- ADVANCED RIFLE
	[GetHashKey("weapon_mg")] = 0.35, -- MG
	[GetHashKey("weapon_combatmg")] = 0.35, -- COMBAT MG
	[GetHashKey("weapon_sniperrifle")] = 10.20, -- SNIPER RIFLE
	[GetHashKey("weapon_heavysniper")] = 0.90, -- HEAVY SNIPER
	[GetHashKey("weapon_heavysniper_mk2")] = 3.90, -- HEAVY SNIPER MK2
	[GetHashKey("weapon_microsmg")] = 0.35, -- MINI SMG		
	[GetHashKey("weapon_marksmanrifle")] = 5.60, -- MARKSMANRIFFLE
	[GetHashKey("weapon_marksmanrifle_mk2")] = 5.60, -- MARKSMANRIFFLE MK2
	[GetHashKey("weapon_pumpshotgun")] = 2.00, -- PompeShotgun
	[GetHashKey("weapon_heavyshotgun")] = 1.60, -- HeavyShotgun
}


--function InitRecoil()
    Citizen.CreateThread(function()
    	while true do
            Citizen.Wait(0)
			local pPed = GetPlayerPed(-1)

            if IsPedArmed(pPed, 6) then
    		    if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
    		    	local _,wep = GetCurrentPedWeapon(PlayerPedId())
    		    	if recoils[wep] and recoils[wep] ~= 0 then
    		    		tv = 0
    		    		if GetFollowPedCamViewMode() ~= 4 then
    		    			repeat 
    		    				Wait(0)
    		    				camp = GetGameplayCamRelativePitch()
    		    				SetGameplayCamRelativePitch(camp+0.35, 0.45)
    		    				tv = tv+0.35
    		    			until tv >= recoils[wep]
    		    		else
    		    			repeat 
    		    				Wait(0)
    		    				camp = GetGameplayCamRelativePitch()
    		    				if recoils[wep] > 0.35 then
    		    					SetGameplayCamRelativePitch(camp+0.6, 1.2)
    		    					tv = tv+0.6
    		    				else
    		    					SetGameplayCamRelativePitch(camp+0.016, 0.333)
    		    					tv = tv+0.35
    		    				end
    		    			until tv >= recoils[wep]
    		    		end
    		    	end
                end
            else
                Wait(1000)
            end
    	end
	end)

--end