fx_version 'adamant'
game 'gta5'

name 'koth-ui'

ui_page 'dist/index.html'

files {
	'dist/main.js',
  'dist/index.html',
  'img/*',
  'dist/*.png',
}

client_scripts {
	'client.lua'
}

export 'SendUIMessage'
