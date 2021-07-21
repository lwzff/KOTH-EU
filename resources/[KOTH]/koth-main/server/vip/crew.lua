local GetCrewData = {}

Citizen.CreateThread(function()
    GetCrewData = LoadCrewData()
end)

function LoadCrewData()
    local crewdata = LoadResourceFile("koth-main", "data/CrewData.json")
    return crewdata and json.decode(crewdata) or {}
end


function GetCrew(name)
	for i = 1, #GetCrewData, 1 do
		if name == GetCrewData[i].name then
			return GetCrewData[i]
		end
	end
	return false
end


RegisterNetEvent("Crew:Createcrew")
AddEventHandler("Crew:Createcrew", function(namecrew)
    local _src = source
    if not GetCrew(namecrew) then
        local data = {
            name = namecrew
        }
        table.insert(GetCrewData,data)
		SaveResourceFile("koth-main", "data/CrewData.json", json.encode(GetCrewData))
        --@todo Create log
    else
        TriggerClientEvent("KOTH:CenterNotification",_src,-1,-1, "The name of the crew already exists !")
        return
    end
end)