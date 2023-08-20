 
ESX = exports["es_extended"]:getSharedObject()  
local ox_inventory = exports.ox_inventory 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)
local isEscorting = false 
local isAttached = false

local Tonyhandecuff = false
local Tonyfeetcuff = false
local cuffObj
local dragnotify = nil
local  sechde = false

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end
function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end
function ShowUI(message, icon)
    if icon == 0 then
        lib.showTextUI(message)
    else
        lib.showTextUI(message, {
            icon = icon
        })
    end
end

function HideUI()
    lib.hideTextUI()
end

local policeinteractions = {
  
    {
        name = 'esx_policeinteractions:handcuff',
        event = 'esx_policeinteractions:handcuff',
        icon = 'fa-solid fa-handcuffs',
        groups = {["police"] = 0},

        label = TranslateCap('HandCuff_uncuff'), 
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity, distance, coords, name, bone)
        end
    },

	{
        name = 'esx_policeinteractions:feetcuff',
        event = 'esx_policeinteractions:feetcuff',
        icon = 'fa-solid fa-handcuffs',
        groups = {["police"] = 0},

		label = TranslateCap('FeetCuff_uncuff'), 
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity, distance, coords, name, bone)
        end
    },
	{
        name = 'esx_policeinteractions:escort',
        event = 'esx_policeinteractions:escort',
        icon = 'fa-solid fa-hand',
        groups = {["police"] = 0},

		label = TranslateCap('Darg'), 
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity, distance, coords, name, bone)
        end
    },
	{
        name = 'esx_policeinteractions:sechce',
        event = 'esx_policeinteractions:sechce',
        icon = 'fa-solid fa-magnifying-glass',
        groups = {["police"] = 0},

		label = TranslateCap('Sechce'), 
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity, distance, coords, name, bone)
        end
    },
	{
        name = 'esx_policeinteractions:putInVehiclece',
        event = 'esx_policeinteractions:putInVehiclece',
        icon = 'fa-regular fa-square-plus', 
        groups = {["police"] = 0},

		label = TranslateCap('PutInVehiclece'), 
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity, distance, coords, name, bone)
        end
    } 

}

local policecarinteractions = {
	
 
	{
        name = 'esx_policeinteractions:OutVehiclece',
        event = 'esx_policeinteractions:OutVehiclece',
        icon = 'fa-regular fa-square-minus',
        groups = {["police"] = 0},

		label = TranslateCap('OutVehiclece'), 
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity, distance, coords, name, bone)
        end
    }

}

exports.ox_target:addGlobalPlayer(policeinteractions)

exports.ox_target:addGlobalVehicle(policecarinteractions)


RegisterNetEvent('esx_policeinteractions:handcuff')
AddEventHandler('esx_policeinteractions:handcuff', function()


	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(GetPlayerPed(-1))
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(GetPlayerPed(-1))
	local target_id = GetPlayerServerId(target)
	if distance <= 2.0   then
 		TriggerServerEvent('esx_policeinteractions:removehandcuff')
	else 
 
   
	end
 


end)	

RegisterNetEvent('esx_policeinteractions:re')
AddEventHandler('esx_policeinteractions:re', function()
	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(GetPlayerPed(-1))
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(GetPlayerPed(-1))
	local target_id = GetPlayerServerId(target)
	TriggerServerEvent('esx_policeinteractions:handcufftargetid', target_id, playerheading, playerCoords, playerlocation)

end	)

 

RegisterNetEvent('esx_policeinteractions:targetcloseplayer')
AddEventHandler('esx_policeinteractions:targetcloseplayer', function(playerheading, playercoords, playerlocation)
 
 

	playerPed = GetPlayerPed(-1)
     SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)  

	local coords = GetEntityCoords(playerPed)
    local hash = `p_cs_cuffs_02_s`
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end

	cuffObj = CreateObject(hash,coords,true,false)
	AttachEntityToEntity(cuffObj, playerPed, GetPedBoneIndex(PlayerPedId(), 60309), -0.058, 0.005, 0.090, 290.0, 95.0, 120.0, true, false, false, false, 0, true)
  

 	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	Tonyhandecuff = true
	LoadAnimDict('anim@move_m@prisoner_cuffed')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    DisplayRadar(false)
    SetEnableHandcuffs(playerPed, true)
    DisablePlayerFiring(playerPed, true)
    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) 
    SetPedCanPlayGestureAnims(playerPed, false)
 
 
   
