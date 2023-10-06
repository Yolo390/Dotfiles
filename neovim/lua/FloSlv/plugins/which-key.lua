return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local which_key = require("which-key")

    local opts = {
      mode = "n",
      prefix = "<leader>",
    }

    local mappings = {
      ["f"] = { " " },
      ["g"] = { "GIT" },
      ["l"] = { "LSP" },
      ["t"] = { "TROUBLE/TODO" },
      ["u"] = { "NOTIFY" },
      ["w"] = { "WORKSPACE" },
    }

    which_key.register(mappings, opts)
  end,
  opts = {
    show_help = false,
    ignore_missing = false, -- Enable this to hide mappings for which you didn't specify a label.
    -- Disable the WhichKey popup for certain buf types and file types.
    -- Disabled by default for Telescope.
    disable = {
      buftypes = {},
      filetypes = {},
    },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    plugins = {
      marks = false, -- Don't show list of marks in normal mode.
      registers = false, -- Don't show list of registers in normal mode.
      spelling = {
        enabled = false, -- Enabling this will show WhichKey when pressing z= to select spelling suggestions.
      },
      presets = {
        operators = false, -- Adds help for operators like d, y, ...
        motions = false, -- Adds help for motions.
        text_objects = false, -- Help for text objects triggered after entering an operator.
        windows = false, -- Default bindings on <c-w> .
        nav = true, -- Misc bindings to work with windows.
        z = false, -- Bindings for folds, spelling and others prefixed with z.
        g = false, -- Bindings for prefixed with g.
      },
    },
    icons = {
      breadcrumb = "» ", -- Symbol used in the command line area that shows your active key combo.
      separator = " ", -- Symbol used between a key and it's label.
      group = " ", -- Symbol prepended to a group.
    },
    window = {
      border = "single", -- None, single, double, shadow.
      position = "bottom", -- Bottom, top.
      margin = { 1, 0, 1, 0 }, -- Extra window margin [top, right, bottom, left].
      padding = { 2, 2, 2, 2 }, -- Extra window padding [top, right, bottom, left].
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- Min and max height of the columns.
      width = { min = 20, max = 50 }, -- Min and max width of the columns.
      spacing = 3, -- Spacing between columns.
      align = "left", -- Align columns left, center or right.
    },
  },
}
