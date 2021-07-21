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

function GetIdentifierFromIdDiscord(source, identifier)
    identifier = identifier or 'discord:'
    local identifiers = GetPlayerIdentifiers(tonumber(source))

    for i = 1, #identifiers, 1 do
        if string.sub(identifiers[i], 1, string.len(identifier)) == identifier then
            return identifiers[i]
        end
    end
return false
end

RegisterNetEvent("GetUserBDD")
AddEventHandler("GetUserBDD", function()
    local _src = source
    local identifier = GetPlayerToken(_src, 0)
    local identifiers = GetIdentifierFromId(_src)

    local result = MySQL.Sync.fetchAll('SELECT * FROM player WHERE license = @identifier', {
        ['@identifier'] = identifier,
    })
    
    if result[1] == nil then
        --local identifiers = GetIdentifierFromId(_src)
        local resulte = MySQL.Sync.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
            ['@identifier'] = identifiers,
        })
        if resulte[1] == nil then
            MySQL.Async.execute('INSERT INTO player (license, money, level,license1,exp) VALUES (@identifier, @money,@level,@licencess , @exp)', {
                ['@identifier'] = identifier,
                ['@money'] = Config.Money,
                ['@level'] = Config.Level,
                ['@licencess'] = identifiers,
                ['@exp'] = Config.exp,
            })
            Wait(500)
            MySQL.Async.fetchAll('SELECT * FROM player WHERE license = @identifier', {
                ['@identifier'] = identifiers
            }, function(resulte)
                TriggerEvent("SendConnectionExtra",_src,resulte)
            end)
        else
            MySQL.Async.fetchAll('UPDATE player SET license1 = @license1s WHERE license = @identifier',{['@identifier'] = identifier,['@license1s'] = identifiers}, function(result)
            end)
            MySQL.Async.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
                ['@identifier'] = identifiers
            }, function(resulte)
                TriggerEvent("SendConnectionExtra",_src,resulte)
            end)
        end
    else
        MySQL.Async.fetchAll('UPDATE player SET license1 = @license1s WHERE license = @identifier',{['@identifier'] = identifier,['@license1s'] = identifiers}, function(result)
        end)
        MySQL.Async.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
            ['@identifier'] = identifiers
        }, function(resulte)
            TriggerEvent("SendConnectionExtra",_src,resulte)
        end)
    end
end)

RegisterNetEvent("KOTH:UpdateHUD2")
AddEventHandler("KOTH:UpdateHUD2", function(source)
    local _src = source
    local identifier = GetIdentifierFromId(_src)
    
    MySQL.Async.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
        ['@identifier'] = identifier
    }, function(resulte)
        if resulte[1] ~= nil then
            TriggerClientEvent("KOTH-MAIN:UpdatePlayerHUD",_src,resulte)
        end
    end)
end)