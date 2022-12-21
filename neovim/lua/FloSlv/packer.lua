-- Automatically source and re-sync packer whenever you save.
-- local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
-- 	command = 'source <afile> | PackerSync',
-- 	group = packer_group,
-- 	pattern = vim.fn.expand '$MYVIMRC'
-- })

-- Plugins
return require'packer'.startup({
	function(use)
		-- Packer can manage itself
		use 'wbthomason/packer.nvim'

		-- Colorscheme
		use 'folke/tokyonight.nvim'
		-- use { "catppuccin/nvim", as = "catppuccin" }

		-- Display
		use 'nvim-lualine/lualine.nvim'
		use 'glepnir/dashboard-nvim'
		use 'kyazdani42/nvim-web-devicons'
		use {
			'kyazdani42/nvim-tree.lua',
			requires = { 'kyazdani42/nvim-web-devicons' },
			tag = 'nightly'
		}
		use 'TaDaa/vimade'
		--use 'gelguy/wilder.nvim'

		-- Telescope
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
			requires = { { 'nvim-lua/plenary.nvim' } }
		}
		use {
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
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

		-- Harpoon
		use 'ThePrimeagen/harpoon'

		-- Nvim-treesitter
	    use {
			'nvim-treesitter/nvim-treesitter',
			run = function() require('nvim-treesitter.install').update({
				with_sync = true
			}) end
		}
		use 'p00f/nvim-ts-rainbow'

		-- LSP
		use {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig"
		}
		use 'RRethy/vim-illuminate'

		-- Nvim-cmp
		use 'hrsh7th/nvim-cmp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/cmp-path'
		use 'hrsh7th/cmp-cmdline'
		use 'hrsh7th/cmp-nvim-lua'
		use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
		use 'onsails/lspkind.nvim'
		use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
		use 'L3MON4D3/LuaSnip' -- Snippets plugin
		use 'rafamadriz/friendly-snippets'

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
		-- use 'ggandor/leap.nvim'
	end,
	config = {
		display = {
			open_fn = function()
				return require('packer.util').float({ border = 'single' })
			end
		}
	}
})
