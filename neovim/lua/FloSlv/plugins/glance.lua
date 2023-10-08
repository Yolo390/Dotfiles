return {
  "dnlhc/glance.nvim",
  config = function()
    local glance = require("glance")
    -- local actions = glance.actions

    glance.setup({
      detached = true,
      border = {
        enable = true, -- Show window borders. Only horizontal borders allowed.
        top_char = "―",
        bottom_char = "―",
      },
      list = {
        position = "left", -- Position of the list window 'left'|'right'.
        width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5 .
      },
      theme = {
        enable = true, -- Will generate colors for the plugin based on your current colorscheme.
        mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme.
      },
    })
  end,
}
