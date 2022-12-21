-- ###########
-- # KEYMAPS #
-- ###########


local key = vim.keymap.set
local full_options = { noremap = true, silent = true }
local noremap = { noremap = true }


-- Set leader key as a space.
vim.g.mapleader = ' '


-- Save and re source current file
key('n', '<leader>s', ':w | source %<CR>', full_options)


-- TABS
key('n', 'H', 'gT', noremap)
key('n', 'L', 'gt', noremap)
key('n', 'tt', ':tabnew<CR>', full_options)


-- WINDOWS
key('n', '<leader>v', ':vsplit<CR>', full_options)
key('n', '<leader>x', ':split<CR>', full_options)


-- COPY FROM CURSOR TO END OF LINE
key('n', 'Y', 'y$', noremap)


-- KEEPING IN CENTERED
key('n', 'n', 'nzzzv', full_options)
key('n', 'N', 'Nzzzv', full_options)
key('n', 'G', 'Gzz', full_options)


-- NAVIGATE EASILY BETWEEN WINDOWS - using vim-tmux-navigator plugin
vim.g.tmux_navigator_no_mappings = true

key('n', '<M-h>', ':TmuxNavigateLeft<CR>', full_options)
key('n', '<M-j>', ':TmuxNavigateDown<CR>', full_options)
key('n', '<M-k>', ':TmuxNavigateUp<CR>', full_options)
key('n', '<M-l>', ':TmuxNavigateRight<CR>', full_options)


-- UNDO BREAK POINTS
key('i', ',', ',<C-g>u', {})
key('i', ';', ';<C-g>u', {})
key('i', '.', '.<C-g>u', {})
key('i', '!', '!<C-g>u', {})
key('i', '?', '?<C-g>u', {})


-- MOVING TEXT
key('v', 'J', ":move '>+1<CR>gv=gv", full_options)
key('v', 'K', ":move '<-2<CR>gv=gv", full_options)
key('n', '<C-j>', ':move .+1<CR>==', full_options)
key('n', '<C-k>', ':move .-2<CR>==', full_options)


-- VISUAL MODE INDENTATION
key('v', '<', '<gv', full_options)
key('v', '>', '>gv', full_options)


-- RESIZE WITH ARROWS
key('n', '<C-Up>', ':resize +2<CR>', full_options)
key('n', '<C-Down>', ':resize -2<CR>', full_options)
key('n', '<C-Left>', ':vertical resize -2<CR>', full_options)
key('n', '<C-Right>', ':vertical resize +2<CR>', full_options)


-- -- Autorun
-- local languages = {
-- 	sh = { exec = './%' },
-- 	rust = { build = 'cargo build', exec = 'cargo run' }
-- }
--
-- for lang, data in pairs(languages) do
-- 	if data.build ~= nil then
-- 		vim.api.nvim_create_autocmd('FileType', {
-- 			pattern = lang,
-- 			command = ':lua nnoremap <Leader>b :!' .. data.build .. '<CR>'
-- 		})
-- 	end
--
-- 	vim.api.nvim_create_autocmd("FileType", {
-- 		pattern = lang,
-- 		command = ':lua nnoremap <Leader>ex :split<CR>:terminal ' .. data.exec .. '<CR>'
-- 	})
-- end


-- #############
-- # TELESCOPE #
-- #############

local builtin = require'telescope.builtin'
local themes = require'telescope.themes'

key('n', '<leader>ff', ':lua CurrentDir()<CR>', full_options)
key('n', '<leader>flo', ':lua Flo()<CR>', full_options)
key('n', '<leader>dev', ':lua Dev()<CR>', full_options)
key('n', '<leader>dot', ':lua Dotfiles()<CR>', full_options)
key('n', '<leader>he', ':lua Help()<CR>', full_options)
key('n', '<leader>key', ':lua Keymaps()<CR>', full_options)
key('n', '<leader>re', ':lua Repo()<CR>', full_options)
key('n', '<leader>zo', ':lua Zoxide()<CR>', full_options)
key('n', '<leader>emo', ':lua Symbols()<CR>', full_options)
key('n', '<leader>p', ':lua Plugins()<CR>', full_options)
key('n', '<leader>boo', ':lua Bookmarks()<CR>', full_options)

key('n', '<leader>fb', ':Telescope buffers<CR>', full_options)
key('n', '<leader>fgf', ':Telescope git_files<CR>', full_options)
key('n', '<leader>fgc', ':Telescope git_commits<CR>', full_options)
key('n', '<leader>fs', ':Telescope live_grep<CR>', full_options)
key('n', '<leader>fr', ':Telescope lsp_references<CR>', full_options)
key('n', '<leader>neo', ':Telescope neoclip<CR>', full_options)

