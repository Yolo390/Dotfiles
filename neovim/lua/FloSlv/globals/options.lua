-- ###########
-- # OPTIONS #
-- ###########


local vim = vim

local options = {
  -- DISPLAY
	title = true,
	number = true,
	relativenumber = true,
	wrap = true,
	scrolloff = 10,
	sidescrolloff = 10,
	mouse = 'a',
	cursorline = true,
	colorcolumn = '80',
	numberwidth = 4,
	textwidth = 80,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	fileencoding = 'utf-8',
	signcolumn = 'yes',
	cmdheight = 2,
	showmode = false,
	splitbelow = true,
	splitright = true,
	smartindent = true,
	clipboard = 'unnamedplus',
	laststatus = 2, -- set to 3 for an unique lualine bar.
	termguicolors = true,
	-- SAVING
	backup = false,
	writebackup = false,
	swapfile = false,
	undodir = vim.fn.expand('~') .. '/Flo/Dotfiles/neovim/lua/FloSlv/undodir',
	undofile = true,
	undolevels = 500,
	-- SEARCH
	ignorecase = true,
	smartcase = true,
	-- COMPLETION
	wildignore = '*.o,*.r,*.so,*.sl',
	completeopt = { 'menu', 'menuone', 'noselect' }, -- need it for nvim_cmp
	-- REMOVE BEEP
	visualbell = true,
	errorbells = false
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

-- Set '|' for each tab indentation
vim.cmd [[ set list lcs=tab:\|\ ]]

-- Set 2 spaces as tab for JavaScript files - only for Monopoly project
-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = 'javascript',
-- 	callback = function ()
-- 		vim.opt_local.expandtab = true
-- 		vim.opt_local.shiftwidth = 2
-- 		vim.opt_local.tabstop = 2
-- 		vim.opt_local.softtabstop = 2
-- 	end
-- })

-- Set winbar only for some filetypes.
vim.api.nvim_set_hl(0, 'WinSeparator', { guibg = None })

vim.api.nvim_create_autocmd({ 'FileType', 'BufWinEnter', 'BufFilePost' }, {
	callback = function()
		local winbar_filetype_exclude = {
			'help',
			'dashboard',
			'NvimTree',
			'harpoon',
			'undotree',
			'fugitive',
			'dbui',
			'packer',
			'glowpreview',
			'lsp-installer'
		}

		local excludes = function()
			if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
				vim.opt_local.winbar = nil
				return true
			end

			return false
		end

		if excludes() then return end

		local value = '%=%m' .. vim.fn.expand('%:~:.')

		local status_ok, _ = pcall(
			vim.api.nvim_set_option_value,
			'winbar',
			value,
			{ scope = 'local' }
		)

		if not status_ok then return end
	end
})
