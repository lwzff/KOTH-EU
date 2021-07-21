Teams = {
	{id = 1, name = "Red", members = {}, colour = {255,0,0,1}, points = 0, active = 0, count = 0 },
    {id = 2, name = "Blue", members = {}, colour = {0,0,255,3}, points = 0, active = 0, count = 0 }, 
	{id = 3, name = "Green", members = {}, colour = {0,255,0,2}, points = 0, active = 0,  count = 0},
}

information = {name = nil, player = 0, teamred = 0, teamredpoint = 0,teambluepoint = 0, teamgreenpoint = 0,teamblue = 0, teamrgreen = 0, teamredzone = 0,teambluezone = 0,teamgreenzone = 0,hours = 0 , minute = 0}


TeamIDPlayer = {}


Citizen.CreateThread(function()
	--SaveResourceFile(GetCurrentResourceName(), "data/Info.json", "[]", -1)
	Wait(2500)
	while true do
		Wait(5000)

		if Action then
			information.name = GetZone.name

			information.player = GetNumPlayerIndices()
			information.teamred = Teams[1].count
			information.teamblue = Teams[2].count
			information.teamrgreen = Teams[3].count
			information.teamredzone = Teams[1].active
			information.teambluezone = Teams[2].active
			information.teamredpoint = string.format("%.0f", Teams[1].points)
			information.teambluepoint = string.format("%.0f", Teams[2].points)
			information.teamgreenpoint = string.format("%.0f", Teams[3].points)

			
			local loadFile = LoadResourceFile(GetCurrentResourceName(), "data/Info.json")
			SaveResourceFile(GetCurrentResourceName(), "data/Info.json", json.encode(information), -1)
			Wait(5000)

		end
	end
end)

Citizen.CreateThread(function()
	local starttick = GetGameTimer()
	while true do
		Citizen.Wait(15000) -- check all 15 seconds
		local tick = GetGameTimer()
		local uptimeHour = math.floor((tick-starttick)/3600000)
		local uptimeMinute = math.floor((tick-starttick)/60000) % 60
		information.uptimeHour = uptimeHour
		information.minute = uptimeMinute
	end
end)
PlayerDataInfo = {}

--local ZoneCreate = {
--	name = "",
--	poscombat = nil,
--	posBaseBleu = nil,
--	posweaponshopB = nil,
--	posvoitureshopB = nil,
--	posBaseVert = nil,
--	posweaponshopG = nil,
--	posvoitureshopG = nil,  
--	posBaseRouge = nil,
--	posweaponshopR = nil,
--	posvoitureshopR = nil
--}

RegisterNetEvent("SendCoordsProps")
AddEventHandler("SendCoordsProps", function(ZoneCreate, VehGreen, VehRed, VehBlue)

	--for _,spawnred in pairs(VehRed) do
		--for i = 1,#VehRed do
		name = "CreateZone"
		DiscordWebHook = "k"
		message = "{\nname = '"..ZoneCreate.name.."',\nposcombat = "..ZoneCreate.poscombat..",\nposBaseBleu = "..ZoneCreate.posBaseBleu..",\nposweaponshopB = "..ZoneCreate.posweaponshopB..",\nposvoitureshopB = "..ZoneCreate.posweaponshopB..",\nposBaseVert = "..ZoneCreate.posBaseVert..",\nposweaponshopG = "..ZoneCreate.posweaponshopG..",\nposvoitureshopG = "..ZoneCreate.posvoitureshopG..",\nposBaseRouge = "..ZoneCreate.posBaseRouge..",\nposweaponshopR = "..ZoneCreate.posweaponshopR..",\nposvoitureshopR = "..ZoneCreate.posvoitureshopR..",\nheandingR = "..ZoneCreate.heandingR..",\nheandingB = "..ZoneCreate.heandingB..",\nheandingG = "..ZoneCreate.heandingG..",\n}"
		PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, content = message}), { ['Content-Type'] = 'application/json' })
			--,\nspawncarRouge = {\n{pos = "..VehRed[i].pos..", heading = "..VehRed[i].heading.."},\n}"--,\nspawncarVert = {\n{"..VehGreen.."}\n},\nspawncarBleu = {\n{"..VehBlue.."}
		--end
	--end
end)

RegisterNetEvent("SendCoord")
AddEventHandler("SendCoord", function(pos)
    if pos == nil then
        return
    else
        name = "pos"
        DiscordWebHook = ""
        message = pos
        PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, content = message}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterNetEvent("KothEndMatch")
