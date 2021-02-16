# co_logger
Fivem log script



##Kullanım :

 

Server tarafı scriptler için mysqle veri gönderir 'co_logger' tablosuna

```
TriggerClientEvent('co_logger:client:CoLog', source, { tip = 'twitter', veri = 'Bir post paylaştı.' , tarih = os.date() })
  
```
