Locale = {
	banlistloaded = "La BanList a été chargé avec succès.",
	reason = "Reason",
	noreason = "Reason Undetermined",
	during = "while",
	isban = "was banned",
	isunban = "was disbanded",
	invalidid = "ID incorrect",
	invalididentifier = "Unable to identify you, please reopen FiveM.",
	invalidtime = "Incorrect ban duration",
	yourban = "You have been banned",
	youban = "You banned",
	permban = "permanent",
	timeleft = "Remaining time",
	day = "Day",
	hour = "Hours",
	minute = "Minutes",
	by = "by",
	ban = "Ban a player who is online",
	banoff = "Ban a player who is offline",
	timehelp = "Duration (hours)",
	licenseid = "LicenseID"
}

local AllowedName = {
	"Nampac_",
	"Kylian Loze",
	" Dmz ",
	"Dmz ",
	"Dmz  ",
	"eZ Dmz	",
	"eZ Dmz",
	"Nampac_"
}


ConfigDiscord = {
	DiscordToken = "ODE2Nzk4NTY4MjQ0NzA3MzI5.YEAM8g.wTDfI7pjmUNeJnRZ3YP2bFP6kgs",
	GuildId = "807001512303525978",

	-- Format: ["Role Nickname"] = "Role ID" You can get role id by doing \@RoleName
	Roles = {
		["Beta Testers"] = "811297560546377778" -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
	}
}

roles = { -- Role nickname(s) needed to pass the whitelist
    "Beta Testers",
}

