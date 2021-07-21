local playerCount = 0
local list = {}

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function(reason)
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
    TriggerEvent("SendLogs","``Le joueur "..GetPlayerName(source).." c'est deconnecter avec la raison suivante : "..reason..".``", "connection")
  end
end)

AddEventHandler('playerConnecting', function(name, setReason)
  local cv = GetConvarInt('sv_maxclients', 200)

  print('Connecting: ' .. name .. '^7')
  TriggerEvent("SendLogs","``Le joueur "..name.." est en train de se connecter.``", "connection")
  if playerCount >= cv then
    print('Full. :(')

    setReason('This server is full (past ' .. tostring(cv) .. ' players).')
    CancelEvent()
  end
end)