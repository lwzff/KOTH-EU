ZoneData = {}
--VoteInfo = {}
Action = false
local timer = 8
Citizen.CreateThread(function()
    ZoneData = GetZones()
    --VoteInfo = GetVote()
    InitZone()
    --while (timer ~= 0) do
    --    Wait(500)
    --    InitZone()
--
    --    timer = timer - 1
    --end
end)

function InitZone()
    print("Init Zone")
    Zone = Config
    GetZone = Zone[math.random(1, #Config)]
    if GetZone.name == ZoneData.name then
        print("Change Zone")
        InitZone()
    elseif GetZone.name ~= ZoneData.name then
        print("Name Server "..GetZone.name)
        Action = true
    end

    --if VoteInfo.map ~= nil then
    --    if GetZone.name ~= VoteInfo.map then
    --        print("The generate zone does not correspond to the vote")
    --        InitZone()
    --    elseif GetZone.name == VoteInfo.map then
    --        print("Name Server "..GetZone.name)
    --        StartResource("koth-"..GetZone.name)
    --        Action = true
    --    end
    --end
end

function GetZones()
	local data = LoadResourceFile('koth-main', 'data/Info.json')
	return data and json.decode(data)
end

--function GetVote()
--	local data = LoadResourceFile('koth-main', 'data/voteinfo.json')
--	return data and json.decode(data)
--end

RegisterCommand("testf",function(source)
    if source == 0 then
        Zone = Config
        GetZone = Zone[math.random(1, #Zone)]
        print("Name Server "..GetZone.name)
    end
end, true)


RegisterNetEvent("MapPositon")
AddEventHandler("MapPositon", function()
    local _src = source
    TriggerClientEvent("MapPosition",_src, GetZone)   
end)