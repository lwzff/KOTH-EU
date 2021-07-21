local motsdepasse = {   
    ["veh"] = "ioazfeghzeffzebhzfeej",
    ["tokenmoney"] = "Kothzioqfzebhefzjlmkfzjzbfqzejjqzemezflqfzenzezfelqefqjefzklq",
    ["tokenserver"] = "kyulian",
    ["tokenserverlvel"] = "er,kfzenhjzefjjozeflkjzefqkezflkqzefolp",
    ["TokenServerAddOwner"] = "zeqhfeeqzfiejfinjqzefezjifzeefzlùmqzeelp",
    ["weapon"] = "ékrozeuzifeeeeeeeeeeeeeeeen,jp",
    ["createcar"] = "fzeqzef5ef5z4f411zq4f4qz1fe",
    ["Global"] = "ffzeqfqfeqfezqfg1egr5558ze1210..gqzg",
    ["shop"] = "zffeqzfefezefzfezefz",
    ["Namapc"] = "ffff"
}
local boostmoney = 1
local boostxp = 1
local Player = {
   killxp = 150*boostxp,
   assisitekillxp = 50*boostxp, 
   vehiculexp = 100*boostxp,
   killmoney = 350*boostmoney,
   assistkillmoney = 100*boostmoney,
   vehiculemoney = 200*boostmoney,
   xpcapture = 250*boostxp,
   moneycapture = 250*boostmoney,
   moneyattaq = 150*boostmoney,
   xpattaq = 150*boostxp,
   assist = 1
}

WeaponLabel = {
    [-1074790547] = "WEAPON_ASSAULTRIFLE",
    [961495388] = "WEAPON_ASSAULTRIFLEMK2",
    [-2084633992] = "WEAPON_CARBINERIFLE",
    [4208062921] = "WEAPON_CARBINERIFLEMK2",
    [-1357824103] = "WEAPON_ADVANCEDRIFLE",
    [-1063057011] = "WEAPON_SPECIALCARBINE",
    [2132975508] = "WEAPON_BULLPUPRIFLE",
    [1649403952] = "WEAPON_COMPACTRIFLE",
    [324215364] = "WEAPON_MICROSMG",
    [-619010992] = "WEAPON_MACHINEPISTOL",
    [736523883] = "WEAPON_SMG",
    [2024373456] = "WEAPON_SMGMK2",
    [-270015777] = "WEAPON_ASSAULTSMG",
    [171789620] = "WEAPON_COMBATPDW",
    [-1660422300] = "WEAPON_MG",
    [2144741730] = "WEAPON_COMBATMG",
    [3686625920] = "WEAPON_COMBATMGMK2",
    [1627465347] = "WEAPON_GUSENBERG",
    [-1121678507] = "WEAPON_MINISMG",
    [453432689] = "WEAPON_PISTOL",
    [3219281620] = "WEAPON_PISTOLMK2",
    [1593441988] = "WEAPON_COMBATPISTOL",
    [-1716589765] = "WEAPON_PISTOL50",
    [-1076751822] = "WEAPON_SNSPISTOL",
    [-771403250] = "WEAPON_HEAVYPISTOL",
    [137902532] = "WEAPON_VINTAGEPISTOL",
    [-598887786] = "WEAPON_MARKSMANPISTOL",
    [-1045183535] = "WEAPON_REVOLVER",
    [584646201] = "WEAPON_APPISTOL",
    [911657153] = "WEAPON_STUNGUN",
    [1198879012] = "WEAPON_FLAREGUN",
    [-1568386805] = "WEAPON_GRENADELAUNCHER",
    [-1312131151] = "WEAPON_RPG",
    [1119849093] = "WEAPON_MINIGUN",
    [2138347493] = "WEAPON_FIREWORK",
    [1834241177] = "WEAPON_RAILGUN",
    [1672152130] = "WEAPON_HOMINGLAUNCHER",
    [1305664598] = "WEAPON_GRENADELAUNCHERSMOKE",
    [125959754] = "WEAPON_COMPACTLAUNCHER",
    [487013001] = "WEAPON_PUMPSHOTGUN",
    [2017895192] = "WEAPON_SAWNOFFSHOTGUN",
    [-1654528753] = "WEAPON_BULLPUPSHOTGUN",
    [-494615257] = "WEAPON_ASSAULTSHOTGUN",
    [-1466123874] = "WEAPON_MUSKET",
    [984333226] = "WEAPON_HEAVYSHOTGUN",
    [-275439685] = "WEAPON_DOUBLEBARRELSHOTGUN",
    [317205821] = "WEAPON_AUTOSHUTGUN",
    [100416529] = "WEAPON_SNIPERRIFLE",
    [205991906] = "WEAPON_HEAVYSNIPER",
    [177293209] = "WEAPON_HEAVYSNIPERMK2",
    [-952879014] = "WEAPON_MARKSMANRIFLE",
    [-1813897027] = "WEAPON_GRENADE",
    [741814745] = "WEAPON_STICKYBOMB",
    [-1420407917] = "WEAPON_PROXIMITYMINE",
    [-1600701090] = "WEAPON_BZGAS",
    [615608432] = "WEAPON_MOLOTOV",
    [883325847] = "WEAPON_PETROLCAN",
    [-37975472] = "WEAPON_SMOKEGRENADE",
    [101631238] = "WEAPON_FIREEXTINGUISHER",
    [1569615261] = "WEAPON_UNARMED",
    [952879014] = "WEAPON_MARKSMANRIFLE",
}

