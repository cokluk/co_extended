
ESX = nil

 
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end)

RegisterNetEvent('co_logger:client:CoLog')
AddEventHandler('co_logger:client:CoLog', function(data)
	TriggerServerEvent("co_logger:gonder", data);
end)


 

RegisterNetEvent('co_logger:arac')
AddEventHandler('co_logger:arac', function(data)
	TriggerServerEvent("co_logger:log", data[1]);
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local veh = data[3]
    if veh == nil then veh = "adder" end
    vehiclehash = GetHashKey(veh)
    RequestModel(vehiclehash)
    
    Citizen.CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                ShowNotification("~r~Could not load the vehicle model in time, a crash was prevented.")
                break
            end
        end
        local vehicle = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    end)
end)


 



RegisterNetEvent('co_logger:owner_arac')
AddEventHandler('co_logger:owner_arac', function(data)
 
    TriggerServerEvent("co_logger:log", data[1]);
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local veh = data[3]
    if veh == nil then veh = "adder" end
    vehiclehash = GetHashKey(veh)
    RequestModel(vehiclehash)
    
    Citizen.CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                ShowNotification("~r~Could not load the vehicle model in time, a crash was prevented.")
                break
            end
        end
        local vehicle = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
        local plaka = 'Co'..math.random(11, 99)..math.random(111, 999)
        SetVehicleNumberPlateText(vehicle, plaka)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        local surulen_arac = nil
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local entityWorld = GetOffsetFromEntityInWorldCoords(ply, 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(plyCoords["x"], plyCoords["y"], plyCoords["z"], entityWorld.x, entityWorld.y, entityWorld.z, 10, ply, 0)
        local a, b, c, d, targetVehicle = GetRaycastResult(rayHandle)
        if targetVehicle ~= nil then
            surulen_arac = targetVehicle
            local vehicleProps = ESX.Game.GetVehicleProperties(surulen_arac)
            vehicleProps.plate = plaka
            TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
        end
 
    end)
end)


 

RegisterNetEvent('co_logger:heal')
AddEventHandler('co_logger:heal', function(data, ped)
    TriggerServerEvent("co_logger:log", data);
    SetEntityHealth(PlayerPedId(), data)
end)
