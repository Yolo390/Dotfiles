return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
		"nvimtools/none-ls.nvim",
  },
  cmd = "Mason",
  build = ":MasonUpdate",
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_null_ls = require("mason-null-ls")

    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = " ",
          package_pending = "󰠠 ",
          package_uninstalled = " ",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "cssmodules_ls",
        "graphql",
        "html",
        "jsonls",
        "lua_ls",
        "phpactor",
        "prismals",
        "rust_analyzer",
        "sqlls",
        "tailwindcss",
        "taplo",
        "tsserver",
        "vimls",
        "yamlls",
      },
      -- Auto-install configured servers (with lspconfig).
      -- automatic_installation = true,
    })

    mason_null_ls.setup({
      ensure_installed = {
        "prettier", -- JS/TS formatters.
        "shfmt", -- Shell formatter.
        "stylua", -- lua formatter.
        "eslint_d", -- JS/TS linters.
      },
      -- Auto-install configured servers (with lspconfig).
      automatic_installation = true,
    })

    -- TODO find how to set Mason color border.
    -- UI
    -- vim.api.nvim_set_hl(0, "MasonBorder", { fg = "#CCCCCC" })
  end,
}
