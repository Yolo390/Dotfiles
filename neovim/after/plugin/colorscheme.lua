local tokyo_status, tokyonight = pcall(require, 'tokyonight')
if not tokyo_status then
	return
end

tokyonight.setup({
	style = 'moon' -- 'storm', 'night', 'moon' and 'day'
})

vim.cmd [[ colorscheme tokyonight ]]

-- CATPPUCIN THEME
-- latte, frappe, macchiato, mocha
-- vim.g.catppuccin_flavour = 'macchiato' 
-- require'catppuccin'.setup()
-- vim.cmd [[ colorscheme catppuccin ]]
