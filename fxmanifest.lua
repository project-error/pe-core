fx_version 'cerulean'

game 'gta5'

version '1.0.0'

description 'upgraded-octo-couscous'

lua54 'yes'

use_fxv2_oal 'yes'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'config/sv_config.lua',
	'server/shared/*.lua',
	'server/*.lua',
}

client_scripts {
    'client/*.lua'
}

dependencies{
    'spawnmanager',
    'oxmysql',
}