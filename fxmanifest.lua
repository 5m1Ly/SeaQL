fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Sm1Ly'
description 'A resource for optimizing your server its data traffic'
version '1.6.0'
stay_up_to_date 'true'

server_scripts {

	-- loading testing content
	".devcontainer/**/*.lua",

	-- load wrapper files
	"server/**/*.lua",

}