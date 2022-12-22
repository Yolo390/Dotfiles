vim.g.vimade = {
	fadelevel = 0.4,
	enabletreesitter = 0,
	enablesigns = 1,
	enablefocusfading = 1
}

local custom_fade = vim.api.nvim_create_augroup('custom_fade', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
	group = custom_fade,
	callback = function ()
		-- Reset ColorColumn when enter Telescope popup prompt
		local win_type = vim.fn.win_gettype(0)
		local filetype = vim.bo.filetype

		if (win_type == 'popup' and filetype == 'TelescopePrompt') then
			vim.cmd [[ highlight ColorColumn guibg=#24283b ]]
		end

	end
})

vim.api.nvim_create_autocmd({ 'WinLeave' }, {
	group = custom_fade,
	callback = function ()
		-- Reset ColorColumn when leave Telescope popup prompt
		local win_type = vim.fn.win_gettype(0)
		local filetype = vim.bo.filetype

		if (win_type == 'popup' and filetype == 'TelescopePrompt') then
			vim.cmd [[ highlight ColorColumn guibg=#1f2335 ]]
		end
	end
})
