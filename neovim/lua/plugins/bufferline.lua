return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  config = function()
    vim.opt.termguicolors = true

    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "tabs",
        separator_style = "slant",
      },
    })
  end,
}
