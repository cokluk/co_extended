# co_logger
Fivem log script



##Kullanım :

server.cfg;

add_ace resource.co_logger command.restart allow
add_ace resource.co_logger command.stop allow
add_ace resource.co_logger command.start allow
 

Server tarafı scriptler için mysqle veri gönderir 'co_logger' tablosuna

```
TriggerClientEvent('co_logger:client:CoLog', source, { tip = 'twitter', veri = 'Bir post paylaştı.' , tarih = os.date() })
  
```
