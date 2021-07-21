ServerCallbacks = {}

CurrentRequestId = 0

TriggerServerCallback = function(name, cb, ...)
    ServerCallbacks[CurrentRequestId] = cb
    TriggerServerEvent('trigger_server_callback', name, CurrentRequestId, ...)
    if CurrentRequestId < 65535 then
        CurrentRequestId = CurrentRequestId + 1
    else
        CurrentRequestId = 0
    end
end

RegisterNetEvent('server_callback')
AddEventHandler('server_callback', function(requestId, ...)
    if (ServerCallbacks[requestId] ~= nil) then
        ServerCallbacks[requestId](...)
        ServerCallbacks[requestId] = nil
    end
end)