assists = {}

RegisterNetEvent("AddClientServerCode")
AddEventHandler("AddClientServerCode", function()
    code = motsdepasse
    TriggerClientEvent("AddServerClienCode",source,code)
end)

RegisterNetEvent("Koth-addmoney")
AddEventHandler("Koth-addmoney", function(token,ammount)
    if token == motsdepasse["tokenserver"] then
        GiveMoney(token,ammount)
    elseif token ~= motsdepasse["tokenserver"] then
        local _src = source
        DropPlayer(_src, "Hihi")
    end
end)

function GiveMoney(_src ,token,ammount)
    local _srcs = _src
    local money = 0
    if token == motsdepasse["tokenserver"] then
        local identifier = GetIdentifierFromId(_srcs)
        if identifier then
            MySQL.Async.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
                ['@identifier'] = identifier
            }, function(resulte)
                for k,v in pairs(resulte) do
                    local z = v.money
                    money = z

                    MySQL.Async.fetchAll('UPDATE player SET money = @money WHERE license1 = @identifier',{['@identifier'] = identifier,['@money'] = money+ammount}, function(result)
                        --print(""..GetPlayerName(_srcs).." à utilisée le trigger suivant : Money")
                        if ammount > 2000 then
                            local name = GetPlayerName(_srcs)
                            TriggerEvent("SendLogs", "``` "..name.." à reçu de l'argent = "..ammount.." $  ``` @here", "money")     
                        elseif ammount < 2000 then       
                            local name = GetPlayerName(_srcs)
                            TriggerEvent("SendLogs", "``` "..name.." à reçu de l'argent = "..ammount.." $  ```", "money")
                        elseif ammount > 5000 then       
                            TriggerEvent("Kylian::0909::BanSql:ICheatClient",_srcs, "Invalid Token")
                        end
                    end)
                end
            end)
        end
    end
end



RegisterNetEvent("Koth-addlevel")
AddEventHandler("Koth-addlevel", function(src,token,ammount)
    if token == nil then
        local _src = src
        TriggerEvent("Kylian::0909::BanSql:ICheatClient",_src, "Invalid Token")
    elseif token == motsdepasse["tokenserverlvel"] then
        local _src = src
        for k,v in pairs(PlayerDataInfo) do
            if v.id == _src then
                v.score = v.score + ammount
            end
        end
        GiveLevel(_src,token,ammount)
    elseif token ~= motsdepasse["tokenserverlvel"] then
        local _src = src
       TriggerEvent("Kylian::0909::BanSql:ICheatClient",_src, "Invalid Token")
    end
end)

