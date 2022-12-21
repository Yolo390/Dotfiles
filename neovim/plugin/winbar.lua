-- Workaround to avoid error 'not enough room' with wilder.
require'winbar'.setup({
    enabled = true,
	icons = {
		file_icon_default = '',
		seperator = '/',
		editor_state = '●',
		lock_icon = '',
	},
     exclude_filetype = {
		'',
		'dashboard',
		'dbui',
		'fugitive',
		'glowpreview',
		'harpoon',
        'help',
        'NvimTree',
		'packer',
		'startify',
		'undotree'
	}
})
