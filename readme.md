<h1 align="center">
  <img src="https://github.com/5m1Ly/SeaQL/blob/production/img/seaql-banner-trans.png">
</h1>

## About
<strong>With this resource you can use the normal sql syntax, however an extra keyword has been added that must be at the beginning of your query, this is 'SYNC' or 'ASYNC'. based on the given keyword and your underlying sql library, it will then automatically execute the query and return the results synchronously or asynchronously.</strong>

## Supported Libraries
Here you will find all the sql libraries this wrapper supports
- oxmysql
	- version: 2.2.5
	- [repo ->](https://github.com/overextended/oxmysql)

## Example

```lua
-- simply call the SeaQL table
SeaQL(
    -- pass a query to the call
    -- NOTE: it needs to start with 'SYNC' or 'ASYNC'
    'SYNC INSERT INTO testing_table (t_int, t_str, t_json) VALUES (?, ?, ?)',
    -- pass the params like you would with oxmysql
    {
        1,
        '2',
        { name = 1, pos = 2 } -- table params get auto json encoded
    },
    -- add a callback to catch the result
    function(result)
        print('callback')
    end
)

--[[
    when fetching data do the same thing but add a 4th param
    the 4th param is to tell if you want to cache the data
    for example when you fetch user data set it to false
    but when you fetch a list of vehicles set it to true
	when you fetch a list of license plates set it to true
]]
SeaQL('SYNC SELECT t_json FROM testing_table WHERE t_int = ?', { 1 }, function(result)
    print('callback')
end, true)
```