local FormattedToken = "Bot "..ConfigDiscord.DiscordToken

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetRoles(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(ConfigDiscord.GuildId, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		else
			print("Une erreur s'est produite, peut être que la personne n'est pas sur le discord? Erreur: "..member.data)
			return false
		end
	else
		print("identifiant manquant")
		return false
	end
end

function IsRolePresent(user, role)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	local theRole = nil
	if type(role) == "number" then
		theRole = tostring(role)
	else
		theRole = ConfigDiscord.Roles[role]
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(ConfigDiscord.GuildId, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			for i=1, #roles do
				if roles[i] == theRole then
					print("Rôle trouvé")
					return true
				end
			end
			print("Le rôle n'est pas dispo")
			return false
		else
			print("Une erreur s'est produite, peut être que la personne n'est pas sur le discord? Erreur: "..member.data)
			return false
		end
	else
		print("identifiant manquant")
		return false
	end
end

Citizen.CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/"..ConfigDiscord.GuildId, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		print("Permisition : "..data.name.." ("..data.id..")")
	else
		print("Une erreur s'est produite, peut être que la personne n'est pas sur le discord? Erreur: "..(guild.data or guild.code)) 
	end
end)



notWhitelisted = "You are not Authorized to join server. Please join discord.gg/atlantiss-koth ." -- Message displayed when they are not whitelist with the role


AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	local _source = source
	local licenseid, playerip,token = 'N/A', 'N/A','N/A'
	local name = playerName
	licenseid = GetIdentifierFromId(_source)
	playerip = GetPlayerEndpoint(_source)
    token = GetPlayerToken(_source, 0)

	if not licenseid then
		setKickReason(Locale.invalididentifier)
		CancelEvent()
	end

    if not token then
		setKickReason(Locale.invalididentifier)
		CancelEvent()
	end

	deferrals.defer()
	Citizen.Wait(0)
	deferrals.update(('Verification of %s In progress ...'):format(playerName))
	Citizen.Wait(0)

    IsBanned(licenseid, function(isBanned, banData)
		if isBanned then
			if tonumber(banData.permanent) == 1 then
				deferrals.done(('You are banned from Atlantiss KOTH\nReason : %s\nRemaining time : Permanent\nAuthor : %s'):format(banData.reason, banData.sourceName))
			else
				if tonumber(banData.expiration) > os.time() then
					local timeRemaining = tonumber(banData.expiration) - os.time()
					deferrals.done(('You are banned from Atlantiss KOTH\nRaison : %s\nTemps Restant : %s\nAuthor : %s'):format(banData.reason, SexyTime(timeRemaining), banData.sourceName))
				else
					DeleteBan(licenseid)
					deferrals.done()
				end
			end
		else
			--if Action then
				deferrals.done()
			--else
			--	deferrals.done("KOTH-Map loading...")
			--end
			--if playerName == "Nampac" or playerName == "Kylian." or playerName == "eZ Dmz" or playerName == "Nicolas" or playerName == "MEGA" or playerName == "Santiano Ruiz" or playerName == "🏴 eZ Jax 🏴" or playerName == "Elliot Morris" or playerName == "f" or playerName == "M&M's" then
				
			--else
				--for k, v in ipairs(GetPlayerIdentifiers(_source)) do
				--	if string.sub(v, 1, string.len("discord:")) == "discord:" then
				--		identifierDiscord = v
				--	end
				--end
				--if identifierDiscord then
				--	for i = 1, #roles do
				--		if IsRolePresent(_source, roles[i]) then
				--			deferrals.done()
				--		else
				--			deferrals.done(notWhitelisted)
				--		end
				--	end
				--else
			--deferrals.done(notWhitelisted)
			--	--end
			--end
		end
	end)
end)


function SexyTime(seconds)
	local days = seconds / 86400
	local hours = (days - math.floor(days)) * 24
	local minutes = (hours - math.floor(hours)) * 60
	seconds = (minutes - math.floor(minutes)) * 60
	return ('%s day %s hours %s minutes %s seconds'):format(math.floor(days), math.floor(hours), math.floor(minutes), math.floor(seconds))
end

function SendMessage(source, message)
	if source ~= 0 then
		TriggerClientEvent('chat:addMessage', source, { args = {'^1BanInfo ', message} })
	else
		print(('SqlBan: %s'):format(message))
	end
end

function AddBan(source, licenseid,token, playerip, targetName, sourceName, time, reason, permanent)
	time = time * 3600
	local timeat = os.time()
	local expiration = time + timeat

	MySQL.Async.execute('INSERT INTO banlist (licenseid,token, playerip, reason, timeat, expiration, permanent) VALUES (@licenseid,@token, @playerip, @reason, @timeat, @expiration, @permanent)', {
		['@licenseid'] = licenseid,
        ['@token'] = token,
		['@playerip'] = playerip,
		['@reason'] = reason,
		['@timeat'] = timeat,
		['@expiration'] = expiration,
		['@permanent'] = permanent
	}, function()
		MySQL.Async.execute('INSERT INTO banlisthistory (licenseid,token, playerip, reason, timeat, expiration, permanent) VALUES (@licenseid,@token, @playerip, @reason, @timeat, @expiration, @permanent)', {
			['@licenseid'] = licenseid,
            ['@token'] = token,
			['@playerip'] = playerip,
			['@reason'] = reason,
			['@timeat'] = timeat,
			['@expiration'] = expiration,
			['@permanent'] = permanent
		})

		if permanent == 0 then
			SendMessage(source, (('Vous avez banni %s / Durée : %s / Raison : %s'):format(targetName, SexyTime(time), reason)))
			--TriggerEvent('Kylian::0909::esx:customDiscordLog', ('`%s` a banni `%s` / Durée : `%s` / Raison : `%s`\n```\n%s\n%s\n```'):format(sourceName, targetName, SexyTime(time), reason, licenseid, playerip), 'Ban Info')
		else
			SendMessage(source, (('Vous avez banni %s / Durée : Permanent / Raison : %s'):format(targetName, reason)))
			--TriggerEvent('Kylian::0909::esx:customDiscordLog', ('`%s` a banni `%s` / Durée : `Permanent` / Raison : `%s`\n```\n%s\n%s\n```'):format(sourceName, targetName, reason, licenseid, playerip), 'Ban Info')
		end
	end)
end

function DeleteBan(token, cb)
	MySQL.Async.execute('DELETE FROM banlist WHERE licenseid = @licenseid', {
		['@licenseid'] = token
	}, function()
		if cb then
			cb()
		end
	end)
end

function IsBanned(licenseid, cb)
	MySQL.Async.fetchAll('SELECT * FROM banlist WHERE licenseid = @licenseid', {
		['@licenseid'] = licenseid,
	}, function(result)
		if #result > 0 then
			cb(true, result[1])
		else
			cb(false, result[1])
		end
	end)
end

local function getLicense(source)
    local license = nil
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    return license
end


RegisterCommand("ban", function(source, args, rawcommand)
	local _src = source
	local license = getLicense(_src)
	if Admin.Whitlist[license] ~= nil then
			local licenseid, playerip,token = 'N/A', 'N/A', 'N/A'
			local target = tonumber(args[1])
			local expiration = tonumber(args[2])
			local reason = table.concat(args, ' ', 3)


			if target and target > 0 then
				local sourceName = GetPlayerName(source)
				local targetName = GetPlayerName(target)

				if targetName then
					if expiration and expiration <= 336 then
						licenseid = GetIdentifierFromId(target, 'license:')
						discordid = GetIdentifierFromIdDiscord(target)
						banid = math.random(1,999)

						playerip = GetPlayerEndpoint(target)
						token = GetPlayerToken(target,0)

						if not licenseid then
							licenseid = 'N/A'
						end

						if reason == '' then
							reason = Locale.noreason
						end

						if expiration > 0 then
							AddBan(source, licenseid,token, playerip, targetName, sourceName, expiration, reason, 0)
							DropPlayer(target, ('You are banned from Atlantiss KOTH\nBan ID : %s\nRaison : %s\nTemps Restant : %s\nAuthor : %s'):format(banid,reason, SexyTime(expiration * 3600), sourceName))
							TriggerEvent("SendLogsBan",target,targetName,banid, "Le staff "..sourceName.." à ban :\n\n**__Name__** : "..targetName.."\n**__IP__** : "..playerip.."\n**__Token__** : "..token.."\n**__Temps__** : "..SexyTime(expiration * 3600).."\n**__Raison__** : "..reason.."")
						else
							AddBan(source, licenseid,token, playerip, targetName, sourceName, expiration, reason, 1)
							DropPlayer(target, ('You are banned from Atlantiss KOTH\nBan ID : %s\nReason : %s\nRemaining time : Permanent\nAuthor : %s'):format(banid,reason, sourceName))
							TriggerEvent("SendLogsBan",target,targetName,banid, "Le staff "..sourceName.." à ban :\n\n**__Name__** : "..targetName.."\n**__IP__** : "..playerip.."\n**__Token__** : "..token.."\n**__Temps__** : Permanent\n**__Raison__** : "..reason.."")
						end
					else
						SendMessage(source, Locale.invalidtime)
					end
				else
					SendMessage(source, Locale.invalidid)
				end
			else
				SendMessage(source, Locale.invalidid)
			end
		end
end, false)

RegisterCommand("unban", function(source, args)
	local _src = source
	local license = getLicense(_src)
	if Admin.Whitlist[license] ~= nil then
		if source ~= 0 then
			local sourceName = GetPlayerName(source)
			local token = table.concat(args, ' ')


			if token then
				MySQL.Async.fetchAll('SELECT * FROM banlist WHERE token LIKE @licenseid', {
					['@licenseid'] = ('%' .. token .. '%')
				}, function(data)
					if data[1] then
						DeleteBan(data[1].token, function()
							TriggerEvent("SendLogsUnban", "Le staff "..sourceName.." à déban "..data[1].targetName.."")
						end)
					else
						SendMessage(source, Locale.invalidname)
					end
				end)
			else
				SendMessage(source, Locale.cmdunban)
			end
		else
			local token = table.concat(args, ' ')

			if token then
				MySQL.Async.fetchAll('SELECT * FROM banlist WHERE token LIKE @licenseid', {
					['@licenseid'] = ('%' .. token .. '%')
				}, function(data)
					if data[1] then
						DeleteBan(data[1].token, function()
							TriggerEvent("SendLogsUnban", "La console à déban "..data[1].targetName.."")
						end)
					end
				end)
			end
		end
	end
end, false)

RegisterServerEvent('Kylian::0909::BanSql:ICheatClient')
AddEventHandler('Kylian::0909::BanSql:ICheatClient', function(id,reason)
	local _source = id
	local licenseid, playerip,token = 'N/A', 'N/A'
	if reason == nil then
		reason = 'Cheat KOTH'
	end

	if reason == "Invalid Token" then
		TriggerEvent("SendLogsBanCheat", "Invalid Token SuckMyDick")
	end
	if _source then
		local name = GetPlayerName(_source)

		if name then
			licenseid = GetIdentifierFromId(_source, 'license:')
			playerip = GetPlayerEndpoint(_source)
			token = GetPlayerToken(_source,0)

			if not licenseid then
				licenseid = 'N/A'
			end
			AddBan(_source, licenseid,token, playerip, name, 'AC KOTH', 0, reason, 1)
			DropPlayer(_source, ('You are banned from KOTH\nReason : %s\nRemaining time : Permanent\nAuthor : AC KOTH'):format(reason))
		end
	else
		print('BanSql Error : Anti-Cheat KOTH have received invalid id.')
	end
end)