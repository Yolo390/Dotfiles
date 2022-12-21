-- Thnaks TjDevries for all this stuff !
local ok, plenary_reload = pcall(require, 'plenary.reload')
local reloader = require
if ok then
	reloader = plenary_reload.reload_module
end

-- Print tables
P = function (string)
	print(vim.inspect(string))
	return string
end

-- Debug via notifications
DN = function (value, cm)
	local time = os.date'%H:%M'
	local context_msg = cm or ' '
	local msg = context_msg .. ' ' .. time

	vim.notify(vim.inspect(value), 'info', {
		title = { 'Debug output', msg }
	})

	return value
end

-- To reload a module
RELOAD = function (...)
	return reloader(...)
end

R = function (name)
	RELOAD(name)
	return require(name)
end
