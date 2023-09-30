return {
  "folke/tokyonight.nvim",
	priority = 1000,
  lazy = false,
	config = function ()
		vim.cmd[[colorscheme tokyonight]]

		local tokyonight = require("tokyonight")

		tokyonight.setup({
			style = "storm"
		})
	end
}
