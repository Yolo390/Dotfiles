return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- ---Whether to attach navic to language servers automatically.
    ---@type boolean
    attach_navic = true,

    ---Filetypes not to enable winbar in.
    ---@type string[]
    exclude_filetypes = { "netrw", "toggleterm" },

    ---Whether to display path to file.
    ---@type boolean
    show_dirname = false,

    ---Whether to display file name.
    ---@type boolean
    show_basename = true,

    ---Whether to replace file icon with the modified symbol when buffer is
    ---modified.
    ---@type boolean
    show_modified = false,

    ---Whether to show/use navic in the winbar.
    ---@type boolean
    show_navic = false,
  },
}
