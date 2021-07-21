Colors = {
	{ label = "Black", value = 'black', basePrice = 1200},
	{ label = "White", value = 'white', basePrice = 1200},
	{ label = "Grey", value = 'grey', basePrice = 1200},
	{ label = "Red", value = 'red', basePrice = 1200},
	{ label = "Pink", value = 'pink', basePrice = 1200},
	{ label = "Blue", value = 'blue', basePrice = 1200},
	{ label = "Yellow", value = 'yellow', basePrice = 1200},
	{ label = "Green", value = 'green', basePrice = 1200},
	{ label = "Orange", value = 'orange', basePrice = 1200},
	{ label = "Brown", value = 'brown', basePrice = 1200},
	{ label = "Purple", value = 'purple', basePrice = 1200},
	{ label = "Chrome", value = 'chrome', basePrice = 1200},
	{ label = "Gold", value = 'gold', basePrice = 1200}
}

function GetColors(color)
	local colors = {}
	if color == 'black' then
		colors = {
			{ index = 0, label = "Black"},
			{ index = 1, label = "Graphite"},
			{ index = 2, label = "Black Metallic"},
			{ index = 3, label = "Molten steel"},
			{ index = 11, label = "Black Anthracite"},
			{ index = 12, label = "Black Mast"},
			{ index = 15, label = "Night Dark"},
			{ index = 16, label = "Deep black"},
			{ index = 21, label = "Petroleum"},
			{ index = 147, label = "Carbon"}
		}
	elseif color == 'white' then
		colors = {
			{ index = 106, label = "Vanilla"},
			{ index = 107, label = "Cream"},
			{ index = 111, label = "White"},
			{ index = 112, label = "Polar White"},
			{ index = 113, label = "Beige"},
			{ index = 121, label = "Matt white"},
			{ index = 122, label = "Snow"},
			{ index = 131, label = "Cotton"},
			{ index = 132, label = "Alabaster"},
			{ index = 134, label = "Pure white"}
		}
	elseif color == 'grey' then
		colors = {
			{ index = 4, label = "Silver"},
			{ index = 5, label = "Grey Metallic"},
			{ index = 6, label = "Acier mine"},
			{ index = 7, label = "Grey Dark"},
			{ index = 8, label = "Grey Rocky"},
			{ index = 9, label = "Grey night"},
			{ index = 10, label = "Aluminium"},
			{ index = 144, label = "Grey Hunter"},
			{ index = 156, label = "Grey"}
		}
	elseif color == 'red' then
		colors = {
			{ index = 27, label = "Red"},
			{ index = 28, label = "Red Turin"},
			{ index = 29, label = "Poppy"},
			{ index = 30, label = "Red Copper"},
			{ index = 31, label = "Red Cardinal"},
			{ index = 46, label = "Red Blade"},
			{ index = 143, label = "Red Wine"},
			{ index = 150, label = "Volcano"}
		}
	elseif color == 'pink' then
		colors = {
			{ index = 135, label = "Pink Electricity"},
			{ index = 136, label = "Pink Salmon"},
			{ index = 137, label = "Pink Dragee"}
		}
	elseif color == 'blue' then
		colors = {
			{ index = 54, label = "Topaz"},
			{ index = 60, label = "Blue Clear"},
			{ index = 61, label = "Blue galaxy"},
			{ index = 62, label = "Blue dark"},
			{ index = 63, label = "Blue azure"},
			{ index = 64, label = "Blue marine"},
			{ index = 65, label = "lapis lazuli"},
			{ index = 67, label = "Blue diamond"},
			{ index = 68, label = "surf"},
			{ index = 69, label = "Pastel"},
			{ index = 70, label = "Blue celestial"},
			{ index = 73, label = "Blue rally"},
			{ index = 74, label = "Blue paradise"},
			{ index = 75, label = "Blue night"},
			{ index = 77, label = "Blue cyan"},
			{ index = 78, label = "Cobalt"},
			{ index = 79, label = "Blue electric"},
			{ index = 80, label = "Blue horizon"},
			{ index = 82, label = "Blue metallic"},
			{ index = 83, label = "aigue Marine"},
			{ index = 84, label = "Blue agathe"},
			{ index = 85, label = "Zirconium"},
			{ index = 86, label = "spinel"},
			{ index = 87, label = "tourmaline"},
			{ index = 127, label = "Paradise"},
			{ index = 140, label = "bubble gum"},
			{ index = 141, label = "Blue midnight"},
			{ index = 146, label = "Blue not allowed"},
			{ index = 157, label = "Blue glacier"}
		}
	elseif color == 'yellow' then
		colors = {
			{ index = 42, label = "Yellow"},
			{ index = 88, label = "Yellow Corn"},
			{ index = 89, label = "Yellow Rally"},
			{ index = 91, label = "Yellow Clear"},
			{ index = 126, label = "Yellow Blade"}
		}
	elseif color == 'green' then
		colors = {
			{ index = 49, label = "Green Black"},
			{ index = 50, label = "Green Rally"},
			{ index = 51, label = "Green Fir"},
			{ index = 52, label = "Green Olive"},
			{ index = 53, label = "Green Clear"},
			{ index = 55, label = "Green Lime"},
			{ index = 56, label = "Green Forest"},
			{ index = 57, label = "Green Lawn"},
			{ index = 58, label = "Green Imperial"},
			{ index = 152, label = "Green Hunter"},
			{ index = 155, label = "Amarylisse"}
		}
	elseif color == 'orange' then
		colors = {
			{ index = 36, label = "Tangerine"},
			{ index = 38, label = "Orange"},
			{ index = 41, label = "Matte Orange"},
			{ index = 123, label = "Light orange"},
			{ index = 124, label = "Peach"},
			{ index = 130, label = "Pumpkin"},
			{ index = 138, label = "Orange Lambo"}
		}
	elseif color == 'brown' then
		colors = {
			{ index = 45, label = "Copper"},
			{ index = 47, label = "Light brown"},
			{ index = 48, label = "Dark brown"},
			{ index = 154, label = "Desert"}
		}
	elseif color == 'purple' then
		colors = {
			{ index = 71, label = "Indigo"},
			{ index = 72, label = "Deep Purple"},
			{ index = 76, label = "Purple dark"},
			{ index = 81, label = "Amethyst"},
			{ index = 142, label = "Purple Mystical"},
			{ index = 145, label = "Purple Metallic"},
			{ index = 148, label = "Purple Mast"},
			{ index = 149, label = "Purple Deep Matte"}
		}
	elseif color == 'chrome' then
		colors = {
			{ index = 117, label = "Brushed Chromium"},
			{ index = 118, label = "Chromium Black"},
			{ index = 119, label = "Brushed aluminum"},
			{ index = 120, label = "Chromium"}
		}
	elseif color == 'gold' then
		colors = {
			{ index = 37, label = "Gold"},
			{ index = 158, label = "Gold Pure"},
			{ index = 159, label = "Gold Brush"},
			{ index = 160, label = "Gold Clear"}
		}
	end
	return colors
