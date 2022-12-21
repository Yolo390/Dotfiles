require'nvim-treesitter.configs'.setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		'bash',
		'c',
		'css',
		'dockerfile',
		'gitignore',
		'graphql',
		'help',
		'html',
		'javascript',
		'json',
		'lua',
		'markdown',
		'prisma',
		'rasi',
		'regex',
		'rust',
		'scss',
		'toml',
		'typescript',
		'vim'
	},
	autotag = {
		enable = true -- use nvim-ts-autotag plugin
	},
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false
	},
	indent = {
		enable = true
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	}
}