function CurrentDir ()
	builtin.find_files {
		prompt_title = '🌞 ' .. vim.fn.substitute(vim.fn.getcwd(), '/home/floslv', '~', ''),
		cwd = vim.fn.substitute(vim.fn.getcwd(), '/home/floslv', '~', ''),
		hidden = true
	}
end

function Flo ()
	builtin.find_files {
		cwd = '~/Flo',
		prompt_title = '🏠 ~/Flo',
		hidden = true
	}
end

function Dev ()
	builtin.find_files {
		cwd = '~/Flo/Dev',
		prompt_title = '💻 Dev',
		hidden = true
	}
end

function Dotfiles ()
	if pcall(function()
		builtin.git_files(
			themes.get_dropdown {
				cwd = '~/Flo/Dotfiles',
				prompt_title = ' Dotfiles',
				hidden = true,
				previewer = false
			}
		)
	end) then
	else
		builtin.find_files(
			themes.get_dropdown {
				prompt_title = ' Dotfiles',
				cwd = '~/Flo/Dotfiles',
				hidden = true,
				previewer = false
			}
		)
	end
end

function Help ()
	builtin.help_tags(
		themes.get_dropdown({
			prompt_title = '❓ Help',
			previewer = false
		})
	)
end

function Keymaps ()
	builtin.keymaps(
		themes.get_ivy {
			prompt_title = '👀 Key maps'
		}
	)
end

function Repo ()
	require'telescope'.extensions.repo.list(
		themes.get_dropdown({
			prompt_title = '🌵 Repo',
			previewer = false
		})
	)
end

function Zoxide ()
	require'telescope'.extensions.zoxide.list(
		themes.get_dropdown({
			prompt_title = '🌸 Zoxide'
		})
	)
end

function Symbols ()
	builtin.symbols(
		themes.get_dropdown({
			prompt_title = '💢 Emoji'
		})
	)
end

function Plugins ()
	require'telescope'.extensions.packer.packer {
		prompt_title = '  Plugins',
		previewer = false
	}
end

function Bookmarks ()
	require'telescope'.extensions.bookmarks.bookmarks(
		themes.get_ivy {
			prompt_title = '  Firefox bookmarks '
		}
	)
end


-- #######
-- # LSP #
-- #######

key('n', '<leader>df', ':lua vim.lsp.buf.definition()<CR>', full_options)
key('n', 'K', ':lua vim.lsp.buf.hover()<CR>', full_options)
key('n', '<leader>err', ':lua vim.diagnostic.open_float()<CR>', full_options)


-- #############
-- # NVIM-TREE #
-- #############

key('n', '<C-a>', ':NvimTreeToggle<CR>', full_options)
key('n', '<C-f>', ':NvimTreeFindFile<CR>', full_options)


-- #################
-- # VIM-DADBOD-UI #
-- #################

key('n', '<leader>mo', ':tabnew | :DBUIToggle<CR>:TabooRename DB<CR>', full_options)

vim.cmd [[
autocmd FileType dbui nmap <buffer> u <Plug>(DBUI_ToggleDetails)
autocmd FileType dbui nmap <buffer> <CR> <Plug>(DBUI_SelectLine)
autocmd FileType dbui nmap <buffer> d <Plug>(DBUI_DeleteLine)
autocmd FileType dbui nmap <buffer> R <Plug>(DBUI_Redraw)
autocmd FileType dbui nmap <buffer> A <Plug>(DBUI_AddConnection)
autocmd FileType dbui nmap <buffer> S <Plug>(DBUI_SelectLineVSplit)
]]


-- ###########
-- # HARPOON #
-- ###########

key('n', '<leader>af', ":lua require'harpoon.mark'.add_file()<CR>", full_options)
key('n', '<leader>aa', ":lua require'harpoon.ui'.toggle_quick_menu()<CR>", full_options)


-- ###########
-- # LUASNIP #
-- ###########

key('n', '<leader>y', ':source ~/Flo/Dotfiles/nvim/plugin/luasnip.lua<CR>', noremap)


-- ############
-- # GITSIGNS #
-- ############
-- see gitsigns.lua


-- ############
-- # NVIM-CMP #
-- ############
-- see nvim-cmp.lua


-- ########
-- # GLOW #
-- ########

key('n', '<leader>gl', ':Glow<CR>', full_options)
