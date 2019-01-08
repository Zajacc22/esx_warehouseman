ESX 						   = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('magazynier:odkladanie')
AddEventHandler('magazynier:odkladanie', function()
	

  			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 1)
  			TriggerClientEvent("pNotify:SendNotification", source, {
            text = "Odkladanie kartonu",
            type = "error",
            queue = "lmao",
            timeout = 1800,
            layout = "Centerleft"
        	})
 	
end)





RegisterServerEvent('magazynier:zaplac') 
AddEventHandler('magazynier:zaplac', function(zaplata)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	xPlayer.addMoney(zaplata)
end)