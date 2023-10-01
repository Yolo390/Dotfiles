return {
  "ellisonleao/glow.nvim",
  -- cmd = "Glow",
  config = function()
    local glow = require("glow")

    glow.setup({
      border = "rounded",
    })

    local utils = require("FloSlv.core.utils")

    utils.map("n", "<leader>md", ":Glow<CR>", "Glow: open", {
      noremap = true,
      silent = true,
    })
  end,
}
