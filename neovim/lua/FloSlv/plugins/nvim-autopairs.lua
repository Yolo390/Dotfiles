return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true, -- Enable treesitter.
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes.
        javascript = { "template_string" }, -- Don't add pairs in javscript template_string treesitter nodes.
      },
    })

    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- Make autopairs and completion work together.
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
