RegisterServerCallback(
    "onlinePlayers:list",
    function(source, callback)
        --local players = {}
        --for _, playerId in ipairs(GetPlayers()) do
        --    table.insert(players, {id = playerId, name = GetPlayerName(playerId) or " "})
        --end
        local players = GetNumPlayerIndices()
        callback(players)
    end
)
