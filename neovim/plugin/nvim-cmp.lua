local cmp = require'cmp'
local lspkind = require'lspkind'
local luasnip = require 'luasnip'

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-i>'] = cmp.mapping.select_next_item(),
		['<C-p'] = cmp.mapping.select_prev_item(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" })
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp', keyword_length = 3 },
		{ name = 'nvim_lua' },
		{ name = 'path' },
		{ name = 'luasnip' }
	}, {
		{ name = 'buffer', keyword_length = 3 }
	}),
	formatting = {
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				buffer = '[BUF]',
				path = '[PATH]',
				nvim_lsp = '[LSP]',
				nvim_lua = '[LUA]',
				luasnip = '[SNIP]'
			}
		}
	},
	enabled = function()
		-- disable completion in comments
		local context = require'cmp.config.context'
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == 'c' then
			return true
		else
			return not context.in_treesitter_capture('comment')
			and not context.in_syntax_group('Comment')
		end
	end
})

-- Setup lspconfig.
local lspconfig = require'lspconfig'
local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
	'tsserver',
	'graphql',
	'cssls',
	'html',
	'sumneko_lua',
	'jsonls',
	'rust_analyzer',
	'taplo',
	'vimls'
}

for _, server in ipairs(servers) do
	lspconfig[server].setup {
		capabilities = capabilities,
		on_attach = function(client)
			require'illuminate'.on_attach(client)
		end
	}
end
