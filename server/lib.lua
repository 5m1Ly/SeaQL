SeaQL = {}

-- meta methods
SeaQL.__index = SeaQL
SeaQL.__tostring = Utils.tostring

SeaQL = setmetatable({
	info = Info.set("0.0.4"),
	cache = Cache.new()
}, SeaQL)