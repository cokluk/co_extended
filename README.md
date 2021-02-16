# co_logger
Fivem log script



##Kullanım :

Client tarafı scriptler için 

```
exports['co_logger']:CoLog({ ['tip'] = 'twitter', ['veri'] = 'Bir post paylaştı.', ['tarih'] = os.date() })

```

Server tarafı scriptler için 

```

TriggerClientEvent('co_logger:client:CoLog', source, { tip = 'twitter', veri = 'Bir post paylaştı.' , tarih = os.date() })
  
  
```
