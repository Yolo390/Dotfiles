return {
  "hrsh7th/nvim-cmp",
  version = false, -- Last release is way too old.
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer", -- Source for text in buffer.
    "hrsh7th/cmp-path", -- Source for file system paths.
    "L3MON4D3/LuaSnip", -- Snippet engine.
    "saadparwaiz1/cmp_luasnip", -- For autocompletion.
    "rafamadriz/friendly-snippets", -- Useful snippets.
    "onsails/lspkind.nvim", -- VS-code like pictograms.
    "roobert/tailwindcss-colorizer-cmp.nvim", -- Tailwindcss integration.
  },
  config = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local luasnip_load_vsc = require("luasnip.loaders.from_vscode")
    local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp")

    -- Loads vscode style snippets from installed plugins (ex: friendly-snippets).
    luasnip_load_vsc.lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      -- Configure how nvim-cmp interacts with snippet engine.
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "luasnip", keyword_length = 3 },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = {
          cmp.ItemField.Menu,
          cmp.ItemField.Abbr,
          cmp.ItemField.Kind,
        },
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          menu = {
            buffer = "[BUF]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[LUA]",
            path = "[PATH]",
            luasnip = "[SNIP]",
          },
          before = tailwindcss_colorizer_cmp.formatter,
        }),
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
    })
  end,
}
