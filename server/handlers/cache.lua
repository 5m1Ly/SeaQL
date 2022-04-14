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
			local hashed_key = self.hashes[id] ~= nil and id or Utils.hash(id)

			-- set storage index key
			local stored_key = self.hashes[hashed_key] ~= nil and self.hashes[hashed_key] or #self.storage + 1

			-- set the return value
			local retval = self.hashes[hashed_key] ~= nil and self.storage[stored_key].data or hashed_key

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