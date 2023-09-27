local winbar_status, winbar = pcall(require, 'winbar')
if not winbar_status then
	return
end

winbar.setup({
    enabled = true,
	icons = {
		file_icon_default = '',
		seperator = '/',
		editor_state = '●',
		lock_icon = '',
	},
     exclude_filetype = {
		'', -- Workaround to avoid error 'not enough room' with wilder plugin !
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
