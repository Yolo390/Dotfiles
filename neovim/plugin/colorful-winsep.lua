require("colorful-winsep").setup({
	highlight = {
		bg = "#16161E",
		fg = "#1F3442"
	},
	-- timer refresh rate
	interval = 30,
	-- This plugin will not be activated for filetype in the following table.
	no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
	symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
	close_event = function()
		-- Executed after closing the window separator
	end,
	create_event = function()
		-- Executed after creating the window separator
	end
})
