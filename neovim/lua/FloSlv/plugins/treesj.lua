return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local treesj = require("treesj")
    local utils = require("FloSlv.core.utils")

    treesj.setup()

    utils.map("n", "<leader>o", ":TSJToggle<CR>", "Treesj toggle", {
      noremap = true,
      silent = true,
    })
  end,
}
