fx_version 'cerulean'
game 'gta5'

author 'Virgil big thug outa the opps block ya know thug'
description 'Lil Calm Fucking People/s cars'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'lang/lang.lua'
}

client_script {
    'client/*.lua',
}

server_script {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua'
}