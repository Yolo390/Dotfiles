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

-- Automatically source and re-sync packer when you save `packer.lua`.
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

		-- Dashboard
		use({
			"glepnir/dashboard-nvim",
			event = "VimEnter",
			config = function()
				local ts_builtin_status, ts_builtin = pcall(require, "telescope.builtin")
				if not ts_builtin_status then
					return
				end

				local ts_themes_status, ts_themes = pcall(require, "telescope.themes")
				if not ts_themes_status then
					return
				end

				-- If you want to display Neovim loaded packages in footer instead of header.
				-- local plugins_count =
				-- 	vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))

				require("dashboard").setup({
					theme = "hyper",
					config = {
						header = {
							" ",
							" ",
							" ",
							" ____ ____ ____ ____ ____ ____ ",
							"||N |||E |||O |||V |||I |||M ||",
							"||__|||__|||__|||__|||__|||__||",
							"|/__\\|/__\\|/__\\|/__\\|/__\\|/__\\|",
							" ",
							" ",
							" ",
						},
						week_header = { enable = false },
						shortcut = {
							{ desc = "✅ Packer", group = "@property", action = "PackerSync", key = "p" },
							{ desc = "✅ Mason", group = "@property", action = "Mason", key = "m" },
							{ desc = "✅ TS", group = "@property", action = "TSUpdate", key = "t" },
							{
								desc = "🔍 Files",
								group = "Label",
								action = function()
									ts_builtin.find_files({
										cwd = vim.fn.substitute(vim.fn.getcwd(), "/home/floslv", "~", ""),
										prompt_title = "🌞 "
											.. vim.fn.substitute(vim.fn.getcwd(), "/home/floslv", "~", ""),
										hidden = true,
									})
								end,
								key = "f",
							},
							{
								desc = "💻 Dev",
								group = "Label",
								action = function()
									ts_builtin.find_files({
										cwd = "~/Flo/Dev",
										prompt_title = "💻 Dev",
										hidden = true,
									})
								end,
								key = "d",
							},
							{
								desc = "🔧 Dot",
								group = "Label",
								action = function()
									if
										pcall(function()
											ts_builtin.git_files(ts_themes.get_dropdown({
												cwd = "~/Flo/Dotfiles",
												prompt_title = " Dotfiles",
												hidden = true,
												previewer = false,
											}))
										end)
									then
									else
										ts_builtin.find_files(ts_themes.get_dropdown({
											prompt_title = " Dotfiles",
											cwd = "~/Flo/Dotfiles",
											previewer = false,
										}))
									end
								end,
								key = "o",
							},
						},
						packages = { enable = true },
						project = { limit = 0, action = "Telescope find_files cwd=" },
						mru = { limit = 0 },
						footer = {
							" ",
							" ",
							" ",
							"Bienvenue Flo !",
							" ",
							os.date("%A %d/%m/%Y %H:%M"),
							-- " ",
							-- "Neovim plugins: " .. plugins_count, -- display neovim loaded packages.
						},
					},
				})
			end,
			require = { { "nvim-tree/nvim-web-devicons" } },
		})

		-- Display
		use("TaDaa/vimade")
		use("lukas-reineke/indent-blankline.nvim")

		-- nvim-colorizer => color highlighter
		use("NvChad/nvim-colorizer.lua")

		-- nvim-web-devicons => icons
		use("nvim-tree/nvim-web-devicons")

		-- nvim-tree => file explorer
		use({
			"nvim-tree/nvim-tree.lua",
			requires = { "nvim-tree/nvim-web-devicons" },
			tag = "nightly",
		})

		-- todo-comments => highlight and search for todo comments like TODO, HACK, BUG in the code base.
		use({
			"folke/todo-comments.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- which-key => easy way to find your <leader> mapping
		use("folke/which-key.nvim")

		-- lualine => status bar (bottom)
		use("nvim-lualine/lualine.nvim")

		-- winbar => window bar (top)
		use("fgheng/winbar.nvim")

		-- colorful-winsep => window color separation
		-- use("nvim-zh/colorful-winsep.nvim")
		-- Have an issue with Lualine and performance...
		-- see https://github.com/nvim-zh/colorful-winsep.nvim/issues/26

		-- wilder => wildmenu
		use({ "gelguy/wilder.nvim", requires = { "romgrk/fzy-lua-native" } })

		-- bqf => better quickfix list
		-- use({ "kevinhwang91/nvim-bqf" })

		-- trouble => a pretty list for showing diagnostics, references, telescope results, quickfix and location lists.
		use({
			"folke/trouble.nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
		})

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

		-- color in nvim-cmp for Tailwind CSS.
		use("roobert/tailwindcss-colorizer-cmp.nvim")

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

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
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
