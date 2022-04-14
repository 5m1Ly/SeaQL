Query = {}

function Query.new()

	return setmetatable({}, {
		__index = Query,
		__tostring = Utils.tostring
	})

end