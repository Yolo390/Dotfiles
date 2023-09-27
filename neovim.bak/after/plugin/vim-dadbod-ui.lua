-- First, launch mongoDB in terminal w/ alias 'ms' or sudo systemctl start mongod
-- Connect to mongoDB: :DB mongodb+srv://<user>:<password>@flo.j1cmj.mongodb.net/<dbName>?retryWrites=true&w=majority

vim.cmd [[
	let g:db_ui_table_helpers = {
	\	'mongodb+srv': {
	\		'List': '{table}.find()'
	\	}
	\}
]]

vim.g.db_ui_disable_mappings = 1
vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_save_location = '~/.config/nvim/lua/FloSlv/db'
vim.g.db_ui_win_position = 'right'
vim.g.db_ui_winwidth = 30
