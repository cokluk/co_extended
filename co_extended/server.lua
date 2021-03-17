ESX = nil
CON = false
local socket = nil


if Config.SocketServer.socket == true then
    ExecuteCommand("set websocket_host "..Config.SocketServer.ip)
    ExecuteCommand("set websocket_port "..Config.SocketServer.port)
    --ExecuteCommand("set websocket_authorization "..Config.SocketServer.auth)
    if Config.SocketServer.debug == true then
      ExecuteCommand("set websocket_debug true")
    else
      ExecuteCommand("set websocket_debug false")
    end 
    ExecuteCommand("stop WebSocketServer")
    ExecuteCommand("start WebSocketServer")
    CON = true
end 



AddEventHandler("WebSocketServer:onConnect", function(endpoint)
    print("New WS remote endpoint: " .. endpoint)
	socket = endpoint
	  TriggerEvent("WebSocketServer:send", "sa - ", socket);
end)

 
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end)

Citizen.CreateThread(function()

    while true do
       if Config.Maven.send_playercount_data == true then
        Citizen.Wait(Config.Maven.send_time)
        local oyuncu = GetNumPlayerIndices()
        MySQL.Async.fetchAll("UPDATE co_base SET online='@online'", {["@online"] = oyuncu}, function()   end)
       end
    end

end)

local id_ping = nil
local isim = nil
local hex = nil
local gonderiyorum = false


Citizen.CreateThread(function()

    while true do
    
        Citizen.Wait(15000) 
		if gonderiyorum ~= true then
		id_ping = nil
        isim = nil
        hex = nil
       -- MySQL.Async.fetchAll("TRUNCATE TABLE co_playerlist", {}, function()   end)
        local players = GetPlayers()
        for _, i in ipairs(players) do
          local oyuncu_ismi = GetPlayerName(i) 
          local ping = GetPlayerPing(i) 
          local identifier = GetPlayerIdentifiers(i)[1]
         -- MySQL.Async.fetchAll("INSERT INTO co_playerlist (`uid`, `oyuncu_ismi`, `identifier`, `ping`) VALUES(@uid, @oyuncu_ismi, @identifier, @ping);", {["@uid"] = i, ["@oyuncu_ismi"] = oyuncu_ismi,["@identifier"] = identifier, ["@ping"] = ping}, function()  end)
		  
		  if id_ping ~= nil then 
		      id_ping = id_ping..'['..i..']'..'  ['..ping ..'/ms] \\n'
		  else
		      id_ping = "[" .. i .. "]" .. "  [" ..  ping .. "/ms] \\n"
			  --id_ping = id_ping..'['..i..']'..'  ['..ping ..'/ms] \\n'
		  end
		  
		  if isim ~= nil then
            isim = isim .. " \\n" .. oyuncu_ismi
          else
            isim = oyuncu_ismi
			--isim = isim .. " \\n" .. oyuncu_ismi
          end
		  
		  if hex ~= nil then
            hex =  hex .. " \\n ".. identifier 
          else
            hex =  identifier 
			--hex = hex .. " \\n ".. identifier 
          end
		  
		  TriggerEvent("co_extended:plst_data");
		  
		
		

        end
        end
 
    end

end)



RegisterNetEvent("co_extended:gonder")
AddEventHandler('co_extended:gonder', function(data)
    MySQL.Async.fetchAll("INSERT INTO co_extended (`tip`, `veri`, `zaman`) VALUES(@tip, @veri, @zaman);", {["@tip"] = data.tip, ["@veri"] = data.veri, ["@zaman"] = data.tarih}, function()
 
    end)
end)


RegisterNetEvent("co_extended:log")
AddEventHandler('co_extended:log', function(data)
  print(data)
end)

local iptal = false

AddEventHandler("WebSocketServer:onDisconnect", function(endpoint)
    print("WS remote endpoint " .. endpoint .. " has been disconnected")
	if endpoint == socket then
	   iptal = true
	end
end)

AddEventHandler("WebSocketServer:onMessage", function(message, endpoint)
    
    if CON == true then
    base = Split(message, " ")
    local xPlayer = ESX.GetPlayerFromId(base[2])
    local ped =  GetPlayerPed(base[2])
    
	

    RegisterNetEvent("co_extended:plst_data")
    AddEventHandler('co_extended:plst_data', function()
	  if endpoint ~= nil then 
	    if isim ~= nil and id_ping ~= nil and hex ~= nil  then 
		 
         TriggerEvent("WebSocketServer:send",  '{ "tip": "COPLYLST", "id_ping": "'..id_ping..'", "isim": "'..isim..'", "hex": "'..hex..'"  }', endpoint);
		 print('CO-FIVEM discord botuna veri gönderildi.')
		-- TriggerEvent("WebSocketServer:send", '{ tip:"isim", veri:"'..isim..'" }', endpoint);
		-- TriggerEvent("WebSocketServer:send", '{ tip:"hex", veri:"'..hex..'" }', endpoint);
		end
	  else
	    print('CO-FIVEM DISCORD BOTU SOCKET BAĞLANTISINI SAĞLIYAMADI!')
	  end
    end)
 
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

    if base[1] == "itemver" then

        local item = base[3]
        local miktar = base[4]

        xPlayer = ESX.GetPlayerFromId(base[2])
 
        if xPlayer.canCarryItem(item, miktar) then
            xPlayer.addInventoryItem(item, miktar)
            wait(1)
            ExecuteCommand("restart disc-inventoryhud")
        end

    end

    if base[1] == "meslek" then 
       xPlayer.setJob(base[3], base[4])
    end

    if base[1] == "arac" then 
        TriggerClientEvent("co_extended:arac", tonumber(base[2]) , base)
    end 

    if base[1] == "arac_sahip" then 
        TriggerClientEvent("co_extended:owner_arac", tonumber(base[2]) , base)
    end 

 

    if base[1] == "cfg_grup" then 
        local hex = base[2]
        local grup = base[3]
        ExecuteCommand("add_principal identifier."..hex.." group."..grup)	      
    end 

    if base[1] == "cfg_komut" then 

        local parca = nil
        for i=1, #base do
             if  parca ~= nil then
                parca = parca.." "..base[i]
             else
                parca = base[i]
             end 
        end
        parca = string.gsub(parca, "cfg_komut ", "")
 
        ExecuteCommand(parca)	      
 
    end 
end 

end)


function wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

 

