local global_run = function (output_bufnr, pattern, command)
	local local_group = vim.api.nvim_create_augroup('local_group', { clear = true })

	vim.api.nvim_create_autocmd('BufWritePost', {
		group = local_group,
		pattern = pattern,
		callback = function ()
			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {
				'Output of: main.rs'
			})

			vim.fn.jobstart(command, {
				stdout_buffered = true, -- send one line at a time
				on_stdout = function (_, data)
					if (data) then
						vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
					end
				end,
				on_stderr = function (_, data)
					if (data) then
						vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
					end
				end
			})
		end
	})
end

vim.api.nvim_create_user_command('AutoRun', function ()
	print'AutoRun starts... !'

	local bufnr = vim.fn.input'Bufnr: '
	local pattern = vim.fn.input'Pattern: '
	local command = vim.split(vim.fn.input'Command: ', ' ')

	global_run(tonumber(bufnr), pattern, command)
end, {})
