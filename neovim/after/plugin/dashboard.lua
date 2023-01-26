local dash_status, dashboard = pcall(require, "dashboard")
if not dash_status then
	return
end

local ts_status, telescope = pcall(require, "telescope")
if not ts_status then
	return
end

local ts_builtin_status, ts_builtin = pcall(require, "telescope.builtin")
if not ts_builtin_status then
	return
end

local ts_themes_status, ts_themes = pcall(require, "telescope.themes")
if not ts_themes_status then
	return
end

local db = dashboard

local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))

db.setup({
	theme = "doom",
	config = {
		packages = { enable = true },
		header = {
			" ____ ____ ____ ____ ____ ____ ",
			"||N |||E |||O |||V |||I |||M ||",
			"||__|||__|||__|||__|||__|||__||",
			"|/__\\|/__\\|/__\\|/__\\|/__\\|/__\\|",
			" ",
			" ",
			" ",
		},
		center = {
			{
				icon = " ",
				icon_hi = "Title",
				desc = "Find File",
				desc_hi = "String",
				key = "b",
				key_hi = "Number",
				action = "lua print(2)",
			},
			{
				icon = " ",
				icon_hi = "Title",
				desc = "Find Dotfiles",
				desc_hi = "String",
				key = "f",
				key_hi = "Number",
				action = "lua print(3)",
			},
		},
		footer = {
			" ",
			" ",
			"Bienvenue Flo !",
			" ",
			-- os.date("%A %d/%m/%Y %H:%M"),
			os.date("%A %d/%m/%Y"),
			" ",
			"Neovim plugins: " .. plugins_count,
		},
	},
})

-- db.custom_header = {
-- ' ____ ____ ____ ____ ____ ____ ',
-- '||N |||E |||O |||V |||I |||M ||',
-- '||__|||__|||__|||__|||__|||__||',
-- '|/__\\|/__\\|/__\\|/__\\|/__\\|/__\\|',
-- ' ',
-- ' ',
-- ' '
-- }

-- local builtin = ts_builtin
-- local themes = ts_themes
-- local extensions = telescope.extensions

-- db.custom_center = {
-- 	{
-- 		icon = '🔍   ',
-- 		desc = 'Find file        ',
-- 		action = function()
-- 			builtin.find_files({
-- 				cwd = vim.fn.substitute(vim.fn.getcwd(), '/home/floslv', '~', ''),
-- 				prompt_title = '🌞 ' .. vim.fn.substitute(vim.fn.getcwd(), '/home/floslv', '~', ''),
-- 				hidden = true
-- 			})
-- 		end
-- 	},
-- 	{
-- 		icon = '💻   ',
-- 		desc = 'Dev             ',
-- 		action = function()
-- 			builtin.find_files({
-- 				cwd = '~/Flo/Dev',
-- 				prompt_title = '💻 Dev',
-- 				hidden = true
-- 			})
-- 		end
-- 	},
-- 	{
-- 		icon = '🔅   ',
-- 		desc = 'Dotfiles         ',
-- 		action = function()
-- 			if pcall(function()
-- 				builtin.git_files(
-- 					themes.get_dropdown {
-- 						cwd = '~/Flo/Dotfiles',
-- 						prompt_title = ' Dotfiles',
-- 						hidden = true,
-- 						previewer = false
-- 					}
-- 				)
-- 			end) then
-- 			else
-- 				builtin.find_files(
-- 					themes.get_dropdown {
-- 						prompt_title = ' Dotfiles',
-- 						cwd = '~/Flo/Dotfiles',
-- 						hidden = true,
-- 						previewer = false
-- 					}
-- 				)
-- 			end
-- 		end
-- 	},
-- 		{
-- 		icon = '🌵   ',
-- 		desc = 'Git repos        ',
-- 		action = function ()
-- 			require'telescope'.extensions.repo.list(
-- 					themes.get_dropdown({
-- 						prompt_title = '🌵 Git repos',
-- 						previewer = false
-- 				})
-- 			)
-- 		end
-- 	},
-- 	{
-- 		icon = '🌸   ',
-- 		desc = 'Zoxide          ',
-- 		action = function ()
-- 			require'telescope'.extensions.zoxide.list(
-- 				themes.get_dropdown({
-- 					prompt_title = '🌸 Zoxide'
-- 				})
-- 			)
-- 		end
-- 	},
-- 	{
-- 		icon = '🔌   ',
-- 		desc = 'Plugins         ',
-- 		action = function()
-- 			extensions.packer.packer({
-- 				prompt_title = '  Plugins',
-- 				previewer = false
-- 			})
-- 		end
-- 	},
-- 	{
-- 		icon = '🦊   ',
-- 		desc = 'Firefox bookmarks',
-- 		action = function ()
-- 			extensions.bookmarks.bookmarks(
-- 				themes.get_ivy {
-- 					prompt_title = '  Firefox bookmarks '
-- 				}
-- 			)
-- 		end
-- 	},
-- 	{
-- 		icon = '📝   ',
-- 		desc = 'New file        ',
-- 		action = 'DashboardNewFile'
-- 	},
-- 	{
-- 		icon = '🔑   ',
-- 		desc = 'Key maps        ',
-- 		action = function()
-- 			builtin.keymaps(
-- 				themes.get_ivy({
-- 					prompt_title = '👀 Key maps'
-- 				})
-- 			)
-- 		end
-- 	},
-- 	{
-- 		icon = '❓   ',
-- 		desc = 'Help             ',
-- 		action = function()
-- 			builtin.help_tags(
-- 				themes.get_dropdown({
-- 					prompt_title = '❓ Help',
-- 					previewer = false
-- 				})
-- 			)
-- 		end
-- 	}
-- }
