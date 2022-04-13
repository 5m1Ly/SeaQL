Cache = {}

function Cache.new()

	return setmetatable({
		container = {}
	}, {
		__index = Cache,
		__tostring = Utils.tostring
	})

end

function Cache:createIndex(str)

	local hash = Utils.hash(str)

	return self.container[hash] ~= nil and self:createIndex(hash) or hash

end

function Cache.add(spec, data)

	local str = spec .. (type(data) == 'table' and json.encode(data) or tostring(data))
	local hash = Cache:createIndex(str)

	self.container[hash] = data

	return hash

end

function Cache.get(hashedKey)

	return self.container[hashedKey]

end