Info = {}

-- methods
--- @param { string } version : should hold the current version of you resource
--- @return { table }
Info.set = function(version)

	local tbl = {
		version = version,
		ox = GetResourceState("oxmysql") == 'started' and true or false
	}

	PerformHttpRequest('https://api.github.com/repos/5m1Ly/SeaQL/releases/latest', function(status, response, headers)

		status = tonumber(status)
		response = json.decode(response)

		local str = ''
		local success = false

		if status >= 200 and status < 300 then
			success = true
		else
			print(('^8ERROR: api GET request to %s failed, recieved http status code %s^0'):format(
				'https://api.github.com/repos/5m1Ly/SeaQL/releases/latest',
				status
			))
		end

		if success then

			if not response.prerelease then

				str = str .. ('\n^5ltst version: ^2%s^5\ncurr version: ^3%s\n'):format(
					response.name,
					tbl.version
				)

				if response.name == tbl.version then
					str = str .. '\n^2SUCC: everything is up to date...'
				else
					str = str .. '\n^8WARN: your version of the SeaQL is not up to date. you can download the latest version from the link below.'
					str = str .. ('\n^3DOWNLOAD: ^5%s'):format(response.html_url)
				end

			else
				str = str .. '\n^3WARN: be aware of the new prerelease update isn\'t needed yet...'
			end

		else
			str = str .. '\n^3WARN: could not verify the version of your resource...'
		end

		str = str .. '\n^2SUCC: resource is up and running...\n\n^9Created by ^8Sm1Ly^9 for servers build with the ^8CitizenFX Framework^9!\n^0'
		print(str)

	end, 'GET')

	return setmetatable(tbl, {
		__index = Info,
		__tostring = Utils.tostring
	})

end