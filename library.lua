SeaQL = {}

-- meta methods
SeaQL = setmetatable({
	info = Info.set("1.0.0"),
	cache = {}
}, {
	__index = SeaQL,
	__tostring = Utils.tostring,
	__call = function(self, query, params, callback, shouldCache)
		local retval
		local function CreateKey(str, ext)
			local retval = ('%s_%s'):format(str, ext)
			return retval:lower()
		end
		local key = CreateKey("seaql_query", query:gsub(" ", "_"))
		key = Utils.hash(key)
		if self.cache[key] ~= nil then
			print"cache call"
			callback(self.cache[key])
		else
			print"database call"
			local sql = Sql:init()
			sql:query(query)
			sql:data(params)
			if not shouldCache then
				sql:exec(callback)
			else
				local function cb(result)
					self.cache[key] = result
					callback(result)
				end
				sql:exec(cb)
			end
		end
		return retval
	end
})

local function testQuery()

	SeaQL('SYNC SELECT t_json FROM testing_table WHERE t_int = ?', { 1 }, function(result)
		print('callback')
	end, true)

end

-- SetTimeout(1000, testQuery)
-- SetTimeout(2000, testQuery)
-- SetTimeout(3000, testQuery)