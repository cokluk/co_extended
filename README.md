# co_extended
Fivem log script



##Kullanım :

server.cfg;
```
add_ace resource.co_logger command allow

```

Server tarafı scriptler için mysqle veri gönderir 'co_logger' tablosuna

```
TriggerClientEvent('co_extended:client:CoLog', source, { tip = 'twitter', veri = 'Bir post paylaştı.' , tarih = os.date() })
  
```
