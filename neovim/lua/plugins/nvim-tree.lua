return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- Recommended settings from nvim-tree documentation.
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Keymaps.
    local key = vim.keymap.set
    local full_options = { noremap = true, silent = true }

    key("n", "<C-a>", ":NvimTreeToggle<CR>", full_options)
    key("n", "<C-t>", ":NvimTreeFindFileToggle<CR>", full_options)

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
