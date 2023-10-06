return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      -- highlight = { "Function", "Label" },
    },
    exclude = {
      filetypes = {
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
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
    },
  },
}
