_teams = {
  {id = 1,color = "red", players = 0, point = 0, target = 0},
  {id = 2,color = "blue", players = 0, point = 0, target = 0},
  {id = 3,color = "green", players = 0, point = 0, target = 0}
}

local WeaponLabel = nil
local play = false
local s2 = nil
local s2 = nil
local pr = nil


_weapons = {
  [-1716589765] = { "WEAPON_APPISTOL" },
  [-1357824103] = { "WEAPON_ADVANCEDRIFLE" },
}

RegisterNetEvent("WeaponSelect")
AddEventHandler("WeaponSelect", function(weapon)
  ss = weapon
end)

RegisterNetEvent("ReturnClientWeaponHud")
AddEventHandler("ReturnClientWeaponHud", function(type, weapons)
    if type == 1 then
      s1 = weapons --Second
    elseif type == 2 then
      s2 = weapons --Derbuer
    elseif type == 3 then
      pr = weapons --Premier
    end
end)

RegisterNetEvent("RemoveelAllWZEAPOFBHFJFH")
AddEventHandler("RemoveelAllWZEAPOFBHFJFH", function()
  pr = "false"
  s1 = "false"
  s2 = "false"
  SendNUIMessage({
    weapon14 = "false",
    weapon13 = "false",
    weapon12 = "false",
    weapon2 = "false",
    weapon3 = "false",
    weapon1 = "false",

    -- Envoyer weapon2, weapon3
  })
end)


AddEventHandler("playerSpawned",function()
--TriggerEvent("KOTH_HUD:removeHUD",1)
--Wait(500)
 --TriggerEvent("KOTH_HUD:removeHUD",2)

  if s2 then
    s2 = "false"
  end
  if s1 then
    s1 = "false"
  end
  if pr then
    pr = "false"
  end
  SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
  iSRespwan = true
end)

RegisterNetEvent("UpdateInfo")
AddEventHandler("UpdateInfo", function(stats)
  _teams[1].point = string.format("%.0f", stats.points[1])
  _teams[2].point = string.format("%.0f", stats.points[2])
  _teams[3].point = string.format("%.0f", stats.points[3])
  _teams[1].target = stats.players[1]
  _teams[2].target = stats.players[2]
  _teams[3].target = stats.players[3]
  _teams[1].players = stats.count[1]
  _teams[2].players = stats.count[2]
  _teams[3].players = stats.count[3]
end)

team = false

Citizen.CreateThread(function()
  local name = GetPlayerName(PlayerId())

  while true do
    Wait(100)
      local playerLife = GetEntityHealth(PlayerPedId())
      local _,getWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)
      local _,getAmmo = GetAmmoInClip(PlayerPedId(), getWeapon)
      local maxAmmo = GetMaxAmmoInClip(PlayerPedId(), getWeapon, 1)
      w = getWeapon
      SendNUIMessage(
        {
        life = tonumber(playerLife)
        --ammo = getAmmo,
        }
      )

    if team == false then
      SendNUIMessage({
        teams = _teams
      })
      exports['koth-ui']:SendUIMessage({teams = _teams})
    end

    if s2 then
      SendNUIMessage({
        weapon14 = true,
        weapon3 = s2
        -- Envoyer weapon2, weapon3
      })
    else
      SendNUIMessage({weapon3 = "false"})
    end
    if s1 then
        SendNUIMessage({
          weapon13 = true,
          weapon2 = s1
          -- Envoyer weapon2, weapon3
        })
        if IsEntityDead(PlayerPedId()) then
          SendNUIMessage({
            weapon14 ="false",
            weapon13 ="false",
            weapon12 ="false",
            weapon2 = "false",
            weapon3 = "false",
            weapon1 = "false",
    
            -- Envoyer weapon2, weapon3
          })
        end
      else
        SendNUIMessage({weapon2 = "false"})
      end
    if pr then
      SendNUIMessage({
        weapon12 = true,
        weapon1 = pr
        -- Envoyer weapon2, weapon3
      })
      if IsEntityDead(PlayerPedId()) then
        SendNUIMessage({
          weapon14 = "false",
          weapon13 = "false",
          weapon12 = "false",
          weapon2 = "false",
          weapon3 = "false",
          weapon1 = "false",
  
          -- Envoyer weapon2, weapon3
        })
      end
    else
      SendNUIMessage({weapon1 = "false"})
    end
    SendNUIMessage({
      equiped = "false",
    })
    if IsPedArmed(PlayerPedId(), 4) then
      --for k,v in pairs(_weapons) do
      --  if k == getWeapon then

          SendNUIMessage({
            equiped = ss,
            ammo = getAmmo,
            --weapon2 = s2
            -- Envoyer weapon2, weapon3
          })
      --  end
      --end
        --else
        --  SendNUIMessage({
        --    weapon = "WEAPON_UNARMED"
        --  })
        end

    if IsControlPressed(1, 45) then
      if IsPedArmed(PlayerPedId(), 4) then
        if getAmmo ~= maxAmmo then
          SendNUIMessage({reload = true})
        end
      end
    else 
      if IsPedArmed(PlayerPedId(), 4) then
        if getAmmo == 0 then
          SendNUIMessage({reload = true})
        end
      end
    end
  end
