Citizen.CreateThread(
	function()
		Wait(2000)
		SendNUIMessage({
			eventName = "showNotification", 
			args = {message = 'Welcome on Atlantiss KOTH', theme = 'success', time = 5000, progBar = false}
		})

		--[[ while (true) do
			Wait(2000)
			
		end ]]
	end
)

RegisterNUICallback('AtlantissKOTH:UI:SendNUIMessage', function(object)
  	SendNUIMessage(object)
end)


exports(
	'SendUIMessage',
	function(array)
		SendNUIMessage(array)
	end
)
