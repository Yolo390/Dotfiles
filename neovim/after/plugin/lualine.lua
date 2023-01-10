local lualine_status, lualine = pcall(require, 'lualine')
if not lualine_status then
	return
end

lualine.setup({
	options = {
		theme = 'nord', -- nightfly, nord, grubbox_dark, material, tokyonight
		disabled_filetypes = {
			statusline = { 'dashboard', 'NvimTree' },
			winbar = { 'dashboard', 'NvimTree' }
		}
	},
	sections = {
		lualine_a =  { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename' },
		lualine_x = { '' },
		lualine_y = { 'filetype' },
		lualine_z = { 'progress' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {}
	},
	extensions = { 'fugitive', 'fzf', 'quickfix' }
})
