Config = {


    Maven = {
        ["send_time"] = 5000,
        ["send_list_time"] = 15000,
        ["send_playerlist_data"] = true, -- FALSE YAPMAYIN AKSİ TAKDİRDE SERVER CRASH YİYECEKTİR.
        ["send_playercount_data"] = true, -- FALSE YAPMAYIN AKSİ TAKDİRDE SERVER CRASH YİYECEKTİR.
    },

    -- REQUIRE WebSocketServer script https://github.com/Hellslicer/WebSocketServer
    SocketServer = { 
        ["socket"] = true, -- DISABLE CONNECTION WEBSOCKET
        ["debug"] = false,  -- SOCKET DEBUG
        ["ip"] = '0.0.0.0',  -- DONT CHANGE IF U WANT REMOTE CONNECTIONS
        ["port"] = '30999',  -- ALLOW PORT FROM FIREWALL 
        --["auth"] = 'CoMaven', -- GIVE EMPTY IF U WANNA USE NO PASSWORD
    },

    DiscordServerConfig = {

    },
 

}