Query = {}

function Query.new(ox)

	return setmetatable({ ox = ox }, {
		__index = Query,
		__tostring = Utils.tostring,
		__call = function(self, query, params, callback)


		end
	})

end