local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
	return
end

local lspkind_status, lspkind = pcall(require, 'lspkind')
if not lspkind_status then
	return
end

local luasnip_status, luasnip = pcall(require, 'luasnip')
if not luasnip_status then
	return
end

local luasnip_vsc_status, luasnip_load_vsc = pcall(require, 'luasnip.loaders.from_vscode')
if not luasnip_vsc_status then
	return
end

luasnip_load_vsc.lazy_load()

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert {
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		},
		['<C-j>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-k>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 3 },
		{ name = 'luasnip' },
		{ name = 'buffer', keyword_length = 3 }
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
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
}