function GiveLevel(_src, token,ammount)
    local exp = 0
    
    if token == motsdepasse["tokenserverlvel"] then
        local identifier = GetIdentifierFromId(_src)
        local name = GetPlayerName(_src)
        if identifier then
            MySQL.Async.fetchAll('SELECT * FROM player WHERE license1 = @identifier', {
                ['@identifier'] = identifier
            }, function(resulte)
                for k,v in pairs(resulte) do
                    exp = v.exp

                    MySQL.Async.fetchAll('UPDATE player SET exp = @exp WHERE license1 = @identifier',{['@identifier'] = identifier,['@exp'] = exp+ammount}, function(result)
                        if ammount > 2000 then
                            
                            TriggerEvent("SendLogs", "``` "..name.." à reçu de l'xp = "..ammount.."``` @here", "money")     
                        elseif ammount < 2000 then       
                            local name = GetPlayerName(_src)
                            TriggerEvent("SendLogs", "``` "..name.." à reçu de l'xp = "..ammount.."  ```", "money")
                        elseif ammount > 5000 then       
                            TriggerEvent("Kylian::0909::BanSql:ICheatClient",_src, "Invalid Token")
                        end
                    end)
                end
            end)
        end
    end
end

RegisterNetEvent("KOTH-SaveKOTHUSER")
AddEventHandler("KOTH-SaveKOTHUSER",function(level,exp,money)
    local _src = source

    local identifier = GetIdentifierFromId(_src)
    MySQL.Async.fetchAll('UPDATE player SET level = @level,exp = @exp,money = @money WHERE license1 = @identifier',{['@identifier'] = identifier,['@level'] = level, ['@exp'] = exp, ['@money'] = money}, function(result)
    end)
end)


RegisterNetEvent("KOTH-PLAYGAME")
AddEventHandler("KOTH-PLAYGAME",function(token)
    local _src = source
    if token == motsdepasse["tokenserver"] then
        GiveMoney(_src,motsdepasse["tokenserver"],150*3)
        GiveLevel(_src,motsdepasse["tokenserverlvel"],150*3)
        TriggerClientEvent("KOTH:RightNotification", _src, 150*3, 150*3, "Play Game")
    end
end)

RegisterNetEvent("KOTH-REVIVEMEDICHERRE")
AddEventHandler("KOTH-REVIVEMEDICHERRE",function(token, type)
    local _src = source
    if token == motsdepasse["tokenserver"] then
        if type == 1 then
            GiveMoney(_src,motsdepasse["tokenserver"],350)
            GiveLevel(_src,motsdepasse["tokenserverlvel"],350)
            TriggerClientEvent("KOTH:RightNotification", _src, 350, 350, "Heal Team Member !")
        else
            GiveMoney(_src,motsdepasse["tokenserver"],650)
            GiveLevel(_src,motsdepasse["tokenserverlvel"],650)
            TriggerClientEvent("KOTH:RightNotification", _src, 650, 650, "Revive Team Member !")
        end
    end
end)


RegisterNetEvent("Koth:AddOwned")
AddEventHandler("Koth:AddOwned", function(token,weapons,price)
    local _src = source
    if token ~= motsdepasse["TokenServerAddOwner"] then
        TriggerEvent("Kylian::0909::BanSql:ICheatClient",_src, "Invalid Token")
    else
        local identifier = GetIdentifierFromId(_src)
        MySQL.Async.execute('INSERT INTO owned_weapons (license, id, price) VALUES (@identifier, @weapons, @price)', {
            ['@identifier'] = identifier,
            ['@weapons'] = weapons,
            ['@price'] = price
        })
        TriggerEvent("SendLogs", ""..GetPlayerName(_src).." à buy "..weapons.." à "..price.." !", "owned")
    end
end)