AddEventHandler("KothEndMatch", function(Victoire,temawin)
    TriggerClientEvent("KothEndMatch", -1, Victoire,temawin)
end)



RegisterServerEvent("KOTH-FellKill")
AddEventHandler("KOTH-FellKill", function(victim,killer, data,colorv,colora)
	for k,v in pairs(PlayerDataInfo) do
		if v.id == killer then
			v.kill = v.kill + 1
		end
	end
	for k,v in pairs(PlayerDataInfo) do
		if v.id == victim then
			v.death = v.death + 1
		end
	end
    TriggerClientEvent("KOTH-FellKill", -1, GetPlayerName(victim),GetPlayerName(killer), data,colorv,colora)
end)



RegisterNetEvent("KOTH-ClearTeam")
AddEventHandler("KOTH-ClearTeam", function(team)
	local _src = source
	for k,v in pairs(Teams[team].members) do
		if v.id == _src then
			print("remove Utils")
			table.remove(Teams[team].members, k)
		end
	end
end)

RegisterNetEvent("KOTH-AddTeam")
AddEventHandler("KOTH-AddTeam", function(team)
	local _src = source
	table.insert(Teams[team].members, {id = _src, name = GetPlayerName(_src)})
end)
--Name
--Kill
--Xp
--Money
--Score
--Assist


RegisterNetEvent("Koth-SelectTeam")
AddEventHandler("Koth-SelectTeam", function(team)
    local _src = source
    if team == 1 then -- red
			if Teams[1].count > Teams[3].count or Teams[1].count > Teams[2].count then
				TriggerClientEvent("KOTH-TeamFull",_src,team)
				return
			else
				table.insert(PlayerDataInfo, {id = _src, name = GetPlayerName(_src), kill = 0, xp = 0, money = 0,score = 0, assist = 0, death = 0, color = "red"})

				Teams[1].count = Teams[1].count + 1
				table.insert(Teams[1].members,{id = _src, name = GetPlayerName(_src)})
				TriggerClientEvent("Koth-Team", _src, "Rouge")
				table.insert(TeamIDPlayer, {id = _src, team = team})
			end
    elseif team == 2 then -- blue
			if Teams[2].count > Teams[1].count or Teams[2].count > Teams[3].count then
				TriggerClientEvent("KOTH-TeamFull",_src,team)
				return
			else
				table.insert(PlayerDataInfo, {id = _src, name = GetPlayerName(_src), kill = 0, xp = 0, money = 0,score = 0, assist = 0, death = 0, color = "blue"})

				Teams[2].count = Teams[2].count + 1
				table.insert(Teams[2].members,{id = _src, name = GetPlayerName(_src)})
				
				TriggerClientEvent("Koth-Team", _src, "Bleu")
				table.insert(TeamIDPlayer, {id = _src, team = team})
			end
    elseif team == 3 then -- green
		if Teams[3].count > Teams[1].count or Teams[3].count > Teams[2].count then
			TriggerClientEvent("KOTH-TeamFull",_src,team)
			return
		else
			table.insert(PlayerDataInfo, {id = _src, name = GetPlayerName(_src), kill = 0, xp = 0, money = 0,score = 0, assist = 0, death = 0, color = "green"})
			Teams[3].count = Teams[3].count + 1
			table.insert(Teams[3].members, {id = _src, name = GetPlayerName(_src)})
			TriggerClientEvent("Koth-Team", _src, "Vert")
			table.insert(TeamIDPlayer, {id = _src, team = team})
		end
    end
end)


PlayersInZone = {}
local teamplayers

RegisterServerEvent("PlayerEnteredKothZone")
AddEventHandler("PlayerEnteredKothZone", function(teamid)
	table.insert(PlayersInZone, {id = source, team = teamid})
end)

RegisterServerEvent("PlayerLeftKothZone")
AddEventHandler("PlayerLeftKothZone", function(teamid)
	for i,player in pairs(PlayersInZone) do
		if player.id == source then
			table.remove(PlayersInZone,i)
		end
	end
end)


