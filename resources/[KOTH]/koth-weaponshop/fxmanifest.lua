fx_version 'adamant'
game 'gta5'

ui_page 'shop.html'

client_script 'client/client.lua'
server_script {
  '@mysql-async/lib/MySQL.lua',

  'ConfigWeapon.lua',
  'server/server.lua'
}

files {
  "weapons.meta",
  'shop.html',
  'style.css',
  'script.js',
  'content/logo.png',
  'content/class_images/*.jpg',
  'content/class_images/*.png',
  'content/class_images/*.PNG',

  'content/item_images/*.png',
  'content/item_images/*.PNG',
  'content/item_images/*.jpg',
  'jquery.min.js'
}

data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'
