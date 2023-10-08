local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Latest stable release.
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- UI
vim.api.nvim_set_hl(0, "LazyNormal", { fg = "#ffffff" })

require("lazy").setup({ { import = "FloSlv.plugins" } }, {
  install = {
    -- Install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- Try to load one of these colorschemes when starting an installation during startup.
    colorscheme = { "nord" },
  },
  checker = {
    enabled = true, -- Automatically check for plugin updates.
    notify = true,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- Disable some rtp plugins.
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    -- A number <1 is a percentage., >1 is a fixed size.
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- Wrap the lines in the ui.
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    title = nil, ---@type string Only works when border is not "none".
    title_pos = "center", ---@type "center" | "left" | "right"
    -- Show pills on top of the Lazy window.
    pills = true, ---@type boolean
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = " ",
      list = {
        "●",
        "",
        "★",
        "‒",
      },
    },
  },
})
