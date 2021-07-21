game 'gta5'
fx_version 'cerulean'

dependencies {
    'koth-ui'
}

client_script 'server-callback/client.lua'
server_script 'server-callback/server.lua'

client_scripts {
	"src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",
    "src/client/components/*.lua",
    "src/client/menu/elements/*.lua",
    "src/client/menu/items/*.lua",
    "src/client/menu/panels/*.lua",
	"src/client/menu/windows/*.lua",
}

client_scripts {
    'ConfigAdmin.lua',
    'Config_skin.lua',
    'client/AC/cl_ac.lua',
    --'Configzone.lua',
    'client/utils/*.lua',
    --'client/utils/discord.lua',
    'client/zone/*.lua',
    'client/killstreak/*.lua',
    'client/props/*.lua',

    'client/*.lua',
    'client/vip/*.lua',

}

server_script {
    '@mysql-async/lib/MySQL.lua',

    'Configzone.lua',

    'ConfigAdmin.lua',
    'server/*.lua',
    'server/**/*.lua',

}

files {
    'ui/*.html',
    'ui/content/logo.png',
    'ui/content/*.ogg',
    'dist/main.js',
    'assets/img/compass.svg',
    'assets/img/compass.png',
    'assets/img/arrow.png',
    'assets/img/arrow.svg',
    'assets/img/crosshair.png',
    'assets/img/logo.png',
}

exports {
    "gettoken"
}

ui_page 'ui/menu.html'



export 'TriggerServerCallback'
server_export "RegisterServerCallback"
