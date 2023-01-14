local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
	return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
	return
end

local luasnip_vsc_ok, luasnip_load_vsc = pcall(require, "luasnip.loaders.from_vscode")
if not luasnip_vsc_ok then
	return
end

-- local tail_col_cmp_ok, tailwindcss_colorizer_cmp = pcall(require, "tailwindcss-colorizer-cmp")
-- if not tail_col_cmp_ok then
-- 	return
-- end

luasnip_load_vsc.lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp", keyword_length = 2 },
		{ name = "path" },
		{ name = "luasnip", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = {
			cmp.ItemField.Menu,
			cmp.ItemField.Abbr,
			cmp.ItemField.Kind,
		},
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				buffer = "[BUF]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[LUA]",
				path = "[PATH]",
				luasnip = "[SNIP]",
			},
			-- before = function(entry, vim_item)
			-- 	local word = entry:get_insert_text()
			-- 	-- local filetype = entry:
			-- 	-- DN(entry)
			-- 	return vim_item
			-- end,
		}),
		-- format = tailwindcss_colorizer_cmp.formatter,
	},
})
