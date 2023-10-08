return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      -- build = ":MasonUpdate", -- WARN: It's not working !
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim", -- NOTE: Instead of none-ls/null-ls.
        -- "jay-babu/mason-null-ls.nvim", -- NOTE: to use none-ls/null-ls.
      },
    },
    { "folke/neodev.nvim", opts = {} },
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      opts = {},
    },
  },
  config = function()
    local lspconfig = require("lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- NOTE: Formatting/linting with none-ls/null-ls.
    -- local mason_null_ls = require("mason-null-ls")

    local neodev = require("neodev")
    local fidget = require("fidget")

    local ts_builtin_status, ts_builtin = pcall(require, "telescope.builtin")
    if not ts_builtin_status then
      return
    end

    -- LSP settings.
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      local utils = require("FloSlv.core.utils")

      local nmap = function(keys, func, desc)
        -- add description
        if desc then
          desc = "LSP: " .. desc
        end

        utils.map("n", keys, func, desc, {
          buffer = bufnr,
          noremap = true,
          silent = true,
        })
      end

      -- Actions.
      nmap("<leader>la", vim.lsp.buf.code_action, "code action.")
      nmap("<leader>ln", vim.lsp.buf.rename, "re name.")

      -- Diagnostics
      nmap("<leader>lf", ts_builtin.diagnostics, "diagnostic finder.")
      nmap("<leader>lo", vim.diagnostic.open_float, "diagnostic open.")

      -- Documentation.
      nmap("K", vim.lsp.buf.hover, "documentation.")

      -- LSP.
      nmap("<leader>ld", ":Glance definitions<CR>", "goto definition.") -- NOTE: Better than telescope to display definitions.
      -- nmap("<leader>ld", ts_builtin.lsp_definitions, "goto definition.")
      nmap("<leader>lD", vim.lsp.buf.declaration, "goto declaration.")
      nmap("<leader>li", ":Glance implementations<CR>", "goto implementation.") -- NOTE: Better than telescope to display implementation.
      -- nmap("<leader>li", ts_builtin.lsp_implementations, "goto implementation.")
      nmap("<leader>lr", ":Glance references<CR>", "goto references.") -- NOTE: Better than telescope to display references.
      -- nmap("<leader>lr", ts_builtin.lsp_references, "goto references.")
      nmap(
        "<leader>ls",
        ts_builtin.lsp_document_symbols,
        "goto document symbols"
      )
      nmap("<leader>lt", vim.lsp.buf.type_definition, "goto type definition")

      -- Workspaces.
      nmap(
        "<leader>wa",
        vim.lsp.buf.add_workspace_folder,
        "workspace add folder."
      )
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "workspace list folder")
      nmap(
        "<leader>wr",
        vim.lsp.buf.remove_workspace_folder,
        "workspace remove folder."
      )
      nmap(
        "<leader>ws",
        ts_builtin.lsp_dynamic_workspace_symbols,
        "workspace symbols."
      )

      -- Create a command `:Format` local to the LSP buffer.
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP." })
    end

    -- Enable the following LSP servers. They will automatically be installed.
    local servers = {
      bashls = {},
      cssls = {},
      cssmodules_ls = {},
      graphql = {},
      html = {},
      jsonls = {},
      lua_ls = {},
      phpactor = {},
      prismals = {},
      rust_analyzer = {},
      sqlls = {},
      tailwindcss = {},
      taplo = {},
      tsserver = {},
      vimls = {},
      yamlls = {},
    }

    -- Setup neovim lua configuration.
    neodev.setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- Setup Mason so it can manage external tooling.
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

    -- Ensure the LSP servers above are installed.
    mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        })
      end,
    })

    -- Ensure the linters and formatters are installed.
    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd", -- JS/TS formatters.
        "stylua", -- Lua formatter.
        "shfmt", -- Shell formatter.
        "eslint_d", -- JS/TS linters.
      },
      run_on_start = true,
    })

    -- NOTE: to use none-ls/null-ls.
    -- mason_null_ls.setup({
    --   ensure_installed = {
    --     "prettierd", -- JS/TS formatters.
    --     "stylua", -- Lua formatter.
    --     "shfmt", -- Shell formatter.
    --     "eslint_d", -- JS/TS linters.
    --   },
    -- })

    -- Turn on lsp status information.
    fidget.setup({})

    -- -- Configure Graphql language server.
    -- lspconfig["graphql"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
    -- })

    -- -- Configure Lua server (with special settings).
    -- lspconfig["lua_ls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   settings = {
    --     Lua = {
    --       -- Make the language server recognize "vim" global.
    --       diagnostics = {
    --         globals = { "vim" },
    --       },
    --       workspace = {
    --         -- Make language server aware of runtime files.
    --         library = {
    --           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    --           [vim.fn.stdpath("config") .. "/lua"] = true,
    --         },
    --       },
    --     },
    --   },
    -- })

    -- UI
    local lsp = vim.lsp

    lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    lsp.handlers["textDocument/signatureHelp"] =
      lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = true,
      float = {
        focusable = false,
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Change the Diagnostic symbols in the sign column (gutter).
    local signs =
      { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Override default vim.diagnostic.open_float() function,
    -- to change border and background color to adapt colors from Diagnostic event.
    vim.diagnostic.open_float = (function(orig)
      return function(bufnr, opt)
        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
        local options = opt or {}

        -- A more robust solution would check the "scope" value in `opts` to
        -- determine where to get diagnostics from, but if you're only using
        -- this for your own purposes you can make it as simple as you like.
        local diagnostics =
          vim.diagnostic.get(options.bufnr or 0, { lnum = lnum })
        local max_severity = vim.diagnostic.severity.HINT

        for _, d in ipairs(diagnostics) do
          -- Equality is "less than" based on how the severities are encoded.
          if d.severity < max_severity then
            max_severity = d.severity
          end
        end

        local border_color = ({
          [vim.diagnostic.severity.HINT] = "DiagnosticHint",
          [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
          [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
          [vim.diagnostic.severity.ERROR] = "DiagnosticError",
        })[max_severity]

        options.border = {
          { "╭", border_color },
          { "─", border_color },
          { "╮", border_color },
          { "│", border_color },
          { "╯", border_color },
          { "─", border_color },
          { "╰", border_color },
          { "│", border_color },
        }

        -- Change background color.
        -- dracula #282a36
        -- nord #2e3440
        -- tokyonight #24283b
        vim.cmd([[ highlight DiagnosticBGColor guibg=#2e3440]])
        vim.api.nvim_set_option_value(
          "winhl",
          "Normal:DiagnosticBGColor",
          { win = 0 }
        )

        -- Return new params.
        orig(bufnr, options)
      end
    end)(vim.diagnostic.open_float)
  end,
}
