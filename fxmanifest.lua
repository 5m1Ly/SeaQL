fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Sm1Ly'
description 'A resource for optimizing your server its data traffic'
version '0.0.8'

server_scripts {

	-- load wrapper files
	"server/**/*.lua",

	-- loading testing content
	-- "tests/cache-test.lua",
	-- "tests/query-test.lua",
	"tests/seaql-test.lua",

}