end)

 
RegisterNetEvent('esx_policeinteractions:player')
AddEventHandler('esx_policeinteractions:player', function()
 	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 




RegisterNetEvent('esx_policeinteractions:uncuff')
AddEventHandler('esx_policeinteractions:uncuff', function()
	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(GetPlayerPed(-1))
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(GetPlayerPed(-1))
	local target_id = GetPlayerServerId(target)
	TriggerServerEvent('esx_policeinteractions:allunlockcuff', target_id, playerheading, playerCoords, playerlocation)
end)

RegisterNetEvent('esx_policeinteractions:uncufffeet')
AddEventHandler('esx_policeinteractions:uncufffeet', function()
	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(GetPlayerPed(-1))
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(GetPlayerPed(-1))
	local target_id = GetPlayerServerId(target)
	TriggerServerEvent('esx_policeinteractions:feetunlockcuff', target_id, playerheading, playerCoords, playerlocation)
end)





RegisterNetEvent('esx_policeinteractions:douncuffing')
AddEventHandler('esx_policeinteractions:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_policeinteractions:getuncuffed')
AddEventHandler('esx_policeinteractions:getuncuffed', function(playerheading, playercoords, playerlocation)

   
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	Tonyfeetcuff = false
	Tonyhandecuff = false
 
	ClearPedTasks(GetPlayerPed(-1))
    DisplayRadar(true)
	
    ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)

 
		DeleteEntity(cuffObj)


end)

RegisterNetEvent('esx_policeinteractions:feetcuff')
AddEventHandler('esx_policeinteractions:feetcuff', function()


	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(GetPlayerPed(-1))
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(GetPlayerPed(-1))
	local target_id = GetPlayerServerId(target)
	if distance <= 2.0 then
		TriggerServerEvent('esx_policeinteractions:removefeetcuff')
	else
 
     
	end


end)
RegisterNetEvent('esx_policeinteractions:ft')
AddEventHandler('esx_policeinteractions:ft', function()
	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(GetPlayerPed(-1))
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(GetPlayerPed(-1))
	local target_id = GetPlayerServerId(target)
	TriggerServerEvent('esx_policeinteractions:requestarrest', target_id, playerheading, playerCoords, playerlocation)


end)	
 
RegisterNetEvent('esx_policeinteractions:getarrested')
AddEventHandler('esx_policeinteractions:getarrested', function(playerheading, playercoords, playerlocation)
 
 

	playerPed = GetPlayerPed(-1)
 
     SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)  
 	AttachEntityToEntity(obj2, playerPed, GetPedBoneIndex(playerPed,  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	Tonyfeetcuff = true
	 
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    DisplayRadar(false)
    SetEnableHandcuffs(playerPed, true)
    DisablePlayerFiring(playerPed, true)
    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)  
    SetPedCanPlayGestureAnims(playerPed, false)

	local coords = GetEntityCoords(PlayerPedId())
    local hash = `p_cs_cuffs_02_s`
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
  
        cuffObj = CreateObject(hash,coords,true,false)
        AttachEntityToEntity(cuffObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true) 
  

end)

 
RegisterNetEvent('esx_policeinteractions:doarrested')
AddEventHandler('esx_policeinteractions:doarrested', function()
 	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 
 
 
CreateThread(function()
 	while true do
		local Sleep = 0   
		if isEscorting  and not dragnotify    then
			ShowUI(_U('StopDargging'), 'hand')
		 
			if IsControlJustPressed(0, 183) then
				dragnotify = true
				lib.hideTextUI()
 				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					dragnotify = true

					TriggerServerEvent('esx_policeinteractions:attachPlayer',GetPlayerServerId(closestPlayer),'escort')
				end
              
			end
		elseif dragnotify then
			Wait(1000)
			lib.hideTextUI()
			dragnotify = nil
		 
      
        end

	 
		 



	Wait(Sleep)
	end
end)


CreateThread(function()
	local DisableControlAction = DisableControlAction
	local IsEntityPlayingAnim = IsEntityPlayingAnim
	while true do
		local Sleep = 1000

		if Tonyfeetcuff then
			Sleep = 0
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
	 

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

	 

				DisableControlAction(0, 32, true) -- W
				DisableControlAction(0, 34, true) -- A
				DisableControlAction(0, 31, true) -- S 
				DisableControlAction(0, 30, true) -- D 
	 


			if IsEntityPlayingAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 3) ~= 1 then
                playerPed = GetPlayerPed(-1)

				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					RemoveAnimDict('mp_arresting')
 
				end)
			end
		 
		 
		end 

		if Tonyhandecuff then
			Sleep = 0
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
	 

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
 


			if IsEntityPlayingAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 3) ~= 1 then
                playerPed = GetPlayerPed(-1)

				ESX.Streaming.RequestAnimDict('anim@move_m@prisoner_cuffed', function()
					TaskPlayAnim(ESX.PlayerData.ped, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					RemoveAnimDict('anim@move_m@prisoner_cuffed')
 
				end)
			end
		 
		 
		end 

	Wait(Sleep)
	end
end)

 


 

