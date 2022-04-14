SeaQL = {}

-- meta methods
SeaQL.__index = SeaQL
SeaQL.__tostring = Utils.tostring
SeaQL.__call = function(self, query, params, callback)

	local function createID(str, addition)
		return (('%s_%s'):format(str, addition)):lower()
	end

	-- define reval variable
	local retval
	local key = "SeaQL"

	-- check if the params are set in a table
	assert(type(query) == 'string', "query need to be a string")

	local chuncks = Utils.split(query, ' ')
	local status = {
		sync = chuncks[1],
		exec = chuncks[2]
	}

	key = createID(key, table.concat(chuncks, '_'))

	-- check if the query start with SYNC or ASYNC
	assert(status.sync == 'SYNC' or status.sync == 'ASYNC', "query needs to start with 'SYNC' or 'ASYNC'")

	-- format the query to a usable one
	query = string.gsub(query, status.sync..' ', '')

	-- check if the params are set in a table
	assert(type(params) == 'table', "params need to be placed within a table")

	-- json encode the table params
	for k, v in pairs(params) do
		local vt = type(v)
		if vt == 'table' then
			params[k] = Utils.json(v)
		elseif vt == 'string' or vt == 'number' then
			id = createID(id, v)
		end
	end

	if self.cached[key] ~= nil then

		-- get cached data
		retval = self.cache('get', self.cached[key])

	else

		-- execute the query
		retval = self.query(query, params)

		-- add to cached data
		self.cached[key] = self.cache('add', key, retval)

	end


	-- check if the callback actually is a function
	assert(callback == nil or type(callback) == 'function', "params need to be placed within a table")

	return callback ~= nil and callback(retval) or retval

end

SeaQL = setmetatable({
	info = Info.set("0.0.7"),
	cache = Cache.new(),
	cached = {},
	query = Query.new()
}, SeaQL)