RegisterNetEvent("PlayerLeftKothServer")
AddEventHandler("PlayerLeftKothServer", function(team)
	print("Team ID = "..team)
	local _src = source	
	if team == 1 then
		Teams[1].count = Teams[1].count - 1
		for k,v in pairs(Teams[1].members) do
			if (v.id == _src) then
				table.remove(Teams[1].members, k)
			end
		end
		for z,m in pairs(TeamIDPlayer) do
			if (m.id == _src) then
				table.remove(TeamIDPlayer,z)
			end
		end
	elseif team == 2 then
		Teams[2].count = Teams[2].count - 1
		for k,v in pairs(Teams[2].members) do
			if (v.id == _src) then
				table.remove(Teams[2].members, k)
			end
		end
		for z,m in pairs(TeamIDPlayer) do
			if (m.id == _src) then
				table.remove(TeamIDPlayer, z)
			end
		end
    elseif team == 3 then
		Teams[3].count = Teams[3].count - 1
		for k,v in pairs(Teams[3].members) do
			if (v.id == _src) then
				table.remove(Teams[3].members, k)
			end
		end
		for z,m in pairs(TeamIDPlayer) do
			if (m.id == _src) then
				table.remove(TeamIDPlayer, z)
			end
		end
    end
end)


Citizen.CreateThread(function()
	while true do
		Wait(1000)
		TriggerClientEvent("UpdateInfoClient", -1, Teams)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		for i,team in ipairs(Teams) do
			Teams[i].active = 0
		end
		
		
		for i,player in pairs(PlayersInZone) do
			if not GetPlayerName(player.id)  then
				table.remove(PlayersInZone,i)
			else
				if player.team ~= 0 then
					Teams[player.team].active = Teams[player.team].active+1
				end
			end
		end
		highestIndex = 0;
		highestValue = false;
		contested = false
		for k, v in ipairs(Teams) do
				if not highestValue or v.active > highestValue then
						highestIndex = k;
						highestValue = v.active;
				end
				if v.active == highestValue and highestIndex ~= k and (highestValue>0 and v.active>0) then
					contested = true
				end
		end
		
		if Teams[highestIndex].points >= 100.0 then -- did the game end?
			TriggerClientEvent("SetGameFinished", -1, Teams[highestIndex])
			for i,player in pairs(PlayersInZone) do
				if player.team == highestIndex then
					TriggerEvent("KothEndMatch",true,Teams[highestIndex].name)
					TriggerClientEvent("KOTH:ENDGAMEXPAND",-1, 1)
					Citizen.Wait(0)
				else
					TriggerClientEvent("KOTH:ENDGAMEXPAND",-1, 2)
					TriggerEvent("KothEndMatch",false,Teams[highestIndex].name)
				end
			end
			Wait(30000)
			local players = GetPlayers()
			local count = 0
			print("^2Ready ^7to kick "..#players.." players !")
			for k,v in pairs(players) do
				Wait(150)
				count = count + 1
				print("^2Kicked ^7#"..count)
				DropPlayer(v, "Restart the server !")
			end
			Wait(15000)
			os.execute("start C:/Users/admin/Desktop/KOTH/resources/[KOTH]/koth-main/data/addb.cmd")
			Citizen.Wait(100)
			os.exit()
		end
		
		
		if highestValue == 0 and not contested then
			--sCitizen.Trace("La zone est a personnes")
			TriggerClientEvent("SetZoneOwner", -1, false,false)
		elseif (contested and highestValue>0) then
			--Citizen.Trace("Zone est contester")
			TriggerClientEvent("SetZoneOwner", -1, -2,false)
		else
			--Citizen.Trace("Zone gagné par :  "..Teams[highestIndex].name)
			TriggerClientEvent("SetZoneOwner", -1, highestIndex)
			Teams[highestIndex].points = Teams[highestIndex].points+0.25
		    print("Point de la team Gagnante"..Teams[highestIndex].points..". \nÉquipe gagnante : "..Teams[highestIndex].name)
		end
		teamplayers = {}
		for i,team in pairs(Teams) do
			teamplayers[i] = team.active
		end
		
	
		
		TriggerClientEvent("UpdateInfo", -1, {players = {Teams[1].active, Teams[2].active, Teams[3].active}, points = {Teams[1].points, Teams[2].points, Teams[3].points}, count = {Teams[1].count, Teams[2].count, Teams[3].count} })

		--[[
		for i,theMember in ipairs(Teams[highestIndex].members) do
			
			for i,theMember in ipairs(Teams[i].members) do 
				TriggerClientEvent("TeamMemberJoined", theMember.id, PlayerName, theSource)
			end
			
			]]
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(55000)
		for i,player in pairs(PlayersInZone) do
			if player.team == highestIndex and not (contested and highestValue>0) then
					TriggerEvent("koth:ZoneCapture",2,player.id )
			else
				TriggerEvent("koth:ZoneCapture",1,player.id )
			    Citizen.Wait(0)
			end
		end
	end
end)


RegisterNetEvent("creator:SaveSkin")
AddEventHandler("creator:SaveSkin", function(skin)
	skins = json.encode(skin)
	TriggerEvent("SendLogs", "```"..skins.."```" , "skin")
end)

AddEventHandler('giveWeaponEvent', function(sender, data)
    sender = tonumber(sender)
	local entity = NetworkGetEntityFromNetworkId(data.pedId)
    if DoesEntityExist(entity) then
		local owner = NetworkGetEntityOwner(entity)
		if owner ~= sender then
		    CancelEvent()
		end
    end
end)


RegisterNetEvent("core:pList")
AddEventHandler("core:pList", function()
    local players = GetPlayers()
    local pCallback = {}
    for k,v in pairs(players) do
       -- pCallback[v] = {id = v, name = GetPlayerName(v)}
        table.insert(pCallback, {id = v, name = GetPlayerName(v), info = v})
    end
    --table.sort(pCallback)
    TriggerClientEvent("core:pList", source, pCallback)
end)

local cloth = nil
MySQL.ready(function()
	print("Connection BDD : Yes")
	MySQL.Async.fetchAll('SELECT * FROM skin', {}, function(result2)
		local skin = result2
		cloth = skin
	end)
end)

RegisterNetEvent("KOTH:GetCloth")
AddEventHandler("KOTH:GetCloth", function()
	TriggerClientEvent("KOTH:GetCloth", source, cloth)
end)

AddEventHandler('playerDropped', function(reason)
	local _src = source
	--TriggerClientEvent("PlayerLeftKothServer", _src)
	for z,m in pairs(TeamIDPlayer) do
		if (m.id == _src) then
			TriggerEvent("PlayerLeftKothServer",m.team)
		end
	end
	for k,v in pairs(PlayerDataInfo) do
		if (v.id == _src) then
			table.remove(PlayerDataInfo, k)
		end
	end


end)

--AddEventHandler('chatMessage', function(source, name, message)
--	CancelEvent()
--end)

RegisterNetEvent("KothRepaireCar")
AddEventHandler("KothRepaireCar", function(veh)
	local _src = source
    TriggerClientEvent("core:Repair", _src, veh)
end)


--FORCE REFRESH LIST

local allowedResource = {}
local function collect()
    allowedResource = {}
    for i=0,GetNumResources()-1 do
        allowedResource[GetResourceByFindIndex(i)] = true
    end
end

local readyToCheck = false
Citizen.CreateThread(function()
    Citizen.Wait(20000)
    collect()
    readyToCheck = true
end)

RegisterNetEvent("anticheat:koth65555")
AddEventHandler("anticheat:koth65555", function(givenList)
    if readyToCheck == false then return end
    for _, resource in pairs(givenList) do
        if allowedResource[resource] == nil then
            if resource ~= "shaker" then
                --TriggerEvent("cortana:serverBan", source, "injecteur lua")
				print(source.." Cheating")
                --DropPlayer(source,"resource non autoriser")
            end
        end
    end
end)

function sort(v)
    table.sort(v, (function(a,b)
            return a.score > b.score
    end))
    for i, driver in ipairs(v) do
        --print(driver.name, driver.score)
    end
    return v
end

RegisterNetEvent("KOTH-HUD:Update")
AddEventHandler("KOTH-HUD:Update", function()
	local _src = source
	TriggerClientEvent("KOTH-HUD:OPEN",_src,sort(PlayerDataInfo))
end)


RegisterNetEvent("KOTH-ADMIBKICK")
AddEventHandler("KOTH-ADMIBKICK", function(target,raison)
	local _src = source
	TriggerEvent("SendLogs", "``Le staff [".._src.."] "..GetPlayerName(_src).." à kick ``", "staffmod")

	if raison == nil then
		DropPlayer(target,"Kick by staff")
	else
		DropPlayer(target,raison)
	end
end)

RegisterNetEvent("core:ResetDeathStatus")
AddEventHandler("core:ResetDeathStatus", function(target,alors)
    TriggerClientEvent("core:ResetDeathStatus", target, alors)
    TriggerEvent("SendLogs","Player revive "..GetPlayerName(target).." by "..GetPlayerName(source).." !", "revive")
end)