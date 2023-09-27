return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "│",
    filetype_exclude = {
      "help",
      "alpha",
      "dashboard",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
      "NvimTree",
    },
    show_current_context = true,
    show_current_context_start = true,
    -- show_trailing_blankline_indent = false,
    -- show_end_of_line = true,
    -- space_char_blankline = '.'
  },
}
