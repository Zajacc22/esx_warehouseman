local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local coordx = 0
local coordy = 0
local coordz = 0
local namezone = "Delivery"
local namezonenum = 0
local namezoneregion = 0
local handsup = false
local myJob     = nil
local PlayerData              = {}
ESX = nil
local karton = false
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}
local MissionNum = 0
local ustaw = false
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

-- branie
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))

			if(GetDistanceBetweenCoords(coords, 995.45, -3109.13, -39.91, true) < 100.0) then
				DrawMarker(23, 995.45, -3109.13, -39.91, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 100, 100, 204, 100, false, true, 2, false, false, false, false)
			
		end
	end
end)

--odkladanie
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
                  if namezone ~= 'Delivery' then
			if(GetDistanceBetweenCoords(coords, coordx, coordy, coordz, true) < 100.0) then
				DrawMarker(23, coordx, coordy, coordz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 100, 204, 100, 100, false, true, 2, false, false, false, false)
                              SetNewWaypoint(coordx, coordy)
                      end
      
		end
	end
end)







AddEventHandler('magazynier:hasEnteredMarker', function(zone)


	if zone == 'wezkarton' then

karton = true


end


	if zone == 'odlozkarton' then

namezone = "Delivery"
karton = false
coordx = 0
coordy = 0
coordz = 0
	end





end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("anim@heists@box_carry@")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed)  and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if karton then
				if DoesEntityExist(lPed) then
					SetCurrentPedWeapon(lPed, 0xA2719263, true)
					Citizen.CreateThread(function()
						RequestAnimDict("anim@heists@box_carry@")
						while not HasAnimDictLoaded("anim@heists@box_carry@") do
							Citizen.Wait(10)
						end
                         
						--if not handsup then
if not IsEntityPlayingAnim(lPed, "anim@heists@box_carry@", "walk", 3)  then

							--handsup = true
							TaskPlayAnim(lPed, "anim@heists@box_carry@", "walk", 8.0, -8, -1, 49, 0, 0, 0, 0)
						end   
					end)
				end
			end
		end
		if not karton then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("anim@heists@box_carry@")
					while not HasAnimDictLoaded("anim@heists@box_carry@") do
						Citizen.Wait(10)
					end


if IsEntityPlayingAnim(lPed, "anim@heists@box_carry@", "walk", 3)  then
					
						ClearPedSecondaryTask(lPed)
					end
				end)
			end
		end
	end
end)

Citizen.CreateThread(function()
while true do
Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)
        local obj = 'hei_prop_heist_wooden_box'

	if karton  then 
					
        if box == nil then
			box = CreateObject(GetHashKey("hei_prop_heist_wooden_box"), 0, 0, 0, true, true, true) -- creates object
AttachEntityToEntity(box, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.15, 0.30, -0.35, -95.0, 75.0, -10.0, true, true, false, true, 1, true) -- object is attached to right hand    
else
        end			
            elseif not karton then

            DeleteEntity(box) 
            box = nil
     			
end
		

  end
end) 

function wezkarton()
		Citizen.Wait( 0 )
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped )  then
       if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

karton = true



end
end
end



Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		


			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil
                        local zaplata = 0
				if(GetDistanceBetweenCoords(coords, 995.45, -3109.13, -39.91, true) < 3.0)   then
					isInMarker  = true
					currentZone = 'wezkarton'
                                
                                      losuj()

				end
			
				if(GetDistanceBetweenCoords(coords, coordx, coordy, coordz, true) < 3.0) and namezone ~= 'Delivery' and IsControlJustReleased(0, Keys['E']) then
					isInMarker  = true
					currentZone = 'odlozkarton'
                                          zaplata = math.random(35, 54)                                       
                  TriggerServerEvent('magazynier:odkladanie', (GetPlayerPed(-1)))
                   TriggerEvent('magazynier:freezePlayer', true)
                                         Citizen.Wait(2500)
                                       TriggerEvent('magazynier:freezePlayer', false)
                                       
                                         TriggerServerEvent('magazynier:zaplac', zaplata)
                                     ShowNotification("~g~Zarobiles ~b~$"..zaplata)
                                          ustaw = false
				end
			
			
			


			


			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('magazynier:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				
			end

		--end

	end
end)
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function losuj()

	
if not ustaw then
		MissionNum = math.random(1, 8)
	
		if MissionNum == 1 then  namezone = "Delivery1LS" coordx = 1003.45 coordy = -3093.13 coordz = -39.91
		elseif MissionNum == 2 then  namezone = "Delivery2LS" coordx = 1003.45 coordy = -3110.13 coordz = -39.91
		elseif MissionNum == 3 then  namezone = "Delivery3LS" coordx = 1018.45 coordy = -3093.13 coordz = -39.91
		elseif MissionNum == 4 then  namezone = "Delivery4LS" coordx = 1024.45 coordy = -3091.13 coordz = -39.91
		elseif MissionNum == 5 then  namezone = "Delivery5LS" coordx = 1026.45 coordy = -3103.13 coordz = -39.91
		elseif MissionNum == 6 then  namezone = "Delivery6LS" coordx = 1018.45 coordy = -3106.13 coordz = -39.91
		elseif MissionNum == 7 then  namezone = "Delivery7LS" coordx = 1007.45 coordy = -3098.13 coordz = -39.91
		elseif MissionNum == 8 then  namezone = "Delivery8LS" coordx = 1016.45 coordy = -3099.13 coordz = -39.91

		end
		
                                       
		ustaw = true
	end
	
	
end

RegisterNetEvent('magazynier:freezePlayer')
AddEventHandler('magazynier:freezePlayer', function(freeze)
	FreezeEntityPosition(GetPlayerPed(-1), freeze)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if karton then

			DisableControlAction(2, 25, true) -- Aim

		else
			Citizen.Wait(500)
		end
	end
end)


Citizen.CreateThread(function()
	local blip = AddBlipForCoord(1181.9100, -3113.7482, 6.1753)
	SetBlipSprite (blip, 478)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Magazynier')
	EndTextCommandSetBlipName(blip)
end)