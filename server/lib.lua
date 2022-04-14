SeaQL = {}

-- meta methods
SeaQL.__index = SeaQL
SeaQL.__tostring = Utils.tostring
SeaQL.__call = function(self, query, data, callback)

end

SeaQL = setmetatable({
	info = Info.set("0.0.5"),
	cache = Cache.new()
}, SeaQL)