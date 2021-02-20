ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(5000)
        local oyuncu = GetNumPlayerIndices()
        MySQL.Async.fetchAll("UPDATE co_base SET online='@online'", {["@online"] = oyuncu}, function()   end)

    end

end)



RegisterNetEvent("co_logger:gonder")
AddEventHandler('co_logger:gonder', function(data)

 
    MySQL.Async.fetchAll("INSERT INTO co_logger (`tip`, `veri`, `zaman`) VALUES(@tip, @veri, @zaman);", {["@tip"] = data.tip, ["@veri"] = data.veri, ["@zaman"] = data.tarih}, function()
 
    end)
end)
 
 
AddEventHandler("WebSocketServer:onConnect", function(endpoint)
    print("New WS remote endpoint: " .. endpoint)
end)

AddEventHandler("WebSocketServer:onMessage", function(message, endpoint)

    base = Split(message, " ")
    local xPlayer = ESX.GetPlayerFromId(base[2])
 
    if base[1] == "revive" then 
           TriggerClientEvent('esx_ambulancejob:revive', tonumber(base[2]))
    end 

    if base[1] == "kick" then 
        xPlayer = ESX.GetPlayerFromId(base[2])
        if xPlayer ~= nil then
          xPlayer.kick(base[3])
          TriggerEvent("WebSocketServer:send", base[3].." Kullanıcı atıldı.");
        else 
            TriggerEvent("WebSocketServer:send", "Kullanıcı bulunmadı.");
        end
    end 

    print("komut başarılı => "..message..ped)
 
end)


function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

 
