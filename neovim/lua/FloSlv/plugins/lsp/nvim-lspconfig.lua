return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "folke/neodev.nvim", opts = {} },
    { "hrsh7th/cmp-nvim-lsp" },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local neodev = require("neodev")

    local ts_builtin_status, ts_builtin = pcall(require, "telescope.builtin")
    if not ts_builtin_status then
      return
    end

    local wk = require("which-key")
    wk.register({
      l = {
        name = "LSP",
        D = { vim.lsp.buf.declaration, "Goto declaration." },
        d = { vim.lsp.buf.definition, "Goto definition." },
        i = { vim.lsp.buf.implementation, "Goto implementation." },
        r = { ts_builtin.lsp_references, "Goto references." },
        t = { vim.lsp.buf.type_definition, "Goto type definition." },
      },
    }, { prefix = "<leader>" })

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      -- Set keymaps.
      -- Actions.
      opts.desc = "[R]e[N]ame"
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "[C]ode [A]ction"
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      -- Diagnostics.
      opts.desc = "Diagnostic: open."
      keymap("n", "<leader>do", vim.diagnostic.open_float, opts)

      opts.decs = "Diagnostic: telescope."
      keymap("n", "<leader>dg", ts_builtin.diagnostics, opts)

      -- Documentation.
      opts.desc = "Hover documentation."
      keymap("n", "K", vim.lsp.buf.hover, opts)

      -- Workspaces.
      opts.desc = "Workspace: symbols."
      keymap("n", "<leader>ws", ts_builtin.lsp_dynamic_workspace_symbols, opts)

      opts.desc = "Workspace: add folder."
      keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

      opts.desc = "Workspace: remove folder."
      keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

      opts.desc = "Workspace: list folders."
      keymap("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
    end

    -- Setup neovim lua configuration.
    neodev.setup()

    -- To enable autocompletion (assign to every lsp server config).
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure HTML server.
    lspconfig["html"].setup({
      settings = {},
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure TypeScript server with plugin.
    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure CSS server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure Tailwindcss server.
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure Prisma orm server.
    lspconfig["prismals"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure Graphql language server.
    lspconfig["graphql"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
    })

    -- Configure Lua server (with special settings).
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          -- Make the language server recognize "vim" global.
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- Make language server aware of runtime files.
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- UI
    local lsp = vim.lsp

    lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    lsp.handlers["textDocument/signatureHelp"] = lsp.with(vim.lsp.handlers.hover, {
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

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Override default vim.diagnostic.open_float() function
    -- to change border and background color to adapt colors from Diagnostic event.
    vim.diagnostic.open_float = (function(orig)
      return function(bufnr, opt)
        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
        local options = opt or {}

        -- A more robust solution would check the "scope" value in `opts` to
        -- determine where to get diagnostics from, but if you're only using
        -- this for your own purposes you can make it as simple as you like
        local diagnostics = vim.diagnostic.get(options.bufnr or 0, { lnum = lnum })
        local max_severity = vim.diagnostic.severity.HINT

        for _, d in ipairs(diagnostics) do
          -- Equality is "less than" based on how the severities are encoded
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

        -- Change background color
        vim.cmd([[ highlight DiagnosticBGColor guibg=#24283b]])
        vim.api.nvim_win_set_option(0, "winhl", "Normal:DiagnosticBGColor")

        -- Return new params
        orig(bufnr, options)
      end
    end)(vim.diagnostic.open_float)
  end,
}
