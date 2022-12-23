local luasnip_status, luasnip = pcall(require, 'luasnip')
if not luasnip_status then
	return
end

local luasnip_util_status, luasnip_util_types = pcall(require, 'luasnip.util.status')
if not luasnip_util_status then
	return
end

require'luasnip.loaders.from_vscode'.lazy_load({ paths = { './lua/FloSlv/globals/snippets.lua' } })

local ls = luasnip
local types = luasnip_util_types

ls.config.set_config {
	history = true,
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = true
}
