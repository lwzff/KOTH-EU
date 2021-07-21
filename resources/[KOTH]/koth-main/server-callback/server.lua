ServerCallbacks = {}

RegisterServerEvent('trigger_server_callback')
AddEventHandler('trigger_server_callback', function(name, requestId, ...)
    local _source = source
    TriggerServerCallback(name, requestID, _source, function(...)
        TriggerClientEvent('server_callback', _source, requestId, ...)
    end, ...)
end)

RegisterServerCallback = function(name, cb)
    ServerCallbacks[name] = cb
end

TriggerServerCallback = function(name, requestId, source, cb, ...)
    if ServerCallbacks[name] ~= nil then
        ServerCallbacks[name](source, cb, ...)
    else
    end
end