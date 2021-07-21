RegisterNetEvent("Koth-GetItem")
AddEventHandler("Koth-GetItem", function(token,type,id,prix,class)
    local _src = source
    if _src ~= nil then
        TriggerEvent("SendLogs", "Player "..GetPlayerName(_src).." rent "..GetHashKey(id).."","rent")
        if token == "fzeqzef5ef5z4f411zq4f4qz1fe" then
            if type == "vehicule" then
                TriggerClientEvent("koth-main:createcar",_src,token,id)
            else 
                local hash = GetHashKey(id)
                local name = id
                if class == "primary" then
                    TriggerClientEvent("ReturnClientWeapon",_src,hash,class,{primary = name })
                elseif class == "secondary" then
                    TriggerClientEvent("ReturnClientWeapon",_src,hash,class,{secondary = name})
                elseif class == "throwable" then
                    TriggerClientEvent("ReturnClientWeapon",_src,hash,class,{throwable = name})
                end
            end
        end
    end
end)

RegisterNetEvent("Koth-Refreh")
AddEventHandler("Koth-Refreh", function() 
    TriggerClientEvent("Koth-Refreh",source,_type,_items)
 end)


 function GetIdentifierFromId(source, identifier)
    identifier = identifier or 'license:'
    local identifiers = GetPlayerIdentifiers(tonumber(source))

    for i = 1, #identifiers, 1 do
        if string.sub(identifiers[i], 1, string.len(identifier)) == identifier then
            return identifiers[i]
        end
    end
return false
end
 
RegisterNetEvent("Koth-RefrehOwned")
AddEventHandler("Koth-RefrehOwned", function()
    local _src = source
    local identifier = GetIdentifierFromId(_src)
    MySQL.Async.fetchAll('SELECT * FROM owned_weapons WHERE license = @identifier', {
        ['@identifier'] = identifier
    }, function(resulte)
        TriggerClientEvent("Koth-RefrehOwned",_src,resulte)
    end)
end)

RegisterNetEvent("Koth-RemoveMoney")
AddEventHandler("Koth-RemoveMoney", function(prix) 
    local _src = source
    local money = 0
    if prix ~= "free" then
        local identifier = GetIdentifierFromId(_src)
        MySQL.Async.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
            ['@identifier'] = identifier
        }, function(resulte)
            for k,v in pairs(resulte) do
                local z = v.money
                money = z
                MySQL.Async.fetchAll('UPDATE player SET money = @money WHERE license1 = @identifier',{['@identifier'] = identifier,['@money'] = money -prix}, function(result)
                end)
            end
        end)
    end
end)

 
RegisterNetEvent("Koth-GetLevel")
AddEventHandler("Koth-GetLevel", function()
    local _src = source
    local identifier = GetIdentifierFromId(_src)
    MySQL.Async.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
        ['@identifier'] = identifier
    }, function(resulte)
        TriggerClientEvent("Koth-GetLevel",_src,resulte)
    end)
end)

Whitl = {
    [GetHashKey("scorcher")] = true,
    [GetHashKey("rancherxl")] = true,
    [GetHashKey("rebel")] = true,
    [GetHashKey("blazer")] = true,
    [GetHashKey("sanchez2")] = true,
    [GetHashKey("dune")] = true,
    [GetHashKey("crusader")] = true,
    [GetHashKey("m939")] = true,
    [GetHashKey("policet")] = true,
    [GetHashKey("rumpo3")] = true,
    [GetHashKey("wastelander")] = true,
    [GetHashKey("fbi2")] = true,
    [GetHashKey("guardian")] = true,
    [GetHashKey("dune3")] = true,
    [GetHashKey("bf400")] = true,
    [GetHashKey("technical3")] = true,
    [GetHashKey("gurkha")] = true,
    [GetHashKey("baller5")] = true,
    [GetHashKey("xls2")] = true,
    [GetHashKey("cog552")] = true,
    [GetHashKey("schafter5")] = true,
    [GetHashKey("unarm")] = true,
    [GetHashKey("barrage")] = true,
    [GetHashKey("stryker")] = true,
    [GetHashKey("insurgent3")] = true,
    [GetHashKey("insurgent")] = true,
    [GetHashKey("insurgent2")] = true,
    [GetHashKey("dukes2")] = true,
    [GetHashKey("scarab")] = true,
    [GetHashKey("rhino")] = true,
    [GetHashKey("buzzard2")] = true,
    [GetHashKey("haitun")] = true,
    [GetHashKey("annihilator")] = true,
    [GetHashKey("mhx")] = true,
    [GetHashKey("buzzard")] = true,
    [GetHashKey("cargobob")] = true,
    [GetHashKey("nh90")] = true,
    [GetHashKey("pavehawk")] = true,
    [GetHashKey("valkyrie2")] = true,
    [GetHashKey("pavelow")] = true,
    [GetHashKey("hunter")] = true, 
    [GetHashKey("osprey")] = true,
    [GetHashKey("ahx")] = true,
    [GetHashKey("ah1z")] = true,
    [GetHashKey("oppressor")] = true,
    [GetHashKey("oppressor1")] = true,
    [GetHashKey("oppressor2")] = true,
    [GetHashKey("cuban800")] = true,
    [GetHashKey("vigilante")] = true,
    [GetHashKey("Vagner")] = true,
    [GetHashKey("Voltic2")] = true,
    [GetHashKey("akula")] = true,
    [GetHashKey("brabus500")] = true,
    [GetHashKey("rcbandito")] = true,
    [GetHashKey("strikeforce")] = true,
    [GetHashKey("s_m_y_pilot_01")] = true

}


AddEventHandler("entityCreating", function(entity)
    if DoesEntityExist(entity) then
        if not Whitl[GetEntityModel(entity)] then
            CancelEvent()
        end
    end
end)
