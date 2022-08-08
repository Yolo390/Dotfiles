require'telescope'.setup {
	defaults = {
		prompt_prefix = '🔍 ',
		hidden = true,
		mappings = {
			n = {
				['<C-d>'] = require'telescope.actions'.delete_buffer
			}
		}
	},
	extensions = {
		bookmarks = {
			selected_browser = 'firefox',
			url_open_command = 'open', -- Either provide a shell command to open the URL
			url_open_plugin = nil, -- Available: 'vim_external', 'open_browser'
			full_path = true,
			firefox_profile_name = nil,
			debug = false
		}
	}
}

require'telescope'.load_extension'fzf'
require'telescope'.load_extension'luasnip'
require'telescope'.load_extension'notify'
require'telescope'.load_extension'zoxide'
require'telescope'.load_extension'repo'
require'telescope'.load_extension'packer'
require'telescope'.load_extension'bookmarks'
require'telescope'.load_extension'neoclip'
require('neoclip').setup()

-- UI
vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg='#CCCCCC' })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg='#CCCCCC' })
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg='#CCCCCC' })
vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg='#CCCCCC' })

vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg='#24283b' })
vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg='#24283b' })
vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg='#24283b' })

vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg='#ffffff' })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg='#ffffff' })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg='#ffffff' })
