-- Automatically source and re-sync packer whenever you save.
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | PackerSync',
	group = packer_group,
	pattern = vim.fn.expand 'packer.lua'
})

-- Plugins
return require'packer'.startup({
	function(use)
		-- Packer manager
		use 'wbthomason/packer.nvim'

		-- Colorscheme
		use 'folke/tokyonight.nvim'
		-- use { 'catppuccin/nvim', as = 'catppuccin' }

		-- Lualine => status bar
		use 'nvim-lualine/lualine.nvim'

		-- Display
		use 'glepnir/dashboard-nvim'
		use 'kyazdani42/nvim-web-devicons'
		use {
			'kyazdani42/nvim-tree.lua',
			requires = { 'kyazdani42/nvim-web-devicons' },
			tag = 'nightly'
		}
		use 'TaDaa/vimade'

		use 'fgheng/winbar.nvim' -- needed to avoid error with wilder. See wilder config !
		use 'gelguy/wilder.nvim'

		-- Telescope => fuzzy finder
		use {
			'nvim-telescope/telescope.nvim',
			branch = '0.1.x', -- tag = '0.1.0',
			requires = { 'nvim-lua/plenary.nvim' }
		}

		-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
		use {
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
			-- run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
			cond = vim.fn.executable 'make' == 1
		}

		use 'benfowler/telescope-luasnip.nvim'
		use 'jvgrootveld/telescope-zoxide'
		use 'cljoly/telescope-repo.nvim'
		use 'AckslD/nvim-neoclip.lua'
		use 'nvim-telescope/telescope-symbols.nvim'
		use 'sudormrfbin/cheatsheet.nvim'
		use 'nvim-telescope/telescope-packer.nvim'
		use {
			'dhruvmanila/telescope-bookmarks.nvim',
			-- Uncomment if the selected browser is Firefox or buku
			requires = {
				'kkharji/sqlite.lua'
			}
		}

		-- Harpoon => navigation between files
		use 'ThePrimeagen/harpoon'

		-- Nvim-treesitter => highlighting and indenting code
	    use {
			'nvim-treesitter/nvim-treesitter',
			run = function()
				pcall(require'nvim-treesitter.install'.update { with_sync = true })
			end
		}
		use 'p00f/nvim-ts-rainbow'

		-- Language Server Protocol => LSP
		use {
			'neovim/nvim-lspconfig',
			requires = {
				-- Automatically install LSPs to stdpath for neovim
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',

				-- Useful status updates for LSP
				'j-hui/fidget.nvim',

				-- Additional lua configuration, makes nvim stuff amazing
				'folke/neodev.nvim',

				'RRethy/vim-illuminate'
			}
		}

		-- Nvim-cmp => autocompletion
		use {
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-cmdline',
				'L3MON4D3/LuaSnip',
				'saadparwaiz1/cmp_luasnip',
				'rafamadriz/friendly-snippets',
				'onsails/lspkind.nvim'
			}
		}

		-- Databases
		use 'tpope/vim-dadbod'
		use 'kristijanhusak/vim-dadbod-ui'

		-- Commentaries
		use 'numToStr/Comment.nvim'

		-- Notifications
		use 'rcarriga/nvim-notify'

		-- GIT
		use 'lewis6991/gitsigns.nvim'

		-- MARKDOWN
		use 'ellisonleao/glow.nvim'

		-- Documentation
		use 'nanotee/luv-vimdocs'
		use 'milisims/nvim-luaref'

		-- RUST
		use 'simrat39/rust-tools.nvim'

		-- Debug
		use 'mfussenegger/nvim-dap'

		-- HTML
		-- use 'AndrewRadev/tagalong.vim' -- Change an HTML(ish) opening/closing tag 
		use 'tpope/vim-surround'
		use 'windwp/nvim-ts-autotag'

		-- Tabs
		use 'gcmt/taboo.vim'

		-- Marks
		use 'kshenoy/vim-signature'

		-- Tmux
		use 'christoomey/vim-tmux-navigator'

		-- Others
		use 'windwp/nvim-autopairs'
		use 'norcalli/nvim-colorizer.lua'
		use 'lukas-reineke/indent-blankline.nvim'
	end,
	config = {
		display = {
			open_fn = function()
				return require('packer.util').float({ border = 'single' })
			end
		}
	}
})
