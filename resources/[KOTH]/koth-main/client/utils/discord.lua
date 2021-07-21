-- Citizen.CreateThread(function()
-- 	while true do
-- 		SetDiscordAppId(816798568244707329)
--         SetRichPresence("[EU] KOTH")

-- 		SetDiscordRichPresenceAsset('logo_koth_dmz_dore')
--         --SetDiscordRichPresenceAssetText('[EU] KOTH')
--         SetDiscordRichPresenceAction(0, 'Discord','https://discord.gg/kotheu')

-- 		Citizen.Wait(5000)
-- 	end
-- end)


local discordButton = {
    {index = 0, name = 'Rejoindre le discord', url = "https://discord.com/invite/atlantiss-koth"},
    {index = 1, name = 'Aller sur le site', url = "https://atlantiss-rp.com/#accueil"}
}

Citizen.CreateThread(
    function()
        for _, v in ipairs(discordButton) do
            SetDiscordRichPresenceAction(v.index, v.name, v.url)
        end
        while true do
            SetDiscordAppId(829032746385932288)
            SetDiscordRichPresenceAsset("logo-1024x1024")
            SetDiscordRichPresenceAssetText("https://discord.gg/atlantiss-koth")

            TriggerServerCallback(
                'onlinePlayers:list',
                function(users)
                    SetRichPresence(GetPlayerName(PlayerId()) .. " 👥 " .. users .. "/200")
                end
            )

            Citizen.Wait(60000)
        end
    end
)
