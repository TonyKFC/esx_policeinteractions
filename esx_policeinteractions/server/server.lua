ESX = exports["es_extended"]:getSharedObject()  

RegisterServerEvent('esx_policeinteractions:handcufftargetid')
AddEventHandler('esx_policeinteractions:handcufftargetid', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_policeinteractions:targetcloseplayer', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_policeinteractions:player', _source)

 
end)


RegisterServerEvent('esx_policeinteractions:allunlockcuff')
AddEventHandler('esx_policeinteractions:allunlockcuff', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_policeinteractions:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_policeinteractions:douncuffing', _source)
    xPlayer.addInventoryItem('handcuff', handcuff)

end)

RegisterServerEvent('esx_policeinteractions:feetunlockcuff')
AddEventHandler('esx_policeinteractions:feetunlockcuff', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_policeinteractions:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_policeinteractions:douncuffing', _source)
    xPlayer.addInventoryItem('footcuff', handcuff)

end)

RegisterServerEvent('esx_policeinteractions:requestarrest')
AddEventHandler('esx_policeinteractions:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_policeinteractions:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_policeinteractions:doarrested', _source)

 
end)


RegisterServerEvent("esx_policeinteractions:removehandcuff")
AddEventHandler("esx_policeinteractions:removehandcuff", function(Target)
    _source = source

	local xPlayer = ESX.GetPlayerFromId(source)
    local handcuff = xPlayer.getInventoryItem('handcuff').count
    if  handcuff >= 1 then  

	    xPlayer.removeInventoryItem('handcuff', handcuff)
        TriggerClientEvent('esx_policeinteractions:re', _source)
    else
        TriggerClientEvent('esx_policeinteractions:uncuff', _source)

    end
end)

RegisterServerEvent("esx_policeinteractions:removefeetcuff")
AddEventHandler("esx_policeinteractions:removefeetcuff", function(Target)
    _source = source

	local xPlayer = ESX.GetPlayerFromId(source)
    local feetcuff = xPlayer.getInventoryItem('footcuff').count
    if  feetcuff >= 1 then  

	    xPlayer.removeInventoryItem('footcuff', feetcuff)
        TriggerClientEvent('esx_policeinteractions:ft', _source)
    else
        TriggerClientEvent('esx_policeinteractions:uncufffeet', _source)

    end
end)


RegisterServerEvent('esx_policeinteractions:attachPlayer',function(who,anim)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	TriggerClientEvent('esx_policeinteractions:doAnimation',_source,anim)
	TriggerClientEvent('esx_policeinteractions:getDragged',who, _source, anim)
end)
  

RegisterNetEvent('esx_policeinteractions:putInVehicle')
AddEventHandler('esx_policeinteractions:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policeinteractions:putInVehicle', target)
	end
end)

RegisterNetEvent('esx_policeinteractions:OutVehicle')
AddEventHandler('esx_policeinteractions:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policeinteractions:OutVehicle', target)
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Dragging Out Of Vehicle!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_policeinteractions:sech')
AddEventHandler('esx_policeinteractions:sech', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policeinteractions:sech', target)
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Dragging Out Of Vehicle!'):format(xPlayer.source))
	end
end)