local function getLicense(source)
    local license = nil
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    return license
end

local function canUse(source)
    local license = getLicense(source)
    if license == nil then return end
    return Admin.Whitlist[license] ~= nil
end

local function getRank(source)
    local license = getLicense(source)
    if license == nil then return end
    return Admin.Whitlist[license], license
end

RegisterNetEvent("KOTH-CanUse")
AddEventHandler("KOTH-CanUse", function()
    local _src = source
    local state,license = canUse(_src)
    local rank = -1
    if state then rank = getRank(_src) end
    TriggerClientEvent("KOTH-CanUse", _src, state, rank, license)
end)


local stafffmod = {}
RegisterNetEvent("stafflog")
AddEventHandler("stafflog", function(staffmod)
    if staffmod then
        TriggerEvent("SendLogs","``Le staff ["..source.."] "..GetPlayerName(source).." à activer son menu staff``", "staffmod")
        stafffmod[source] = {time = os.time()}
    else
        local min, sec = GetTime(os.difftime(os.time(), stafffmod[source].time))
        TriggerEvent("SendLogs", "``Le staff ["..source.."] "..GetPlayerName(source).." à désactiver son menu staff après "..min.."m et "..sec.."s en staffmod``", "staffmod")
        stafffmod[source] = nil
    end
end)

function GetTime(time)
    local time = time
    local min = 0
    while time > 60 do
        time = time - 60
        min = min + 1
    end
    return min, time
end

RegisterNetEvent("koth-b:bring")
AddEventHandler("koth-b:bring", function(id,pos)
    TriggerClientEvent("koth-b:bring", id, pos)
end)


RegisterNetEvent("Koth:GotoPlayer")
AddEventHandler("Koth:GotoPlayer", function(id)
    local coords = GetEntityCoords(GetPlayerPed(id))
    TriggerClientEvent("koth:goto", source, coords)
end)