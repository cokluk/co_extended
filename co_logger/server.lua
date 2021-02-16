RegisterNetEvent("co_logger:gonder")
AddEventHandler('co_logger:gonder', function(data)

 
    MySQL.Async.fetchAll("INSERT INTO co_logger (`tip`, `veri`, `zaman`) VALUES(@tip, @veri, @zaman);", {["@tip"] = data.tip, ["@veri"] = data.veri, ["@zaman"] = data.tarih}, function()
 
    end)



end)
 
 