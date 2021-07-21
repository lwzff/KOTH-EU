local img = "https://cdn.discordapp.com/attachments/807265225719808040/813506607828172860/Original_Logo.png"

local webhooks = {
    ["connection"] = {w = "X"},
    ["cheat"] = {w = "X"},
    ["connexion-extra"] = {w = "X"},
    ["staff"] = {w = "X"},
    ["money"] = {w = ""},
    ["skin"] = {w =  ""},
    ["ban"] = {w = ""},
    ["ban-cheat"] = {w = ""},
    ["unban"] = {w = ""},
    ["owned"] = {w = ""},
    ["revive"] = {w = ""},
    ["ON"] = {w = ""},
    ["Kill"] = {w = ""},
    ["staffmod"] = {w = ""},
    ["rent"] = {w = ""},
}

function SendLog(msg, type)
    local webhook = webhooks[type].w

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = type, content = msg, avatar_url = img, tts = false}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("SendLogs")
AddEventHandler("SendLogs", function(msg,type)
    SendLog(msg, type)
end)

RegisterNetEvent("SendConnectionExtra")
AddEventHandler("SendConnectionExtra", function(source,info)
    local _src = source
    webhook = webhooks["connexion-extra"].w
    local discord = GetIdentifierFromIdDiscord(_src)
    local token = GetPlayerToken(_src, 0)
    local test = GetNumPlayerTokens(_src)
    local licences = GetIdentifierFromId(_src)
    TriggerClientEvent("SendUtis",_src,info)

    if not discord then
        for k,v in pairs(info) do
            msg = '**__Id Boutique__** : '..v.id..'\n\n**__Nom__** : ' ..GetPlayerName(_src).. '\n\n**__License__** : '..licences..'\n\n**__Token Player__** : '..token..'\n\n**__Token Player 2__** : '..test..'\n\n**__ID__** : '.._src..'\n\n**__IP__** : ' ..GetPlayerEndpoint(_src).. '\n\n**__Ping__** : ' ..GetPlayerPing(_src)..'\n\n**__Discord__** :null\n\n**__DiscordID__** : null\n\n**__Money__** : ' ..v.money..'\n\n**__Level__** : ' ..v.level..''
        end
    else
        for k,v in pairs(info) do
            msg = '**__Id Boutique__** : '..v.id..'\n\n**__Nom__** : ' ..GetPlayerName(_src).. '\n\n**__License__** : '..licences..'\n\n**__Token Player__** : '..token..'\n\n**__Token Player 2__** : '..test..'\n\n**__ID__** : '.._src..'\n\n**__IP__** : ' ..GetPlayerEndpoint(_src).. '\n\n**__Ping__** : ' ..GetPlayerPing(_src)..'\n\n**__Discord__** : <@' ..discord:gsub("discord:", "")..'>\n\n**__DiscordID__** : '..discord:gsub("discord:", "")..'\n\n**__Money__** : ' ..v.money..'\n\n**__Level__** : ' ..v.level..''
        end
    end


    local content = {
        {
        	["color"] = '16711680', --rosso
            ["title"] = "Kylian Connection extra",
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "© Kylian#9977 - "..os.date("%x %X %p")
                
            }, 
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Kylian", embeds = content}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent("SendLogsBanCheat")
AddEventHandler("SendLogsBanCheat", function(msg)
    webhook = webhooks["ban-cheat"].w
    local id = source
    local banid = math.random(1,999)
    local content = {
        {
            ["color"] = '14177041',
            ["title"] = "**DETECTION ["..id.."] ".. GetPlayerName(id) .."** BAN-ID: "..banid,
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "Ban AC",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Ban", embeds = content}), { ['Content-Type'] = 'application/json' })
    TriggerEvent("Kylian::0909::BanSql:ICheatClient",id, ""..banid.." : Cheat.")
end)


RegisterNetEvent("SendLogsBan")
AddEventHandler("SendLogsBan", function(target,name,banid,msg)
    webhook = webhooks["ban"].w
    local id = target
    local content = {
        {
            ["color"] = '14177041',
            ["title"] = "**Ban ["..id.."] ".. name .."** BAN-ID: "..banid,
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "Ban",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Ban", embeds = content}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent("SendLogsUnban")
AddEventHandler("SendLogsUnban", function(msg)
    webhook = webhooks["unban"].w
    local id = target
    local content = {
        {
            ["color"] = '14177041',
            ["title"] = "**UNBAN**",
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "UNBAN",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Unban", embeds = content}), { ['Content-Type'] = 'application/json' })
end)
