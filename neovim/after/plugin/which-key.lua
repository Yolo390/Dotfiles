local wk_status, which_key = pcall(require, 'which-key')
if not wk_status then
	return
end

which_key.setup {
	icons = {
		breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
		separator = '', -- symbol used between a key and it's label
		group = '', -- symbol prepended to a group
	},
	window = {
		border = 'single', -- none, single, double, shadow
		position = 'bottom', -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = 'left' -- align columns left, center or right
	},
	show_help = true
}
