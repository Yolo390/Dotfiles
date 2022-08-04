vim.g.Illuminate_ftblacklist = {
	'NvimTree',
	'harpoon',
	'packer',
	'dbui',
	'fugitive',
	'undotree',
	'dashboard',
	'glowpreview'
}

-- Add underline to selected group
local group = vim.api.nvim_create_augroup('Underline', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	command = 'highlight illuminatedWord cterm=underline gui=underline',
	group = group
})
