Cache = {}

function Cache.newStorage()

	return setmetatable({ container = {} }, {
		__index = Cache,
		__tostring = Utils.tostring
	})

end

