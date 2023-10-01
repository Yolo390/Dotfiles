return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/which-key.nvim",
  },
  cmd = { "TroubleToggle", "Trouble" },
  keys = function()
    return {
      { "<leader>tt", ":TroubleToggle<CR>", desc = "Trouble: toggle" },
      { "<leader>td", ":TroubleToggle document_diagnostics<CR>", desc = "Trouble: document diagnostics" },
      { "<leader>tw", ":TroubleToggle workspace_diagnostics<CR>", desc = "Trouble: workspace diagnostics" },
      { "<leader>tq", ":TroubleToggle quickfix<CR>", desc = "Trouble: quickfix list" },
      { "<leader>ts", ":TroubleToggle lsp_references<CR>", desc = "Trouble: LSP references" },
      -- { "<leader>tll", ":TroubleToggle loclist<CR>", desc = "(T)rouble: (L)ocation (L)ist" },
    }
  end,
  config = function()
    local trouble = require("trouble")

    trouble.setup({
      position = "bottom", -- Position of the list can be: bottom, top, left, right.
      height = 10, -- Height of the trouble list when position is top or bottom.
      width = 50, -- Width of the list when position is left or right.
      icons = true, -- Use devicons for filenames.
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist".
      fold_open = " ", -- Icon used for open folds.
      fold_closed = " ", -- Icon used for closed folds.
      group = true, -- Group results by file.
      padding = true, -- Add an extra new line on top of the list.
      action_keys = { -- Key mappings for actions in the trouble list.
        -- Map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- Close the list.
        cancel = "<esc>", -- Cancel the preview and get back to your last window / buffer / cursor.
        refresh = "r", -- Manually refresh.
        jump = { "<cr>", "<tab>" }, -- Jump to the diagnostic or open / close folds.
        open_split = { "<c-x>" }, -- Open buffer in new split.
        open_vsplit = { "<c-v>" }, -- Open buffer in new vsplit.
        open_tab = { "<c-t>" }, -- Open buffer in new tab.
        jump_close = { "o" }, -- Jump to the diagnostic and close the list.
        toggle_mode = "m", -- Toggle between "workspace" and "document" diagnostics mode.
        toggle_preview = "P", -- Toggle auto_preview.
        hover = "K", -- Opens a small popup with the full multiline message.
        preview = "p", -- Preview the diagnostic location.
        close_folds = { "zM", "zm" }, -- Close all folds.
        open_folds = { "zR", "zr" }, -- Open all folds.
        toggle_fold = { "zA", "za" }, -- Toggle fold of current file.
        previous = "k", -- Previous item.
        next = "j", -- Next item.
      },
      indent_lines = true, -- Add an indent guide below the fold icons.
      auto_open = false, -- Automatically open the list when you have diagnostics.
      auto_close = false, -- Automatically close the list when you have no diagnostics.
      auto_preview = false, -- Automatically preview the location of the diagnostic. <esc> to close preview and go back to last window.
      auto_fold = false, -- Automatically fold a file trouble list at creation.
      auto_jump = { "lsp_definitions" }, -- For the given modes, automatically jump if there is only a single result.
      signs = {
        -- Icons/text used for a diagnostic.
        error = " ",
        warning = " ",
        hint = " ",
        information = " ",
        other = "󰠠 ",
      },
      use_diagnostic_signs = false, -- Enabling this will use the signs defined in your lsp client.
    })
  end,
}
