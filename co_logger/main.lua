print("calisiyor")

RegisterNetEvent('co_logger:client:CoLog')
AddEventHandler('co_logger:client:CoLog', function(data)
	TriggerServerEvent("co_logger:gonder", data);
 

end)

 