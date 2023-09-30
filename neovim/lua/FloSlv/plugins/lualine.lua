return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        theme = "nord", -- "dracula-nvim"
        globalstatus = false,
        disabled_filetypes = {
          statusline = { "alpha", "NvimTree" },
          winbar = { "alpha", "NvimTree" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics" },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "selectioncount" },
          { "progress" },
          { "encoding" },
        },
        lualine_y = { "filetype" },
        lualine_z = { "fileformat" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "lazy", "fugitive", "fzf", "quickfix" },
    })
  end,
}
