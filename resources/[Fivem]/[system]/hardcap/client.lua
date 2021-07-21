Citizen.CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('hardcap:playerActivated')

			return
		end
	end
end)

AddEventHandler('onClientMapStart', function()
	TriggerServerEvent("MapPositon")
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(3500)
    TriggerEvent("KOTH_HUD:removeHUD",1)

	exports.spawnmanager:setAutoSpawn(false)
  end)