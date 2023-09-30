return {
  {
    "folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim"
		},
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override = {
        --   ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        --   ["vim.lsp.util.stylize_markdown"] = true,
        --   ["cmp.entry.get_documentation"] = true,
        -- },
				signature = {
					enabled = false
				},
				hover = {
					enabled = false
				}
      },
      -- routes = {
      --   {
      --     filter = {
      --       event = "msg_show",
      --       any = {
      --         { find = "%d+L, %d+B" },
      --         { find = "; after #%d+" },
      --         { find = "; before #%d+" },
      --       },
      --     },
      --     view = "mini",
      --   },
      -- },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
			views = {
				cmdline_popup = {
					position = {
						row = -2,
						col = "50%"
					}
				},
				cmdline_popupmenu = {
					position = {
						row = -5,
						col = "50%"
					}
				}
			}
    },
  },
}
