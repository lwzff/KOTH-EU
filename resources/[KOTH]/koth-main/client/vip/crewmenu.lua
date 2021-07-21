local OpenTeam = false
local Crew = false

RMenu.Add("menu_crew", "menu_crew_main", RageUI.CreateMenu("Your crew","crew menu",10,222))
RMenu:Get('menu_crew', 'menu_crew_main'):SetRectangleBanner(22,18,18,65);
RMenu:Get('menu_crew', 'menu_crew_main').Closed = function() OpenTeam = false end;


local Pourcent = 0.0
local LoadInfo = 0

function InitPlayerMenu()
    if OpenTeam then print("Menu Open") end
    if not OpenTeam then
        OpenTeam = true
        Citizen.CreateThread(function()
            while OpenTeam do
                RageUI.IsVisible(RMenu:Get("menu_crew",'menu_crew_main'),true,true,true,function()
                    if not Crew then
                        RageUI.ButtonWithStyle("Create Crew", nil, {RightLabel = "🔨 ~b~→→"}, true, function(_,_,s)
                            if s then
                                local name = tostring(KeyboardInput('TEAM_NAME', 'Name Crew :', name or '', 30))
                                if name ~= nil then
                                    TriggerServerEvent("Crew:Createcrew", name)
                                end
                            end
                        end)
                    elseif Crew then

                    end
                end, function()
                end)
                Wait(1)
            end
        end)
    end
end