RegisterNetEvent('esx_policeinteractions:escort')
AddEventHandler('esx_policeinteractions:escort', function()
 --RegisterCommand('escort',function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('esx_policeinteractions:attachPlayer',GetPlayerServerId(closestPlayer),'escort')
    end
end)

RegisterNetEvent('esx_policeinteractions:doAnimation',function(anim)
    if anim == 'escort' then
        if isEscorting then
            ClearPedTasks(PlayerPedId())
            isEscorting = false
        else
            isEscorting = true
            LoadAnimDict('amb@world_human_drinking@coffee@male@base')
            if IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base', 3) ~= 1 then
                TaskPlayAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base' ,8.0, -8, -1, 51, 0, false, false, false)
            end
        end
  
    end
end)
RegisterNetEvent('esx_policeinteractions:getDragged',function(entToAttach,anim)
    local curAttachedPed = GetPlayerPed(GetPlayerFromServerId(entToAttach))
   
    if anim == 'escort' then
        if not isAttached then
             ClearPedTasks(PlayerPedId())
             isAttached = true
            loadanimdict('mp_arresting')
            LoadAnimDict('move_m@generic_variations@walk')
            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            AttachEntityToEntity(PlayerPedId(),curAttachedPed, 1816,0.25, 0.49, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            amBeingEscorted(curAttachedPed)
        else
             isAttached = false
             DetachEntity(PlayerPedId())
            ClearPedTasks(PlayerPedId())
        end
   
    
    end
end)

function amBeingEscorted(entID)
    CreateThread(function()
        while isAttached do
            Wait(0)
            local speed = GetEntitySpeed(entID)
            if speed > 1 then
                if IsEntityPlayingAnim(PlayerPedId(), 'move_m@generic_variations@walk', 'walk_b', 3) ~= 1 then
                    TaskPlayAnim(PlayerPedId(), 'move_m@generic_variations@walk','walk_b' ,8.0, -8, -1, 0, 0, false, false, false)
                end
            end
        end
    end)

end

RegisterNetEvent('esx_policeinteractions:sechce')
AddEventHandler('esx_policeinteractions:sechce', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if lib.progressBar({
		duration = 5000,
		label = 'searching',
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
		},
		anim = {
			dict = 'anim@gangops@facility@servers@bodysearch@',
			clip = 'player_search'
		},
	 
	}) then 

		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			OpenBodySearchMenu(closestPlayer)
		 
			TriggerServerEvent('esx_policeinteractions:sech', GetPlayerServerId(closestPlayer))
		 
		   end

	 else 

	 end



 
  
end)


RegisterNetEvent('esx_policeinteractions:sech')
AddEventHandler('esx_policeinteractions:sech', function()
 
 
	local playerPed = PlayerPedId(-1)
	sechde = true
	loadanimdict('missminuteman_1ig_2')
	TaskPlayAnim(GetPlayerPed(-1), 'missminuteman_1ig_2', 'handsup_base', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
 
	 

end)
function OpenBodySearchMenu(player)
	exports.ox_inventory:openInventory('player', GetPlayerServerId(player))
 end
 

 RegisterNetEvent('esx_policeinteractions:putInVehiclece')
 AddEventHandler('esx_policeinteractions:putInVehiclece', function()
   local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
   if closestPlayer ~= -1 and closestDistance <= 3.0 then

	TriggerServerEvent('esx_policeinteractions:putInVehicle', GetPlayerServerId(closestPlayer))
  end
 end)


 RegisterNetEvent('esx_policeinteractions:putInVehicle')
AddEventHandler('esx_policeinteractions:putInVehicle', function()
	local playerPed = PlayerPedId()

	
	local vehicle, distance = ESX.Game.GetClosestVehicle()

	if vehicle and distance < 5 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i = maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
		end
	end
end)


RegisterNetEvent('esx_policeinteractions:OutVehiclece')
AddEventHandler('esx_policeinteractions:OutVehiclece', function()
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 3.0 then

   TriggerServerEvent('esx_policeinteractions:OutVehicle', GetPlayerServerId(closestPlayer))
  end
end)


RegisterNetEvent('esx_policeinteractions:OutVehicle')
AddEventHandler('esx_policeinteractions:OutVehicle', function()
	local GetVehiclePedIsIn = GetVehiclePedIsIn
	local IsPedSittingInAnyVehicle = IsPedSittingInAnyVehicle
	local TaskLeaveVehicle = TaskLeaveVehicle
	if IsPedSittingInAnyVehicle(ESX.PlayerData.ped) then
		local vehicle = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
		TaskLeaveVehicle(ESX.PlayerData.ped, vehicle, 64)
	end
end)