end

function UpdateVehProps()
    local pVeh = nil
    local pPed = GetPlayerPed(-1)
    pVeh = GetVehiclePedIsIn(pPed, 0)
    VehProps = GetVehicleProperties(pVeh)
end


function SetVehicleProperties(vehicle, props)
	SetVehicleModKit(vehicle, 0)

	if props.plate ~= nil then
		SetVehicleNumberPlateText(vehicle, props.plate)
	end

	if props.plateIndex ~= nil then
		SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
	end

	if props.health ~= nil then
		SetEntityHealth(vehicle, props.health)
	end

	if props.dirtLevel ~= nil then
		SetVehicleDirtLevel(vehicle, props.dirtLevel)
	end

	if props.color1 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, props.color1, color2)
	end

	if props.color2 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, color1, props.color2)
	end

	if props.pearlescentColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
	end

	if props.wheelColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
	end

	if props.wheels ~= nil then
		SetVehicleWheelType(vehicle, props.wheels)
	end

	if props.windowTint ~= nil then
		SetVehicleWindowTint(vehicle, props.windowTint)
	end

	if props.neonEnabled ~= nil then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
	end

	if props.extras ~= nil then
		for id,enabled in pairs(props.extras) do
			if enabled then
				SetVehicleExtra(vehicle, tonumber(id), 0)
			else
				SetVehicleExtra(vehicle, tonumber(id), 1)
			end
		end
	end

	if props.neonColor ~= nil then
		SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
	end

	if props.modSmokeEnabled ~= nil then
		ToggleVehicleMod(vehicle, 20, true)
	end

	if props.tyreSmokeColor ~= nil then
		SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	end

	if props.modSpoilers ~= nil then
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	end

	if props.modFrontBumper ~= nil then
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	end

	if props.modRearBumper ~= nil then
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	end

	if props.modSideSkirt ~= nil then
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	end

	if props.modExhaust ~= nil then
		SetVehicleMod(vehicle, 4, props.modExhaust, false)
	end

	if props.modFrame ~= nil then
		SetVehicleMod(vehicle, 5, props.modFrame, false)
	end

	if props.modGrille ~= nil then
		SetVehicleMod(vehicle, 6, props.modGrille, false)
	end

	if props.modHood ~= nil then
		SetVehicleMod(vehicle, 7, props.modHood, false)
	end

	if props.modFender ~= nil then
		SetVehicleMod(vehicle, 8, props.modFender, false)
	end

	if props.modRightFender ~= nil then
		SetVehicleMod(vehicle, 9, props.modRightFender, false)
	end

	if props.modRoof ~= nil then
		SetVehicleMod(vehicle, 10, props.modRoof, false)
	end

	if props.modEngine ~= nil then
		SetVehicleMod(vehicle, 11, props.modEngine, false)
	end

	if props.modBrakes ~= nil then
		SetVehicleMod(vehicle, 12, props.modBrakes, false)
	end

	if props.modTransmission ~= nil then
		SetVehicleMod(vehicle, 13, props.modTransmission, false)
	end

	if props.modHorns ~= nil then
		SetVehicleMod(vehicle, 14, props.modHorns, false)
	end

	if props.modSuspension ~= nil then
		SetVehicleMod(vehicle, 15, props.modSuspension, false)
	end

	if props.modArmor ~= nil then
		SetVehicleMod(vehicle, 16, props.modArmor, false)
	end

	if props.modTurbo ~= nil then
		ToggleVehicleMod(vehicle,  18, props.modTurbo)
	end

	if props.modXenon ~= nil then
		ToggleVehicleMod(vehicle,  22, props.modXenon)
	end

	if props.modFrontWheels ~= nil then
		SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
	end

	if props.modBackWheels ~= nil then
		SetVehicleMod(vehicle, 24, props.modBackWheels, false)
	end

	if props.modPlateHolder ~= nil then
		SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
	end

	if props.modVanityPlate ~= nil then
		SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
	end

	if props.modTrimA ~= nil then
		SetVehicleMod(vehicle, 27, props.modTrimA, false)
	end

	if props.modOrnaments ~= nil then
		SetVehicleMod(vehicle, 28, props.modOrnaments, false)
	end

	if props.modDashboard ~= nil then
		SetVehicleMod(vehicle, 29, props.modDashboard, false)
	end

	if props.modDial ~= nil then
		SetVehicleMod(vehicle, 30, props.modDial, false)
	end

	if props.modDoorSpeaker ~= nil then
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
	end

	if props.modSeats ~= nil then
		SetVehicleMod(vehicle, 32, props.modSeats, false)
	end

	if props.modSteeringWheel ~= nil then
		SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
	end

	if props.modShifterLeavers ~= nil then
		SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
	end

	if props.modAPlate ~= nil then
		SetVehicleMod(vehicle, 35, props.modAPlate, false)
	end

	if props.modSpeakers ~= nil then
		SetVehicleMod(vehicle, 36, props.modSpeakers, false)
	end

	if props.modTrunk ~= nil then
		SetVehicleMod(vehicle, 37, props.modTrunk, false)
	end

	if props.modHydrolic ~= nil then
		SetVehicleMod(vehicle, 38, props.modHydrolic, false)
	end

	if props.modEngineBlock ~= nil then
		SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
	end

	if props.modAirFilter ~= nil then
		SetVehicleMod(vehicle, 40, props.modAirFilter, false)
	end

	if props.modStruts ~= nil then
		SetVehicleMod(vehicle, 41, props.modStruts, false)
	end

	if props.modArchCover ~= nil then
		SetVehicleMod(vehicle, 42, props.modArchCover, false)
	end

	if props.modAerials ~= nil then
		SetVehicleMod(vehicle, 43, props.modAerials, false)
	end

	if props.modTrimB ~= nil then
		SetVehicleMod(vehicle, 44, props.modTrimB, false)
	end

	if props.modTank ~= nil then
		SetVehicleMod(vehicle, 45, props.modTank, false)
	end

	if props.modWindows ~= nil then
		SetVehicleMod(vehicle, 46, props.modWindows, false)
	end

	if props.modLivery ~= nil then
		SetVehicleMod(vehicle, 48, props.modLivery, false)
		SetVehicleLivery(vehicle, props.modLivery)
	end

	if DoesEntityExist(vehicle) then
		if props.windowStatus ~= nil then
			for i = 1,6 do
				print(i, props.windowStatus[i], IsVehicleWindowIntact(vehicle, i))
				if props.windowStatus[i] ~= nil and props.windowStatus[i] == false and IsVehicleWindowIntact(vehicle, i) ~= false then
					print("Broken window, maybe should crash now")
					SmashVehicleWindow(vehicle, i) 
				end
			end
		end

		if props.tyres ~= nil then
			for k,v in pairs(props.tyres) do
				if v then
					SetVehicleTyreBurst(vehicle, tonumber(k), true, 100.0)
				end
			end
		end
	end
