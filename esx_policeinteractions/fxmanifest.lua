fx_version 'bodacious'
lua54 'yes'
game  'gta5'

author 'TonyKFC.interactions'

version '1.0.0'
 
client_scripts{
	
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/*.lua'
 
}

server_scripts{
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/*.lua'

}


shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua', 
  }
dependencies {
	 
	'oxmysql',
	'ox_lib', 
}