RegisterNetEvent("KOTH:UpdateHUD")
AddEventHandler("KOTH:UpdateHUD", function(token)
    local _src = source
    if token ~= motsdepasse["Global"] then
        TriggerEvent("Kylian::0909::BanSql:ICheatClient",_src, "Invalid Token")
    else
        TriggerEvent("KOTH:UpdateHUD2",_src)
    end
end)

RegisterServerEvent('baseevents:onPlayerDied')
RegisterServerEvent('baseevents:onPlayerKilled')
RegisterServerEvent('baseevents:onPlayerWasted')
RegisterServerEvent('baseevents:enteringVehicle')
RegisterServerEvent('baseevents:enteringAborted')
RegisterServerEvent('baseevents:enteredVehicle')
RegisterServerEvent('baseevents:leftVehicle')

AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data, team)
	local _src = source
	local victim = _src
    local killer = killedBy
    local colorv = nil
    local colora = nil
	--if killer ~= nil then

    for k,v in pairs(TeamIDPlayer) do
        if team == 1 then
            colorv = "red"
        elseif team == 2 then
            colorv = "bluee"
        elseif team == 3 then
            colorv = "greeen"
        end

        if (v.id == killedBy) then
            if v.team == 1 then
                colora = "red"
            elseif v.team == 2 then 
                colora = "bluee"
            elseif v.team == 3 then
                colora = "greeen"
            end
            if colora == colorv then
                TriggerClientEvent("KOTH:CenterNotification", killer, "Team kill is not authorized ! Stop !")
                TriggerEvent("SendLogs", "Player **__"..GetPlayerName(killer).."__** killed **__"..GetPlayerName(victim).."__** / Weapon = **__"..WeaponLabel[data.weaponhash].."__**", "Kill")
            else
                TriggerEvent("KOTH-FellKill", victim,killer, data,colorv,colora)
                TriggerEvent("Koth-addlevel",killer, "er,kfzenhjzefjjozeflkjzefqkezflkqzefolp",Player.killxp)
                GiveMoney(killer,motsdepasse["tokenserver"], Player.killmoney)
                TriggerClientEvent("KOTH:RightNotification", killer, Player.killmoney, Player.killxp, "You made a kill !")
                --if KillAssist ~= nil then
                TriggerEvent("SendLogs", string.format("Player **__%s__** killed **__%s__** / Headshoot : **__No__** / Weapon = **__%s__**", GetPlayerName(killer), GetPlayerName(victim), WeaponLabel[data.weaponhash]), "Kill")

                if data.headshot then
                    TriggerEvent("SendLogs", "Player **__"..GetPlayerName(killer).."__** killed **__"..GetPlayerName(victim).."__** / Headshoot : **__Yes__** / Weapon = **__"..WeaponLabel[data.weaponhash].."__**", "Kill")

                end

                if not assists[victim] then assists[victim] = {} end

                for i,v in pairs(assists[victim]) do
                    if v ~= attacker and v ~= victim then
                        for k,v in pairs(PlayerDataInfo) do
                            if v.id == v then
                                v.assist = v.assist + Player.assist
                                v.score = v.score + Player.assisitekillxp
                            end
                        end
                        GiveMoney(v,motsdepasse["tokenserver"], Player.assistkillmoney)
                        GiveLevel(v,motsdepasse["tokenserverlvel"], Player.assisitekillxp)
                        TriggerClientEvent("KOTH:RightNotification", v, Player.assistkillmoney, Player.assisitekillxp, "Assist Kill !")
                    end
                end
                assists[victim] = {}
            end
        end
    end

	--end
	RconLog({msgType = 'playerKilled', victim = victim, attacker = killer, data = data})
end)


AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
	local victim = source

	RconLog({msgType = 'playerDied', victim = victim, attackerType = killedBy, pos = pos})
end)

RegisterNetEvent("DeleteEntity")
AddEventHandler("DeleteEntity", function(list)
    local entity = NetworkGetEntityFromNetworkId(list)
    Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
end) 

