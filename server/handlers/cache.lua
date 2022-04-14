Cache = {}

function Cache.new()
	return setmetatable({
		clearing = false,
		hashes = {},
		storage = {}
	}, {
		__index = Cache,
		__tostring = Utils.tostring,
		__call = function(self, action, id, data)

			local function hash(str)
				local hash = Utils.hash(str)
				return self.hashes[hash] ~= nil and hash(hash) or hash
			end

			local function organize()

				-- sort the order of the data
				table.sort(self.storage, function(x, y) return x.uses > y.uses end)

				-- sort the hashes
				self.hashes = {}

				for i = 1, #self.storage, 1 do

					local store = self.storage[i]
					self.hashes[store.hash] = i

				end

			end

			-- set hashed index key
			local hashed_key = self.hashes[id] ~= nil and id or hash(id)

			-- set storage index key
			local stored_key = self.hashes[hashed_key] ~= nil and self.hashes[hashed_key] or #self.storage + 1

			-- set the return value
			local retval = self.hashes[hashed_key] ~= nil and self.storage[stored_key] or hashed_key

			-- check type of action
			if action == 'add' then
				self.hashes[hashed_key] = stored_key
				self.storage[stored_key] = { hash = hashed_key, uses = 1, data = data }
			elseif action == 'get' then
				-- register the use for sorting
				self.storage[stored_key].uses = self.storage[stored_key].uses + 1
				-- organize the data structure
				organize()
			end

			if not self.clearing then
				self.clearing = true
				self:clear()
			end

			return retval

		end
	})
end

function Cache:clear()
	for i = #self.storage, 1, -1 do
		if self.storage[i].uses <= 3 then
			self.hashes[self.storage[i].hash] = nil
			self.storage[i] = nil
		else break end
	end
	SetTimeout(600000, function() self:clear() end)
end

-- uncomment to test the caching stage
--[[
	local data
	local cache = Cache.new()

	local hash1 = cache('add', 'storetest1', {})
	data = cache('get', hash1)
	data = cache('get', hash1)
	data = cache('get', hash1)

	local hash2 = cache('add', 'storetest2', {})
	data = cache('get', hash2)
	data = cache('get', hash2)
	data = cache('get', hash2)
	data = cache('get', hash2)
	data = cache('get', hash2)

	local hash3 = cache('add', 'storetest3', { test = 3 })
	data = cache('get', hash3)
	data = cache('get', hash3)
	data = cache('get', hash3)
	data = cache('get', hash3)
	data = cache('get', hash3)
	data = cache('get', hash3)

	local hash4 = cache('add', 'storetest4', {})
	data = cache('get', hash4)
	data = cache('get', hash4)
	data = cache('get', hash4)

	local hash5 = cache('add', 'storetest5', {})

	local hash6 = cache('add', 'storetest6', {})

	local hash7 = cache('add', 'storetest7', {})
	data = cache('get', hash7)
	data = cache('get', hash7)
	data = cache('get', hash7)

	local hash8 = cache('add', 'storetest8', {})

	local hash9 = cache('add', 'storetest9', {})
	data = cache('get', hash9)
	data = cache('get', hash9)

	local hash10 = cache('add', 'storetest10', {})

	local hash11 = cache('add', 'storetest11', {})
	data = cache('get', hash11)
	data = cache('get', hash11)

	cache:clear()

	print(cache)
]]