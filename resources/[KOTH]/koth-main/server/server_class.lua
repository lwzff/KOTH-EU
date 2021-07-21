RegisterNetEvent('KOTH:Medic:objCreate')
AddEventHandler('KOTH:Medic:objCreate', function(coors, deleteCD)
    local _src = source
    local coodone = coors
    local serverData = {
        pickup = "prop_medstation_01",
        coords = coodone,
        team = 3
    }
    TriggerClientEvent("KOTH:Medic:objCreate", -1, _src, serverData, deleteCD)
end)

DetectionCache = {}


