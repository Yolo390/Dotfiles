return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "benfowler/telescope-luasnip.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")

    telescope.setup({
      defaults = {
        prompt_prefix = " 🔍 ",
        hidden = true,
        mappings = {
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-d>"] = actions.delete_buffer,
          },
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },
    })

    -- UI
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#CCCCCC" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#CCCCCC" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#CCCCCC" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#CCCCCC" })

    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#24283b" })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#24283b" })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#24283b" })

    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#ffffff" })
  end,
}
