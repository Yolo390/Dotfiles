return {
  "roobert/tailwindcss-colorizer-cmp.nvim",
  config = function()
    local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp")

    tailwindcss_colorizer_cmp.setup({
      color_square_width = 2,
    })
  end,
}
