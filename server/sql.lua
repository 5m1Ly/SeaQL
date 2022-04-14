local executebles = {
	['SYNC-INSERT'] = MySQL.Sync.insert,
	['SYNC-SELECT'] = MySQL.Sync.fetchAll,
	['SYNC-UPDATE'] = MySQL.Sync.execute,
	['SYNC-DELETE'] = MySQL.Sync.execute,
	['ASYNC-INSERT'] = MySQL.Async.insert,
	['ASYNC-SELECT'] = MySQL.Async.fetchAll,
	['ASYNC-UPDATE'] = MySQL.Async.execute,
	['ASYNC-DELETE'] = MySQL.Async.execute
}

Sql = {}

-- function to use sql
function Sql:init()

	local tbl = {
        q = "",
        d = {},
        r = function() return end
    }

	setmetatable(tbl, self)
    self.__index = self

	return tbl

end

-- function to prepare the query for execution
---@param query string - query starting with 'SYNC' or 'ASYNC'
function Sql:query(query)

	local retval = false

	-- split the query on space
	local syntax = Utils.split(query, " ")

	-- check if query contains sync or async
    if syntax[1] == "SYNC" or syntax[1] == "ASYNC" then

        -- remove the sync or async then we get an executeble query
        self.q = syntax[1] == "SYNC" and query:gsub("SYNC ", "", 1) or query:gsub("ASYNC ", "", 1)

		-- create query type to get the correct index
        self.f = syntax[1]..'-'..syntax[2]

		retval = true

	else

		print("API:ERROR:SQL | query needs to start with 'SYNC' or 'ASYNC', got '"..query.."' instead!")

	end

	return retval

end

-- function to prepare the query for execution
---@param data table - table containing data to be processed for execution
function Sql:data(data)

	local retval = false

	if data ~= nil and type(data) == "table" then

		-- encode any table within data
		for k, v in pairs(data) do
			if type(v) == 'table' then
				data[k] = Utils.json(v)
			end
		end

        self.d = data

		retval = true

	else

        print("API:ERROR:SQL | data needs to be a table, got '"..type(data).."' instead!")

    end

	return retval

end

-- function to prepare the query for execution
---@param cb function - callback function with the result as parameter
function Sql:exec(cb)

	CreateThread(function()

		-- now execute the query by selecting a function
		local result = executebles[self.f](self.q, self.d)

		-- pass data to callback or return
		cb(result)

	end)

end