end)

RegisterNetEvent("KOTH-FellKill")
AddEventHandler("KOTH-FellKill",function(victim,kill, data, colorvictim, colorattaque)
  local armes = WeaponLabel[data.weaponhash]
  if armes ~= nil then
      SendNUIMessage({
        killer = kill,
        weaponkill = armes,
        ca = colorattaque,
        cv = colorvictim,
        killed = victim,
      })
    else
      SendNUIMessage({
        killer = kill,
        weaponkill = "VEHICLE",
        ca = colorattaque,
        cv = colorvictim,
        killed = victim,
      })
    end
end)

function GetRequiredExp(level)
  return (182.5*(level^2))-(297.5*level)+115
end

function GetLevel(exp)
  return math.floor((595+(math.sqrt(5)*math.sqrt((584*exp)+4500)))/730)
end


_PlayerInfo = { name = nil, lvl = nil, xp = nil, nextExp = nil, lvls = nil, xp2 = nil, money = 5000 , progress = nil}

RegisterNetEvent("KOTH-MAIN:UpdatePlayerHUD")
AddEventHandler("KOTH-MAIN:UpdatePlayerHUD",function(PlayerData)
  local name = GetPlayerName(PlayerId())
  for k,v in pairs(PlayerData) do
    local money = tonumber(v.money)
    local lvl = tonumber(v.level)
    local xp = tonumber(v.exp)
    local nextExp = GetRequiredExp(lvl + 1)
    _PlayerInfo.name = name
    _PlayerInfo.lvl = GetLevel(xp)
    _PlayerInfo.lvls = _PlayerInfo.lvl + 1 
    _PlayerInfo.xp = xp
    _PlayerInfo.nextExp = nextExp
    _PlayerInfo.money = money
    local needexp = nextExp - GetRequiredExp(lvl)
    local xp = xp - GetRequiredExp(lvl)
    local pourcentage = xp / needexp
    _PlayerInfo.progress = tostring(math.floor(pourcentage * 100)).."%"
    if _PlayerInfo.xp >= nextExp then
      TriggerServerEvent("KOTH-SaveKOTHUSER",GetLevel(_PlayerInfo.xp),_PlayerInfo.xp, _PlayerInfo.money)
    end
  end
end)

function HUDPlayer()
  local names = GetPlayerName(PlayerId())
  local moneys = 600

  SendNUIMessage({player = _PlayerInfo})
  exports['koth-ui']:SendUIMessage({playerInfos = _PlayerInfo})
end

Citizen.CreateThread(function()
  exports['spawnmanager']:setAutoSpawn(false)

  while true do 
    Wait(1)
    HUDPlayer()
  end
end)

Citizen.CreateThread(function()
  TriggerEvent("KOTH:ClearAllBlips")
  while true do
    TriggerServerEvent("KOTH:UpdateHUD", "ffzeqfqfeqfezqfg1egr5558ze1210..gqzg")
    Wait(5000)
  end
end)

RegisterNetEvent("KOTH_HUD:removeHUD")
AddEventHandler("KOTH_HUD:removeHUD",function(type)
  if type == 1 then
    SendNUIMessage({
      hud = true
    })
  elseif type == 2 then
    SendNUIMessage({
      huds = true
    })
  end
end)


function showRightNotification(money, exp, reason)
  if money == -1 then money = nil end
  if exp == -1 then exp = nil end
  local data = {type = "right", notif_money = money, notif_exp = exp, notif_reason = reason}
  SendNUIMessage(data)
end

RegisterNetEvent("KOTH:RightNotification")
AddEventHandler("KOTH:RightNotification", function(money, exp, reason)
    showRightNotification(money, exp, reason)
end)

function showRightNotifications(reason)
  local data = {type = "center", notif_reasons = reason}
  SendNUIMessage(data)
end


RegisterNetEvent("KOTH:CenterNotification")
AddEventHandler("KOTH:CenterNotification", function(reason)
  showRightNotifications(reason)
end)

Citizen.CreateThread(function()
  Wait(500)
  exports['koth-main']:TriggerServerCallback(
    'KOTH:RetrunWEAPONNAME',
    function(weapon)
      WeaponLabel = weapon
    end
  )
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        
		if veh then
      SetVehicleRadioEnabled(veh, true)
			if GetPedInVehicleSeat(veh, -1) == ped and GetVehicleClass(GetVehiclePedIsIn(ped, false)) ~= 15 then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			else
				SetPlayerCanDoDriveBy(PlayerId(), true)
			end
		end
	end
end)

Citizen.CreateThread(function()
  local minimap = RequestScaleformMovie("minimap")
  while true do
      Citizen.Wait(0)
      BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
      ScaleformMovieMethodAddParamInt(3)
      EndScaleformMovieMethod()
  end
end)

RegisterNUICallback('AtlantissKOTH:HUD:SendNUIMessage', function(object)
  SendNUIMessage(object)
end)

exports(
	'SendUIMessage',
	function(array)
		SendNUIMessage(array)
	end
)
