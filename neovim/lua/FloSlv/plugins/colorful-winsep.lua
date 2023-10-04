return {
  "nvim-zh/colorful-winsep.nvim",
  config = true,
  event = { "WinNew" },
  opts = function()
    return {
      highlight = {
        -- bg = '#eb6f92',
        fg = "#eb6f92",
      },
      -- Timer refresh rate.
      interval = 10,
      -- This plugin will not be activated for filetype in the following table.
      no_exec_files = {
        "packer",
        "TelescopePrompt",
        "mason",
        "NvimTree",
        "help",
        "fugitive",
        "fugitiveblame",
        "merginal",
        "noice",
        "Trouble",
      },
      symbols = { "─", "│", "┌", "┐", "└", "┘" },
      -- Executed after closing the window separator.
      close_event = function() end,
      -- Executed after creating the window separator.
      create_event = function() end,
    }
  end,
}