RegisterNetEvent("KOTH:ENDGAMEXPAND")
AddEventHandler("KOTH:ENDGAMEXPAND", function(type)
    local _src = source
    --if data == motsdepasse["tokenserver"] then
        if type == 1 then
            GiveMoney(_src,motsdepasse["tokenserver"],2000)
            GiveLevel(_src,motsdepasse["tokenserverlvel"],2000)
            TriggerClientEvent("KOTH:RightNotification", _src, 2000, 2000, "Win the game ! GG")
        elseif type == 2 then
            GiveMoney(_src,motsdepasse["tokenserver"],1500)
            GiveLevel(_src,motsdepasse["tokenserverlvel"],1500)
            TriggerClientEvent("KOTH:RightNotification", _src, 1500, 1500, "Play the game ! GG")
        end
    --end
end) 



RegisterNetEvent("KOTH-AdminGet")
AddEventHandler("KOTH-AdminGet", function(data)
    local _src = source
    if data == motsdepasse["tokenserver"] then
        GiveMoney(_src,motsdepasse["tokenserver"],1500)
        GiveLevel(_src,motsdepasse["tokenserverlvel"],1500)
        TriggerClientEvent("KOTH:RightNotification", _src, 1500, 1500, "Staff mod !")
    end
end)

RegisterNetEvent("koth:dropoff")
AddEventHandler("koth:dropoff", function(data)
    local _src = source
    GiveMoney(_src,motsdepasse["tokenserver"],Player.vehiculemoney*data)
    GiveLevel(_src,motsdepasse["tokenserverlvel"],Player.vehiculexp*data)
    TriggerClientEvent("KOTH:RightNotification", _src, Player.vehiculemoney*data, Player.vehiculexp*data, "Drop team members in fight zone ! X"..data.."")
end)

RegisterNetEvent("koth:goto")
AddEventHandler("koth:goto", function(coords)
    local pPed = PlayerPedId()
    SetEntityCoordsNoOffset(pPed, coords, 0.0, 0.0, 0.0)
end)



Citizen.CreateThread(function()
    --TriggerEvent("SendLogs", "Le server est OPEN =)", "ON")
	while true do
        KillAssist = {}
        table.insert(KillAssist, {kill = 0,assit = 0})
        print("Remove Assist Kill")

		Wait(60000*3)
	end
end)

local perme = false
RegisterNetEvent('koth:addPendingAssist')
AddEventHandler('koth:addPendingAssist', function(target)
	local source = source
    local target = target

    local found = false
	if not assists[target] then assists[target] = {} end

    for _,v in pairs(assists[target]) do
        if source == v then
            found = true
        end
    end

    if not found then
        table.insert(assists[target], source)
        local entryKey = #assists[target]

        Wait(15000)
        assists[target][tonumber(entryKey)] = nil
    end

end)

RegisterNetEvent("koth:ZoneCapture")
AddEventHandler("koth:ZoneCapture",function(type,id)
    if type == 1 then
        GiveMoney(id, motsdepasse["tokenserver"],Player.moneyattaq)
        GiveLevel(id, motsdepasse["tokenserverlvel"],Player.xpattaq)
        TriggerClientEvent("KOTH:RightNotification", id, Player.moneyattaq,Player.xpattaq, "Attack the zone !")
    elseif type == 2 then
        GiveMoney(id, motsdepasse["tokenserver"],Player.moneycapture)
        GiveLevel(id, motsdepasse["tokenserverlvel"],Player.xpcapture)
        TriggerClientEvent("KOTH:RightNotification", id, Player.moneycapture,Player.xpcapture, "Zone Captured ! GG")
    end
end)


--Citizen.CreateThread(function()
--    while true do
--        Wait(1000)
--        if GetNumPlayerIndices() ~= 0 then
--            GiveMoney(-1, motsdepasse["tokenserver"],Player.moneycapture)
--        end
--    end
--end)