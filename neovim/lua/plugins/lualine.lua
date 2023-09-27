return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        theme = "nord",
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "alpha", "dashboard", "NvimTree" },
          winbar = { "dashboard", "NvimTree" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "filename" },
          { "searchcount" },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
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
      globalstatus = false,
    })
  end,
}
