local global_run = function (pattern, command)
	local local_group = vim.api.nvim_create_augroup('local_group', { clear = true })

	vim.api.nvim_create_autocmd('BufWritePost', {
		group = local_group,
		pattern = pattern,
		callback = function ()
			local cwd = vim.fn.getcwd(0)

			-- Create new tmux window, select this new pane and run cargo
			vim.cmd(":silent ! tmux split-window -h \\; select-pane -t 2 \\; send-keys -t Flo:Neovim.2 'cd " .. cwd .. " && " .. command .. "' Enter")

		end
	})
end

vim.api.nvim_create_user_command('AutoRunTerm', function ()
	print'AutoRunTerm starts... !'

	local pattern = vim.fn.input'Pattern: '
	local command = vim.fn.input'Command: '

	global_run(pattern, command)
end, {})
