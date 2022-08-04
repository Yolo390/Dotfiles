require'telescope'.setup {
	defaults = {
		prompt_prefix = '🔍 ',
		hidden = true
	}
}

require'telescope'.load_extension'fzf'
require'telescope'.load_extension'luasnip'
require'telescope'.load_extension'notify'
require'telescope'.load_extension'zoxide'
require'telescope'.load_extension'repo'
require'telescope'.load_extension'packer'
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
