resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'CO-extended'
author 'COKLUK - https://github.com/cokluk'
version 'v1.1.0'

 

client_scripts { 
	'@es_extended/locale.lua',
	'main.lua',
}

server_scripts { 
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

exports {
	'CoLog',
	'comaven',
	'arac_gonder', 
}

shared_script 'config.lua'

dependency 'es_extended'