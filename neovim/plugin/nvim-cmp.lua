local cmp = require'cmp'
local lspkind = require'lspkind'
local luasnip = require 'luasnip'

require'luasnip.loaders.from_vscode'.lazy_load()

local languages = {
	'javascript',
	'javascriptreact',
	'typescript',
	'typescriptreact',
	'css',
	'scss',
	'html',
	'lua',
	'json',
	'jsonc',
	'conf',
	'rust',
	'toml'
}

for _, language in ipairs(languages) do
	cmp.setup.filetype(language, {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end
		},
		mapping = cmp.mapping.preset.cmdline({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<C-i>'] = cmp.mapping.select_next_item(),
			['<C-p'] = cmp.mapping.select_prev_item(),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<C-j>'] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
				end, { 'i', 's' }),
			['<C-k'] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
				end, { 'i', 's' })
		}),
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered()
		},
		sources = cmp.config.sources({
			{ name = 'path' },
			{ name = 'nvim_lsp', keyword_length = 3 },
			{ name = 'nvim_lua' },
			{ name = 'luasnip' }
		}, {
			{ name = 'buffer', keyword_length = 3 }
		}),
		formatting = {
			format = lspkind.cmp_format({
				mode = 'symbol_text',
				menu = ({
					buffer = '[BUF]',
					nvim_lsp = '[LSP]',
					nvim_lua = '[LUA]',
					path = '[PATH]',
					luasnip = '[SNIP]'
				})
			})
		}
	})
end

-- Setup lspconfig.
local lspconfig = require'lspconfig'
local capabilities = require'cmp_nvim_lsp'.default_capabilities()

local servers = {
	'graphql',
	'tsserver',
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
