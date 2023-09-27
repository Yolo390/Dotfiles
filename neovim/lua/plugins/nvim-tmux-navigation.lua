return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    local nvim_tmux_nav = require("nvim-tmux-navigation")

    local key = vim.keymap.set

    key("n", "<M-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
    key("n", "<M-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
    key("n", "<M-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
    key("n", "<M-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
  end,
}
