return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = function()
    return {
      { "<leader>o", ":TSJToggle<CR>", desc = "Treesj toggle" },
    }
  end,
  config = function()
    local treesj = require("treesj")

    treesj.setup({
      use_default_keymaps = false,
    })
  end,
}
