return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")
    local utils = require("FloSlv.core.utils")

    -- Recommended settings from nvim-tree documentation.
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Keymaps.
    local full_options = { noremap = true, silent = true }
    utils.map(
      "n",
      "<C-a>",
      ":NvimTreeToggle<CR>",
      "NvimTree: toggle",
      full_options
    )
    utils.map(
      "n",
      "<C-t>",
      ":NvimTreeFindFileToggle<CR>",
      "NvimTree: toggle in current file",
      full_options
    )

    nvimtree.setup({
      sort_by = "case_sensitive",
      view = {
        adaptive_size = true,
        side = "right",
        -- width = 30,
      },
      renderer = {
        group_empty = true,
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
}
