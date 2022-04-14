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