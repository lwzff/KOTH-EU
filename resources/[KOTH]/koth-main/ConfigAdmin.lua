Admin = {
    ranks = { 
        [1] = {
            label = "Modérateur", 
            color = "~o~",
            permissions = {
            },
        },

        [2] = {
            label = "Admin", 
            color = "~v~",
            permissions = {
            },
        },

        [3] = {
            label = "Fondateur", 
            color = "~r~",
            permissions = {
                1,2
            },
        },

    },

    
    functions = {
        [1] = {
            cat = "player",
            sep = "↓ ~b~Téleportations ~s~↓",
            toSub = false,
            label = "Téléportation sur le joueur",
            press = function(selectedPlayer)
                TriggerServerEvent("Koth:GotoPlayer", selectedPlayer.id)
            end
        },

        [2] = {
            cat = "player",
            sep = nil,
            toSub = false,
            label = "Téleportation sur moi",
            press = function(selectedPlayer)
                local pos = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("koth-b:bring", selectedPlayer.id, pos)
            end
        },

        [3] = {
            cat = "player",
            sep = "↓ ~b~Ban / Kick ~s~↓",
            toSub = false,
            label = "Ban",
            press = function(selectedPlayer)
                local pos = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("koth-b:bring", selectedPlayer.id, pos)
            end
        },
        
    }
}

Admin.Whitlist = {
    -- 1 = Modérateur
    -- 2 = Admin
    -- 3 = Fondateur
    --["license:"] = perms,
    ["license:3a8febbe9ddf1856c0fb1636d43003fd91589890"] = 3, --Kiki -Fondateur
    ["license:ae8ddd876936afeadbccc2a650d1ad16bef0e406"] = 3, --Dmz -Fondateur
    ["license:6055eda0cc4b1c3fd99e702a335d4a901a9b62f8"] = 3, --Nampac -Fondateur
    ["license:2c6416c9a3783f4cb8f3e7ca67c19b75a67ec903"] = 3, -- John -Fondateur
    ["license:13bcf613851d071f18ccdd9426d94744b2a20b7d"] = 3, -- Shiiro -Fondateur
    ["license:e8a6bd39d2e362728c53112a6bc57f5bd02ca5dd"] = 3, --Tonton -Admin
    ["license:92149e0ddfae3636baf18386da597d71c56116de"] = 3, -- Snoupix -Admin
    ["license:376f4a6488caf15928c0f1714fbea4e3867ce2a4"] = 3, --LDA -Modo
    ["license:1cb5d5605f6b28f60a9ccf593fd77df927d32633"] = 3, --Theo -Modo
    ["license:b105cbceed50f7586a35dc9435a3b6782e6738bd"] = 3, --Pikapikachups -Modo
    ["license:016a0ad3cde0ceddc5320ecea0891a554e91afbb"] = 3, -- Yegor -Modo
    ["license:7b2f2a893618c4c203126ed0baa8f73bc2e7f428"] = 3, -- Akram -Modo
    ["license:3875e5f1980b07f7db042ccfcd8c7d87ab66cb35"] = 3, -- Psyko -Modo
--  ["license:164133563446fa8cfc6cfcbb69f27b646b5689b2"] = 3, --Jax
}
