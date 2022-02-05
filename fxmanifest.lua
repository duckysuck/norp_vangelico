--[[ FX Information ]]--
fx_version		'cerulean'
game			'gta5'
lua54			'yes'

--[[ Resource Information ]]--
name         'norp-vangelico'
author       'Judd#7644'
version      '1.0.0'
repository   'https://github.com/nightowlsrp/norp-vangelico'
description  'Vangelico Robbery'

--[[ Manifest ]]--
dependencies {
	'PolyZone',
	'qtarget'
}

shared_scripts {
    '@es_extended/imports.lua',
    'shared/*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}