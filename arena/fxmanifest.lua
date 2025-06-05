fx_version 'bodacious'
game 'gta5'

ui_page 'web/build/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'shared-side/config_client.lua',
	'client-side/*.lua',
	'mods/**/client.lua'
}

server_scripts {
        '@vrp/lib/utils.lua',
        'server-side/server.lua',
        'mods/**/server.lua'
}

shared_scripts {
    '@vrp/lib/utils.lua',
	'shared-side/arenas.lua',
}


files {
	'web/build/*',
	'web/build/**/*',
	'audios/*'
}
                                          