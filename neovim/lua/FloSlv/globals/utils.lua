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
	return require'plenary.reload'.reload_module(...)
end

R = function (name)
	RELOAD(name)
	return require(name)
end