end

function GetVehicleProperties(vehicle)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		local extras = {}

		for id = 0, 12 do
			if DoesExtraExist(vehicle, id) then
				extras[tostring(id)] = IsVehicleExtraTurnedOn(vehicle, id) == 1
			end
		end

		return {
			model = GetEntityModel(vehicle),

			color1 = colorPrimary,
			color2 = colorSecondary,

			pearlescentColor = pearlescentColor,
			wheelColor = wheelColor,

			wheels = GetVehicleWheelType(vehicle),
			windowTint = GetVehicleWindowTint(vehicle),
			xenonColor = GetVehicleXenonLightsColour(vehicle),

			neonEnabled = {
				IsVehicleNeonLightEnabled(vehicle, 0),
				IsVehicleNeonLightEnabled(vehicle, 1),
				IsVehicleNeonLightEnabled(vehicle, 2),
				IsVehicleNeonLightEnabled(vehicle, 3)
			},

			neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
			extras = extras,
			tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),

			modSpoilers = GetVehicleMod(vehicle, 0),
			modFrontBumper = GetVehicleMod(vehicle, 1),
			modRearBumper = GetVehicleMod(vehicle, 2),
			modSideSkirt = GetVehicleMod(vehicle, 3),
			modExhaust = GetVehicleMod(vehicle, 4),
			modFrame = GetVehicleMod(vehicle, 5),
			modGrille = GetVehicleMod(vehicle, 6),
			modHood = GetVehicleMod(vehicle, 7),
			modFender = GetVehicleMod(vehicle, 8),
			modRightFender = GetVehicleMod(vehicle, 9),
			modRoof = GetVehicleMod(vehicle, 10),

			modEngine = GetVehicleMod(vehicle, 11),
			modBrakes = GetVehicleMod(vehicle, 12),
			modTransmission = GetVehicleMod(vehicle, 13),
			modHorns = GetVehicleMod(vehicle, 14),
			modSuspension = GetVehicleMod(vehicle, 15),
			modArmor = GetVehicleMod(vehicle, 16),

			modTurbo = IsToggleModOn(vehicle, 18),
			modSmokeEnabled = IsToggleModOn(vehicle, 20),
			modXenon = IsToggleModOn(vehicle, 22),

			modFrontWheels = GetVehicleMod(vehicle, 23),
			modBackWheels = GetVehicleMod(vehicle, 24),

			modPlateHolder = GetVehicleMod(vehicle, 25),
			modVanityPlate = GetVehicleMod(vehicle, 26),
			modTrimA = GetVehicleMod(vehicle, 27),
			modOrnaments = GetVehicleMod(vehicle, 28),
			modDashboard = GetVehicleMod(vehicle, 29),
			modDial = GetVehicleMod(vehicle, 30),
			modDoorSpeaker = GetVehicleMod(vehicle, 31),
			modSeats = GetVehicleMod(vehicle, 32),
			modSteeringWheel = GetVehicleMod(vehicle, 33),
			modShifterLeavers = GetVehicleMod(vehicle, 34),
			modAPlate = GetVehicleMod(vehicle, 35),
			modSpeakers = GetVehicleMod(vehicle, 36),
			modTrunk = GetVehicleMod(vehicle, 37),
			modHydrolic = GetVehicleMod(vehicle, 38),
			modEngineBlock = GetVehicleMod(vehicle, 39),
			modAirFilter = GetVehicleMod(vehicle, 40),
			modStruts = GetVehicleMod(vehicle, 41),
			modArchCover = GetVehicleMod(vehicle, 42),
			modAerials = GetVehicleMod(vehicle, 43),
			modTrimB = GetVehicleMod(vehicle, 44),
			modTank = GetVehicleMod(vehicle, 45),
			modWindows = GetVehicleMod(vehicle, 46),
			modLivery = GetVehicleLivery(vehicle)
		}
	else
		return
	end
end