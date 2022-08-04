require'luasnip.loaders.from_vscode'.lazy_load({ paths = { './lua/FloSlv/globals/snippets.lua' } })

local ls = require'luasnip'
local types = require'luasnip.util.types'

ls.config.set_config {
	history = true,
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = true
}
