return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- cmd = { "ToggleTerm", "ToggleTermToggleAll" },
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup()

    local utils = require("FloSlv.core.utils")

    utils.map("n", "<leader> ", ":ToggleTerm direction=float name=Floflo<CR>", "Open a new terminal", {
      noremap = true,
      silent = true,
    })
  end,
}
