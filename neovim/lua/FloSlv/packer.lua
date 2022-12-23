-- Auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- Automatically source and re-sync packer whenever you save.
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerSync",
	group = packer_group,
	pattern = vim.fn.expand("packer.lua"),
})

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

local packer_util_ok, packer_util = pcall(require, "packer.util")
if not packer_util_ok then
	return
end

-- Plugins
packer.startup({
	function(use)
		-- Packer manager
		use("wbthomason/packer.nvim")

		-- Colorscheme
		use("folke/tokyonight.nvim")
		-- use { 'catppuccin/nvim', as = 'catppuccin' }

		-- Display
		use("glepnir/dashboard-nvim")
		use("kyazdani42/nvim-web-devicons")
		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			tag = "nightly",
		})
		use("TaDaa/vimade")
		use("norcalli/nvim-colorizer.lua")
		use("lukas-reineke/indent-blankline.nvim")

		-- which-key => easy way to find your <leader> mapping
		use("folke/which-key.nvim")

		-- lualine => status bar (bottom)
		use("nvim-lualine/lualine.nvim")

		-- winbar => window bar (top)
		use("fgheng/winbar.nvim")

		-- colorful-winsep => window color separation
		-- use 'nvim-zh/colorful-winsep.nvim'
		-- Have an issue with Lualine and performance...
		-- see https://github.com/nvim-zh/colorful-winsep.nvim/issues/26

		-- wilder => wildmenu
		use({ "gelguy/wilder.nvim", requires = { "romgrk/fzy-lua-native" } })

		-- telescope => fuzzy finder
		use({
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x", -- tag = '0.1.0',
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- telescope-fzf-native => Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
			-- run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
			cond = vim.fn.executable("make") == 1,
		})

		-- telescope => more Telescope plugins integration.
		use("benfowler/telescope-luasnip.nvim")
		use("jvgrootveld/telescope-zoxide")
		use("cljoly/telescope-repo.nvim")
		use("AckslD/nvim-neoclip.lua")
		use("nvim-telescope/telescope-symbols.nvim")
		use("sudormrfbin/cheatsheet.nvim")
		use("nvim-telescope/telescope-packer.nvim")
		use({
			"dhruvmanila/telescope-bookmarks.nvim",
			-- Uncomment if the selected browser is Firefox or buku
			requires = {
				"kkharji/sqlite.lua",
			},
		})

		-- harpoon => navigate between files
		use({ "ThePrimeagen/harpoon", requires = { "nvim-lua/plenary.nvim" } })

		-- nvim-treesitter => highlighting and indenting code
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				pcall(require("nvim-treesitter.install").update({ with_sync = true }))
				-- local ts_update = pcall(require("nvim-treesitter.install").update({ with_sync = true }))
				-- ts_update() -- make sure parsers are automatically updated whenever nvim-treesitter is installed/updated
			end,
		})
		use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
		-- use("p00f/nvim-ts-rainbow")

		-- nvim-lspconfig => integration for LSP (Language Server Protocol)
		-- mason => installing and managing LSP servers, linters and formatters
		-- mason-lspconfig => fill the gap between nvim-lspconfig and mason
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",

				-- Display useful loading status updates for LSP
				"j-hui/fidget.nvim",

				-- Additional lua configuration, makes nvim stuff amazing
				"folke/neodev.nvim",

				"RRethy/vim-illuminate",
			},
		})

		-- null-ls => formatting and linting
		-- mason-null-ls => fill the gap between null-ls and mason
		use("jose-elias-alvarez/null-ls.nvim")
		use("jayp0521/mason-null-ls.nvim")

		-- nvim-cmp => autocompletion
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp", -- integration for nvim-lspconfig
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-cmdline",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip", -- integration for luasnip
				"rafamadriz/friendly-snippets", -- collection of snippets
				"onsails/lspkind.nvim",
			},
		})

		-- Databases
		use("tpope/vim-dadbod")
		use("kristijanhusak/vim-dadbod-ui")

		-- Comment => easy way to comment code
		use("numToStr/Comment.nvim")

		-- nvim-notify => notifications
		use("rcarriga/nvim-notify")

		-- GIT
		use("lewis6991/gitsigns.nvim")

		-- glow => markdown
		use("ellisonleao/glow.nvim")

		-- Documentation
		-- check if it's still relevant since we have neodev for lsp !
		use("nanotee/luv-vimdocs")
		use("milisims/nvim-luaref")

		-- rust-tools => toolbox for Rust
		use("simrat39/rust-tools.nvim")

		-- nvim-dap => debug
		use("mfussenegger/nvim-dap")

		-- Autoclosing, autorename and autopair
		use("tpope/vim-surround") -- easy way to surround word or text
		use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose and autorename html tag with treesitter
		use("windwp/nvim-autopairs") -- autopair parents, brackets, quotes, etc...

		-- taboo => tab manager
		use("gcmt/taboo.vim")

		-- vim-signature => easy way to manage marks
		use("kshenoy/vim-signature")

		-- vim-tmux-navigator => integration for Tmux !
		use("christoomey/vim-tmux-navigator")

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return packer_util.float({ border = "single" })
			end,
		},
	},
})
